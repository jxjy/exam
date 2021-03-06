package cn.mrx.exam.pojo;

import cn.mrx.exam.controller.validation.UserLogin;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import org.hibernate.validator.constraints.NotEmpty;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 
 * </p>
 *
 * @author Mr.X
 * @since 2017-03-26
 */
@TableName("t_user")
public class User extends Model<User> {

    private static final long serialVersionUID = 1L;

	/**
	 * 主键id
	 */
	@TableId(type = IdType.AUTO)
	private Integer id;
	/**
	 * 用户名
	 */
	@NotEmpty(message="用户名不能为空！", groups = UserLogin.class)
	private String username;
	/**
	 * 密码
	 */
	@NotEmpty(message="密码不能为空！", groups = UserLogin.class)
	private String pwd;
	/**
	 * 邮箱
	 */
	private String email;
	/**
	 * 真实姓名
	 */
	@TableField(value="really_name")
	private String reallyName;
	/**
	 * 登录次数
	 */
	private Integer time;
	/**
	 * 上次登录ip
	 */
	@TableField(value="last_login_ip")
	private String lastLoginIp;
	/**
	 * 上次登录时间
	 */
	@TableField(value="last_login_time")
	private Date lastLoginTime;
	/**
	 * 用户登录验证码
	 */
	@NotEmpty(message="验证码不能为空！", groups = UserLogin.class)
	private String captcha;
	/**
	 * 所属角色id
	 */
	@TableField(value="role_id")
	private Integer roleId;

	/**
	 * 新增：选中已有的学生，不映射数据库
	 */
	@TableField(exist = false)
	private boolean flag;


	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getReallyName() {
		return reallyName;
	}

	public void setReallyName(String reallyName) {
		this.reallyName = reallyName;
	}

	public Integer getTime() {
		return time;
	}

	public void setTime(Integer time) {
		this.time = time;
	}

	public String getLastLoginIp() {
		return lastLoginIp;
	}

	public void setLastLoginIp(String lastLoginIp) {
		this.lastLoginIp = lastLoginIp;
	}

	public Date getLastLoginTime() {
		return lastLoginTime;
	}

	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	public String getCaptcha() {
		return captcha;
	}

	public void setCaptcha(String captcha) {
		this.captcha = captcha;
	}

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public boolean isFlag() {
		return flag;
	}

	public void setFlag(boolean flag) {
		this.flag = flag;
	}

	@Override
	protected Serializable pkVal() {
		return this.id;
	}

}
