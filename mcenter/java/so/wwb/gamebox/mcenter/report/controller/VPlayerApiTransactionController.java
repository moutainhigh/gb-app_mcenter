package so.wwb.gamebox.mcenter.report.controller;

import org.soul.commons.bean.Pair;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.DateQuickPicker;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.net.ServletTool;
import org.soul.web.session.SessionManagerBase;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.iservice.master.report.IVPlayerApiTransactionService;
import so.wwb.gamebox.mcenter.report.form.VPlayerApiTransactionForm;
import so.wwb.gamebox.mcenter.report.form.VPlayerApiTransactionSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.CacheBase;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.boss.enums.TemplateCodeEnum;
import so.wwb.gamebox.model.company.setting.po.SysExport;
import so.wwb.gamebox.model.company.setting.vo.SysExportVo;
import so.wwb.gamebox.model.master.player.vo.PlayerRankVo;
import so.wwb.gamebox.model.master.report.po.VPlayerApiTransaction;
import so.wwb.gamebox.model.master.report.so.VPlayerApiTransactionSo;
import so.wwb.gamebox.model.master.report.vo.VPlayerApiTransactionListVo;
import so.wwb.gamebox.model.master.report.vo.VPlayerApiTransactionVo;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.cache.ExportCriteriaTool;
import so.wwb.gamebox.web.report.controller.AbstractExportController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 控制器
 *
 * @author kobe
 * @time 2016-11-9 10:44:44
 */
@Controller
//region your codes 1
@RequestMapping("/report/fundsTrans")
public class VPlayerApiTransactionController extends AbstractExportController<IVPlayerApiTransactionService, VPlayerApiTransactionListVo, VPlayerApiTransactionVo, VPlayerApiTransactionSearchForm, VPlayerApiTransactionForm, VPlayerApiTransaction, Integer> {

