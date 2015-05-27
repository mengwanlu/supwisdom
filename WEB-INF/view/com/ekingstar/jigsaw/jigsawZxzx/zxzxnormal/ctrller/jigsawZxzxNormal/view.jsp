<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/view/include.jsp"%>

<%-- <script type="text/javascript" src='<c:url value="/js/dropdown.js"/>'></script>  --%>

<%
String portletId = PortalUtil.getPortletId(renderRequest);

List<Long> tabIds = (List<Long>) request.getAttribute("tabIds");
Map<Long, String> tabChannels = (Map<Long, String>) request.getAttribute("tabChannels");
Map<Long, List<JcChannelExt>> tabSubChannels = (Map<Long, List<JcChannelExt>>) request.getAttribute("tabSubChannels");
%>

<script type="text/javascript">
$(document).ready(function() {
	$(".app-wrap-input").focus(function(){
	  if($(this).val() ==this.defaultValue){  
		  $(this).css("color","#666666");         
	  } 
	}).blur(function(){
	 if ($(this).val() == '') {
			$(this).css("color","#cccccc");
        }
	});
	
	/*document.onclick = function(e){
		e = window.event || e; 
		obj = $(e.srcElement || e.target);
		if ($(obj).is(".btn-area *")||!$(obj).is(".ddl-select,.ddl-select *,.ddl-listbox,.ddl-listbox *")) {
			$(".ddl-listbox").hide();
		}else{
			$(".ddl-listbox").show();
		}
	};*/
	
	$dropdownlist = $(".dropdownlist");
	
	$dropdownlist.find(".ddl-select").click(function(){
		$(".ddl-listbox").show();
	});
	
	$dropdownlist.find(".btn-ok").click(function(){
		$listbox = $dropdownlist.find("input:checkbox:checked");
		var selectids = "";
		var selectvals = "";
		$listbox.each(function(){
			selectids+=$(this).val()+",";
			selectvals+=$(this).attr("text")+";";
		});
		if(""!=selectids&&selectids.length>0&&selectids.indexOf(",")>=0){
			selectids = selectids.substring(0, selectids.length-1);
		}
		if(""!=selectvals&&selectvals.length>0&&selectvals.indexOf(";")>=0){
			selectvals = selectvals.substring(0, selectvals.length-1);
		}else{
			selectvals ="选择部门";
		}
		$dropdownlist.find("#selectedvalue").val(selectids);
		$dropdownlist.find(".ddl-select").text(selectvals);
		$(".ddl-listbox").hide();
	});
	
	$dropdownlist.find(".btn-cancel").click(function(){
		$(".ddl-listbox").hide();
	});
	
	/*
	var deptdata = [];
	function getDept(){
		$.ajax({
			type : "post",
			dataType : "json",
			url : "<portlet:resourceURL id='getdept'/>",
			data : {},
			success : function(json) {
				for(var i=0;i<json.length;i++){
					var _node={
					   id:json[i]["_organizationId"],
					   name:json[i]["_name"]
					};
					deptdata.push(_node);
				}
			},
			error : function(date) {
			}
		});
	}
	getDept();

	$('#s22').dropdownlist({
		id:'dr2',
		columns:3,
		selectedtext:'',
		listboxwidth:0,
		maxchecked:5,
		checkbox:true,
		listboxmaxheight:330,
		width:588,
		data:{
			'1':'水产与生命学院','2':'宣传部','3':'图书馆',
			'4':'海洋科学学院','5':'人事处','6':'现教中心',
			'7':'食品学院','8':'教务处','9':'资产经营有限公司',
			'10':'经管学院','11':'学生处','12':'后勤服务中心',
			'13':'信息学院','14':'财务与资产管理处','15':'后勤产业',
			'16':'工程学院','17':'研究生院','18':'出国',
			'19':'人文学院','20':'科技处','21':'长期出国',
			'22':'外国语学院','23':'后勤管理处','24':'其他',
			'25':'社会科学部','26':'基建处','27':'长病假',
			'28':'国际文化交流学院','29':'工会','30':'待岗',
			'31':'爱恩学院','32':'实验室与设备管理处','33':'借调',
			'34':'继续教育学院','35':'保卫处','36':'海洋科学研究院',
			'37':'校办公室','38':'外事处（港澳台办）','39':'远洋渔业资源调查船建设管理办公室',
			'40':'组织部','41':'发展规划处','42':'学报编辑部',
			'43':'纪监审办',
		},数据，格式：{value:name}
		data:deptdata,
		onchange:function(text,value){
		   alert(text+','+value);
		}
	 });*/
	 
	$(".sub-left-ul li a").mouseover(function() {
        $(this).addClass("sub-left-ul-on").parent().siblings("li").find("a").removeClass("sub-left-ul-on");
        /*$(this).parent().next("dl").find("a").removeClass("sec-menu-on");*/
		$(this).parent().next("dl").slideDown();
		$(this).parent().siblings("li").next("dl").slideUp();
    });
});

