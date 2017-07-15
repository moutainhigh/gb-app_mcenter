package so.wwb.gamebox.mcenter.report.betting.controller;

import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.site.report.IVPlayerGameOrderService;
import so.wwb.gamebox.mcenter.init.ConfigManager;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.company.enums.SiteStatusEnum;
import so.wwb.gamebox.model.company.sys.po.VSysSiteUser;
import so.wwb.gamebox.model.site.report.po.VPlayerGameOrder;
import so.wwb.gamebox.model.site.report.vo.VPlayerGameOrderListVo;
import so.wwb.gamebox.model.site.report.vo.VPlayerGameOrderVo;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.report.betting.controller.BaseGameOrderController;
import so.wwb.gamebox.web.report.betting.form.VPlayerGameOrderForm;
import so.wwb.gamebox.web.report.betting.form.VPlayerGameOrderSearchForm;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by cherry on 16-11-8.
 */
@Controller
@RequestMapping("/report/gameTransaction")
public class GameOrderController extends BaseGameOrderController<IVPlayerGameOrderService, VPlayerGameOrderListVo, VPlayerGameOrderVo, VPlayerGameOrderSearchForm, VPlayerGameOrderForm, VPlayerGameOrder, Integer> {
    private static final Log LOG = LogFactory.getLog(GameOrderController.class);
    @Override
    protected void doInit(VPlayerGameOrderListVo listVo, Model model) {
       /* checkSysCode(listVo);
        setDataSource(listVo);*/
        super.doInit(listVo, model);
    }

    @Override
    protected VPlayerGameOrderListVo doList(VPlayerGameOrderListVo listVo, VPlayerGameOrderSearchForm form, BindingResult result, Model model) {
       /* checkSysCode(listVo);
        setDataSource(listVo);*/
        return super.doList(listVo, form, result, model);
    }

    /**
     * 站长账号获取该站长下站点
     *
     * @param listVo
     */
    private void checkSysCode(VPlayerGameOrderListVo listVo) {
        boolean isMaster = SessionManager.isCurrentSiteMaster();
        listVo.setIsMaster(isMaster);
        if (isMaster) {
            listVo.setSites(getSites());
        }
    }

    /**
     * 获取站点
     *
     * @return
     */
    private List<VSysSiteUser> getSites() {
        Map<String, VSysSiteUser> map = Cache.getSysSiteUser();
        List<VSysSiteUser> sites = new ArrayList<>();
        for (VSysSiteUser site : map.values()) {
            if ((ConfigManager.getConfigration().getSubsysCode()).equals(site.getSubsysCode())
                    && SessionManager.getMasterUserId().intValue() == site.getSysUserId().intValue()
                    && SiteStatusEnum.NORMAL.getCode().equals(site.getStatus())) {
                sites.add(site);
            }
        }
        return sites;
    }
}
