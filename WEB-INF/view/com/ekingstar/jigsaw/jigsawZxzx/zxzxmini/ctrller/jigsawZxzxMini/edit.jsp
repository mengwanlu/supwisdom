<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/view/include.jsp"%>

<%
	List<JcChannelExt> jcChannelExts = JcChannelExtLocalServiceUtil.findJcChannelExtByParentId(-1L);
%>

<portlet:renderURL var="redirectUrl" portletMode="view" />

<div>
	<h3>请选择默认配置频道</h3>
	<table class="table table-bordered">
		<tbody>
			<tr>
				<%
				if (jcChannelExts!=null) {
					for (int i = 0; i < jcChannelExts.size(); i++) {
				%>
				<td><input type="checkbox" name="selectChannel"
					id="<%=jcChannelExts.get(i).getChannelId()%>"></td>
				<td><%=jcChannelExts.get(i).getChannelName()%></td>
				<%
					if ((i + 1) % 3 == 0) {
				%>
			</tr>
			<tr>
				<%
					}
					}
				}
				%>
			</tr>
		</tbody>
	</table>
	<br> <input type="button" value="确认" id="confirmSelect"
		onclick='<%="javascritp:confirmSelect();"%>'>
</div>

<portlet:renderURL var="configUrl" portletMode="view"
	windowState="<%=LiferayWindowState.EXCLUSIVE.toString()%>">
	<portlet:param name="action" value="config"></portlet:param>
</portlet:renderURL>

<aui:script>
	function confirmSelect() {
		var count = 0;
		var config = "";
		var che = document.getElementsByName("selectChannel");
		for (; count < che.length; count++) {
			if (che[count].checked) {
				break;
			}
		}
		if (count == che.length) {
			alert("请选择频道 ");
		} else {
			for (var i = 0; i < che.length; i++) {
				if (che[i].checked) {
					(config == "") ? (config = che[i].id) : (config = config
							+ "_" + che[i].id);
				}
			}
		}
		
		var data = { 
			'<portlet:namespace />config' : config
		};

		var url = '<%=configUrl%>';
		
		jQuery.ajax({
			type : "post",
			url : url,
			data : data,
			dataType : "json",
			success : function(json){
				alert(json.message);
				
				if (json.result) {
					window.location.href = "<%=redirectUrl%>";
				}
			}
		});
		
	}
	
</aui:script>