document.body.onclick=function(e){ 
	e = window.event || e; 
	obj = $(e.srcElement || e.target);
	if ($(obj).is(".btn-area *")||!$(obj).is(".ddl-select,.ddl-select *,.ddl-listbox,.ddl-listbox *")) {
		$(".ddl-listbox").hide();
	}else{
		$(".ddl-listbox").show();
	}
}; 

</script>

<portlet:renderURL var="change" portletMode="view" windowState="<%=LiferayWindowState.EXCLUSIVE.toString()%>" />

<div class="content-wrap" id="news">
  <div class="sub-header c_253751">资讯中心</div>
  <div class="clearfix" style="height:10px;"></div>
  
  <div class="left-wrap">
    <div class="sub-left-wrap">
      <h2 class="sub-left-title">分类</h2>
      <input id="channelId" name="channelId" type="hidden" />
      <input id="channelIdCurrent" name="channelIdCurrent" type="hidden" value="${currentchannel }"/>
	  <ul class="sub-left-ul jq-channels">
		<%
			for (int i = 0; i < tabIds.size(); i++) {
		%>
		   <li level="one"><a href="javascript:void(0);" data="<%= tabIds.get(i) %>"><%= tabChannels.get(tabIds.get(i)) %></a></li>
		<%
		    List<JcChannelExt> childch = JcChannelExtLocalServiceUtil.findJcChannelExtByParentId(tabIds.get(i));
		    if(null!=childch&&childch.size()>0){
		%>
		    <dl class="sec-menu" style="display:none;">
		<%     for(int j = 0; j < childch.size(); j++){ 
				JcChannelExt twolwvel = childch.get(j);
				if(null!=twolwvel){
		 %>
	          <dd level="two"><a href="javascript:void(0);" data="<%= twolwvel.getChannelId() %>"><%=twolwvel.getChannelName() %></a></dd>
	    <%     	}
			  }%>
	        </dl>
		<% 
		    }
		 }
		%>
	 </ul>
    </div>
  </div>
  
  <div class="meet-content">
    <h2 class="app-wrap-title"></h2>
    <div class="app-wrap-search1">
	    <div class="sub-search" style="float:none; width:auto;">
	       <input id="title" class="app-wrap-input" type="text" value="" placeholder="请输入搜索标题"/>
		   <input id="queryKeywords" class="sub-submit" style="margin-left:2px;" type="button" value="搜索" />
	     </div>
		<div class="clearfix"></div>
	
	    <div id="advance_query" class="app-wrap-search2" style="font-size:12px;display:none;" id="orgChannels">
	        <p>
			    <span style="line-height:30px;">发布部门：&nbsp;</span>
			    <div id="choosedept" class="dropdownlist">
			          <input type="hidden" id="selectedvalue">
			          <div class="ddl-select">选择部门</div>
			          <div class="ddl-listbox"> 
			              <table width="100%" cellpadding="0" cellspacing="0" border="0">
			              	<tbody>
			              		<tr>
			              		   <td>
			              		      <ul>
			              		         <c:forEach items="${orglist }" var="org" varStatus="status">
			              		            <li style="display:inline-block;width:30%;line-height:15px;padding-top:2px;">
			              		               <label style="font-size:12px;">
			              		                   <input type="checkbox" name="channelorg" value="${org.organizationId }" text="${org.name }" style="line-height:15px;">
			              		                   <span title="${org.name }"> 
													    <c:choose>
															<c:when test="${fn:length(org.name )>13 }">
																<c:out value="${fn:substring(org.name ,0,13) }" />
																<B>...</B>
															</c:when>
															<c:otherwise>
																<c:out value="${org.name }" />
															</c:otherwise>
														</c:choose>
													</span>
			              		               </label>
			              		            </li>
			              		         </c:forEach>
			              		      </ul>
			              		   </td>
			              		</tr>
			              	</tbody>
			              	<tfoot>
			              	<tr>
			              		<td colspan="3">
			              			<span class="btn-area">
			              				<input type="button" value="确定" class="btn-ok">
			              				<input type="button" value="取消" class="btn-cancel">
			              			</span>
			              		</td>
			              	</tr>
			              	</tfoot>
			              	</table>
			          </div>
			    </div>
			</p>
			
			<div class="clearfix" style="height:20px;"></div>
			<p>发布时间：
		         <input type="text" id="startDate" class="app-wrap-date" placeholder="开始时间" style="margin:0 5px 0 0;" readonly="readonly" /> 到
		         <input type="text" id="endDate" class="app-wrap-date"  placeholder="结束时间" style="margin:0 0 0 10px;" readonly="readonly" />
		    </p>
		
	        <div class="clearfix"></div>
	        <p style="margin:18px 0 0 0;">
	                                 关&nbsp;&nbsp;键&nbsp;&nbsp;字：
	          <input class="message-text" id="keywords" name="keywords"  type="text" value="" placeholder="请输入搜索内容">
	        </p>
		</div>
		<div class="pull-right cd-message-advance">
			<span id="toggleAdvanceQuery" class="more-query" style="cursor:pointer;">高级搜索</span>
		</div>
	</div>
    
    <div class="clearfix" style="height:20px;"></div>
    <div class="app-wrap-content" style="min-height:1120px;">
      <table class="message-table" cellpadding="0" cellspacing="0">
        <tr>
          <th class="text-l p-fl" style="border-left:1px solid #dee3e8;padding-left:25px;width:469px;">标题</th>
          <th style="width:144px;" class="text-l">发布单位</th>
          <th style="width:108px;" class="text-l" style="border-right:1px solid #dee3e8;">发布时间</th>
        </tr>
      </table>
      <aa:zone name="newslist"></aa:zone>
      <input id="newsTotalCount" type="hidden" value="0" />
    </div>
    <div class="clearfix" style="height:20px;"></div>
     <div class="turn-page" align="center" style="position:static;">
      <div id="<portlet:namespace/>paginator" style="display:none; margin:0px;"></div>
    </div>
  </div>
  <div class="clearfix"></div>
