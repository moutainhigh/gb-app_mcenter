package so.wwb.gamebox.mcenter.operation.controller;

import org.soul.commons.dict.DictTool;
import org.soul.commons.query.sort.Direction;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.operation.IVActivityMessageHallService;
import so.wwb.gamebox.mcenter.operation.form.VActivityMessageHallForm;
import so.wwb.gamebox.mcenter.operation.form.VActivityMessageHallSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.company.site.po.SiteI18n;
import so.wwb.gamebox.model.master.operation.po.VActivityMessageHall;
import so.wwb.gamebox.model.master.operation.vo.VActivityMessageHallListVo;
import so.wwb.gamebox.model.master.operation.vo.VActivityMessageHallVo;
import so.wwb.gamebox.web.cache.Cache;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;


/**
 * 活动大厅控制器
 *
 * @author steffan
 * @time 2018-3-15 15:58:14
 */
@Controller
//region your codes 1
@RequestMapping("/vActivityMessageHall")
public class VActivityMessageHallController extends BaseCrudController<IVActivityMessageHallService, VActivityMessageHallListVo, VActivityMessageHallVo, VActivityMessageHallSearchForm, VActivityMessageHallForm, VActivityMessageHall, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/operation/activityHall/hall/";
        //endregion your codes 2
    }

    //region your codes 3

    @Override
    protected VActivityMessageHallListVo doList(VActivityMessageHallListVo listVo, VActivityMessageHallSearchForm form, BindingResult result, Model model) {
        String localLanguage = SessionManager.getLocale().toString();

        //活动状态
        Map<String, Serializable> activityState = DictTool.get(DictEnum.ACTIVITY_STATE);
        model.addAttribute("activityState", activityState);

        //活动类型
        Map<String, Serializable> activityType = DictTool.get(DictEnum.ACTIVITY_TYPE);
        model.addAttribute("activityType", activityType);

        //获取site18n信息
        Map<String, SiteI18n> siteI18nMap = Cache.getOperateActivityClassify();
        Map<String, SiteI18n> tempMap = new LinkedHashMap<>();
        for (Map.Entry<String, SiteI18n> entry : siteI18nMap.entrySet()) {
            SiteI18n siteI18n = entry.getValue();
            if (localLanguage.equals(siteI18n.getLocale())) {
                tempMap.put(siteI18n.getKey(), siteI18n);
            }
        }
        model.addAttribute("siteI18nMap", tempMap);
        model.addAttribute("siteI18ns", new ArrayList<>(tempMap.values()));

        model.addAttribute("localLanguage", localLanguage);
        listVo.getSearch().setActivityVersion(localLanguage);
        listVo.getSearch().setIsDeleted(Boolean.FALSE);

        listVo.getQuery().addOrder(VActivityMessageHall.PROP_LIST_ORDER_NUM, Direction.ASC).addOrder(VActivityMessageHall.PROP_START_TIME,Direction.DESC);
        VActivityMessageHallListVo search = this.getService().search(listVo);
        return super.doList(listVo, form, result, model);
    }

    @Override
    public String list(VActivityMessageHallListVo listVo, @FormModel("search") @Valid VActivityMessageHallSearchForm form, BindingResult result, Model model, HttpServletRequest request, HttpServletResponse response) {
        return super.list(listVo, form, result, model, request, response);
    }

    //endregion your codes 3

}