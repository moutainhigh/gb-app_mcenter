package so.wwb.gamebox.mcenter.operation.controller;


import org.soul.commons.collections.CollectionTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.init.context.CommonContext;
import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.master.operation.IActivityMessageService;
import so.wwb.gamebox.mcenter.operation.form.VActivityMessageForm;
import so.wwb.gamebox.mcenter.operation.form.VActivityMessageSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.cache.CacheKey;
import so.wwb.gamebox.model.company.site.po.SiteI18n;
import so.wwb.gamebox.model.master.operation.po.ActivityMessage;
import so.wwb.gamebox.model.master.operation.vo.ActivityMessageListVo;
import so.wwb.gamebox.model.master.operation.vo.ActivityMessageOrderVo;
import so.wwb.gamebox.model.master.operation.vo.ActivityMessageVo;
import so.wwb.gamebox.model.master.operation.vo.PlayerActivityMessage;
import so.wwb.gamebox.web.cache.Cache;

import java.io.Serializable;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by jessie on 16-5-23.
 */
@Controller
@RequestMapping("/operation/activity/order")
public class ActivityOrderController extends BaseCrudController<IActivityMessageService, ActivityMessageListVo, ActivityMessageVo, VActivityMessageSearchForm, VActivityMessageForm, ActivityMessage, Integer> {

    @Override
    protected String getViewBasePath() {
        return "/operation/activity/order/";
    }

    @Override
    protected ActivityMessageListVo doList(ActivityMessageListVo listVo, VActivityMessageSearchForm form, BindingResult result, Model model) {
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
            if (SessionManager.getLocale().toString().equals(siteI18n.getLocale())) {
                tempMap.put(siteI18n.getKey(), siteI18n);
            }
        }
        model.addAttribute("siteI18nMap", tempMap);

        Date current = new Date();
        listVo.getSearch().setStartTime(current);
        listVo.getSearch().setEndTime(current);
        List<ActivityMessage> activityMessageList = getService().getProcessingActivity(listVo);
        listVo.setResult(activityMessageList);
        if (CollectionTool.isNotEmpty(activityMessageList)) {
            Map<String, PlayerActivityMessage> activityMessageMap = Cache.getPcActivityMessages();
            String locale = CommonContext.get().getLocale().toString();
            for (ActivityMessage activityMessage : activityMessageList) {
                PlayerActivityMessage playerActivityMessage = activityMessageMap.get(CacheKey.getCacheKey(String.valueOf(activityMessage.getId()), locale));
                if (playerActivityMessage != null) {
                    activityMessage.setActivityName(playerActivityMessage.getActivityName());
                }
            }
        }
        return listVo;
    }

    @RequestMapping(value = "/saveOrder", method = RequestMethod.POST, headers = {"Content-type=application/json"})
    @ResponseBody
    public boolean saveActivityOrder(@RequestBody ActivityMessageOrderVo activityMessageVo, Model model) {
        activityMessageVo.setProperties(ActivityMessage.PROP_ORDER_NUM);
        getService().updateOrderList(activityMessageVo);
        Cache.refreshPcActivityMessages();
        Cache.refreshMobileActivityMessages();
        Cache.refreshCurrentSitePageCache();
        return activityMessageVo.isSuccess();

    }


}
