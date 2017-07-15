package so.wwb.gamebox.mcenter.lottery.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.web.controller.NoMappingCrudController;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import so.wwb.gamebox.mcenter.lottery.form.SiteLotteryOddsForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.company.lottery.po.SiteLotteryOdd;
import so.wwb.gamebox.model.company.lottery.vo.SiteLotteryOddListVo;
import so.wwb.gamebox.model.company.lottery.vo.SiteLotteryOddVo;
import so.wwb.gamebox.web.cache.Cache;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 站点赔率
 * Created by fei on 17-4-7.
 */
@Controller
@RequestMapping("/lottery/odds")
public class SiteLotteryOddsController extends NoMappingCrudController {
    private static final Log LOG = LogFactory.getLog(SiteLotteryOddsController.class);

    @Override
    protected String getViewBasePath() {
        return "/lottery/odds";
    }

    @RequestMapping("/index")
    public String index(Model model) {
        model.addAttribute("oddRule", JsRuleCreator.create(SiteLotteryOddsForm.class));
        return getViewBasePath() + "/Index";
    }

    /**
     * 获取彩票种类列表
     *
     * @param code
     * @param oddVo
     * @param model
     * @return
     */
    @RequestMapping("/{code}/Index")
    public String getCodeIndex(@PathVariable String code, SiteLotteryOddVo oddVo, Model model) {
        model.addAttribute("code", code);
        code = handleCode(code);
        return getViewBasePath() + "/" + code + "/Index";
    }

    /**
     * 获取投注玩法列表
     *
     * @param code
     * @param betting
     * @param oddVo
     * @param model
     * @return
     */
    @RequestMapping("/{code}/{betting}/Index")
    public String getCodeBettingIndex(@PathVariable String code, @PathVariable String betting, @RequestParam("page") String page, SiteLotteryOddVo oddVo, Model model) {
        Map<Object, SiteLotteryOdd> siteLotteryOddMap = searchLotteryOdd(code, betting, oddVo);
        model.addAttribute("command", siteLotteryOddMap);
        model.addAttribute("betCode", betting);
        model.addAttribute("code", code);
        code = handleCode(code);
        return getViewBasePath() + "/" + code + "/" + page + "/Index";
    }

    /**
     * 获取时时彩类别列表
     *
     * @param code
     * @param category
     * @param oddVo
     * @param model
     * @return
     */
    @RequestMapping("/{code}/{category}/categoryIndex")
    public String getSscCodeCategoryIndex(@PathVariable String code, @PathVariable String category, SiteLotteryOddVo oddVo, Model model) {
        code = handleCode(code);
        return getViewBasePath() + "/" + code + "/" + category + "/Index";
    }

    /**
     * 获取时时彩类别玩法列别
     *
     * @param code
     * @param category
     * @param betCode
     * @param page
     * @param oddVo
     * @param model
     * @return
     */
    @RequestMapping("/{code}/{category}/{betCode}/Index")
    public String getSscPlayIndex(@PathVariable String code, @PathVariable String category, @PathVariable String betCode, @RequestParam("page") String page, SiteLotteryOddVo oddVo, Model model) {
        Map<Object, SiteLotteryOdd> siteLotteryOddMap = searchLotteryOdd(code, betCode, oddVo);
        model.addAttribute("command", siteLotteryOddMap);
        model.addAttribute("betCode", betCode);
        model.addAttribute("code", code);
        code = handleCode(code);
        return getViewBasePath() + "/" + code + "/" + category + "/" + page;
    }

    private String handleCode(@PathVariable String code) {
        if (code.contains("ssc")) {
            code = "ssc";
        } else if (code.contains("k3")) {
            code = "k3";
        }
        return code;
    }

    private Map<Object, SiteLotteryOdd> searchLotteryOdd(@PathVariable String code, @PathVariable String betting, SiteLotteryOddVo oddVo) {
        SiteLotteryOddListVo listVo = new SiteLotteryOddListVo();
        listVo.getSearch().setCode(code);
        listVo.getSearch().setBetCode(betting);
        listVo.getSearch().setSiteId(SessionManager.getSiteId());
        listVo.setPaging(null);
        listVo = ServiceTool.siteLotteryOddService().search(listVo);
        return CollectionTool.toEntityMap(listVo.getResult(), SiteLotteryOdd.PROP_BET_NUM);
    }

