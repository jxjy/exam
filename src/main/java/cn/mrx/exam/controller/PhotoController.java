package cn.mrx.exam.controller;

import cn.mrx.exam.interceptor.PermissionCheck;
import cn.mrx.exam.pojo.Photo;
import cn.mrx.exam.pojo.PhotoConfig;
import cn.mrx.exam.pojo.User;
import cn.mrx.exam.utils.WebConstant;
import cn.mrx.exam.youtu.Youtu;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import sun.misc.BASE64Decoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * <p>
 *   前端控制器
 * </p>
 *
 * @author Mr.X
 * @since 2017-05-03
 */
@Controller
@RequestMapping("/admin/photo")
public class PhotoController extends BaseController {

    Logger logger = LoggerFactory.getLogger(this.getClass());

    /** 腾讯优图配置参数 */
    public static final String APP_ID = "10078911";
    public static final String SECRET_ID = "AKIDJWYO3XovpbCbnptIjy2tZ4OWSBi3Jlrl";
    public static final String SECRET_KEY = "pY8XklfNtDMJ3bx9KbpunuqdFfsulPr7";
    public static final String USER_ID = "1451965355";

    /**
     * 拍摄检测页面
     * @return
     */
    @RequestMapping(value = "/photo-detect", method = RequestMethod.GET)
    @PermissionCheck
    public String takePhoto(){
        return "admin/photo/photo-detect";
    }

    /**
     * 上传图片
     * @param httpServletRequest
     * @return
     */
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    @ResponseBody
    public Object upload(HttpServletRequest httpServletRequest){
        String realPath = httpServletRequest.getSession().getServletContext().getRealPath("/resources/admin/upload/photo/");
        String newName = UUID.randomUUID() + ".png";
        //默认传入的参数带类型等参数：data:image/png;base64,
        String imgStr = httpServletRequest.getParameter("image");
        if (null != imgStr) {
            imgStr = imgStr.substring(imgStr.indexOf(",") + 1);
        }
        Boolean flag = generateImage(imgStr, realPath, newName);
        //保存进数据库
        if(flag){
            Photo photo = new Photo();
            photo.setName(newName);//照片名称
            photo.setCreateTime(new Date());//照片创建日期
            //照片所属人
            HttpSession httpSession = httpServletRequest.getSession();
            User user = (User) httpSession.getAttribute(WebConstant.SESSION_USER);
            photo.setUserId(user.getId());
            boolean xxx = iPhotoService.insert(photo);
        }
        JSONObject jsonObject = JSON.parseObject("{'flag':'"+flag+"', 'fileName':'"+newName+"'}");
        return jsonObject;
    }

    /**
     * 功能描述：base64字符串转换成图片
     * @param imgStr
     * @param filePath
     * @param fileName
     * @return
     */
    public boolean generateImage(String imgStr, String filePath, String fileName) {
        try {
            if (imgStr == null) {
                return false;
            }
            BASE64Decoder decoder = new BASE64Decoder();
            //Base64解码
            byte[] b = decoder.decodeBuffer(imgStr);
            //如果目录不存在，则创建
            File file = new File(filePath);
            if (!file.exists()) {
                file.mkdirs();
            }
            //生成图片
            OutputStream out = new FileOutputStream(filePath + fileName);
            out.write(b);
            out.flush();
            out.close();
            return true;
        } catch (Exception e) {
            logger.error("生成图片异常：{}", e.getMessage());
            return false;
        }
    }

    /**
     * 五官定位
     * @param fileName
     * @param httpServletRequest
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/detectface", method = RequestMethod.POST)
    @ResponseBody
    public Object detectface(String fileName,
                             HttpServletRequest httpServletRequest) throws Exception{
        String realPath = httpServletRequest.getSession().getServletContext().getRealPath("/resources/admin/upload/photo/");
        Youtu youtu = new Youtu(APP_ID, SECRET_ID, SECRET_KEY, Youtu.API_YOUTU_END_POINT, USER_ID);
        JSONObject jsonObject = youtu.DetectFace(realPath + fileName, 1);
        //删除该张图片
        File file = new File(realPath+fileName);
        if(file.exists()){
            file.delete();
        }
        return jsonObject;
    }

    /**
     * 图片采集页面
     * @param httpServletRequest
     * @param model
     * @return
     */
    @RequestMapping(value = "/photo-collect", method = RequestMethod.GET)
    @PermissionCheck
    public String collect(HttpServletRequest httpServletRequest,
                          Model model){
        //查询自己的考试信息
        HttpSession httpSession = httpServletRequest.getSession();
        User user = (User) httpSession.getAttribute(WebConstant.SESSION_USER);

        //查询所有考试未结束的PhotoConfig
        List<PhotoConfig> photoConfigs = iPhotoConfigService.selectList(null);
        //属于自己的考试
        List<PhotoConfig> myPhotoConfigs = new ArrayList<>();
        //正在考试的场次信息
        String collrctRate = "0";
        for (PhotoConfig photoConfig : photoConfigs){
            //现在时间<结束时间
            if (new Date().getTime() < photoConfig.getEndTime().getTime()){
                //查询该堂考试的应考人
                String str = photoConfig.getUserIds();
                if(str!=null && !str.trim().equals("")){
                    for (String s : str.split(",")){
                        if(Integer.valueOf(s) == user.getId()){
                            myPhotoConfigs.add(photoConfig);
                        }
                    }
                }
                //现在时间>开始时间 && 现在时间<结束时间 即正在考试的场次
                if(new Date().getTime() > photoConfig.getStartTime().getTime()){
                    collrctRate = photoConfig.getCollectRate();
                }
            }
        }

        model.addAttribute("myPhotoConfigs", myPhotoConfigs);
        model.addAttribute("collrctRate", collrctRate);
        model.addAttribute("mowTime", new Date());
        return "admin/photo/photo-collect";
    }
}
