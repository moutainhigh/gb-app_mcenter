package so.wwb.gamebox.mcenter.setting.controller;

import org.soul.iservice.smsinterface.ISmsInterfaceService;
import org.soul.model.sms_interface.po.SmsInterface;
import org.soul.model.sms_interface.vo.SmsInterfaceListVo;
import org.soul.model.sms_interface.vo.SmsInterfaceVo;
import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.setting.form.SmsInterfaceForm;
import so.wwb.gamebox.mcenter.setting.form.SmsInterfaceSearchForm;

import java.util.Map;


/**
 * 短信接口控制器
 *
 * @author Administrator
 * @time 2016-7-7 20:20:50
 */
@Controller
//region your codes 1
@RequestMapping("/smsInterface")
public class SmsInterfaceController extends BaseCrudController<ISmsInterfaceService, SmsInterfaceListVo, SmsInterfaceVo, SmsInterfaceSearchForm, SmsInterfaceForm, SmsInterface, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/setting/interface/sms/";
        //endregion your codes 2
    }

    //region your codes 3
    @RequestMapping({"/saveSmsInterface"})
    @ResponseBody
    public Map saveSmsInterface(SmsInterfaceVo smsInterfaceVo,Model model){
        smsInterfaceVo._setDataSourceId(SessionManager.getSiteId());
        SmsInterface sms = smsInterfaceVo.getSms();
        smsInterfaceVo.setResult(sms);
        if(sms.getId()==null){
            ServiceTool.smsInterfaceService().insert(smsInterfaceVo);
        }else{
            smsInterfaceVo.setProperties(SmsInterface.PROP_REQUEST_URL,SmsInterface.PROP_USERNAME,SmsInterface.PROP_PASSWORD,SmsInterface.PROP_DATA_KEY);
            ServiceTool.smsInterfaceService().updateOnly(smsInterfaceVo);
        }

        return getVoMessage(smsInterfaceVo);
    }
    //endregion your codes 3

}