</div>

<portlet:renderURL var="countUrl" portletMode="view" windowState="<%=LiferayWindowState.EXCLUSIVE.toString()%>">
	<portlet:param name="action" value="count"/>
</portlet:renderURL>

<portlet:renderURL var="pagerUrl" portletMode="view" windowState="<%=LiferayWindowState.EXCLUSIVE.toString()%>">
	<portlet:param name="action" value="pager"/>
</portlet:renderURL>


<aui:script>
var portlet = jQuery('#p_p_id_<%= portletId %>_');

var news = portlet.find("#news");

var jq_newsTotalCount = news.find("#newsTotalCount");

var jq_channels = news.find(".jq-channels").find("a");
var jq_sub_channels = news.find(".jq-sub-channels");//.find("div[data]");
//alert(jq_channels.length);

var jq_todo_advance_query = news.find("#advance_query");

var jq_news_queryKeywords = news.find("#queryKeywords");
var jq_news_queryAdvance = news.find("#queryAdvance");

var jq_news_channelId = news.find("#channelId");

var jq_news_keywords = news.find("#keywords");
var jq_news_startDate = news.find("#startDate");
var jq_news_endDate = news.find("#endDate");
var jq_news_org = news.find("#selectedvalue");
var jq_news_title = news.find("#title");
//var jq_news_txt = news.find("#txt");

