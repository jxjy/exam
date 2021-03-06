﻿<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="jspf/taglib.jspf"%>
<!DOCTYPE HTML>
<html>
<head>
	<%@ include file="jspf/head.jspf" %>
</head>
<body>
<div class="page-container">
	<p class="f-20 text-success">欢迎使用${systemWeb.title} <span class="f-14">${systemWeb.version}</span>！</p>
	<p>登录次数：${session_user.time} </p>
	<p>上次登录IP：${session_user.lastLoginIp}  上次登录时间：<fmt:formatDate value="${session_user.lastLoginTime}" type="time" pattern="yyyy-MM-dd HH:mm:ss"/></p>
	<table class="table table-border table-bordered table-bg">
		<thead>
			<tr>
				<th colspan="7" scope="col">信息统计</th>
			</tr>
			<tr class="text-c">
				<th>统计</th>
				<th>资讯库</th>
				<th>图片库</th>
				<th>产品库</th>
				<th>用户</th>
				<th>管理员</th>
			</tr>
		</thead>
		<tbody>
			<tr class="text-c">
				<td>总数</td>
				<td>92</td>
				<td>9</td>
				<td>0</td>
				<td>8</td>
				<td>20</td>
			</tr>
			<tr class="text-c">
				<td>今日</td>
				<td>0</td>
				<td>0</td>
				<td>0</td>
				<td>0</td>
				<td>0</td>
			</tr>
			<tr class="text-c">
				<td>昨日</td>
				<td>0</td>
				<td>0</td>
				<td>0</td>
				<td>0</td>
				<td>0</td>
			</tr>
			<tr class="text-c">
				<td>本周</td>
				<td>2</td>
				<td>0</td>
				<td>0</td>
				<td>0</td>
				<td>0</td>
			</tr>
			<tr class="text-c">
				<td>本月</td>
				<td>2</td>
				<td>0</td>
				<td>0</td>
				<td>0</td>
				<td>0</td>
			</tr>
		</tbody>
	</table>
	<table class="table table-border table-bordered table-bg mt-20">
		<thead>
			<tr>
				<th colspan="2" scope="col">服务器信息</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th width="30%">服务器计算机名</th>
				<td><span id="lbServerName">${systemMess.hostName}</span></td>
			</tr>
			<tr>
				<td>服务器局域网IP地址</td>
				<td>${systemMess.local_ip}</td>
			</tr>
			<tr>
				<td>服务器广域网IP地址</td>
				<td>${systemMess.v4_ip}</td>
			</tr>
			<tr>
				<td>服务器操作系统 </td>
				<td>${systemMess.os_name}</td>
			</tr>
			<tr>
				<td>服务器操作版本 </td>
				<td>${systemMess.os_version}</td>
			</tr>
			<tr>
				<td>服务器的语言种类 </td>
				<td>${systemMess.user_language}</td>
			</tr>
			<tr>
				<td>服务器架构</td>
				<td>${systemMess.os_arch}</td>
			</tr>
			<tr>
				<td>服务器文件系统使用率 </td>
				<td>${systemMess.disk}</td>
			</tr>
			<tr>
				<td>CPU 总数 </td>
				<td>${systemMess.cpu_number}</td>
			</tr>
			<tr>
				<td>服务器内存使用率 </td>
				<td>${systemMess.memery}</td>
			</tr>
			<tr>
				<td>文件分隔符 </td>
				<td>${systemMess.file_separator}</td>
			</tr>
			<tr>
				<td>服务器当前时间 </td>
				<td>${systemMess.date}</td>
			</tr>
			<tr>
				<td>Java的运行环境版本 </td>
				<td>${systemMess.java_version}</td>
			</tr>
			<tr>
				<td>Java的运行环境供应商 </td>
				<td>${systemMess.java_vendor}</td>
			</tr>
			<tr>
				<td>Java的安装路径</td>
				<td>${systemMess.java_home}</td>
			</tr>
			<tr>
				<td>服务器虚拟机中的内存总量</td>
				<td>${systemMess.virtua_total_memory}</td>
			</tr>
			<tr>
				<td>服务器虚拟机中的最大虚拟内存</td>
				<td>${systemMess.virtua_max_memory}</td>
			</tr>
			<tr>
				<td>服务器虚拟机中的空闲内存</td>
				<td>${systemMess.virtua_free_memory}</td>
			</tr>
			<tr>
				<td>用户当前目录</td>
				<td>${systemMess.user_dir}</td>
			</tr>
		</tbody>
	</table>
</div>
<footer class="footer mt-20">
	<div class="container">
			本后台系统由&nbsp;<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=761328790&site=qq&menu=yes">Mr.X</a>&nbsp;提供技术支持</p>
	</div>
</footer>
<%@ include file="jspf/footer.jspf"%>
</body>
</html>