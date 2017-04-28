package cn.mrx.exam.test.mybatis;

import cn.mrx.exam.interceptor.PermissionCheck;
import cn.mrx.exam.pojo.Permission;
import cn.mrx.exam.service.IPermissionService;
import cn.mrx.exam.service.ISystemWebService;
import cn.mrx.exam.service.IUserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

/**
 * Author: Mr.X
 * Date: 2017/3/17
 * Description:
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-service.xml", "classpath:spring/spring-dao.xml"})
public class MybatisTest {

    @Autowired
    private IUserService iUserService;
    @Autowired
    private ISystemWebService iSystemWebService;
    @Autowired
    private IPermissionService iPermissionService;

    @Test
    public void xxxxxxxxxxx() {
        List<Permission> list = iPermissionService.selectList(null);
        for (Permission p : list) {
            System.out.println(p);
        }

    }

}
