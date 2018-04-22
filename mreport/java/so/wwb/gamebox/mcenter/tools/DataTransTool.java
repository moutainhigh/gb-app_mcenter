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
     * 抽取日期
     * @param result
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
}
