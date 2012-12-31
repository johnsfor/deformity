package com.deformity.util;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;

public class StringUtil extends StringUtils {

	public StringUtil() {
		super();
	}

	/**
	 * 对象转化为String，为空转化为空 [""]
	 * @param obj
	 * @return
	 */
	public static String toString(Object obj) {
		return obj == null ? "" : obj.toString();
	}
	
	/**
	 * 对象转化为String，为空转化为默认值 [defaultVale]
	 * @param obj
	 * @param defaultVale
	 * @return
	 */
	public static String toString(Object obj, String defaultVale) {
		return obj == null ? defaultVale : obj.toString();
	}
	
	/**
     * 取得匹配的字符串
     * 
     * @param input
     * @param regex
     * @return
     */
    public static List<String> matchs(String input, String regex, int group) {
        Pattern pattern = Pattern.compile(regex);
        Matcher match = pattern.matcher(input);
        List<String> matches = new ArrayList<String>();
        while (match.find()) {
            matches.add(match.group(group));
        }
        return matches;
    }
    
    /**
     * 检查对象是否有效 obj != null && obj.toString().length() > 0
     * 
     * @param obj
     * @return boolean
     */
    public static boolean isValid(Object obj) {
        return obj != null && obj.toString().length() > 0;
    }
    
    /**
     * 格式化数字
     * 
     * @param str
     * @param pattern
     * @return
     */
    public static String toDecimalFormat(String str, String pattern) {
        if (StringUtil.isEmpty(pattern)) {
            return str;
        }
        DecimalFormat fmt = new DecimalFormat(pattern);
        fmt.setGroupingUsed(true);
        String outStr = null;
        double d;
        try {
            d = Double.parseDouble(str);
            outStr = fmt.format(d);
        } catch (Exception e) {
        }
        return outStr;
    }

	public static String HtmlEncode(String str) {
		if (str == null || "".equals(str)) {
			return "";
		}
		str = str.replaceAll("&", "&amp;");
		str = str.replaceAll("'", "''");
		str = str.replaceAll("\"", "&quot;");
		str = str.replaceAll(" ", "&nbsp;");
		str = str.replaceAll("<", "&lt;");
		str = str.replaceAll(">", "&gt;");
		str = str.replaceAll("\n", "<br>");
		return str;
	}
	public static String HtmlDecode(String str) {
		if (str == null || "".equals(str)) {
			return "";
		}
		str = str.replaceAll("\n", "<br>");
		str = str.replaceAll("&gt;", ">");
		str = str.replaceAll("&lt;", "<");
		str = str.replaceAll("&nbsp;", " ");
		str = str.replaceAll("&quot;", "\"");
		str = str.replaceAll("'", "''");
		return str;
	}

	public static String sqlEncode(String strValue, boolean isLikeStatement) {
		if (strValue == null || "".equals(strValue)) {
			return "";
		}
		String rtStr = strValue;
		if (isLikeStatement) {
			rtStr = strValue.replaceAll("[", "[[]"); // 此句一定要在最前
			rtStr = rtStr.replaceAll("_", "[_]");
			rtStr = rtStr.replaceAll("%", "[%]");
			rtStr = rtStr.replaceAll("\\", "\\\\");
		}
		rtStr = rtStr.replaceAll("'", "''");
		return rtStr;
	}
}
