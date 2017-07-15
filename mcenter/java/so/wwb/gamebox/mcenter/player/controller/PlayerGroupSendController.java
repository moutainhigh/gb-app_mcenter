package so.wwb.gamebox.mcenter.player.controller;

import org.soul.commons.bean.Pair;
import org.soul.commons.collections.CollectionQueryTool;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.log.LogFactory;
import org.soul.commons.query.Criteria;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.security.CryptoTool;
import org.soul.commons.security.key.CryptoKey;
import org.soul.model.msg.notice.enums.NoticePublishMethod;
import org.soul.model.msg.notice.vo.NoticeVo;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.mcenter.player.form.PlayerGroupSendForm;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.common.notice.enums.ManualNoticeEvent;
import so.wwb.gamebox.model.company.site.po.SiteLanguage;
import so.wwb.gamebox.model.master.enums.SiteLangStatusEnum;
import so.wwb.gamebox.model.master.player.vo.UserPlayerVo;
import so.wwb.gamebox.model.master.setting.vo.VNoticeEmailRankListVo;
import so.wwb.gamebox.web.cache.Cache;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by jeff on 15-7-22.
 * 玩家信息群发
 */

@Controller
    @RequestMapping(value = "/player/groupSend")
public class PlayerGroupSendController {
    private static final String CHOOSE_SEND_TYPE = "/player/player/groupsend/ChooseType";
    private static final String SEND_MESSAGE_CONTENT_EDIT = "/player/player/groupsend/EditContent";
    private static final String SEND_MESSAGE_CONTENT_WARNING = "/player/player/groupsend/WarningContent";
    private static final String SEND_TYPE_MAIL = "mail";
    private static final String SEND_TYPE_STATIONLETTER = "stationLetter";

    /**
     * 页面显示最多 站长语言
     */
    private static final Integer MAX_LANG = 3;

    /**
     *
     * 玩家信息群发，选择发送方式弹窗
     * @param playerIds　选中的玩家id
     * @param model model
     * @return 弹窗页面
     */
    @RequestMapping(value = "chooseSendType",method = RequestMethod.GET)
    public String chooseSendType(String playerIds, Model model){
        model.addAttribute("playerIds", playerIds);
        return CHOOSE_SEND_TYPE;
    }


    /**
     * 编辑发送信息弹窗
     * @param model
     * @param userPlayerVo
     * @return
     */
    @RequestMapping(value = "sendByType",method = RequestMethod.GET)
    public String sendByType(Model model,UserPlayerVo userPlayerVo){
        /*VNoticeEmailRankListVo vno  = new VNoticeEmailRankListVo();
        vno.getSearch().setStatus("1");
        vno.getSearch().setBuiltIn(false);
        vno = ServiceTool.vNoticeEmailRankService().search(vno);
        if(vno.getResult().size()>0){
            *//**
             * TODO 模板 发送
             *
             *//*
        *//*站长语言*//*
            userPlayerVo = ServiceTool.userPlayerService().getUserPlayer4GroupSend(userPlayerVo);
            List<SiteLanguage> siteLanguages = new ArrayList<>(Cache.getSiteLanguage().values());
            siteLanguages = CollectionQueryTool.query(siteLanguages, Criteria.add(SiteLanguage.PROP_STATUS, Operator.EQ, SiteLangStatusEnum.USING.getCode()));
            userPlayerVo.setSiteLanguages(siteLanguages);
            NoticeVo noticeVo = new NoticeVo();
            noticeVo.setEventType(ManualNoticeEvent.GROUP_SEND);
            switch (userPlayerVo.getSendType()){
                case SEND_TYPE_MAIL:
                    noticeVo.setPublishMethod(NoticePublishMethod.EMAIL);
                    break;
                case SEND_TYPE_STATIONLETTER:
                    noticeVo.setPublishMethod(NoticePublishMethod.SITE_MSG);
                    break;
                default:
                    return null;
            }
        *//*玩家管理-信息群发 模板信息*//*
//        List<NoticeLocaleTmpl> noticeTmpls = ServiceTool.noticeService().fetchLocaleTmpls(noticeVo);
//        userPlayerVo.setNoticeLocaleTmpls(noticeTmpls);
//        userPlayerVo.setNoticeLocaleTmplJson(JsonTool.toJson(CollectionTool.groupByProperty(noticeTmpls, NoticeTmpl.PROP_GROUP_CODE, String.class)));
            model.addAttribute("userPlayerVo", userPlayerVo);
            model.addAttribute("maxLang", MAX_LANG);
            return SEND_MESSAGE_CONTENT_EDIT;
        }else{
            return SEND_MESSAGE_CONTENT_WARNING;
        }*/

        String url = "";
        if (SEND_TYPE_STATIONLETTER.equals(userPlayerVo.getSendType())) {
            getSendTypeWay(model, userPlayerVo, NoticePublishMethod.SITE_MSG);
            url = SEND_MESSAGE_CONTENT_EDIT;
        } else if (SEND_TYPE_MAIL.equals(userPlayerVo.getSendType())) {
            VNoticeEmailRankListVo vno  = new VNoticeEmailRankListVo();
            vno.getSearch().setStatus("1");
            /*vno.getSearch().setBuiltIn(false);*/
            vno = ServiceTool.vNoticeEmailRankService().search(vno);
            if (vno.getResult().size()>0) {
                getSendTypeWay(model, userPlayerVo, NoticePublishMethod.EMAIL);
                url =  SEND_MESSAGE_CONTENT_EDIT;
            } else {
                url = SEND_MESSAGE_CONTENT_WARNING;
            }
        }
//        model.addAttribute("validateRule", JsRuleCreator.create(PlayerGroupSendForm.class));
        return url;
    }

