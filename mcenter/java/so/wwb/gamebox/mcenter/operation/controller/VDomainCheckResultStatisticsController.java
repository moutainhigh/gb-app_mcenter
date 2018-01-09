package so.wwb.gamebox.mcenter.operation.controller;

import org.soul.web.controller.BaseCrudController;
import so.wwb.gamebox.iservice.company.sys.IVDomainCheckResultStatisticsService;
import so.wwb.gamebox.model.company.sys.po.VDomainCheckResultStatistics;
import so.wwb.gamebox.model.company.sys.vo.VDomainCheckResultStatisticsListVo;
import so.wwb.gamebox.model.company.sys.vo.VDomainCheckResultStatisticsVo;
import so.wwb.gamebox.mcenter.operation.form.VDomainCheckResultStatisticsForm;
import so.wwb.gamebox.mcenter.operation.form.VDomainCheckResultStatisticsSearchForm;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * 控制器
 * 域名检测视图
 * @author lock
 * @time 2018-1-8 11:21:38
 */
@Controller
//region your codes 1
@RequestMapping("/vDomainCheckResultStatistics")
public class VDomainCheckResultStatisticsController extends BaseCrudController<IVDomainCheckResultStatisticsService, VDomainCheckResultStatisticsListVo, VDomainCheckResultStatisticsVo, VDomainCheckResultStatisticsSearchForm, VDomainCheckResultStatisticsForm, VDomainCheckResultStatistics, String> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/operation/domainCheck/";
        //endregion your codes 2
    }

    //region your codes 3

    //endregion your codes 3

}