    private static final Log LOG = LogFactory.getLog(VPlayerApiTransactionController.class);
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/report/apiFund/";
        //endregion your codes 2
    }

    //region your codes 3
    @RequestMapping("/apiTrans")
    public String fundsTrans(VPlayerApiTransactionListVo listVo, Model model, HttpServletRequest request, HttpServletResponse response) {
        if (listVo.getSiteId() != null) {
            listVo._setDataSourceId(listVo.getSiteId());
        } else {
            listVo.setSiteId(SessionManager.getSiteId());
            listVo._setDataSourceId(SessionManager.getSiteId());
        }
        if(listVo.getSearch().getUserTypes() == null || listVo.getSearch().getUserTypes().equals("")){
            listVo.getSearch().setUserTypes("search.username");
        }
        handleParam(listVo);
        initDate(listVo);
        trimSearch(listVo);
        listVo._setDataSourceId(listVo.getSiteId());
        listVo = ServiceSiteTool.vPlayerApiTransactionService().search(listVo);
        List<Pair> userTypeSearchKeys = initUserTypeSearchKeys();
        listVo.setDictFundType(initFundType());
        listVo.setDictCommonStatus(initCommonStatus());
        String conditionJson = ExportCriteriaTool.criteriaToJson(listVo.getQuery().getCriteria());
        String templateCode = TemplateCodeEnum.TRANSFER.getCode();
        model.addAttribute("searchTempCode", templateCode);
        model.addAttribute("searchTemplates", CacheBase.getSysSearchTempByCondition(SessionManager.getUserId(), templateCode));
        model.addAttribute("conditionJson", conditionJson);
        model.addAttribute("command", listVo);
        model.addAttribute("playerRanks", ServiceSiteTool.playerRankService().queryUsableList(new PlayerRankVo()));
        model.addAttribute("api", Cache.getSiteApi());
        model.addAttribute("userTypeSearchKeys", userTypeSearchKeys);
        model.addAttribute("validateRule", JsRuleCreator.create(VPlayerApiTransactionSearchForm.class));
        if (ServletTool.isAjaxSoulRequest(request)) {
            return getViewBasePath() + "IndexPartial";
        } else {
            return getViewBasePath() + "Index";
        }
    }

    private void handleParam(VPlayerApiTransactionListVo listVo) {
        List playerRanks = listVo.getSearch().getPlayerRanks();
        List newPlayerRanks = new ArrayList();
        if (playerRanks != null) {
            for (int i = 0; i < playerRanks.size(); i++) {
                int rankId = Integer.parseInt((String) playerRanks.get(i));
                newPlayerRanks.add(rankId);
            }
            listVo.getSearch().setPlayerRanks(newPlayerRanks);
        }

        String userName = listVo.getSearch().getUsername();
        if (userName != null && userName != "") {
            String[] userNames = StringTool.split(userName, ",");
            listVo.getSearch().setUserNames(Arrays.asList(userNames));
        }

        List apis = listVo.getSearch().getapiList();
        List newApis = new ArrayList();
        if (apis != null) {
            for (int i = 0; i < apis.size(); i++) {
                int apiId = Integer.parseInt((String) apis.get(i));
                newApis.add(apiId);
            }
            listVo.getSearch().setapiList(newApis);
        }
    }

    private List<Pair> initCommonStatus() {
        List<Pair> commonStatus = new ArrayList<>();
        commonStatus.add(new Pair("success", LocaleTool.tranDict(DictEnum.COMMON_STATUS,"success")));
        commonStatus.add(new Pair("process", LocaleTool.tranDict(DictEnum.COMMON_STATUS,"process")));
        commonStatus.add(new Pair("failure", LocaleTool.tranDict(DictEnum.COMMON_STATUS,"failure")));
        return commonStatus;
    }

    private List<Pair> initFundType() {
        List<Pair> fundTypes = new ArrayList<>();
        fundTypes.add(new Pair("transfer_into", LocaleTool.tranDict(DictEnum.COMMON_FUND_TYPE,"transfer_into")));
        fundTypes.add(new Pair("transfer_out", LocaleTool.tranDict(DictEnum.COMMON_FUND_TYPE,"transfer_out")));
        return fundTypes;
    }

    private List<Pair> initUserTypeSearchKeys() {
        List<Pair> searchKeys;
        searchKeys = new ArrayList<>();
        searchKeys.add(new Pair("search.username", LocaleTool.tranView(Module.COLUMN.getCode(), "playerAccount")));
        searchKeys.add(new Pair("search.agentname", LocaleTool.tranView(Module.COLUMN.getCode(), "agentAccount")));
        searchKeys.add(new Pair("search.topagentusername", LocaleTool.tranView(Module.COLUMN.getCode(), "agentTopAccount")));
        return searchKeys;
    }


    private void initDate(VPlayerApiTransactionListVo listVo) {
        if (listVo.getSearch().getType() == null || listVo.getSearch().getType().equals("")) {
            listVo.getSearch().setBeginCreateTime(SessionManagerBase.getDate().getToday());
            listVo.getSearch().setEndCreateTime(SessionManagerBase.getDate().getTomorrow());
            listVo.getSearch().setType("noFirst");
        }
        if (listVo.getSearch().getTransactionType() == null) {
            listVo.getSearch().setTransactionType("transfers");
        }

    }

    /**
     * 统计金额
     *
     * @param listVo
     * @return
     */
    @RequestMapping("/totalMoney")
    @ResponseBody
    public Map totalMoney(VPlayerApiTransactionListVo listVo) {
        handleParam(listVo);
        initDate(listVo);
        trimSearch(listVo);
        return ServiceSiteTool.vPlayerApiTransactionService().totalMoney(listVo);
    }

    @Override
    protected SysExportVo buildExportData(SysExportVo vo) {
        if (vo.getResult() == null) {
            vo.setResult(new SysExport());
        }
        vo.getResult().setService(IVPlayerApiTransactionService.class.getName());
        vo.getResult().setMethod("searchTransactionByCustom");
        vo.getResult().setParam(VPlayerApiTransactionListVo.class.getName());
        vo.getResult().setFileName(LocaleTool.tranView("export", "fund_report") + "-" + DateTool.formatDate(DateQuickPicker.getInstance().getNow(), SessionManager.getLocale(), SessionManager.getTimeZone(), "yyyyMMddHHmmss"));
        vo.getResult().setUsername(SessionManager.getUserName());
        vo.getResult().setExportUserId(SessionManager.getUserId());
        vo.getResult().setExportUserSiteId(SessionManager.getSiteId());
        if (vo.getResult().getSiteId() == null) {
            vo.getResult().setSiteId(SessionManager.getSiteId());
        }
        return vo;
    }

    /**
     * 自动清空前后的空格
     *
     * @param listVo
     */
    private void trimSearch(VPlayerApiTransactionListVo listVo) {
        VPlayerApiTransactionSo so = listVo.getSearch();
        if (StringTool.isNotBlank(so.getUsername())) {
            so.setUsername(so.getUsername().trim());
        }
        if (StringTool.isNotBlank(so.getAgentname())) {
            so.setAgentname(so.getAgentname().trim());
        }
        if (StringTool.isNotBlank(so.getTopagentusername())) {
            so.setTopagentusername(so.getTopagentusername().trim());
        }
        if (StringTool.isNotBlank(so.getTransactionNo())) {
            so.setTransactionNo(so.getTransactionNo());
        }
    }
    //endregion your codes 3

}