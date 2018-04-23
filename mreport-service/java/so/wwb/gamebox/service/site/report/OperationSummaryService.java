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
            generateBalanceBarChartData(result, list);
            generateEffectiveBarChartData(result, list);
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
     * 取现差额玉珏图数据
     * @param result
     * @param list
     * @return
     */
    protected void generateBalanceBarChartData(OperationSummaryVo result, List<OperationSummary> list) {
        OperationSummary summary = getWhichDayData(list, this.DAY1);
        if (summary != null) {
            OperationSummaryChartVo item1 = new OperationSummaryChartVo();
            item1.setNumerical(summary.getDepositAmount());
            item1.setTips(getDay(summary.getStaticDate()));
            item1.setTitle("存款金额");
            result.getBalanceBarChart().add(item1);

            OperationSummaryChartVo item2 = new OperationSummaryChartVo();
            item2.setNumerical(summary.getWithdrawalAmount());
            item2.setTips(getDay(summary.getStaticDate()));
            item2.setTitle("取现金额");
            result.getBalanceBarChart().add(item2);

            //计算占比
            item1.setPercent(item1.getNumerical() / (item1.getNumerical() + item2.getNumerical()));
            item2.setPercent(item2.getNumerical() / (item1.getNumerical() + item2.getNumerical()));
        }
    }

    /**
     * 有效投注额玉珏图数据
     * @param result
     * @param list
     * @return
     */
    protected void generateEffectiveBarChartData(OperationSummaryVo result, List<OperationSummary> list) {
        OperationSummary summary1 = getWhichDayData(list, DAY1);
        OperationSummary summary2 = getWhichDayData(list, DAY2);
        if (summary1 != null && summary2 != null) {
            OperationSummaryChartVo item1 = new OperationSummaryChartVo();
            item1.setNumerical(summary1.getEffectiveTransactionAll());
            item1.setTitle(getDay(summary1.getStaticDate()));
            item1.setTips("有效投注额");
            result.getEffectiveBarChart().add(item1);

            OperationSummaryChartVo item2 = new OperationSummaryChartVo();
            item2.setNumerical(summary2.getEffectiveTransactionAll());
            item2.setTitle(getDay(summary2.getStaticDate()));
            item2.setTips("有效投注额");
            result.getEffectiveBarChart().add(item2);

            //计算占比
            item1.setPercent(item1.getNumerical() / (item1.getNumerical() + item2.getNumerical()));
            item2.setPercent(item2.getNumerical() / (item1.getNumerical() + item2.getNumerical()));
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
        return null;
    }

    private String getDay(Date date) {
        String str = DateTool.formatDate(date, DateTool.yyyy_MM_dd);
        return str.substring(str.indexOf("-")+1, str.length()).replace("-", ".");
    }
}