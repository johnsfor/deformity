/**
 * 扩展方法,列大小按照百分比分配 jqueryui的datagird
 * @param percent 百分比(小数)
 */
function fixWidth(percent) {
    return (document.body.clientWidth - 160) * percent;
}

/**
 * 字符串是否为空
 * @param str 字符串
 */
function isNull(str) {
    return null == str || typeof(str) == "undefined" || "" == str || "null" == str;
}
/**
 * 秒转分钟
 * 保留两位小数
 * @param {}
        *            val
 * @return {}
 */
function converSecToMin(val) {
    if (val == null || val == 'null')
        return '-';
    if (val == '0' | val == 0)
        return 0;
    return (val / 60).toFixed(2);
}
/**
 * 通用添加颜色方法，正颜色不变，负为红色
 */
function renderRedColor(inputVal) {
    var tempStr = inputVal + "";

    if (tempStr.indexOf('%') != -1) {
        tempStr = tempStr.replace("%", " ")
    }
    if (tempStr > 0) {
        tempStr = "<font color='#EF0000'>" + inputVal + "</font>";
    } else if (tempStr < 0) {
        tempStr = "<font color='#008000'>" + inputVal + "</font>";
    } else {
        tempStr = inputVal;
    }
    return tempStr;
}
/**
 * 渲染百分号
 *
 * @param {}
        *            val
 * @return {}
 */
function persentRender(val) {
    if (val == null || val == 'null')
        return '-';
    return val + '%';
}

/**
 * radio选中
 * @param radioName
 * @param radiovalue
 */
function getRadioBoxValue(radioName, radiovalue) {
    var obj = document.getElementsByName(radioName);
    for (i = 0; i < obj.length; i++) {

        if (obj[i].value == radiovalue) {
            obj[i].checked = true;
        }
    }

    return true;
}
/**
 * 父页面radio选中
 * @param radioName
 * @param radiovalue
 */
function getRadioBoxValueAddParent(radioName, radiovalue) {
    var obj = opener.document.getElementsByName(radioName);
    for (i = 0; i < obj.length; i++) {

        if (obj[i].value == radiovalue) {
            obj[i].checked = true;
        }
    }

    return true;
}



/**
 * null --->> 空
 * @param str 字符串
 */
function nullToEmpty(str) {
    if ("null" == str || null == str || typeof(str) == "undefined" || "" == str)
        return "";
    else
        return str;
}

/**是否为手机**/
function isMobile(s) {
    var reg0 = /^13\d{5,9}$/;
    var reg1 = /^15\d{5,9}$/;
    // var reg2 = /^159\d{4,8}$/;
    var reg3 = /^0\d{10,11}$/;
    var reg4 = /^17\d{5,9}$/;
    var reg5 = /^18\d{5,9}$/;
    var my = false;
    if (reg0.test(s))my = true;
    if (reg1.test(s))my = true;
    // if (reg2.test(s))my = true;
    if (reg3.test(s))my = true;
    if (reg4.test(s))my = true;
    if (reg5.test(s))my = true;
    return my;
}
/**是否为座机**/
function isTel(s) {
    var pattern = /(^[0-9]{3,4}\-[0-9]{3,8}$)|(^[0-9]{3,8}$)|(^\([0-9]{3,4}\)[0-9]{3,8}$)|(^0{0,1}13[0-9]{9}$)/;
    return pattern.test(s);
}
/**字符串是否在数组中**/
function inarray(obj, arr) {
    if (typeof obj == 'string') {
        for (var i in arr) {
            if (arr[i] == obj) {
                return true;
            }
        }
    }
    return false;
}
/**字符串出现在数组中个数**/
function inarray(obj, arr) {
    var result=0;
    if (typeof obj == 'string') {
        for (var i in arr) {
            if (arr[i] == obj) {
                result++;
            }
        }
    }
    return result;
}
/**字符串补零**/
function pad(num, n) {
    var len = num.toString().length;
       while(len < n) {
           num = "0" + num;
           len++;
       }
    return num;
}
 //日期格式化
Date.prototype.format = function(format){
var o = {
"M+" : this.getMonth()+1, //month
"d+" : this.getDate(), //day
"h+" : this.getHours(), //hour
"m+" : this.getMinutes(), //minute
"s+" : this.getSeconds(), //second
"q+" : Math.floor((this.getMonth()+3)/3), //quarter
"S" : this.getMilliseconds() //millisecond
}
if(/(y+)/.test(format)) {
format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
}

for(var k in o) {
if(new RegExp("("+ k +")").test(format)) {
format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length));
}
}
return format;
}
//yzb 清空字符串两端空格
String.prototype.trim = function() {     
    return this.replace(/^\s+/g,"").replace(/\s+$/g,"");     
}