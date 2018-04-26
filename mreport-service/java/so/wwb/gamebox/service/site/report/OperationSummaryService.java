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
import so.wwb.gamebox.tools.MReportTool;

import java.util.*;

/**
 * 运营日常统计服务
 * @author martin
 * @time 2018-4-17
 */
public class OperationSummaryService extends BaseService<OperationSummaryMapper, OperationSummaryListVo, OperationSummaryVo, OperationSummary, Integer> implements IOperationSummaryService {

    //上一个期间
    private static final String RANGE1 = "lastRange";

    //上上一个期间
    private static final String RANGE2 = "beforeOfLastRange";

    //按天查询标识
    private static final String RANGE_DAY = "D";

    //按周查询标识
    private static final String RANGE_WEEK = "W";

    //按月查询标识
    private static final String RANGE_MONTH = "M";

    private TimeZone timeZone = TimeZone.getDefault();

    @Autowired
    private OperationSummaryMapper summaryMapper;

    @Override
    public OperationSummaryVo getOperationSummaryData(OperationSummaryVo condition) {
        List<OperationSummary> list = new ArrayList<>();
        String rangeType = RANGE_DAY;
        if (RANGE_MONTH.equals(condition.getQueryDateRange())) {
            rangeType = RANGE_MONTH;//按月查询
            list = summaryMapper.getOperationSummaryOfMonths();

        } else if (RANGE_WEEK.equals(condition.getQueryDateRange())) {
            rangeType = RANGE_WEEK;//按周查询
            list = summaryMapper.getOperationSummaryOfWeeks();

        } else {
            rangeType = RANGE_DAY;//按日查询
            list = summaryMapper.getOperationSummaryOfDays(condition);
        }

        if (CollectionTool.isNotEmpty(list)) {
            getBalanceGaugeChartData(condition, list, rangeType);
            getEffectiveGaugeChartData(condition, list, rangeType);
            getProfitLossGaugeChartData(condition, list, rangeType);
        }
        condition.getEntities().addAll(list);
        return condition;
    }

    /**
     * 取现差额仪表图数据
     * @param result
     * @param list
     * @return
     */
    public void getBalanceGaugeChartData(OperationSummaryVo result, List<OperationSummary> list, String rangeType) {
        OperationSummary summary1 = getWhichData(list, RANGE1, rangeType);
        OperationSummary summary2 = getWhichData(list, RANGE2, rangeType);
        if (summary1 != null && summary2 != null) {
            OperationSummaryChartVo item1 = new OperationSummaryChartVo();
            item1.setNumerical(summary1.getBalanceAmount());
            item1.setTitle(summary1.getStaticDay());
            item1.setTips("取现差额");
            result.getBalanceGaugeChart().add(item1);

            OperationSummaryChartVo item2 = new OperationSummaryChartVo();
            item2.setNumerical(summary2.getWithdrawalAmount());
            item2.setTitle(summary2.getStaticDay());
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
    public void getEffectiveGaugeChartData(OperationSummaryVo result, List<OperationSummary> list, String rangeType) {
        OperationSummary summary1 = getWhichData(list, RANGE1, rangeType);
        OperationSummary summary2 = getWhichData(list, RANGE2, rangeType);
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
    public void getProfitLossGaugeChartData(OperationSummaryVo result, List<OperationSummary> list, String rangeType) {
        OperationSummary summary1 = getWhichData(list, RANGE1, rangeType);
        OperationSummary summary2 = getWhichData(list, RANGE2, rangeType);
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
     * @param range
     * @param rangeType
     * @return
     */
    public OperationSummary getWhichData(List<OperationSummary> list, String range, String rangeType) {
        for (OperationSummary item : list) {
            //按天查询
            if (this.RANGE_DAY.equalsIgnoreCase(rangeType)) {
                if (this.RANGE1.equalsIgnoreCase(range)
                        && DateTool.daysBetween(new Date(), item.getStaticDate()) == 1) {
                    return item;
                }
                if (this.RANGE2.equalsIgnoreCase(range)
                        && DateTool.daysBetween(new Date(), item.getStaticDate()) == 2) {
                    return item;
                }
                continue;
            }
            //按周查询
            if (this.RANGE_WEEK.equalsIgnoreCase(rangeType)) {
                Date sunday1 = MReportTool.getLastWeekLastDay(timeZone, new Date());//上周日
                Date sunday2 = MReportTool.getLastWeekLastDay(timeZone, sunday1);//上上周日
                if (this.RANGE1.equalsIgnoreCase(range)
                        && DateTool.isSameDay(sunday1, item.getStaticDate())) {
                    return item;
                }
                if (this.RANGE2.equalsIgnoreCase(range)
                        && DateTool.isSameDay(sunday2, item.getStaticDate())) {
                    return item;
                }
                continue;
            }
            // 按月查询
            if (this.RANGE_MONTH.equalsIgnoreCase(rangeType)) {
                Date lastDay1 = MReportTool.getLastMonthLastDay(timeZone, new Date());//上个月最后一天
                Date lastDay2 = MReportTool.getLastMonthLastDay(timeZone, lastDay1);//上上个月最后一天
                if (this.RANGE1.equalsIgnoreCase(range)
                        && DateTool.isSameDay(lastDay1, item.getStaticDate())) {
                    return item;
                }
                if (this.RANGE2.equalsIgnoreCase(range)
                        && DateTool.isSameDay(lastDay2, item.getStaticDate())) {
                    return item;
                }
                continue;
            }
        }
        // 没有对应的记录,　设定默认值
        OperationSummary defaultR = new OperationSummary();
        defaultR.setBalanceAmount(0D);
        defaultR.setEffectiveTransactionAll(0D);
        defaultR.setTransactionProfitLoss(0D);
        if (this.RANGE1.equalsIgnoreCase(range)) {
            if (this.RANGE_MONTH.equalsIgnoreCase(rangeType)) {
                Date date = MReportTool.getLastMonthLastDay(timeZone, new Date());
                defaultR.setStaticDay(MReportTool.getDate(date, null));
            } else if (this.RANGE_WEEK.equalsIgnoreCase(rangeType)) {
                Date date = MReportTool.getLastWeekLastDay(timeZone, new Date());
                defaultR.setStaticDay(MReportTool.getDate(date, null));
            } else {
                Date date = DateTool.addDays(new Date(), -1);
                defaultR.setStaticDay(MReportTool.getDate(date, MReportTool.MM_DD));
            }
        }
        if (this.RANGE2.equalsIgnoreCase(range)) {
            if (this.RANGE_MONTH.equalsIgnoreCase(rangeType)) {
                Date date = MReportTool.getLastMonthLastDay(timeZone, new Date());
                     date = MReportTool.getLastMonthLastDay(timeZone, date);
                defaultR.setStaticDay(MReportTool.getDate(date, null));
            } else if (this.RANGE_WEEK.equalsIgnoreCase(rangeType)) {
                Date date = MReportTool.getLastWeekLastDay(timeZone, new Date());
                     date = MReportTool.getLastWeekLastDay(timeZone, date);
                defaultR.setStaticDay(MReportTool.getDate(date, null));
            } else {
                Date date = DateTool.addDays(new Date(), -2);
                defaultR.setStaticDay(MReportTool.getDate(date, MReportTool.MM_DD));
            }
        }
        return defaultR;
    }
}