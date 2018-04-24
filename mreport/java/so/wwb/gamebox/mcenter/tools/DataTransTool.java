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
     * (o1-o2)/o2*100:保留两位小数后返回（参数仅支持int或double）
     *
     * @param o1 today
     * @param o2 yesterday
     * @return
     */
    public static double getPercentage(Object o1, Object o2) {
        if (o1 == null || o2 == null) {
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
