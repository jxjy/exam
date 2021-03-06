﻿<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../jspf/taglib.jspf"%>
<!DOCTYPE HTML>
<html>
	<head>
		<%@ include file="../jspf/head.jspf" %>
		<style type="text/css">
			.main{
				border: 1px solid #efeef0;
				border-radius: 5px;
			}

			.main .collect{
				/*border:1px solid red;*/
				width: 560px;
				margin:50px auto;
				overflow: auto;
			}

			.main .collect #webcam{
				width: 320px;
				background: #b3b3b3;
				border: 20px solid #333;
				border-radius: 20px;
				float: left;
				margin-top: 50px;
				position: relative;
			}

			.main .collect #webcam > object{
				display: block;
				position: relative;
				z-index: 2;
			}

			.main .collect #webcam > img{
				position: absolute;
				border: 0px none;
				padding: 0px;
				bottom: -40px;
				right: 89px;
			}

			.main .collect .tip{
				width: 180px;
				height: 240px;
				border-radius: 5px;
				float: right;
				margin-top:72px;
				margin-right:5px;
			}

			.main .collect .tip span{
				font-size: 12px;
				color: #000;
				padding-left: 26px;
			}

			.main .collect .tip div{
				text-align: center;
				font-size: 16px;
				/*border: 1px solid #000;*/
				padding: 2px 5px 2px 5px;
				min-width: 130px;
				margin: 50px auto;
				/*border-radius: 18px;*/
				display: none;
			}

			.main .collect #start-box{
				width: 99.9%;
				margin-top:40px;
				float: left;
			}

			.main .collect #start-box > div{
				width: 100px;
				height: 30px;
				background-color: #000;
				margin: 10px auto;
				text-align: center;
				line-height: 30px;
				color: #fff;
				border-radius: 15px;
				cursor: pointer;
				float: left;
				margin-left: 23%;
			}
		</style>
	</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 过程分析 <span class="c-gray en">&gt;</span> 图片采集 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
	<div class="page-container">
		<div class="main">
			<!-- 没有自己的考试 -->
			<c:if test="${myPhotoConfigs.size()==0}">
				<div style="text-align: center;padding: 200px 0 200px 0">
					亲爱的，暂时没有你的考试！
					<img src="${ctx}/resources/admin/static/photo/no_exam.jpg"/>
				</div>
			</c:if>
			<!-- 有自己的考试 -->
			<c:if test="${myPhotoConfigs.size()>0}">
				<!-- 迭代出属于自己的考试 -->
				<table class="table table-border table-bordered table-hover table-bg">
					<thead>
					<tr class="text-c">
						<th width="40">ID</th>
						<th width="200">描述</th>
						<th width="200">开始时间</th>
						<th width="200">结束时间</th>
						<th width="200">采集频率(毫秒/次)</th>
						<th width="200">状态</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach items="${myPhotoConfigs}" var="c">
						<tr class="text-c">
							<td>${c.id}</td>
							<td>${c.description}</td>
							<td><fmt:formatDate value="${c.startTime}" type="time" pattern="yyy-MM-dd HH:mm:ss"/></td>
							<td><fmt:formatDate value="${c.endTime}" type="time" pattern="yyy-MM-dd HH:mm:ss"/></td>
							<td>${c.collectRate}</td>
							<c:choose>
								<c:when test="${mowTime>c.startTime && mowTime<c.endTime}">
									<td>正在考试</td>
								</c:when>
								<c:otherwise>
									<td>未开始</td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
					</tbody>
				</table>

				<!-- 采集区域 -->
				<div class="collect">
					<div id="webcam">
						<img src="${ctx}/resources/admin/static/photo/antenna.png"/>
					</div>
					<div class="tip">
						<span><strong style="color: #f00">Tip：</strong>点击START开始既可以进行采集，在这之前你可以调整你的位置！</span>
						<div>
							<img src="${ctx}/resources/admin/static/photo/loading.gif" width="30" height="30"/>
							采集中...
						</div>
					</div>


					<div id="start-box">
						<c:if test="${collrctRate!=0}">
						<div id="start">START</div>
						<div id="stop">STOP</div>
						</c:if>
					</div>

				</div>
			</c:if>
		</div>
	</div>

	<!-- js -->
	<%@ include file="../jspf/footer.jspf" %>
	<script type="text/javascript" src="${ctx}/resources/admin/plug-in/jQuery-webcam/jquery.webcam.min.js"></script>
	<!-- 自定义js -->
	<script type="text/javascript">
		$(function() {
			//webcam上传图片
			var width = 320, height = 240;
			var pos = 0, ctx = null, saveCB, image = [];
			var canvas = document.createElement("canvas");
			canvas.setAttribute('width', width);
			canvas.setAttribute('height', height);
			if (canvas.toDataURL) {
				ctx = canvas.getContext("2d");
				image = ctx.getImageData(0, 0, width, height);
				saveCB = function(data) {
					var col = data.split(";");
					var img = image;
					for(var i = 0; i < width; i++) {
						var tmp = parseInt(col[i]);
						img.data[pos + 0] = (tmp >> 16) & 0xff;
						img.data[pos + 1] = (tmp >> 8) & 0xff;
						img.data[pos + 2] = tmp & 0xff;
						img.data[pos + 3] = 0xff;
						pos+= 4;
					}
					if (pos >= 4 * width * height) {
						ctx.putImageData(img, 0, 0);
						$.post("${ctx}/admin/photo/upload", {type: "data", image: canvas.toDataURL("image/png")}, function (data) {
//							afterDo(data);
						});
						pos = 0;
					}
				};
			} else {
				saveCB = function(data) {
					image.push(data);
					pos+= 4 * width;
					if (pos >= 4 * width * height) {
						$.post("${ctx}/admin/photo/upload", {type: "pixel", image: image.join('|')}, function (data) {
//							afterDo(data);
						});
						pos = 0;
					}
				};
			}

			//初始化webcam区域
			$("#webcam").webcam({
				width: width,
				height: height,
				mode: "callback",
				swffile: "${ctx}/resources/admin/plug-in/jQuery-webcam/jscam_canvas_only.swf",
				onSave: saveCB,
				onCapture: function () {
					webcam.save();
				},
				debug: function (type, string) {
					console.log(type + ": " + string);
				}
			});

			/**
			 *  点击开始按钮
			 *  nowPhotoConfig.collectRate代表采集频率
			 */
			var timer;
			$("#start").click(function () {
				timer = setInterval("webcam.capture()", ${collrctRate});
				$(".main .collect .tip div").removeClass("hui-bounceout").show().addClass("hui-bounce");
			});

			/**
			 * 点击停止按钮
			 */
			$("#stop").click(function () {
				clearInterval(timer);
				$(".main .collect .tip div").fadeOut(1000);
			});
		});
	</script>
</body>
</html>