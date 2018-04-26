package so.wwb.gamebox.tools;

import org.soul.commons.lang.DateQuickPickerTool;
import org.soul.commons.lang.DateTool;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

/**
 * 数据中心Tool
 * @author martin
 * @time 18-4-25
 */
public class MReportTool {

    public static final String MM_DD = "mm.dd";

    /**
     * 获取指定日期的前一周的周后一天(这里将周日作为一周最后一天)
     * @param date
     * @return
     */
    public static Date getLastWeekLastDay(TimeZone timeZone, Date date) {
        Calendar c = Calendar.getInstance();
        c.setTimeZone(timeZone);
        c.setTime(date);
        int day_of_week = c.get(Calendar.DAY_OF_WEEK) - 1;
        if (day_of_week == 0)
            day_of_week = 7;
        c.add(Calendar.DATE, -day_of_week);
        return c.getTime();
    }

    /**
     * 获取指定日期的前一个月最后一天
     * @param timeZone
     * @param date
     * @return
     */
    public static Date getLastMonthLastDay(TimeZone timeZone, Date date) {
        DateQuickPickerTool instance = DateQuickPickerTool.getInstance();
        Date targetMonth = instance.getMonthDay(timeZone, DateQuickPickerTool.LAST_MONTH_FIRST_DAY, date);//上个月第一天
        return instance.getMonthDay(timeZone, DateQuickPickerTool.MONTH_LAST_DAY, targetMonth);//上个月最后一天
    }

    /**
     * 将指定期格式
     * @param date
     * @return
     */
    public static String getDate(Date date, String fmt) {
        String str = DateTool.formatDate(date, DateTool.yyyy_MM_dd);
        if(MM_DD.equalsIgnoreCase(fmt)) {
            return str.substring(str.indexOf("-") + 1, str.length()).replace("-", ".");
        } else {
            return str.replace("-", ".");
        }
    }

    public static void main(String[] args) {
        try {
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            Date date = df.parse("2018-03-22");
            //MReportTool.getLastWeekLastDay(TimeZone.getDefault(), date);
            MReportTool.getLastMonthLastDay(TimeZone.getDefault(), date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }
}
