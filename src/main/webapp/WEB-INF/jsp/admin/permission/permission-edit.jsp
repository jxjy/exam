<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../jspf/taglib.jspf"%>
<!DOCTYPE HTML>
<html>
<head>
	<%@ include file="../jspf/head.jspf" %>
</head>
<body>
<article class="page-container">
	<form method="post" class="form form-horizontal" id="form-permission-edit">
		<input type="hidden" value="${permission.id}" name="id"/>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>URI：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="${permission.uri}" placeholder="uri" id="uri" name="uri">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>权限名称：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="${permission.permissionName}" placeholder="权限名称" id="permissionName" name="permissionName">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">菜单等级：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<span class="select-box">
					<select class="select" size="1" name="nowId">
						<c:choose>
							<c:when test="${permission.nowId==2}">
								<option value="2" selected>二级菜单</option>
								<option value="3">三级菜单</option>
							</c:when>
							<c:when test="${permission.nowId==3}">
								<option value="2">二级菜单</option>
								<option value="3" selected>三级菜单</option>
							</c:when>
						</c:choose>
					</select>
				</span>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">父级等级：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<span class="select-box">
					<select class="select" size="1" name="parentId">
						<c:choose>
							<c:when test="${permission.parentId==1}">
								<option value="1" selected>会员管理</option>
								<option value="2">角色权限管理</option>
								<option value="3">人脸识别技术</option>
								<option value="4">过程分析</option>
								<option value="5">系统设置</option>
							</c:when>
							<c:when test="${permission.parentId==2}">
								<option value="1">会员管理</option>
								<option value="2" selected>角色权限管理</option>
								<option value="3">人脸识别技术</option>
								<option value="4">过程分析</option>
								<option value="5">系统设置</option>
							</c:when>
							<c:when test="${permission.parentId==3}">
								<option value="1">会员管理</option>
								<option value="2">角色权限管理</option>
								<option value="3" selected>人脸识别技术</option>
								<option value="4">过程分析</option>
								<option value="5">系统设置</option>
							</c:when>
							<c:when test="${permission.parentId==4}">
								<option value="1">会员管理</option>
								<option value="2">角色权限管理</option>
								<option value="3">人脸识别技术</option>
								<option value="4" selected>过程分析</option>
								<option value="5">系统设置</option>
							</c:when>
							<c:when test="${permission.parentId==5}">
								<option value="1">会员管理</option>
								<option value="2">角色权限管理</option>
								<option value="3">人脸识别技术</option>
								<option value="4">过程分析</option>
								<option value="5" selected>系统设置</option>
							</c:when>
						</c:choose>
					</select>
				</span>
			</div>
		</div>
		<div class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
				<input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
			</div>
		</div>
	</form>
</article>

<!--_footer 作为公共模版分离出去-->
<%@ include file="../jspf/footer.jspf" %>
<!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本--> 
<script type="text/javascript" src="${ctx}/resources/admin/h-ui/lib/jquery.validation/1.14.0/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx}/resources/admin/h-ui/lib/jquery.validation/1.14.0/validate-methods.js"></script>
<script type="text/javascript" src="${ctx}/resources/admin/h-ui/lib/jquery.validation/1.14.0/messages_zh.js"></script>
<script type="text/javascript">
$(function(){
	$('.skin-minimal input').iCheck({
		checkboxClass: 'icheckbox-blue',
		radioClass: 'iradio-blue',
		increaseArea: '20%'
	});

	$("#form-permission-edit").validate({
		rules:{
			uri:{
				required:true,
				minlength:2,
				maxlength:50
			},
			permissionName:{
				required:true,
			}
		},
		onkeyup:false,
		focusCleanup:true,
		success:"valid",
		submitHandler:function(form){
			$(form).ajaxSubmit({
				url:"${ctx}/admin/permission/edit",
				type:"post",
				dataType:"json",
				data : $("#form-permission-edit").serialize(),
				success:function (json) {
					if(json == true){
						layer.msg('修改成功!',{icon:1,time:1000}, function () {
							window.parent.location.reload(); //刷新父页面
							var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
							parent.layer.close(index);  // 关闭layer
						});
					}else{
						layer.msg('修改失败！',{icon:5,time:1000});
					}

				},
				error:function () {
					layer.msg('服务器错误，请联系管理员！',{icon:5,time:1000});
				}
			});
		}
	});
});
</script> 
<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>