//var jq_news_calendarDate = news.find("#calendarDate");


var g_pageSize = 20;
var g_numberOfPages = 5;

var g_pageIndex = 1;
var g_pageCount = 1;

var g_totalCount = {};

</aui:script>

<aui:script>
// 初始化分页
function initPageNews(currentPage, totalPages) {
	var paginator = news.find('#<portlet:namespace />paginator');

	options = {
		containerClass : "pagination paginator",
		size : "small",
		currentPage : currentPage,
		totalPages : totalPages,
		numberOfPages : g_numberOfPages,
        itemTexts: function (type, page, current) {
	    	switch (type) {
				case "first":
				    return "<span style='font-size:13px;'>&laquo;</span>";
				case "prev":
				    return "<span style='font-size:9px;'>&lt;</span>";
				case "next":
				    return "<span style='font-size:9px;'>&gt;</span>";
				case "last":
				    return "<span style='font-size:13px;'>&raquo;</span>";
				case "page":
				    return page;
			}
		},
		itemContainerClass: function (type, page, current) {
			switch (type) {
		        case "first":
		            return "first";
		        case "last":
		            return "last";
		        default:
		       	 return (page === current) ? "active" : "pointer-cursor";
		    }
		},
		tooltipTitles: function (type, page, current) {
			switch (type) {
				case "first":
				    return "首页";
				case "prev":
				    return "前页";
				case "next":
				    return "后页";
				case "last":
				    return "末页";
				case "page":
				    return "第 " + page + " 页";
		    }
		},
		onPageClicked : function(e, originalEvent, type, page) {
			changeNews(page);
		}
	};

	paginator.bootstrapPaginator(options);
	paginator.show();
}

initPageNews(g_pageIndex, g_pageCount);

</aui:script>

<aui:script>

jQuery(function($){
	initNews();
});

