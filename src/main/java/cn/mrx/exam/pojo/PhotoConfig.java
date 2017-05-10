package cn.mrx.exam.pojo;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 
 * </p>
 *
 * @author Mr.X
 * @since 2017-05-06
 */
@TableName("t_photo_config")
public class PhotoConfig extends Model<PhotoConfig> {

    private static final long serialVersionUID = 1L;

	/**
	 * 主键id
	 */
	@TableId(type = IdType.AUTO)
	private Integer id;
	/**
	 * 开始时间
	 */
	@TableField(value="start_time")
	private Date startTime;
	/**
	 * 结束时间
	 */
	@TableField(value="end_time")
	private Date endTime;
	/**
	 * 描述
	 */
	private String description;
	/**
	 * 是否已经解析,0:为解析,1:已解析
	 */
	private String isAnalysis;
	/**
	 * 发布者
	 */
	@TableField(value="user_id")
	private Integer userId;

	/**
	 * 状态：未开始、考试中、已结束
	 */
	@TableField(exist = false)
	private String status;

	@TableField(exist = false)
	private User user;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getIsAnalysis() {
		return isAnalysis;
	}

	public void setIsAnalysis(String isAnalysis) {
		this.isAnalysis = isAnalysis;
	}

	@Override
	protected Serializable pkVal() {
		return this.id;
	}

}
