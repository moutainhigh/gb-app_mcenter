package so.wwb.gamebox.mcenter.lottery.controller;

import org.soul.commons.collections.CollectionTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.web.controller.NoMappingCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.mcenter.lottery.form.SiteLotteryQuotaSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.company.lottery.po.SiteLotteryQuota;
import so.wwb.gamebox.model.company.lottery.vo.SiteLotteryQuotaListVo;
import so.wwb.gamebox.model.company.lottery.vo.SiteLotteryQuotaVo;
import so.wwb.gamebox.web.cache.Cache;

import javax.validation.Valid;
import java.util.Map;


/**
 * 限额设置控制器
 *
 * @author admin
 * @time 2017-4-11 19:24:18
 */
@Controller
//region your codes 1
@RequestMapping("/lottery/quotas")
public class SiteLotteryQuotaController extends NoMappingCrudController {
    private static final Log LOG = LogFactory.getLog(SiteLotteryQuotaController.class);
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/lottery/quotas";
        //endregion your codes 2
    }

    @RequestMapping({"/index"})
    public String index(Model model) {
        model.addAttribute("quotaRule", JsRuleCreator.create(SiteLotteryQuotaSearchForm.class));
        return getViewBasePath() + "/Index";
    }

    //region your codes 3

    @RequestMapping("/{code}/Index")
    public String getCodeIndex(@PathVariable String code, SiteLotteryQuotaVo quotaVo, Model model) {
        SiteLotteryQuotaListVo listVo = new SiteLotteryQuotaListVo();
        listVo.getSearch().setCode(code);
        listVo.setPaging(null);
        listVo.getSearch().setSiteId(SessionManager.getSiteId());
        listVo = ServiceTool.siteLotteryQuotaService().search(listVo);
        quotaVo.setQuotaList(listVo.getResult());
        Map<Object, SiteLotteryQuota> quotaMap = CollectionTool.toEntityMap(listVo.getResult(), SiteLotteryQuota.PROP_PLAY_CODE);
        model.addAttribute("command", quotaMap);
        String url = getViewBasePath() + "/" + code + "/Index";
        return url;
    }

    @RequestMapping(value = "/updateQuotas", method = RequestMethod.POST)
    @ResponseBody
    public Map updateQuotas(SiteLotteryQuotaVo quotaVo, @FormModel @Valid SiteLotteryQuotaSearchForm form, BindingResult result) {
        if (result.hasErrors()) {
            quotaVo.setSuccess(false);
            return getVoMessage(quotaVo);
        }

        quotaVo.setProperties(SiteLotteryQuota.PROP_BET_QUOTA, SiteLotteryQuota.PROP_PLAY_QUOTA, SiteLotteryQuota.PROP_NUM_QUOTA);
        quotaVo.setEntities(quotaVo.getQuotaList());
        ServiceTool.siteLotteryQuotaService().batchUpdateOnly(quotaVo);
        Cache.refreshAllSiteLotteryQuotas();
        return getVoMessage(quotaVo);
    }
    //endregion your codes 3

}