function initNews() {
	var jq_orgChannels = news.find("#orgChannels");
	var jq_newsOrgMore = news.find(".cd-news-org-more");
	var jq_newsOrgExpanded = false;
	jq_newsOrgMore.click(function(){
		jq_newsOrgExpanded = !jq_newsOrgExpanded;
		
		jq_orgChannels.toggleClass("cd-news-of");
		jq_newsOrgMore.toggleClass("cd-news-expand").text(jq_newsOrgExpanded?"收起":"更多");
	});
	
	jQuery("#toggleAdvanceQuery").click(function(){
	   if(!$("#news").find("#advance_query").is(":hidden")){
	   	   $(this).removeClass("more-query-down").text("高级搜索");
	   }else{
	   	   $(this).addClass("more-query-down").text("收起搜索");
	   }
		jQuery("#advance_query").slideToggle();
	});
	
	var intervalID = 0;
	var channelIdCurrent = news.find("#channelIdCurrent").val();
	jq_channels.each(function(i){
		var jq_channel = jQuery(this).css({"cursor":"pointer"});
		var channelId = jq_channel.attr("data");
		/*
		jq_channel.mouseover(function(){
			if (channelIdCurrent == channelId) return;
			
			intervalID = setTimeout(function(){
				jq_channels.removeClass("sub-left-ul-on");
				jq_channel.addClass("sub-left-ul-on");
				
				channelIdCurrent = channelId;
				
			//	jq_contents.removeClass("active");
			//	news.find("#tab-panel-"+channelId).addClass("active");
				
				jq_sub_channels.find("div[data]").hide();
				var jq_sub_channel = jq_sub_channels.find("div[data='tabSubChannels_"+channelId+"']");
				if (jq_sub_channel.find("input[type='checkbox']").length > 0) {
					jq_sub_channel.show();
					jq_sub_channel.parent().parent().show();
				} else {
					jq_sub_channel.parent().parent().hide();
				}
				
				jq_news_channelId.val(channelId);
				
				g_pageIndex = 1;
				
				resetNews();
			}, 500);
		}).mouseout(function(){
			clearTimeout(intervalID);
		});
		*/
		jq_channel.click(function(){
			clearTimeout(intervalID);
			
			channelIdCurrent = channelId;
			
			jq_channels.removeClass("sub-left-ul-on");
			jq_channel.addClass("sub-left-ul-on");
			
			var level = jq_channel.parent().attr("level");
			if("two"==level){
				jq_channels.removeClass("sec-menu-on");
				jq_channel.addClass("sec-menu-on");
			}
			
			jq_sub_channels.find("div[data]").hide();
			var jq_sub_channel = jq_sub_channels.find("div[data='tabSubChannels_"+channelId+"']");
			if (jq_sub_channel.find("input[type='checkbox']").length > 0) {
				jq_sub_channel.show();
				jq_sub_channel.parent().parent().show();
			} else {
				jq_sub_channel.parent().parent().hide();
			}
			
			jq_news_channelId.val(channelId);
			
			g_pageIndex = 1;
			
			resetNews();
		});

		if (channelIdCurrent==0 && i==0) {
			jq_channel.click();
		} else if (channelIdCurrent == channelId) {
			jq_channel.click();
		}
	});
	
	jq_sub_channels.find("input[type='checkbox']").each(function(){
		var jq_sub_channel = jQuery(this);
		jq_sub_channel.click(function(){
			g_pageIndex = 1;
			changeNews();
		});
	});
	
	jq_news_startDate.change(function() {
		g_pageIndex = 1;
		changeNews();
	});
	jq_news_endDate.change(function() {
		g_pageIndex = 1;
		changeNews();
	});
	
	jq_news_title.keypress(function(event) {
		if ( event.which == 13 ) {
			g_pageIndex = 1;
			changeNews();
		}
	});
	/*jq_news_txt.keypress(function(event) {
		if ( event.which == 13 ) {
			g_pageIndex = 1;
			changeNews();
		}
	});*/
	
	jq_news_queryKeywords.click(function(){
		g_pageIndex = 1;
		
		changeNews();
	});
	
	jq_news_queryAdvance.click(function(){
		g_pageIndex = 1;
		
		changeNews();
	});
	
}
</aui:script>

<aui:script>
function resetNews() {
	g_pageIndex = 1;
	
	jq_sub_channels.find("input[type='checkbox']").prop({"checked": false});
	
	jq_news_keywords.val("");
	jq_news_startDate.val("");
	jq_news_endDate.val("");
	jq_news_title.val("");
	/*jq_news_txt.val("");*/
	
	changeNews();
}

