<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/view/include.jsp"%>

<%
SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
request.setAttribute("format", format);
%>

<div id="news_list_page_${channelId }_${page.pageIndex }" class="news_list_page news_list_page_${channelId }" style="display:none;min-height:1120px;">
	 <table class="message-table1">
			<c:forEach var="news" items="${page.res }">
				<tr>
					<td style="padding-left:25px;width:450px;">
						<portlet:renderURL var="viewContent" portletMode="view" windowState="normal">
							<portlet:param name="action" value="viewContent" />
							<portlet:param name="contentId" value="${news.contentId }" />
						</portlet:renderURL>
						<div style="height: 25px; width:400px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">
						<%-- 
						<!-- [${news.channelName }] -->
						<c:if test="${news.isNew }"><em style="font-size:12px; color: red;">new</em></c:if>
						 --%>
						<a href="<%= viewContent %>" target="_blank" title="${news.title }">${news.title }</a>
						</div>
					</td>
					<td style="width:144px;">${news.origin }</td>
					<td style="width:108px;">${format.format(news.releaseDate) }</td>
			  </tr>
			</c:forEach>
	</table>
</div>
