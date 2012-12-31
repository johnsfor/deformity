package com.deformity.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class DateUtil {
	
	public static void main(String[] args){
		//取当前月份的前若干月的日期
		String dt = "2009-11-03";
		System.out.println(DateAdd(dt, -1, 2,"yyyyMM"));
	}
	public DateUtil() {
	}
	public static String getStrDate(Date date,String format){
		//yyyy-MM-dd"
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format(date);
	}
	/**
	* @see     取得当前日期（格式为：yyyy-MM-dd）
	 * @return String
	 */
	public static String GetDate(String format) {
		//SimpleDateFormat sdf = new SimpleDateFormat(format);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String sDate = sdf.format(new Date());
		return sDate;
	}

	/**
	 * @see     取得当前时间（格式为：yyy-MM-dd HH:mm:ss）
	 * @return String
	 */
	public static String GetDateTime() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String sDate = sdf.format(new Date());
		return sDate;
	}

	/**
	 * @see     按指定格式取得当前时间()
	 * @return String
	 */
	public static String GetTimeFormat(String strFormat) {
		SimpleDateFormat sdf = new SimpleDateFormat(strFormat);
		String sDate = sdf.format(new Date());
		return sDate;
	}

	/**
	 * @see     取得指定时间的给定格式()
	 * @return String
	 * @throws java.text.ParseException
	 */
	public String SetDateFormat(String myDate, String strFormat)
			throws ParseException {

		SimpleDateFormat sdf = new SimpleDateFormat(strFormat);
		String sDate = sdf.format(sdf.parse(myDate));

		return sDate;
	}

	public String FormatDateTime(String strDateTime, String strFormat) {
		String sDateTime = strDateTime;
		try {
			Calendar Cal = parseDateTime(strDateTime);
			SimpleDateFormat sdf = null;
			sdf = new SimpleDateFormat(strFormat);
			sDateTime = sdf.format(Cal.getTime());
		} catch (Exception e) {

		}
		return sDateTime;
	}

	public static Calendar parseDateTime(String baseDate) {
		Calendar cal = null;
		cal = new GregorianCalendar();
		int yy = Integer.parseInt(baseDate.substring(0, 4));
		int mm = Integer.parseInt(baseDate.substring(5, 7)) - 1;
		int dd = Integer.parseInt(baseDate.substring(8, 10));
		int hh = 0;
		int mi = 0;
		int ss = 0;
		if (baseDate.length() > 12) {
			hh = Integer.parseInt(baseDate.substring(11, 13));
			mi = Integer.parseInt(baseDate.substring(14, 16));
			ss = Integer.parseInt(baseDate.substring(17, 19));
		}
		cal.set(yy, mm, dd, hh, mi, ss);
		return cal;
	}

	public int getDay(String strDate) {
		Calendar cal = parseDateTime(strDate);
		return cal.get(Calendar.DATE);
	}

	public int getMonth(String strDate) {
		Calendar cal = parseDateTime(strDate);

		return cal.get(Calendar.MONTH) + 1;
	}

	public static int getWeekDay(String strDate) {
		Calendar cal = parseDateTime(strDate);
		return cal.get(Calendar.DAY_OF_WEEK);
	}

	public static String getWeekDayName(String strDate) {
        String mName[] = { "日", "一", "二", "三", "四", "五", "六" };
                int iWeek = getWeekDay(strDate);
                iWeek = iWeek - 1;
                return "星期" + mName[iWeek];

	}

	public int getYear(String strDate) {
		Calendar cal = parseDateTime(strDate);
		return cal.get(Calendar.YEAR) + 1900;
	}

	public static String DateAdd(String strDate, int iCount, int iType) {
		Calendar Cal = parseDateTime(strDate);

		Cal.add(iType, iCount);
		SimpleDateFormat sdf = null;
		if (iType <= 2)
			sdf = new SimpleDateFormat("yyyy-MM-dd");
		else
			sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String sDate = sdf.format(Cal.getTime());
		return sDate;
	}
	public static String DateAdd(String strDate, int iCount, int iType,String format) {
		Calendar Cal = parseDateTime(strDate);
		
		Cal.add(iType, iCount);
		SimpleDateFormat sdf = null;
		if (iType <= 2)
			sdf = new SimpleDateFormat(format);
		else
			sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String sDate = sdf.format(Cal.getTime());
		return sDate;
	}
	
	public String DateAdd(String strOption, int iDays, String strStartDate) {
		if (!strOption.equals("d"))	;
		return strStartDate;
	}

	public int DateDiff(String strDateBegin, String strDateEnd, int iType) {
		Calendar calBegin = parseDateTime(strDateBegin);
		Calendar calEnd = parseDateTime(strDateEnd);
		long lBegin = calBegin.getTimeInMillis();
		long lEnd = calEnd.getTimeInMillis();
		int ss = (int) ((lBegin - lEnd) / 1000L);
		int min = ss / 60;
		int hour = min / 60;
		int day = hour / 24;
		if (iType == 0)
			return hour;
		if (iType == 1)
			return min;
		if (iType == 2)
			return day;
		else
			return -1;
	}

    /*****************************************
         * @功能     判断某年是否为闰年
         * @return  boolean
         * @throws ParseException
         ****************************************/
        public boolean isLeapYear(int yearNum) {
            boolean isLeep = false;
            /**判断是否为闰年，赋值给一标识符flag*/
            if ((yearNum % 4 == 0) && (yearNum % 100 != 0)) {
                isLeep = true;
            } else if (yearNum % 400 == 0) {
                isLeep = true;
            } else {
                isLeep = false;
            }
            return isLeep;
        }


}