function changeNews(pageIndex, numberOfPages) {
	g_pageIndex = pageIndex || g_pageIndex;
	g_numberOfPages = numberOfPages || g_numberOfPages;
	
	if (!pageIndex) {
		jq_newsTotalCount.val(-1);
	}
	
	var channelId = jq_news_channelId.val();
	var subChannleIds = "";
	jq_sub_channels.find("div[data='tabSubChannels_"+channelId+"']").eq(0).find("input[type='checkbox']").each(function(){
		var jq_sub_channel = jQuery(this);
		if (jq_sub_channel.prop("checked")) {
			subChannleIds += ","+jq_sub_channel.val();
		}
	});
	subChannleIds = subChannleIds == "" ? "" : subChannleIds.substr(1);
	
	var startDate = jq_news_startDate.val();
	var endDate = jq_news_endDate.val();
	var deptids = jq_news_org.val();
	
	var params = "" 
		+ "&<portlet:namespace />channelId=" + channelId 
		+ "&<portlet:namespace />keywords=" + encodeURIComponent(jq_news_keywords.val()) 
		+ "&<portlet:namespace />startDate=" + startDate 
		+ "&<portlet:namespace />endDate=" + endDate 
		+ "&<portlet:namespace />title=" + encodeURIComponent(jq_news_title.val()) 
//	    + "&<portlet:namespace />txt=" + encodeURIComponent(jq_news_txt.val())
	    + "&<portlet:namespace />deptids=" + deptids
		+ "&<portlet:namespace />subChannleIds=" + subChannleIds
	;
	
	var counturl = '<%= countUrl %>' + params;
	
	$.ajax({
		type : "POST",
		dataType : "text",
		url : counturl,
		data: {},
		success : function(data) {
		
			var json = eval("("+data+")");
			
			if (json.ex) {
				alert(json.ex);
				return;
			}
			
			var currentNewsTotalCount = parseInt(jq_newsTotalCount.val());
			var totalCount = json.totalcount;
			jq_newsTotalCount.val(totalCount);
			
			// 如果服务器返回记录总数 不等于 上次加载时的记录总数，则重新请求服务器加载数据
			var needReload = (currentNewsTotalCount != totalCount);

			// 初始化分页，传入当前页码，每页显示数，总页数
			//if (needReload) {
				g_pageCount = parseInt(totalCount / g_pageSize) + (totalCount % g_pageSize > 0 ? 1 : 0);
				if (g_pageIndex>g_pageCount) {g_pageIndex=g_pageCount;}
				if (g_pageIndex==0) {g_pageIndex=1;g_pageCount=1;}
				
				initPageNews(g_pageIndex, g_pageCount);
			//}

			var pageAreaAll = news.find('.news_list_page'); pageAreaAll.hide();
			var pageAreas = news.find('.news_list_page_'+channelId); pageAreas.hide();
			var pageArea = news.find('#news_list_page_'+channelId+'_'+g_pageIndex);
			
			if (!needReload && (typeof pageArea.html()!='undefined')) {
				// 若已加载过数据，且数据未变化，则直接显示
				pageArea.show();
			} else {
				// 否则 重新请求服务器加载
				if (needReload) {
					pageAreas.remove();
				}
				
				var url = '<%=pagerUrl%>' 
					+ "&<portlet:namespace />cur=" + g_pageIndex 
					+ "&<portlet:namespace />delta=" + g_pageSize 
					+ params;
				
				post(url, function() {
					pageArea = news.find('#news_list_page_'+channelId+'_'+g_pageIndex);
					pageArea.show();
				});
			}

		},
		error : function(data) {
		}
	});
}

// 通用的一个跳转方法，适用于所有跟分页有关的刷新，后台调用方法通过url传入
function post(url, callback) {
	$.ajax({
		type : "POST",
		dataType : "text",
		url : url,
		data : {
		},
		success : function(data) {
			if (data.length > 0) {
				idname = "aazone\\." + '<portlet:namespace />newslist';
				//$("#" + idname).html(data);
				$("#" + idname).append(data);
				
				callback();
			}
			;
		},
		error : function(data) {
		}
	});
}
</aui:script>

<aui:script>

//$(document).ready(readyLoad);

function readyLoad() {
	var container = $('#<portlet:namespace />paginator');
	var pageIndex = $('#<portlet:namespace />pageIndex').val();
	var pageCount = $('#<portlet:namespace />pageCount').val();

	options = {
		containerClass : "pagination",
		currentPage : pageIndex,
		numberOfPages : 5,
		totalPages : pageCount,
		pageUrl : function(type, page) {
			return null;
		},
		onPageClicked : function(e, originalEvent, type, page) {
			<portlet:namespace />subpages('<%=change%>', page, '<portlet:namespace />newslist');
		},
		onPageChanged : null
	};

	container.bootstrapPaginator(options);
	
	function <portlet:namespace />subpages(change, pagecur, idname) {
		var querystr = $("#cd-find").val();

		$.ajax({
			type : "POST",
			dataType : "text",
			url : change,
			data : {
				"<portlet:namespace />cur" : pagecur,
				"<portlet:namespace />delta" : "5",
				"<portlet:namespace />date" : date,
				"<portlet:namespace />tabCount" : tabCount,
				"<portlet:namespace />querystr" : querystr
			},
			success : function(data) {
				if (data.length > 0) {
					idname = "aazone\\." + idname;
					$("#" + idname).html(data);
					readyLoad();
				};
			},
			error : function(data) {
			}
		});
	}
}
	
