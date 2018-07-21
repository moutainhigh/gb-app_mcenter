package so.wwb.gamebox.mcenter.share.controller;

import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.model.common.BaseObjectVo;
import org.soul.model.listop.po.SysListOperator;
import org.soul.model.listop.vo.SysListOperatorListVo;
import org.soul.model.listop.vo.SysListOperatorVo;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.listop.ListOpTool;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.company.filter.ISysMasterListOperatorService;
import so.wwb.gamebox.mcenter.enmus.ListOpEnum;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.share.form.SysListOperatorForm;
import so.wwb.gamebox.mcenter.share.form.SysListOperatorSearchForm;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.common.MessageI18nConst;
import so.wwb.gamebox.web.init.ConfigBase;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by tony on 15-7-7.
 */
@Controller
@RequestMapping("/share/columns")
public class ListColumnsController extends BaseCrudController<ISysMasterListOperatorService,SysListOperatorListVo, SysListOperatorVo, SysListOperatorSearchForm, SysListOperatorForm, SysListOperator, Integer> {
    /**
     *
     * 删除列
     */
    @RequestMapping(value="/deleteOperator")
    @ResponseBody
    public Map deleteOperator(SysListOperatorVo vo){
        if(vo.getResult()!=null&&vo.getResult().getId()!=null){
            vo.getSearch().setId(vo.getResult().getId());
            if (vo.getResult().getId()!=null){
                vo.setSuccess(ServiceTool.sysMasterListOperatorService().delete(vo));
            }
            ListOpTool.refreshFields(ListOpEnum.enumOf(vo.getKeyClassName()));
        }
        HashMap map = new HashMap(2,1f);
        map.put("msg", StringTool.isNotBlank(vo.getOkMsg()) ? vo.getOkMsg() : vo.getErrMsg());
        map.put("state", Boolean.valueOf(vo.isSuccess()));
        return map;
    }
    /**
     *
     * @param objectVo
     * @param request
     * @param response
     * @param model
     * @return 保存拖动
     */
    @RequestMapping(value = "/saveOperator",headers = {"Content-type=application/json"})
    @ResponseBody
    public Map saveOperator(@RequestBody SysListOperatorVo objectVo,HttpServletRequest request, HttpServletResponse response, Model model) {
        BaseObjectVo result = null;
        Boolean bool = null;
        //添加数据
        List<SysListOperator> sysListOperatorList = objectVo.getEntities();
        for(int i=0,len=sysListOperatorList.size();i<len;i++){
            if(i==0){
                sysListOperatorList.get(0).setIsDefault(true);
            }else{
                sysListOperatorList.get(i).setIsDefault(false);
            }
            sysListOperatorList.get(i).setOpType(2);
            sysListOperatorList.get(i).setSubsysCode(ConfigBase.get().getSubsysCode());
            sysListOperatorList.get(i).setSiteId(SessionManager.getSiteId());
        }
        //判斷全部操作是否成功
       objectVo.setSuccess(ServiceTool.sysMasterListOperatorService().batchSave(objectVo));
        if(objectVo.isSuccess()) {
            if (ListOpTool.getFields(ListOpEnum.enumOf(objectVo.getKeyClassName())) == null){
                //当默认值为空，刷全部 TODO：不太好
                ListOpTool.refreshAllFields();

            } else {
                ListOpTool.refreshFields(ListOpEnum.enumOf(objectVo.getKeyClassName()));
            }
            Map listOp = ListOpTool.getFields(ListOpEnum.enumOf(objectVo.getKeyClassName()));
            objectVo.setOkMsg(LocaleTool.tranMessage(Module.COMMON, MessageI18nConst.SAVE_SUCCESS));
        } else {
            objectVo.setErrMsg(LocaleTool.tranMessage(Module.COMMON, MessageI18nConst.SAVE_FAILED));
        }
        return this.getVoMessage(objectVo);
    }

    @Override
    protected String getViewBasePath() {
        return null;
    }
}
