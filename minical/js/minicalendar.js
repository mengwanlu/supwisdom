//define(function(require, exports, module) { //参数名字不能改
function minicalendar(option) {
	this.__option = $.extend({
		weekStart : 1,
		weekName : [ i18n.minicalendar.dateformat.sun,
				i18n.minicalendar.dateformat.mon,
				i18n.minicalendar.dateformat.tue,
				i18n.minicalendar.dateformat.wed,
				i18n.minicalendar.dateformat.thu,
				i18n.minicalendar.dateformat.fri,
				i18n.minicalendar.dateformat.sat ], // 星期的格式
		monthName : [ i18n.minicalendar.dateformat.jan,
				i18n.minicalendar.dateformat.feb,
				i18n.minicalendar.dateformat.mar,
				i18n.minicalendar.dateformat.apr,
				i18n.minicalendar.dateformat.may,
				i18n.minicalendar.dateformat.jun,
				i18n.minicalendar.dateformat.jul,
				i18n.minicalendar.dateformat.aug,
				i18n.minicalendar.dateformat.sep,
				i18n.minicalendar.dateformat.oct,
				i18n.minicalendar.dateformat.nov,
				i18n.minicalendar.dateformat.dec ], // 月份的格式
		monthp : i18n.minicalendar.dateformat.postfix,
		dateValueFormat : i18n.minicalendar.dateformat.dateValueFormat,
		currentYear : new Date().getFullYear(),
		currentMonth : new Date().getMonth(),
		currentDate : new Date(),
		today : new Date(),
		maxDate : false,
		onchange : false,
		onclick : false,
		onreset : false
	}, option);
}
minicalendar.prototype = {
	init : function(parent) {
		this.__parent = $(parent);
		this.__parent.addClass("minicalendar");
		this.currentYear = this.__option.currentDate.getFullYear();
		this.currentMonth = this.__option.currentDate.getMonth();
		this.render();
		this.filldate();
		this.__initevent();
	},
	__initevent : function() {
		// body...
		var me = this;
		var aprev = this.__parent.find("a.cal-prev");
		var anext = this.__parent.find("a.cal-next");
		aprev.click(function() {
			var currentDate = new Date(me.__option.currentDate);
			
			currentDate.setFullYear(me.currentYear);
			currentDate.setMonth(me.currentMonth);
			currentDate.setDate(1);
			currentDate = DateAdd("m", -1, currentDate);
			
			me.currentYear = currentDate.getFullYear();
			me.currentMonth = currentDate.getMonth();

			
			me.filldate();
		//	if (me.__option.onchange) {
		//		me.__option.onchange.call(me, me.__option.currentDate);
		//	}
		});
		anext.click(function() {
			var currentDate = new Date(me.__option.currentDate);
			
			currentDate.setFullYear(me.currentYear);
			currentDate.setMonth(me.currentMonth);
			currentDate.setDate(1);
			currentDate = DateAdd("m", 1, currentDate);

			me.currentYear = currentDate.getFullYear();
			me.currentMonth = currentDate.getMonth();

			me.filldate();
		//	if (me.__option.onchange) {
		//		me.__option.onchange.call(me, me.__option.currentDate);
		//	}
		});

	},
	render : function(argument) {
		var html = [];

		html.push("<div class='minical-p1'>");
		html.push("<div class='minical-p1-head'>", 
				"<a class='cal-prev' href='javascript:void(0);' hidefocus='on'></a>", 
				"<span class='ymbtn'></span>", 
				"<a class='cal-next' href='javascript:void(0);' hidefocus='on'></a>", 
				"</div>");
		// 周
		html.push("<table class='minical-body' cellspacing='0'><thead><tr>");
		// 生成周
		for (var i = this.__option.weekStart, j = 0; j < 7; j++) {
			html.push("<th><span>", this.__option.weekName[i], "</span></th>");
			if (i == 6) {
				i = 0;
			} else {
				i++;
			}
		}
		html.push("</tr></thead>");
		// 生成tBody,需要重新生成的
		html.push("<tbody></tbody></table>");
		html.push("</div>");
		this.__parent.html(html.join(""));
	},
	filldate : function() {
		var me = this;
		var tb = this.__parent.find("table.minical-body tbody");
		var yearName = this.currentYear + "年";
		var monthName = (this.currentMonth+1) + "月";
		
		$("span.ymbtn").html(yearName + " " + monthName);
		
		var year = this.currentYear;
		var month = this.currentMonth;
		var firstdate = new Date(year, month, 1);

		var diffday = this.__option.weekStart - firstdate.getDay();
		if (diffday > 0) {
			diffday -= 7;
		}
		var startdate = DateAdd("d", diffday, firstdate);
		var enddate = DateAdd("d", 42, startdate);
		var tds = this.__option.today.Format(this.__option.dateValueFormat);
		var ins = this.__option.currentDate.Format(this.__option.dateValueFormat);
		var bhm = [];
		var dtenable = [];
		for (var i = 1; i <= 42; i++) {
			if (i % 7 == 1) {
				bhm.push("<tr>");
			}
			
			dtenable[i-1] = true;
			
			var ndate = DateAdd("d", i - 1, startdate);
			var tdc = [];
			if (ndate.getMonth() < month) {
				tdc.push("minical-prevday");
			} else if (ndate.getMonth() > month) {
				tdc.push("minical-nextday");
			}
			
			var s = ndate.Format(this.__option.dateValueFormat);
			
			if (this.__option.maxDate) {
				var maxds = this.__option.maxDate.Format(this.__option.dateValueFormat);
				if (s > maxds) {
					dtenable[i-1] = false;
					tdc.push("minical-disabled");
				}
			}
			
			if (s == tds) {
				tdc.push("minical-today");
			}
			else if (s == ins) {
				tdc.push("minical-current");
			}

			bhm.push(
				"<td class='", tdc.join(" "), "' title='", ndate.Format(this.__option.dateValueFormat),
				"' xdate='", ndate.Format("yyyy-M-d"), "'>",
				"<a href='javascript:void(0);' hidefocus='on'>",
				"<span>", ndate.getDate(), "</span>",
				"</a>",
				"</td>");
			
			if (i % 7 == 0) {
				bhm.push("</tr>");
			}
		}
		tb.html(bhm.join(""));
		tb.find("td").each(function(i) {
			if (dtenable[i] == true) {
				$(this).click(tbclick);
			}
		});
		
		function tbclick() {
			if ($(this).prop("data") == "current-click") {
				
				$(this).removeProp("data");
				$(this).removeClass("minical-current").blur();
				
				if (me.__option.onclick) {
					me.__option.onclick.call(me, null);
				}
			} else {
				me.__parent.find("td.minical-current").each(function() {
					$(this).removeProp("data");
					$(this).removeClass("minical-current");
				});

				$(this).prop({"data": "current-click"});
				$(this).addClass("minical-current").blur();
				
				var idate = $(this).attr("xdate");
				var date = idate.split(/\D/);
				me.__option.currentDate = new Date(date[0], parseInt(date[1], 10) - 1, date[2]);
				if (me.__option.onchange) {
					me.__option.onchange.call(me, me.__option.currentDate);
				}
				
				if (me.__option.onclick) {
					me.__option.onclick.call(me, me.__option.currentDate);
				}
			}
		};
	},
	reset : function() {
		var me = this;
		me.__parent.find("td.minical-current").each(function() {
			$(this).removeProp("data");
			$(this).removeClass("minical-current");
		});
		
		me.__option.currentDate = me.__option.today;
		
		var currentDate = new Date(me.__option.currentDate);
		
		me.currentYear = currentDate.getFullYear();
		me.currentMonth = currentDate.getMonth();
		
		me.filldate();
		
		if (me.__option.onreset) {
			me.__option.onreset.call(me);
		}
	},
	togo : function(date) {
		// body...
		this.__option.currentDate = date;
		this.filldate();
	}
};
// module.exports = minicalendar;
// });