    private void getSendTypeWay(Model model, UserPlayerVo userPlayerVo, NoticePublishMethod siteMsg) {
        userPlayerVo = ServiceTool.userPlayerService().getUserPlayer4GroupSend(userPlayerVo);
        //解密email
        if (SEND_TYPE_MAIL.equals(userPlayerVo.getSendType())) {
            List<Map<String,Object>> groupSendPlayers = userPlayerVo.getGroupSendPlayers();
            for (Map<String,Object> groupSendPlayer : groupSendPlayers) {
                String cryptEmail = (String)groupSendPlayer.get(SEND_TYPE_MAIL);
                if(StringTool.isNotBlank(cryptEmail)){
                    String email = CryptoTool.aesDecrypt(cryptEmail, CryptoKey.KEY_NOTICE_CONTACT_WAY);
                    groupSendPlayer.put(SEND_TYPE_MAIL,email);
                }

            }
        }

        List<SiteLanguage> siteLanguages = new ArrayList<>(Cache.getSiteLanguage().values());
        siteLanguages = CollectionQueryTool.query(siteLanguages, Criteria.add(SiteLanguage.PROP_STATUS, Operator.EQ, SiteLangStatusEnum.USING.getCode()));
        userPlayerVo.setSiteLanguages(siteLanguages);
        NoticeVo noticeVo = new NoticeVo();
        noticeVo.setEventType(ManualNoticeEvent.GROUP_SEND);
        noticeVo.setPublishMethod(siteMsg);
        model.addAttribute("userPlayerVo", userPlayerVo);
        model.addAttribute("maxLang", MAX_LANG);
    }

    /**
     * 根据发送类别，发送信息
     * @return
     */
    @RequestMapping(value = "sendByType",method = RequestMethod.POST)
    @ResponseBody
    public Boolean send(UserPlayerVo userPlayerVo, /*@FormModel @Valid PlayerGroupSendForm form,*/ BindingResult result){
        if (result.hasErrors()) {
            return false;
        }
        Map<String, Map<String, String>> sendContent = userPlayerVo.getSendContent();
        Map<String, Pair<String, String>> localeTmplMap = new HashMap();
        for (String key :sendContent.keySet()){
            localeTmplMap.put(key, new Pair<String, String>(sendContent.get(key).get("title"),sendContent.get(key).get("content")));
        }
        NoticeVo variableNoticeVo = new NoticeVo();
        if(userPlayerVo.isByTime()&&userPlayerVo.getTime()!=null){
            variableNoticeVo.setCronExp(DateTool.toCronExp(userPlayerVo.getTime()));
        }
        switch (userPlayerVo.getSendType()){
            case SEND_TYPE_MAIL:
                variableNoticeVo.setPublishMethod(NoticePublishMethod.EMAIL);
                break;
            case SEND_TYPE_STATIONLETTER:
                variableNoticeVo.setPublishMethod(NoticePublishMethod.SITE_MSG);
                break;
            default:
                return null;
        }
        variableNoticeVo.setEventType(ManualNoticeEvent.GROUP_SEND);
        variableNoticeVo.addUserIds(userPlayerVo.getIds().toArray(new Integer[]{}));
        variableNoticeVo.setLocaleTmplMap(localeTmplMap);
        try{
            ServiceTool.noticeService().publish(variableNoticeVo);
        }catch (Exception ex){
            LogFactory.getLog(this.getClass()).error(ex,"发布消息不成功");
        }
        return true;
    }
}
