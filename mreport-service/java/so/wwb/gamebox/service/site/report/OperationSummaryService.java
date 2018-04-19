package so.wwb.gamebox.service.site.report;

import org.soul.service.support.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import so.wwb.gamebox.data.site.report.OperationSummaryMapper;
import so.wwb.gamebox.iservice.site.report.IOperationSummaryService;
import so.wwb.gamebox.model.site.report.po.OperationSummary;
import so.wwb.gamebox.model.site.report.vo.OperationSummaryListVo;
import so.wwb.gamebox.model.site.report.vo.OperationSummaryVo;

/**
 * 运营日常统计服务
 * @author martin
 * @time 2018-4-17
 */
public class OperationSummaryService extends BaseService<OperationSummaryMapper, OperationSummaryListVo, OperationSummaryVo, OperationSummary, Integer> implements IOperationSummaryService {

    @Autowired
    private OperationSummaryMapper summaryMapper;

    @Override
    public OperationSummaryVo getOperationSummaryData(OperationSummaryVo condition) {
        OperationSummaryVo result = new OperationSummaryVo();
        OperationSummary summary1 = new OperationSummary();
        summary1.setTitle("存款金额");
        summary1.setNumerical(8000D);
        result.getEntities().add(summary1);

        OperationSummary summary2 = new OperationSummary();
        summary2.setTitle("取现金额");
        summary2.setNumerical(6000D);
        result.getEntities().add(summary2);

        //计算占比
        summary1.setPercent(summary1.getNumerical()/(summary1.getNumerical()+summary2.getNumerical()));
        summary2.setPercent(summary2.getNumerical()/(summary1.getNumerical()+summary2.getNumerical()));
        return result;
    }

    /**
     * 存取差额统计
     * @return
     */
    public OperationSummaryVo differenceSummary() {
        return null;
    }

    /**
     * 有效投注统计
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

}