// common

Date.prototype.Format = function (format) {
    var o = {
        "M+": this.getMonth() + 1,
        "d+": this.getDate(),
        "h+": this.getHours(),
        "H+": this.getHours(),
        "m+": this.getMinutes(),
        "s+": this.getSeconds(),
        "q+": Math.floor((this.getMonth() + 3) / 3),
        "w": "0123456".indexOf(this.getDay()),
        "S": this.getMilliseconds()
    };
    if (/(y+)/.test(format)) {
        format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    }
    for (var k in o) {
        if (new RegExp("(" + k + ")").test(format))
            format = format.replace(RegExp.$1,
      RegExp.$1.length == 1 ? o[k] :
        ("00" + o[k]).substr(("" + o[k]).length));
    }
    return format;
};
function DateAdd(interval, number, idate) {
    number = parseInt(number);
    var date = new Date();
    if (typeof (idate) == "string") {
        date = idate.split(/\D/);
        eval("var date = new Date(" + date.join(",") + ")");
    }

    if (typeof (idate) == "object") {
        date = new Date(idate.toString());
    }
    switch (interval) {
        case "y": date.setFullYear(date.getFullYear() + number); break;
        case "m": date.setMonth(date.getMonth() + number); break;
        case "d": date.setDate(date.getDate() + number); break;
        case "w": date.setDate(date.getDate() + 7 * number); break;
        case "h": date.setHours(date.getHours() + number); break;
        case "n": date.setMinutes(date.getMinutes() + number); break;
        case "s": date.setSeconds(date.getSeconds() + number); break;
        case "l": date.setMilliseconds(date.getMilliseconds() + number); break;
    }
    return date;
};