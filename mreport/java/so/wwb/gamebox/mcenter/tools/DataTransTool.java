package so.wwb.gamebox.mcenter.tools;

import org.soul.commons.collections.CollectionTool;
import org.soul.commons.lang.DateTool;
import so.wwb.gamebox.model.site.report.po.OperationSummary;
import so.wwb.gamebox.model.site.report.vo.OperationSummaryVo;

import java.util.*;

/**
 * 数据转换Tool
 * @author martin
 * @time 18-4-20
 */
public class DataTransTool {

    /**
     * 存取差额柱状图数据转换
     * @param list
     * @return
     */
    public static List<Map<String, Object>> transBalanceObjToMap(List<OperationSummary> list) {
        if (CollectionTool.isNotEmpty(list)) {
            List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
            Map<String, Object> depositMap = new HashMap<String, Object>();//存款集合
            Map<String, Object> withDrawMap = new HashMap<String, Object>();//取现集合
            Map<String, Object> balanceMap = new HashMap<String, Object>();//差额集合
            depositMap.put("name", "当日存款");
            withDrawMap.put("name", "当日取现");
            balanceMap.put("name", "存取差额");
            for (OperationSummary item : list) {
                String date = getDay(item.getStaticDate());
                depositMap.put(date, item.getDepositAmount());
                withDrawMap.put(date, item.getWithdrawalAmount());
                balanceMap.put(date, item.getDepositAmount() - item.getWithdrawalAmount());
            }
            mapList.add(depositMap);
            mapList.add(withDrawMap);
            mapList.add(balanceMap);
            return mapList;
        }
        return null;
    }

    /**
     * 总登录次数柱状图数据转换
     * @param list
     * @return
     */
    public static List<Map<String, Object>> loginCountObjToMap(List<OperationSummary> list) {
        if (CollectionTool.isNotEmpty(list)) {
            List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
            Map<String, Object> pcLoginMap = new HashMap<String, Object>();//pc端登录集合
            Map<String, Object> phoneLoginMap = new HashMap<String, Object>();//phone端登录集合
            Map<String, Object> CountLoginMap = new HashMap<String, Object>();//总登录数集合
            pcLoginMap.put("name", "登录次数(PC端)");
            phoneLoginMap.put("name", "登录次数(手机端)");
            CountLoginMap.put("name", "登录次数(全部)");
            for (OperationSummary item : list) {
                String date = getDay(item.getStaticDate());
                pcLoginMap.put(date, item.getLoginNumPc());
                phoneLoginMap.put(date, item.getLoginNumPhone());
                CountLoginMap.put(date, item.getLoginNumPc() + item.getLoginNumPhone());
            }
            mapList.add(pcLoginMap);
            mapList.add(phoneLoginMap);
            mapList.add(CountLoginMap);
            return mapList;
        }
        return null;
    }

    /**
     * 抽取日期
     * @param
     * @param list
     */
    public static List<String> extractDateFields(List<OperationSummary> list) {
        if (CollectionTool.isNotEmpty(list)) {
            List<String> fields = new ArrayList<String>();
            for (OperationSummary summary : list) {
                fields.add(getDay(summary.getStaticDate()));
            }
            return fields;
        }
        return null;
    }

    private static String getDay(Date date) {
        String str = DateTool.formatDate(date, DateTool.yyyy_MM_dd);
        return str.substring(str.indexOf("-")+1, str.length()).replace("-", ".");
    }

    /**
     * (o1-o2)/o2*100:保留两位小数后返回（参数仅支持int或double）
     *
     * @param o1 today
     * @param o2 yesterday
     * @return
     */
    public static double getPercentage(Object o1, Object o2) {
        if (o1 == null && o2 == null) {
            return 0.0D;
        } else {
            double d1 = 0.0D, d2 = 0.0D;
            boolean b1 = false, b2 = false;
            if (o1 instanceof Integer) {
                d1 = ((Integer) o1).doubleValue();
                b1 = true;
            }

            if (o2 instanceof Integer) {
                d2 = ((Integer) o2).doubleValue();
                b2 = true;
            }

            if (o1 instanceof Double) {
                d1 = ((Double) o1).doubleValue();
                b1 = true;
            }

            if (o2 instanceof Double) {
                d2 = ((Double) o2).doubleValue();
                b2 = true;
            }

            return b1 && b2 ? Double.valueOf(String.format("%.2f", new Object[]{Double.valueOf((d1 - d2) / d2 * 100 )})).doubleValue() : 0.0D;
        }
    }
}
