<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/view/include.jsp"%>

<%
	List<JcChannelExt> jcChannelExts = JcChannelExtLocalServiceUtil.findJcChannelExtByParentPath("newscenter");
%>

<portlet:renderURL var="redirectUrl" portletMode="view" />

<div>
	<table class="table table-bordered">
	    <tr>
		    <td colspan="${fn:length(identitylist)+2 }">
		         <h3 style="display:inline;float:left;">配置频道：</h3>
				 <input type="button" class="btn btn-small" id="confirmSelect" onclick='<%="javascritp:confirmSelect();"%>' style="margin-left:10px;" value="保存">
		    </td>
		</tr>
		<tr>
		   <td>频道</td>
		   <td colspan="${fn:length(identitylist) }" style="text-align:center;">是否可见</td>
		</tr>
		<tbody id="channelconfig">
			<c:forEach var="jc" items="<%=jcChannelExts %>">
				<tr>
					<td>
						<c:out value="${jc.getChannelName() }"/>
						<input type="hidden" name="selectChannel" value="${jc.getChannelId()}">
					</td>
					<c:forEach items="${identitylist}" var="identity">
						<td>
						   <label>
						    <c:choose>
						        <c:when test="${fn:contains(havechannel.get(jc.getChannelId()),identity.name) }">
						            <input type="checkbox" value="${identity.name }" checked="checked">${identity.description }
						        </c:when>
						        <c:otherwise>
						            <input type="checkbox" value="${identity.name }">${identity.description }
						        </c:otherwise>
						    </c:choose>
						   </label>
					   </td>
					</c:forEach> 
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<portlet:renderURL var="configUrl" portletMode="view" windowState="<%=LiferayWindowState.EXCLUSIVE.toString()%>">
	<portlet:param name="action" value="config"></portlet:param>
</portlet:renderURL>

<aui:script>
	function confirmSelect() {
		var source="{'channel':[";
		var confingdate=$("#channelconfig tr");
		var length=confingdate.length;
		$.each(confingdate,function(index){
			var id=$(this).find("input").val();
			var roleset=$(this).find("input:checkbox:checked");
			var isshow="";
			$.each(roleset,function(){
				isshow+=$(this).val()+",";
			});
			source+="{'channelid':'"+id+"','ishow':'"+isshow+"'}";
			if(index!=length-1){
				source+=",";
			}
		});
		source+="]}";
		
		var data = { 
			'<portlet:namespace />config' : source
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
