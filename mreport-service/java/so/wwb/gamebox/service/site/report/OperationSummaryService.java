package so.wwb.gamebox.service.site.report;

import org.soul.commons.collections.CollectionTool;
import org.soul.commons.lang.DateTool;
import org.soul.service.support.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import so.wwb.gamebox.data.site.report.OperationSummaryMapper;
import so.wwb.gamebox.iservice.site.report.IOperationSummaryService;
import so.wwb.gamebox.model.site.report.po.OperationSummary;
import so.wwb.gamebox.model.site.report.vo.OperationSummaryChartVo;
import so.wwb.gamebox.model.site.report.vo.OperationSummaryListVo;
import so.wwb.gamebox.model.site.report.vo.OperationSummaryVo;

import java.util.Date;
import java.util.List;

/**
 * 运营日常统计服务
 *
 * @author martin
 * @time 2018-4-17
 */
public class OperationSummaryService extends BaseService<OperationSummaryMapper, OperationSummaryListVo, OperationSummaryVo, OperationSummary, Integer> implements IOperationSummaryService {

    private static final String DAY1 = "yesterday";

    private static final String DAY2 = "beforeOfYesterday";

    @Autowired
    private OperationSummaryMapper summaryMapper;

    @Override
    public OperationSummaryVo getOperationSummaryData(OperationSummaryVo condition) {
        OperationSummaryVo result = new OperationSummaryVo();
        List<OperationSummary> list = summaryMapper.getOperationSummaryOfDays();
        if (CollectionTool.isNotEmpty(list)) {
            generateBalanceGaugeChartData(result, list);
            generateEffectiveGaugeChartData(result, list);
            generateProfitLossGaugeChartData(result, list);
        }
        result.getEntities().addAll(list);
        return result;
    }

    /**
     * 存取差额统计
     *
     * @return
     */
    public List<OperationSummary> differenceSummary() {
        return null;
    }

    /**
     * 有效投注统计
     *
     * @return
     */
    public OperationSummaryVo effectiveTradeSummary() {
        return null;
    }

    /**
     * 损益统计
     * @return
     */
    public OperationSummaryVo profitLossSummary() {
        return null;
    }

    /**
     * 返水走势统计
     * @return
     */
    public OperationSummaryVo rakeBackTrendSummary() {
        return null;
    }

    /**
     * 玩家走家统计
     * @return
     */
    public OperationSummaryVo playerTrendSummary() {
        return null;
    }

    /**
     * 活跃用户统计
     * @return
     */
    public OperationSummaryVo activePlayerSummary() {
        return null;
    }

    /**
     * App安装量统计
     * @return
     */
    public OperationSummaryVo appSetupAmountSummary() {
        return null;
    }

    /**
     * App卸载量统计
     * @return
     */
    public OperationSummaryVo appUninstallAmountSummary() {
        return null;
    }

    /**
     * 取现差额仪表图数据
     * @param result
     * @param list
     * @return
     */
    protected void generateBalanceGaugeChartData(OperationSummaryVo result, List<OperationSummary> list) {
        OperationSummary summary1 = getWhichDayData(list, DAY1);
        OperationSummary summary2 = getWhichDayData(list, DAY2);
        if (summary1 != null && summary2 != null) {
            OperationSummaryChartVo item1 = new OperationSummaryChartVo();
            item1.setNumerical(summary1.getBalanceAmount());
            item1.setTitle(summary1.getStaticDay());
            item1.setTips("取现差额");
            result.getBalanceGaugeChart().add(item1);

            OperationSummaryChartVo item2 = new OperationSummaryChartVo();
            item2.setNumerical(summary2.getWithdrawalAmount());
            item2.setTitle(summary1.getStaticDay());
            item2.setTips("取现差额");
            result.getBalanceGaugeChart().add(item2);
        }
    }

    /**
     * 有效投注额仪表图数据
     * @param result
     * @param list
     * @return
     */
    protected void generateEffectiveGaugeChartData(OperationSummaryVo result, List<OperationSummary> list) {
        OperationSummary summary1 = getWhichDayData(list, DAY1);
        OperationSummary summary2 = getWhichDayData(list, DAY2);
        if (summary1 != null && summary2 != null) {
            OperationSummaryChartVo item1 = new OperationSummaryChartVo();
            item1.setNumerical(summary1.getEffectiveTransactionAll());
            item1.setTitle(summary1.getStaticDay());
            item1.setTips("有效投注额");
            result.getEffectiveGaugeChart().add(item1);

            OperationSummaryChartVo item2 = new OperationSummaryChartVo();
            item2.setNumerical(summary2.getEffectiveTransactionAll());
            item2.setTitle(summary2.getStaticDay());
            item2.setTips("有效投注额");
            result.getEffectiveGaugeChart().add(item2);
        }
    }

    /**
     * 损益仪表图数据
     * @param result
     * @param
     * @return
     */
    protected void generateProfitLossGaugeChartData(OperationSummaryVo result, List<OperationSummary> list) {
        OperationSummary summary1 = getWhichDayData(list, DAY1);
        OperationSummary summary2 = getWhichDayData(list, DAY2);
        if (summary1 != null && summary2 != null) {
            OperationSummaryChartVo item1 = new OperationSummaryChartVo();
            item1.setNumerical(summary1.getTransactionProfitLoss());
            item1.setTitle(summary1.getStaticDay());
            item1.setTips("损益");
            result.getProfitLossGaugeChart().add(item1);

            OperationSummaryChartVo item2 = new OperationSummaryChartVo();
            item2.setNumerical(summary2.getTransactionProfitLoss());
            item2.setTitle(summary2.getStaticDay());
            item2.setTips("损益");
            result.getProfitLossGaugeChart().add(item2);
        }
    }

    /**
     * 获取指定周期的运营统计数据
     * @param list
     * @param flag
     * @return
     */
    protected OperationSummary getWhichDayData(List<OperationSummary> list, String flag) {
        for (OperationSummary item : list) {
            if (this.DAY1.equalsIgnoreCase(flag)
                    && DateTool.daysBetween(new Date(), item.getStaticDate()) == 1) {
                return item;
            }
            if (this.DAY2.equalsIgnoreCase(flag)
                    && DateTool.daysBetween(new Date(), item.getStaticDate()) == 2) {
                return item;
            }
        }
        OperationSummary defaultR = new OperationSummary();
        defaultR.setBalanceAmount(0D);
        defaultR.setEffectiveTransactionAll(0D);
        defaultR.setTransactionProfitLoss(0D);
        if (this.DAY1.equalsIgnoreCase(flag)) {
            Date date = DateTool.addDays(new Date(), -1);
            defaultR.setStaticDay(getDay(date));
        }
        if (this.DAY2.equalsIgnoreCase(flag)) {
            Date date = DateTool.addDays(new Date(), -2);
            defaultR.setStaticDay(getDay(date));
        }
        return defaultR;
    }

    private static String getDay(Date date) {
        String str = DateTool.formatDate(date, DateTool.yyyy_MM_dd);
        return str.substring(str.indexOf("-")+1, str.length()).replace("-", ".");
    }
}