function <portlet:namespace />search() {
	gDate = "";
	a.setSelected(new Date());
	
	var querystr = $("#cd-find").val();
	if (querystr.trim()=="" || querystr=="请输入搜索内容") {
		alert("请输入搜索内容。");
		return;
	}
	url ='<%=change%>' + '&<portlet:namespace />tabCount=' + gTabCount + '&<portlet:namespace />querystr=' + querystr;
	jump(url);
}

function <portlet:namespace />changeTab(tabCount) {
	gTabCount = tabCount;

	gDate = "";
	a.setSelected(new Date());

	$("#cd-find").val("");
	
	url = '<%=change%>' + '&<portlet:namespace />tabCount=' + gTabCount;
	jump(url);
}
	
function jump(url){
	$.ajax({
		type : "POST",
		dataType : "text",
		url : url,
		data : {
		},
		success : function(data) {
			if (data.length > 0) {
				idname = "aazone\\." + '<portlet:namespace />newslist';
				$("#" + idname).html(data);
				readyLoad();
			}
			;
		},
		error : function(data) {
		}
	});
}
</aui:script>

<aui:script>
jQuery(function($) {  
	// 为日历汉化
	$.datepicker.regional['zh-CN'] = {  
		clearText: '清除',  
		clearStatus: '清除已选日期',  
		closeText: '关闭',  
		closeStatus: '不改变当前选择',  
		prevText: '&lt;上月',  
		prevStatus: '显示上月',  
		prevBigText: '&lt;&lt;',  
		prevBigStatus: '显示上一年',  
		nextText: '下月>',  
		nextStatus: '显示下月',  
		nextBigText: '>>',  
		nextBigStatus: '显示下一年',  
		currentText: '今天',  
		currentStatus: '显示本月',  
		monthNames: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],  
		monthNamesShort: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],  
  		monthStatus: '选择月份',  
		yearStatus: '选择年份',  
		weekHeader: '周',  
		weekStatus: '年内周次',  
		dayNames: ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],  
		dayNamesShort: ['周日', '周一', '周二', '周三', '周四', '周五', '周六'],  
		dayNamesMin: ['<font color="red">日</font>', '一', '二', '三', '四', '五', '<font color="red">六</font>'],  
		dayStatus: '设置 DD 为一周起始',  
		dateStatus: '选择 m月 d日, DD',  
		dateFormat: 'yy-mm-dd',  
		firstDay: 1,  
		initStatus: '请选择日期',  
		isRTL: false  
	};  
	$.datepicker.setDefaults($.datepicker.regional['zh-CN']);  

	// 加载日历
	$("#startDate").datepicker({
		showAnim:"slideDown",
		showOtherMonths: true,
		selectOtherMonths: true,
		changeMonth: true,
		changeYear: true,
		numberOfMonths: 1,
		dateFormat: 'yy-mm-dd',
		maxDate: "+0M +0D",
		regional:"zh-CN",
		onClose: function( selectedDate ) {
			if (selectedDate == "") return;
			$( "#endDate" ).datepicker( "option", "minDate", selectedDate );
		}
	});
	$("#endDate").datepicker({
		showAnim:"slideDown",
		showOtherMonths: true,
		selectOtherMonths: true,
		changeMonth: true,
		changeYear: true,
		numberOfMonths: 1,
		dateFormat: 'yy-mm-dd',
		maxDate: "+0M +0D",
		regional:"zh-CN",
		onClose: function( selectedDate ) {
			if (selectedDate == "") return;
			$( "#startDate" ).datepicker( "option", "maxDate", selectedDate );
		}
	});
});
</aui:script>
