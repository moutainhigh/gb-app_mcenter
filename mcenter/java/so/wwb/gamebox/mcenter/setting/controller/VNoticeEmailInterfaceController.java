package so.wwb.gamebox.mcenter.setting.controller;


import org.soul.commons.lang.ArrayTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.security.CryptoTool;
import org.soul.commons.support._Module;
import org.soul.model.msg.notice.po.NoticeEmailInterface;
import org.soul.model.msg.notice.vo.NoticeEmailInterfaceVo;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.master.setting.IVNoticeEmailInterfaceService;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.setting.form.NoticeEmailInterfaceForm;
import so.wwb.gamebox.mcenter.setting.form.VNoticeEmailInterfaceForm;
import so.wwb.gamebox.mcenter.setting.form.VNoticeEmailInterfaceSearchForm;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.common.MessageI18nConst;
import so.wwb.gamebox.model.master.player.po.PlayerRank;
import so.wwb.gamebox.model.master.player.vo.PlayerRankVo;
import so.wwb.gamebox.model.master.setting.po.VNoticeEmailInterface;
import so.wwb.gamebox.model.master.setting.vo.VNoticeEmailInterfaceListVo;
import so.wwb.gamebox.model.master.setting.vo.VNoticeEmailInterfaceVo;
import so.wwb.gamebox.model.master.setting.vo.VNoticeEmailRankVo;
import so.wwb.gamebox.web.common.token.Token;

import javax.validation.Valid;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.UUID;


/**
 * 邮件接口视图控制器
 *
 * @author loong
 * @time 2015-8-26 15:07:58
 */
