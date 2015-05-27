<%@page import="com.liferay.portal.model.Layout"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/view/include.jsp"%>

<%
String portletId = PortalUtil.getPortletId(renderRequest);

List<Long> tabIds = (List<Long>) request.getAttribute("tabIds");
Map<Long, String> tabChannels = (Map<Long, String>) request.getAttribute("tabChannels");
Map<Long, List<JcChannelExt>> tabSubChannels = (Map<Long, List<JcChannelExt>>) request.getAttribute("tabSubChannels");

JcContentInfo news=(JcContentInfo)request.getAttribute("news");

%>

<script type="text/javascript">
$(document).ready(function() {
	
	$(".sub-left-ul li a").mouseover(function() {
        $(this).addClass("sub-left-ul-on").parent().siblings("li").find("a").removeClass("sub-left-ul-on");
		$(this).parent().next("dl").slideDown();
		$(this).parent().siblings("li").next("dl").slideUp();
    });
	
	/*var min=14; 	
	//最大字号
	var max=18;	
	var size=14;		
	var elm = $('.article-txt');  		
	//放大字体
	$('.add-on').click(function() {
		if (size<max) {
			size=size+2;
			elm.css({'fontSize' : size});
			$(".minus-off").addClass("minus-on");
		}
		if(size==18){
			$(".add-on").addClass("add-off");
			}
		return false;			
	});
	$('.minus-off').click(function() {
		if (size>min) {
			size=size-2;
			elm.css({'fontSize' : size});
			$(".add-on").removeClass("add-off");
		}
		if(size==14){
			$(".minus-off").removeClass("minus-on");
			}
		return false;			
	});*/

});
</script>

<style type="text/css">
   .detail_bottom{
      float: right;
      font-size: 12px;
      margin:25px 30px 25px 0px;
   }
</style>

<div class="content-wrap" id="news">
  <div class="sub-header c_253751">资讯中心</div>
  <div class="clearfix" style="height:10px;"></div>
  
  <div class="left-wrap">
   <div class="sub-left-wrap">
     <h2 class="sub-left-title">分类</h2>
     <input id="channelId" name="channelId" type="hidden" />
	  <ul class="sub-left-ul jq-channels">
		<%
			for (int i = 0; i < tabIds.size(); i++) {
		%>
		   <li><a href="javascript:void(0);" class="<%= news.getChannelId() == tabIds.get(i) ? "sub-left-ul-on":"" %>" onclick="changeChannel('<%= tabIds.get(i) %>')" ><%= tabChannels.get(tabIds.get(i)) %></a></li>
		<%
			}
		%>
	 </ul>
   </div>
  </div>
  
  <div class="meet-content">
    <h2 class="app-wrap-title"><a href="<portlet:renderURL></portlet:renderURL>">资讯中心</a>&nbsp;&gt;&nbsp;${news.channelName }</h2>
     <div class="article-wrap">
        <h3 class="article-title"> ${news.title }</h3>
        <h3 class="article-head">
                        信息来源：<span class="c_203854">${news.origin }</span> | 发布日期：<span class="c_203854">${news.longDate }</span> | 已被查看了 <span class="c_203854">${jcc.views }</span> 次
		<!--<ul class="article-fonts"> -->
		<!--   <li class="minus-off"></li> -->
		<!--   <li class="add-on"></li> -->
		<!--</ul> -->
        </h3>
        <div class="article-txt">
          <p>${news.content }</p>
          <p>&nbsp;</p>
          <p style="font-size: 12px;">
   			 <c:if test="${fn:length(attachment)>0}"></c:if>       
             <c:forEach items="${attachment }" var="appendice" varStatus="status">
				<c:if test="${status.index == 0}"><i class="ico-accessory" title="附件"></i></c:if>
				<a style="color:#4f9cfd;text-decoration: underline;margin-left:${status.index != 0 ?'50':'0' }px;" 
				href="/jigsawZxzx-portlet/fileDownload?filepath=${appendice.attachmentPath}&filename=${appendice.attachmentName }">${appendice.attachmentName }</a><br>
			</c:forEach>
          </p>
          <c:if test="${fn:length(news.author)>0}">
               <p class="detail_bottom">
			   	   ${news.author }
			  </p>
          </c:if>
          <div class="article-btn" >
              <input class="message-btn" type="button" value="关闭" onclick="closeWin();">
          </div>
        </div>
      </div>
      
      <div id="news_list_page_${channelId }_${page.pageIndex }" class="news_list_page news_list_page_${channelId }" style="display:none;min-height:300px;">
		 <table class="message-table1">
			<c:forEach var="news" items="${page.res }">
				<tr>
					<td width="65%" style="padding-left:25px;">
						<portlet:renderURL var="viewContent" portletMode="view" windowState="normal">
							<portlet:param name="action" value="viewContent" />
							<portlet:param name="contentId" value="${news.contentId }" />
						</portlet:renderURL>
						<div style="height: 25px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">
						<!-- [${news.channelName }] -->
						<c:if test="${news.isNew }"><em style="font-size:12px; color: red;">new</em></c:if>
						<a href="<%= viewContent %>" target="_blank">${news.title }</a>
						</div>
					</td>
					<td width="20%">${news.origin }</td>
					<td>${news.longDate }</td>
				 </tr>
			</c:forEach>
		</table>
	</div>
  </div>
</div>

<script type="text/javascript">
	function changeChannel(currentchannel){
		var url="<portlet:renderURL/>&<portlet:namespace/>currentchannel="+currentchannel;
		window.location.href=url;
	}

	function back(url) {
		window.location.href=url;
	}
	
	function closeWin(){
		window.opener=null;
		window.open('','_self');
		window.close();
	}
</script>