    @RequestMapping(value = "/saveSiteLotteryOdds", method = RequestMethod.POST)
    @ResponseBody
    public Map saveSiteLotteryOdds(SiteLotteryOddVo siteLotteryOddVo) {
        if (StringTool.isBlank(siteLotteryOddVo.getLotteryOddJson())) {
            return getVoMessage(siteLotteryOddVo);
        }
        List<SiteLotteryOdd> lotteryOdds = null;
        try {
            lotteryOdds = JsonTool.fromJson(siteLotteryOddVo.getLotteryOddJson(), new TypeReference<ArrayList<SiteLotteryOdd>>() {
            });
        } catch (Exception e) {
            LOG.error("提交赔率格式有问题，转换出错！{0}", siteLotteryOddVo.getLotteryOddJson());
            siteLotteryOddVo.setSuccess(false);
            return getVoMessage(siteLotteryOddVo);
        }

        if (CollectionTool.isEmpty(lotteryOdds)) {
            return getVoMessage(siteLotteryOddVo);
        }
        siteLotteryOddVo.setProperties(SiteLotteryOdd.PROP_ODD);

        List<SiteLotteryOdd> updateOdds = new ArrayList<>();
        List<Integer> ids = new ArrayList<>();
        for (SiteLotteryOdd lotteryOdd : lotteryOdds) {
            if (lotteryOdd.getId() != null) {
                updateOdds.add(lotteryOdd);
                ids.add(lotteryOdd.getId());
            }
        }
        if (!checkOdd(ids, updateOdds)) {
            LOG.info("保存彩票赔率值有误!");
            siteLotteryOddVo.setSuccess(false);
            return getVoMessage(siteLotteryOddVo);
        }
        if (CollectionTool.isNotEmpty(updateOdds)) {
            siteLotteryOddVo.setEntities(updateOdds);
            int count = ServiceTool.siteLotteryOddService().batchUpdateOnly(siteLotteryOddVo);
            LOG.info("保存站点彩票赔率成功,更新条数{0},更新赔率值{1}", count, JsonTool.toJson(updateOdds));
            Cache.refreshSiteLotteryOdds(SessionManager.getSiteId());
        }
        return getVoMessage(siteLotteryOddVo);
    }

    private Map<Integer, SiteLotteryOdd> getSiteLotteryOddMap(List<Integer> ids) {
        SiteLotteryOddListVo listVo = new SiteLotteryOddListVo();
        listVo.getSearch().setIds(ids);
        listVo.getSearch().setSiteId(SessionManager.getSiteId());
        listVo.setPaging(null);
        listVo = ServiceTool.siteLotteryOddService().search(listVo);
        if (CollectionTool.isEmpty(listVo.getResult())) {
            return null;
        }
        return CollectionTool.toEntityMap(listVo.getResult(), SiteLotteryOdd.PROP_ID, Integer.class);
    }

    private boolean checkOdd(List<Integer> ids, List<SiteLotteryOdd> updateOdds) {
        Map<Integer, SiteLotteryOdd> siteLotteryOddMap = getSiteLotteryOddMap(ids);
        if (siteLotteryOddMap == null) {
            return false;
        }
        SiteLotteryOdd lotteryOdd;
        for (SiteLotteryOdd odd : updateOdds) {
            lotteryOdd = siteLotteryOddMap.get(odd.getId());
            if (lotteryOdd.getOdd() == null) {
                LOG.info("查询查询不到对应的站点赔率,id{0},odd{1}", odd.getId(), odd.getOdd());
                return false;
            }
            if (odd.getOdd() < 0 || odd.getOdd() > lotteryOdd.getOddLimit()) {
                LOG.info("设置赔率格式不正确,odd:{0},上限{1}", odd.getOdd(), lotteryOdd.getOddLimit());
                return false;
            }

        }
        return true;
    }

}
