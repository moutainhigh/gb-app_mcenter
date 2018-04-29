package so.wwb.gamebox.service.site.report;

import org.soul.service.support.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import so.wwb.gamebox.data.site.report.OperationSummaryMapper;
import so.wwb.gamebox.iservice.site.report.IOperationSummaryService;
import so.wwb.gamebox.model.site.report.po.OperationSummary;
import so.wwb.gamebox.model.site.report.vo.OperationSummaryListVo;
import so.wwb.gamebox.model.site.report.vo.OperationSummaryVo;

import java.util.ArrayList;
import java.util.List;
import java.util.TimeZone;

/**
 * 运营日常统计服务
 *
 * @author martin
 * @time 2018-4-17
 */
public class OperationSummaryService extends BaseService<OperationSummaryMapper, OperationSummaryListVo, OperationSummaryVo, OperationSummary, Integer> implements IOperationSummaryService {

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
            list = summaryMapper.getOperationSummaryOfMonths(condition);

        } else if (RANGE_WEEK.equals(condition.getQueryDateRange())) {
            rangeType = RANGE_WEEK;//按周查询
            list = summaryMapper.getOperationSummaryOfWeeks(condition);

        } else {
            rangeType = RANGE_DAY;//按日查询
            list = summaryMapper.getOperationSummaryOfDays(condition);
        }
        condition.getEntities().addAll(list);
        return condition;
    }
}