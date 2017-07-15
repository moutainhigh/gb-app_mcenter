package so.wwb.gamebox.mcenter.player.controller;


import org.soul.commons.bean.Pair;
import org.soul.commons.collections.MapTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.query.Criterion;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.security.Base36;
import org.soul.model.common.FieldProperty;
import org.soul.model.listop.po.SysListOperator;
import org.soul.model.security.privilege.po.SysUserStatus;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.listop.ListOpTool;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.player.IVUserTopAgentManageService;
import so.wwb.gamebox.mcenter.enmus.ListOpEnum;
import so.wwb.gamebox.mcenter.player.form.VUserTopAgentManageForm;
import so.wwb.gamebox.mcenter.player.form.VUserTopAgentManageSearchForm;
import so.wwb.gamebox.mcenter.share.form.SysListOperatorForm;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.listop.FilterRow;
import so.wwb.gamebox.model.listop.FilterSelectConstant;
import so.wwb.gamebox.model.listop.StatusEnum;
import so.wwb.gamebox.model.listop.TabTypeEnum;
import so.wwb.gamebox.model.master.player.po.VUserAgentManage;
import so.wwb.gamebox.model.master.player.po.VUserTopAgentManage;
import so.wwb.gamebox.model.master.player.vo.UserAgentRakebackVo;
import so.wwb.gamebox.model.master.player.vo.UserAgentRebateVo;
import so.wwb.gamebox.model.master.player.vo.VUserTopAgentManageListVo;
import so.wwb.gamebox.model.master.player.vo.VUserTopAgentManageVo;
import so.wwb.gamebox.model.master.setting.po.RebateSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.Serializable;
import java.util.*;


/**
 * 总代管理控制器
 *
 * @author tom
 * @time 2015-9-10 17:18:59
 */
