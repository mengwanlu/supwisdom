<%@ include file="/WEB-INF/view/include.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<div class="container-fluid">
	<div class="row-fluid">
		<div class="span12">
			<ul class="breadcrumb">
				<li>
					<a href="-6">主页</a> <span class="divider">/</span>
				</li>
				<li>
					<a onclick="history.go(-1);">${news.channelName}</a> <span class="divider">/</span>
				</li>
				<li class="active">
					${news.title}
				</li>
			</ul>
			<h2 align="center">
				${news.title}
			</h2>
			<p>
				${news.content}
			</p>
		</div>
	</div>
</div>