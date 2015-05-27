<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/view/include.jsp" %>

<div class="error">
	<table width="100%" cellpadding="0" cellspacing="0" class="text_box_7">
	  <tr>
	    <td width="100%" align="center">
	    	<%= request.getAttribute("MESSAGE") %>
	    	<br/>
	    	如有疑问，请联系管理员！
	    </td>
	  </tr>
	</table>
</div>
