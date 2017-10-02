package so.wwb.gamebox.mcenter.lottery.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.enums.EnumTool;
import org.soul.commons.lang.string.StringTool;
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
import so.wwb.gamebox.model.enums.lottery.LotteryEnum;
import so.wwb.gamebox.model.enums.lottery.LotteryPlayEnum;
import so.wwb.gamebox.web.cache.Cache;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
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
        Map<String,String> playMap = new LinkedHashMap<>();
        for(SiteLotteryQuota quota : listVo.getResult()){
            LotteryPlayEnum playEnum = EnumTool.enumOf(LotteryPlayEnum.class,quota.getPlayCode());
            if(playEnum != null){
                playMap.put(playEnum.getTrans(),playEnum.getCode());
            }
        }
        model.addAttribute("playMap", playMap);
        String url = getViewBasePath() + "/" + code + "/Index";
        return url;
    }

    @RequestMapping(value = "/updateQuotas", method = RequestMethod.POST)
    @ResponseBody
    public Map updateQuotas(SiteLotteryQuotaVo quotaVo) {
        if (StringTool.isBlank(quotaVo.getLotteryQuotaJson())) {
            return getVoMessage(quotaVo);
        }
        List<SiteLotteryQuota> lotteryQuotas = null;
        try {
            lotteryQuotas = JsonTool.fromJson(quotaVo.getLotteryQuotaJson(), new TypeReference<ArrayList<SiteLotteryQuota>>() {
            });
        } catch (Exception e) {
            LOG.error("提交限额格式有问题，转换出错！{0}", quotaVo.getLotteryQuotaJson());
            quotaVo.setSuccess(false);
            return getVoMessage(quotaVo);
        }
        if (CollectionTool.isEmpty(lotteryQuotas)) {
            return getVoMessage(quotaVo);
        }
        List<SiteLotteryQuota> updateQuotas = new ArrayList<>();
        List<Integer> ids = new ArrayList<>();
        for (SiteLotteryQuota lotteryQuota : lotteryQuotas) {
            if (lotteryQuota.getId() != null) {
                updateQuotas.add(lotteryQuota);
                ids.add(lotteryQuota.getId());
            }
        }
        if (!checkOdd(ids, updateQuotas)) {
            LOG.info("保存彩票限额值有误!");
            quotaVo.setSuccess(false);
            return getVoMessage(quotaVo);
        }
        quotaVo.setProperties(SiteLotteryQuota.PROP_BET_QUOTA,SiteLotteryQuota.PROP_NUM_QUOTA,SiteLotteryQuota.PROP_PLAY_QUOTA);
        if (CollectionTool.isNotEmpty(updateQuotas)) {
            quotaVo.setEntities(updateQuotas);
            int count = ServiceTool.siteLotteryQuotaService().batchUpdateOnly(quotaVo);
            LOG.info("保存站点彩票限额成功,更新条数{0},更新赔率值{1}", count, JsonTool.toJson(updateQuotas));
            Cache.refreshSiteLotteryQuotas(SessionManager.getSiteId());
        }
        return getVoMessage(quotaVo);
    }
    private Map<Integer, SiteLotteryQuota> getSiteLotteryQuotaMap(List<Integer> ids) {
        SiteLotteryQuotaListVo listVo = new SiteLotteryQuotaListVo();
        listVo.getSearch().setIds(ids);
        listVo.getSearch().setSiteId(SessionManager.getSiteId());
        listVo.setPaging(null);
        listVo = ServiceTool.siteLotteryQuotaService().search(listVo);
        if (CollectionTool.isEmpty(listVo.getResult())) {
            return null;
        }
        return CollectionTool.toEntityMap(listVo.getResult(), SiteLotteryQuota.PROP_ID, Integer.class);
    }

    private boolean checkOdd(List<Integer> ids, List<SiteLotteryQuota> updateQuotas) {
        Map<Integer, SiteLotteryQuota> siteLotteryQuotaMap = getSiteLotteryQuotaMap(ids);
        if (siteLotteryQuotaMap == null) {
            return false;
        }
        SiteLotteryQuota lotteryQuota;
        for (SiteLotteryQuota quota : updateQuotas) {
            lotteryQuota = siteLotteryQuotaMap.get(quota.getId());
            if (lotteryQuota.getBetQuota() == null) {
                LOG.info("查询查询不到对应的站点单注限额,id{0},betQuota{1}", quota.getId(), quota.getBetQuota());
                return false;
            }
            if (lotteryQuota.getNumQuota() == null) {
                LOG.info("查询查询不到对应的站点单项限额,id{0},numQuota{1}", quota.getId(), quota.getNumQuota());
                return false;
            }
            if (lotteryQuota.getPlayQuota() == null&&!lotteryQuota.getCode().equals(LotteryEnum.HKLHC.getCode())) {
                LOG.info("查询查询不到对应的站点单类别单项限额,id{0},odd{1}", quota.getId(), quota.getPlayQuota());
                return false;
            }
            if (quota.getBetQuota() < 0 || quota.getNumQuota() < 0 ||(!lotteryQuota.getCode().equals(LotteryEnum.HKLHC.getCode())&&quota.getPlayQuota() < 0)) {
                LOG.info("设置限额不能小于0");
                return false;
            }

        }
        return true;
    }
    //endregion your codes 3

}