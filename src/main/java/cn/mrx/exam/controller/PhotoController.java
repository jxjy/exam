package cn.mrx.exam.controller;

import cn.mrx.exam.youtu.Youtu;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import sun.misc.BASE64Decoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
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
     * 拍摄检测
     * @return
     */
    @RequestMapping(value = "/take-photo", method = RequestMethod.GET)
    public String takePhoto(){
        return "admin/photo/take-photo";
    }

    /**
     * 上传图片
     * @param httpServletRequest
     * @param httpServletResponse
     */
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    @ResponseBody
    public Object upload(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse){
        String realPath = httpServletRequest.getSession().getServletContext().getRealPath("/resources/admin/upload/photo/");
        String newName = UUID.randomUUID() + ".png";
        //默认传入的参数带类型等参数：data:image/png;base64,
        String imgStr = httpServletRequest.getParameter("image");
        if (null != imgStr) {
            imgStr = imgStr.substring(imgStr.indexOf(",") + 1);
        }
        Boolean flag = generateImage(imgStr, realPath, newName);
        String result = "";
        if (flag) {
            result = realPath + newName;
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
    public Object detectface(String fileName, HttpServletRequest httpServletRequest) throws Exception{
        String realPath = httpServletRequest.getSession().getServletContext().getRealPath("/resources/admin/upload/photo/");
        Youtu youtu = new Youtu(APP_ID, SECRET_ID, SECRET_KEY, Youtu.API_YOUTU_END_POINT, USER_ID);
        JSONObject jsonObject = youtu.DetectFace(realPath + fileName, 1);
        return jsonObject;
    }

    /**
     * 拍摄检测
     * @return
     */
    @RequestMapping(value = "/collect", method = RequestMethod.GET)
    public String collect(){
        return "admin/photo/collect";
    }
}