@Controller
//region your codes 1
@RequestMapping("/vNoticeEmailInterface")
public class VNoticeEmailInterfaceController extends BaseCrudController<IVNoticeEmailInterfaceService, VNoticeEmailInterfaceListVo, VNoticeEmailInterfaceVo, VNoticeEmailInterfaceSearchForm, VNoticeEmailInterfaceForm, VNoticeEmailInterface, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/setting/interface/email/";
        //endregion your codes 2
    }
    private static final String INDEX = "/setting/interface/email/Edit";
    //region your codes 3
    @Override
    protected VNoticeEmailInterfaceVo doEdit(VNoticeEmailInterfaceVo objectVo, Model model) {
        objectVo = this.getService().get(objectVo);
        String password = CryptoTool.aesDecrypt(objectVo.getResult().getAccountPassword());
        objectVo.getResult().setAccountPassword(password);
        return objectVo;
    }
    @RequestMapping({"/editEmail"})
    public String editEmail(Model model,VNoticeEmailRankVo vNoticeEmailRankVo){
        vNoticeEmailRankVo=ServiceTool.vNoticeEmailRankService().search(vNoticeEmailRankVo);
        String password = CryptoTool.aesDecrypt(vNoticeEmailRankVo.getResult().getAccountPassword());
        vNoticeEmailRankVo.getResult().setAccountPassword(password);
        PlayerRankVo vo = new PlayerRankVo();
        List<PlayerRank> playerRanks = ServiceTool.playerRankService().queryUsableList(vo);
        vNoticeEmailRankVo.setRankList(playerRanks);
        vNoticeEmailRankVo.setValidateRule(JsRuleCreator.create(VNoticeEmailInterfaceForm.class, "result"));
        model.addAttribute("command", vNoticeEmailRankVo);
        return  getViewBasePath()+"EmailEdit";
    }
    /**
     * 保存/修改邮件
     * @param objectVo
     * @param form
     * @param result
     * @return
     */
    @RequestMapping({"/save"})
    @ResponseBody
    @Token(valid = true)
    public Map save(VNoticeEmailInterfaceVo objectVo, @FormModel("result") @Valid VNoticeEmailInterfaceForm form, BindingResult result) {
        if(!result.hasErrors()) {
            if(objectVo.isSuccess()) {
                String accountPassword = objectVo.getResult().getAccountPassword();
                accountPassword = CryptoTool.aesEncrypt(accountPassword);
                objectVo.getResult().setAccountPassword(accountPassword);
                objectVo = this.getService().saveMail(objectVo);

            }
            return this.getVoMessage(objectVo);
        } else {
            objectVo.setSuccess(false);
            return getVoMessage(objectVo);
        }
    }



    @RequestMapping({"/editBuiltInEmail"})
    public String editBuiltInEmail(Model model,NoticeEmailInterfaceVo noticeEmailInterfaceVo){
        noticeEmailInterfaceVo=ServiceTool.noticeEmailInterfaceService().get(noticeEmailInterfaceVo);
        String password = CryptoTool.aesDecrypt(noticeEmailInterfaceVo.getResult().getAccountPassword());
        noticeEmailInterfaceVo.getResult().setAccountPassword(password);
        noticeEmailInterfaceVo.setValidateRule(JsRuleCreator.create(NoticeEmailInterfaceForm.class, "result"));
        model.addAttribute("command", noticeEmailInterfaceVo);
        return  getViewBasePath()+"EmailBuiltInEdit";
    }


    /**
     * 修改默认邮件
     * @param objectVo
     * @param form
     * @param result
     * @return
     */
    @RequestMapping({"/updateBuiltIn"})
    @ResponseBody
    public Map updateBuiltIn(NoticeEmailInterfaceVo objectVo, @FormModel("result") @Valid NoticeEmailInterfaceForm form, BindingResult result) {
        if(!result.hasErrors()) {
            if(objectVo.isSuccess()) {
                String accountPassword = objectVo.getResult().getAccountPassword();
                accountPassword = CryptoTool.aesEncrypt(accountPassword);
                objectVo.getResult().setAccountPassword(accountPassword);
                String[] pro=new String[4];
                pro[0]= NoticeEmailInterface.PROP_SERVER_ADDRESS;
                pro[1]= NoticeEmailInterface.PROP_SERVER_PORT;
                pro[2]= NoticeEmailInterface.PROP_EMAIL_ACCOUNT;
                pro[3]= NoticeEmailInterface.PROP_ACCOUNT_PASSWORD;
                objectVo.setProperties(pro);
                if(objectVo.getSearch().getId()!=null){
                    objectVo.getResult().setId(objectVo.getSearch().getId());
                }
                objectVo = ServiceTool.noticeEmailInterfaceService().updateOnly(objectVo);

            }
            return this.getVoMessage(objectVo);
        } else {
            objectVo.setSuccess(false);
            return getVoMessage(objectVo);
        }
    }
    /**
     *启用/禁用操作
     * @param emailAccount
     * @return
     */
    @RequestMapping({"/updateStatus"})
    @ResponseBody
    public Map updateStatus(String emailAccount){
        VNoticeEmailInterfaceVo vo = new VNoticeEmailInterfaceVo();
        vo.getSearch().setEmailAccount(emailAccount);
        this.getService().updateStatus(vo);
        return this.getVoMessage(vo);
    }

    /**
     * 查询可用层级
     * @return
     */
    @RequestMapping({"/queryUsableList"})
    @ResponseBody
    public List<PlayerRank> queryUsableList(){
        PlayerRankVo vo = new PlayerRankVo();
        List<PlayerRank> playerRanks = ServiceTool.playerRankService().queryUsableList(vo);
        return playerRanks;
    }

    @RequestMapping("/createEmail")
    @Token(generate = true)
    public String createEmail(VNoticeEmailInterfaceVo objectVo, Model model) {
        objectVo=super.doCreate(objectVo, model);
        PlayerRankVo vo = new PlayerRankVo();
        List<PlayerRank> playerRanks = ServiceTool.playerRankService().queryUsableList(vo);
        objectVo.setRankList(playerRanks);
        // 表单校验
        objectVo.setValidateRule(JsRuleCreator.create(VNoticeEmailInterfaceForm.class, "result"));
        model.addAttribute("command", objectVo);
        return INDEX;
    }

    /**
     *删除邮件接口
     * @param ids
     * @return
     */
    @RequestMapping({"/batchDelete"})
    @ResponseBody
    public Map batchDelete(String[] ids) {
        VNoticeEmailInterfaceListVo vo = new VNoticeEmailInterfaceListVo();
        if(ArrayTool.isEmpty(ids)){
            vo.setSuccess(false);
            return this.getVoMessage(vo);
        }
        vo.setPropertyValues(Arrays.asList(ids));
        vo = ServiceTool.vNoticeEmailInterfaceService().batchDel(vo);
        if(vo.isSuccess()){
            vo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.DELETE_SUCCESS));
        }else {
            vo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.DELETE_FAILED));
        }
        return this.getVoMessage(vo);
    }
    /**
     *查询邮件账号是否存在
     * @param
     * @return
     */
    @RequestMapping({"/checkEmailAccount"})
    @ResponseBody
    public boolean checkEmailAccount(@RequestParam("result.emailAccount")String account,@RequestParam("result.original")String original){
        if(account.equals(original)){
            return true;
        }else{
            VNoticeEmailInterfaceListVo vNoticeEmailInterfaceListVo = new VNoticeEmailInterfaceListVo();
            vNoticeEmailInterfaceListVo.getSearch().setEmailAccount(account);
            vNoticeEmailInterfaceListVo=this.getService().search(vNoticeEmailInterfaceListVo);
            return vNoticeEmailInterfaceListVo.getResult().size()==0;
        }

    }
    //endregion your codes 3

}