@Controller
//region your codes 1
@RequestMapping("/vUserTopAgentManage")
public class VUserTopAgentManageController extends BaseCrudController<IVUserTopAgentManageService, VUserTopAgentManageListVo, VUserTopAgentManageVo, VUserTopAgentManageSearchForm, VUserTopAgentManageForm, VUserTopAgentManage, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/player/agent/topagentmanage/";
        //endregion your codes 2rebateName IN [Ljava.lang.String;@7aa72bac
    }

    //region your codes 3

    @Override
    protected VUserTopAgentManageListVo doList(VUserTopAgentManageListVo listVo, VUserTopAgentManageSearchForm form, BindingResult result, Model model) {
        listVo.getSearch().setStatus(StatusEnum.NORMAL.getCode());
        resetCondition(listVo);
        listVo = ServiceTool.vUserTopAgentManageService().searchByCustom(listVo);
        Map allListFields = ListOpTool.getFields(ListOpEnum.VUserTopAgentManageListVo);
        listVo.setAllFieldLists(allListFields);
        if (allListFields != null) {
            model.addAttribute("list", allListFields.values());
        }

        Map<String, Serializable> status = DictTool.get(DictEnum.USER_STATUS);
        status.remove(SysUserStatus.AUDIT_FAIL.getCode());
        status.remove(SysUserStatus.INACTIVE.getCode());
        model.addAttribute("status", status);

        if(listVo.getResult()!=null){
            for(VUserTopAgentManage agent : listVo.getResult()){
                if(StringTool.isNotBlank(agent.getRegistCode())){
                    String code = agent.getRegistCode()+agent.getId();
                    String regCode = Base36.encryptIgnoreCase(code);
                    agent.setRegistCode(regCode);
                }

            }
        }

        return listVo;
    }

    private void resetCondition(VUserTopAgentManageListVo listVo){


        VUserTopAgentManageListVo.VUserTopAgentManageQuery query = listVo.getQuery();
        Criterion[] criterions = query.getCriterions();
        if(criterions==null||criterions.length==0){
            return;
        }
        Criterion[] newCriterion = new Criterion[criterions.length];
        int idx = 0;
        for (Criterion criterion : criterions){
            System.out.println(criterion.getProperty());
            if("rebateName".equals(criterion.getProperty())){
                Criterion criterion1 = new Criterion();
                UserAgentRebateVo userAgentRebateVo = new UserAgentRebateVo();
                if(Operator.IN.equals(criterion.getOperator())){
                    userAgentRebateVo.getSearch().setInIds(stringToInteger(criterion.getValue()));
                    List userIds = ServiceTool.userAgentRebateService().queryInRebateId(userAgentRebateVo);
                    criterion1.setProperty(VUserTopAgentManage.PROP_ID);
                    criterion1.setOperator(Operator.IN);
                    criterion1.setValue(userIds);
                }else if(Operator.NOT_IN.equals(criterion.getOperator())){
                    userAgentRebateVo.getSearch().setNotInIds(stringToInteger(criterion.getValue()));
                    List userIds = ServiceTool.userAgentRebateService().queryNotInRebateId(userAgentRebateVo);
                    criterion1.setProperty(VUserTopAgentManage.PROP_ID);
                    criterion1.setOperator(Operator.IN);
                    criterion1.setValue(userIds);
                }else{
                    //EQ TODO:是否需要新写一个等于的查询条件
                    userAgentRebateVo.getSearch().setInIds(stringToInteger(criterion.getValue()));
                    List userIds = ServiceTool.userAgentRebateService().queryInRebateId(userAgentRebateVo);
                    criterion1.setProperty(VUserTopAgentManage.PROP_ID);
                    criterion1.setOperator(Operator.IN);
                    criterion1.setValue(userIds);
                }
                newCriterion[idx]=criterion1;
            }else if("rakebackName".equals(criterion.getProperty())){
                Criterion criterion1 = new Criterion();
                UserAgentRakebackVo userAgentRebateVo = new UserAgentRakebackVo();
                if(Operator.IN.equals(criterion.getOperator())){
                    userAgentRebateVo.getSearch().setInIds(stringToInteger(criterion.getValue()));
                    List userIds = ServiceTool.userAgentRakebackService().queryInRakebackId(userAgentRebateVo);
                    criterion1.setProperty(VUserTopAgentManage.PROP_ID);
                    criterion1.setOperator(Operator.IN);
                    criterion1.setValue(userIds);
                }else if(Operator.NOT_IN.equals(criterion.getOperator())){
                    userAgentRebateVo.getSearch().setNotInIds(stringToInteger(criterion.getValue()));
                    List userIds = ServiceTool.userAgentRakebackService().queryNotInRakebackId(userAgentRebateVo);
                    criterion1.setProperty(VUserTopAgentManage.PROP_ID);
                    criterion1.setOperator(Operator.IN);
                    criterion1.setValue(userIds);
                }else{
                    //EQ TODO:是否需要新写一个等于的查询条件
                    userAgentRebateVo.getSearch().setInIds(stringToInteger(criterion.getValue()));
                    List userIds = ServiceTool.userAgentRakebackService().queryInRakebackId(userAgentRebateVo);
                    criterion1.setProperty(VUserTopAgentManage.PROP_ID);
                    criterion1.setOperator(Operator.IN);
                    criterion1.setValue(userIds);
                }
                newCriterion[idx]=criterion1;
            }else{
                newCriterion[idx]=criterion;
            }
            idx++;
        }
        query.setCriterions(newCriterion);
    }

    private List<Integer> stringToInteger(Object value){
        List<Integer> integerIds = new ArrayList<>();
        if(value==null){
            return integerIds;
        }
        if(value instanceof Object[]){
            Object[] vals = (Object[])value;
            for(Object id : vals){
                if(id!=null&&StringTool.isNotBlank(id.toString())){
                    integerIds.add(Integer.valueOf(id.toString()));
                }
            }
        }else{
            String val = value.toString();
            String[] vals = val.split(",");
            for(String id :vals){
                if(StringTool.isNotBlank(id)){
                    integerIds.add(Integer.valueOf(id.toString()));
                }
            }
        }
        return integerIds;
    }

    /**
     * 更多数据
     * @return
     */
    @RequestMapping(value = "/columns")
    public String indexOp(HttpServletRequest request, HttpServletResponse response, Model model) {
        VUserTopAgentManageListVo vo = new VUserTopAgentManageListVo();
        Map<String, FieldProperty> fieldPropertyMap = vo.getDefaultFields();

        Map<String, Boolean> hasFields = new HashMap();
        ListOpTool.refreshFields(ListOpEnum.VUserTopAgentManageListVo);
        Map listOp = ListOpTool.getFields(ListOpEnum.VUserTopAgentManageListVo);
        Map map = new TreeMap(new Comparator() {
            @Override
            public int compare(Object o1, Object o2) {
                return ((Integer) o1)-((Integer) o2);
            }
        });
        if (listOp != null) {
            map.putAll(listOp);
        }
        for (Object o : listOp.keySet()) {
            SysListOperator tem = (SysListOperator) listOp.get(o);
            ArrayList<Map<String, String>> tt = JsonTool.fromJson(tem.getContent(), ArrayList.class);
            for (Map<String, String> stringStringMap : tt) {
                for (String s : stringStringMap.keySet()) {
                    hasFields.put(stringStringMap.get("name"), true);
                }
            }
            tem.setMapContent(tt);
        }

        model.addAttribute("keyClassName", ListOpEnum.VUserTopAgentManageListVo.getClassName());
        model.addAttribute("defaultFeilds", fieldPropertyMap);
        model.addAttribute("lists", map);
        model.addAttribute("hasFeilds", hasFields);

        return "share/ListColumns";
    }

    /**
     * 筛选管理
     *
     * @param model
     * @return
     */
    @RequestMapping({"/filters"})
    public String list(Model model) {

        Map<String, SysListOperator> listOp = ListOpTool.getFilter(ListOpEnum.VUserTopAgentManageListVo);
        if (listOp != null && listOp.size() > 0) {
            model.addAttribute("filters", listOp.values());
        }
        //region Filter Conditions
        String vUserTopAgentManager = VUserTopAgentManage.class.getSimpleName();
        List<FilterRow> filterRowList = new ArrayList<>();

        filterRowList.add(new FilterRow(VUserTopAgentManage.PROP_PLAYER_NUM, LocaleTool.tranView("column", vUserTopAgentManager + "." + VUserTopAgentManage.PROP_PLAYER_NUM),
                FilterSelectConstant.equalRange, TabTypeEnum.TEXT, null));
        filterRowList.add(new FilterRow(VUserTopAgentManage.PROP_CHILD_AGENT_NUM, LocaleTool.tranView("column", vUserTopAgentManager + "." + VUserTopAgentManage.PROP_CHILD_AGENT_NUM),
                FilterSelectConstant.equalRange, TabTypeEnum.TEXT, null));
        filterRowList.add(new FilterRow(VUserTopAgentManage.PROP_CREATE_TIME, LocaleTool.tranView("column", vUserTopAgentManager + "." + VUserTopAgentManage.PROP_CREATE_TIME),
                FilterSelectConstant.greatAndLess, TabTypeEnum.DATE, null));
        /*filterRowList.add(new FilterRow(VUserTopAgentManage.PROP_COUNTRY, LocaleTool.tranView("column", vUserTopAgentManager + "." + VUserTopAgentManage.PROP_COUNTRY),
                FilterSelectConstant.containCountry, TabTypeEnum.REGIONS, null));*/
        Map<String, List<Pair>> agentFilter = ServiceTool.vUserTopAgentManageService().searchAgentFilter(new VUserTopAgentManageListVo());
        if (MapTool.isNotEmpty(agentFilter)) {
            String vUserAgentManage = VUserAgentManage.class.getSimpleName();
            List<Pair> rebateSetList = agentFilter.get(RebateSet.class.getName());
            filterRowList.add(new FilterRow(VUserAgentManage.PROP_REBATE_NAME, LocaleTool.tranView("column", vUserAgentManage + "." + VUserAgentManage.PROP_REBATE_NAME),
                    FilterSelectConstant.containPlan, TabTypeEnum.CHECKBOX, rebateSetList));

            /*List<Pair> rakebackSetList = agentFilter.get(RakebackSet.class.getName());
            filterRowList.add(new FilterRow(VUserAgentManage.PROP_RAKEBACK_NAME, LocaleTool.tranView("column", vUserAgentManage + "." + VUserAgentManage.PROP_RAKEBACK_NAME),
                    FilterSelectConstant.containPlan, TabTypeEnum.CHECKBOX, rakebackSetList));*/

        }

        filterRowList.add(new FilterRow(VUserTopAgentManage.PROP_SEX, LocaleTool.tranView("column", vUserTopAgentManager + "." + VUserTopAgentManage.PROP_SEX),
                FilterSelectConstant.equal, TabTypeEnum.SELECT, FilterSelectConstant.sex));
        filterRowList.add(new FilterRow(VUserTopAgentManage.PROP_BIRTHDAY, LocaleTool.tranView("column", vUserTopAgentManager + "." + VUserTopAgentManage.PROP_BIRTHDAY),
                FilterSelectConstant.greatAndLess, TabTypeEnum.DATE, null));

        filterRowList.add(new FilterRow(VUserTopAgentManage.PROP_LAST_LOGIN_TIME, LocaleTool.tranView("column", vUserTopAgentManager + "." + VUserTopAgentManage.PROP_LAST_LOGIN_TIME),
                FilterSelectConstant.greatAndLess, TabTypeEnum.DATE, null));
        filterRowList.add(new FilterRow(VUserAgentManage.PROP_STATUS, LocaleTool.tranView("column", vUserTopAgentManager + "." + VUserAgentManage.PROP_STATUS),
                FilterSelectConstant.contain, TabTypeEnum.CHECKBOX, FilterSelectConstant.status));

        model.addAttribute("validateRule", JsRuleCreator.create(SysListOperatorForm.class, ""));
        model.addAttribute("filterList", filterRowList);
        model.addAttribute("keyClassName", ListOpEnum.VUserTopAgentManageListVo.getClassName());
        model.addAttribute("jsonFilterList", JsonTool.toJson(filterRowList));
        model.addAttribute("goFilterUrl", "/VUserTopAgentManage/index.html");

        return "/share/ListFilters";
    }

    //endregion your codes 3

}