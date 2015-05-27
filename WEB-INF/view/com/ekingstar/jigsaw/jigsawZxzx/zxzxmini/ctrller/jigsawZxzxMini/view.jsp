<%@page import="com.ekingstar.jigsaw.util.FriendlyURLUtil"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/view/include.jsp"%>

<%
String portletId = PortalUtil.getPortletId(renderRequest);

String newsCenterFriendlyURL = FriendlyURLUtil.getNewsCenterFriendlyURL();

String viewContentURL = newsCenterFriendlyURL+"?p_p_id=jigsawZxzxNormal_WAR_jigsawZxzxportlet&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&_jigsawZxzxNormal_WAR_jigsawZxzxportlet_action=viewContent&_jigsawZxzxNormal_WAR_jigsawZxzxportlet_contentId=";

List<JcContentInfo> contents = (List<JcContentInfo>) request.getAttribute("contents");

List<Long> tabIds = (List<Long>) request.getAttribute("tabIds");
Map<Long, String> tabChannels = (Map<Long, String>) request.getAttribute("tabChannels");
%>

<div class="cd-news">
	<div class="cd-news-title">
	  <div class="row-fluid">
	    <div class="span10 jq-channels">
		<%
		for (int i = 0; i < tabIds.size(); i++) {
		%>
			<%= i>0?"|":"" %>
			<font data="<%= tabIds.get(i) %>"><%= tabChannels.get(tabIds.get(i)) %></font>
		<%
		}
		%>
	    </div>
	    <div class="span2 text-right">
			<a target="_blank" href="<%= newsCenterFriendlyURL %>"><img src="<c:url value="/img/more_03.png" />"></a>
		</div>
	  </div>
	</div>
	
	<div class="cd-news-content">
	
	<div class="tab-content">
		<%
			for (int count = 0; count < tabIds.size(); count++) {
				long tabId = tabIds.get(count);
				String activeCssClass = "";
				if (count == 0) {
					activeCssClass = "active";
				}
		%>
		<div class="tab-pane <%= activeCssClass %>" id="tab-panel-<%=tabId%>">
			<table style="width: 100%;">
				<%
					for (int i = 5 * count; i < 5 * count + 5 && i < contents.size(); i++) {
						JcContentInfo jc = contents.get(i);
						String titleString = jc.getTitle();
						long contentId = jc.getContentId();
						if (contentId != -1 && titleString != "") {
							
				%>
				<tr>
					<td style="width: 70%;" title="<%= jc.getTitle() %>">
						<div style="width:80%; height: 25px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">
						[<%= jc.getChannelName() %>]
						<c:if test="<%= jc.isNew()==true %>"><em style="font-size:12px; color: red;">new</em></c:if>
						<a target="_blank" href="<%= viewContentURL + jc.getContentId() %>"><%= jc.getTitle() %></a>
						</div>
					</td>
					<td style="width: 30%; text-align:right;"><%= jc.getShortDate() %></td>
				</tr>
				<%
						}
					}
				%>
			</table>
		</div>
		<%
			}
		%>
	</div>

	</div>
</div>


<aui:script>
var portlet = jQuery('#p_p_id_<%= portletId %>_');

var news = portlet.find(".cd-news");

var jq_channels = news.find(".jq-channels").find("font");

var jq_contents = news.find(".tab-content").find(".tab-pane");

jQuery(function($){
	initNews();
});

function initNews() {
	var intervalID = 0;
	var channelIdCurrent = 0;
	jq_channels.each(function(i){
		var jq_channel = jQuery(this).css({"cursor":"pointer"});
		var channelId = jq_channel.attr("data");
		jq_channel.mouseover(function(){
			if (channelIdCurrent == channelId) return;
			
			intervalID = setTimeout(function(){
				jq_channels.removeClass("cd-title-on");
				jq_channel.addClass("cd-title-on");
				
				jq_contents.removeClass("active");
				news.find("#tab-panel-"+channelId).addClass("active");
				
				channelIdCurrent = channelId;
			}, 1000);
		}).mouseout(function(){
			clearTimeout(intervalID);
		});

		if (i==0) {
			jq_channel.addClass("cd-title-on");
			channelIdCurrent = channelId;
		}
	});
}
</aui:script>