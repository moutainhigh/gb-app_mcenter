package so.wwb.gamebox.mcenter.content.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.master.content.ICttDomainRankService;
import so.wwb.gamebox.mcenter.content.form.CttDomainRankForm;
import so.wwb.gamebox.mcenter.content.form.CttDomainRankSearchForm;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.SiteParamEnum;
import so.wwb.gamebox.model.company.sys.po.SysDomain;
import so.wwb.gamebox.model.company.sys.vo.SysDomainVo;
import so.wwb.gamebox.model.master.content.po.CttDomainRank;
import so.wwb.gamebox.model.master.content.vo.CttDomainRankListVo;
import so.wwb.gamebox.model.master.content.vo.CttDomainRankVo;
import so.wwb.gamebox.model.master.player.vo.PlayerRankVo;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;


/**
 * 内容管理-域名与层级关联表控制器
 *
 * @author jeff
 * @time 2015-8-13 16:37:44
 */
@Controller
//region your codes 1
@RequestMapping("/content/cttDomainRank")
public class CttDomainRankController extends BaseCrudController<ICttDomainRankService, CttDomainRankListVo, CttDomainRankVo, CttDomainRankSearchForm, CttDomainRankForm, CttDomainRank, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/content/";
        //endregion your codes 2
    }



    //region your codes 3
    @RequestMapping(value = "/reset")
    @ResponseBody
    public Map reset(Model model,@RequestBody SysDomainVo sysDomainVo){
        sysDomainVo = getService().changeSort(sysDomainVo);
        ParamTool.refresh(SiteParamEnum.CONTENT_SETTINGS_DOMAIN);
        return getVoMessage(sysDomainVo);
    }
    @RequestMapping("/saveRank")
    @ResponseBody
    public Map saveRank(CttDomainRankVo cttDomainRankVo,SysDomainVo sysDomainVo){
        //查询该域名是否是全部层级
        List<Map<String, Object>> maps = ServiceTool.playerRankService().queryUsableRankList(new PlayerRankVo());
        for(Integer domainId:cttDomainRankVo.getSearch().getDomainIds()){
            sysDomainVo.getSearch().setId(domainId);
            sysDomainVo = ServiceTool.sysDomainService().get(sysDomainVo);
            if(sysDomainVo.getResult().getIsForAllRank()!=null){
                if(sysDomainVo.getResult().getIsForAllRank()){
                    //清空该域名的层级关联表
                    cttDomainRankVo.getSearch().setDomainId(domainId);
                    this.getService().batchDeleteCriteria(cttDomainRankVo);
                    //域名层级关联表集合
                    ArrayList<CttDomainRank> cttDomainRankArrayList = new ArrayList();
                    for(Map<String,Object> playerrank:maps){
                        CttDomainRank cttDomainRank = new CttDomainRank();
                        cttDomainRank.setRankId((Integer) playerrank.get("id"));
                        cttDomainRank.setDomainId(domainId);
                        cttDomainRank.setIsShow(true);
                        cttDomainRankArrayList.add(cttDomainRank);
                    }
                    cttDomainRankVo.setEntities(cttDomainRankArrayList);
                    this.getService().batchInsert(cttDomainRankVo);
                }
            }
        }
        //重新修改层级之后就把全部层级状态改为false
        ArrayList<SysDomain> sysDomains = new ArrayList<>();
        for(Integer id:cttDomainRankVo.getSearch().getDomainIds()){
            SysDomain domain = new SysDomain();
            domain.setId(id);
            domain.setIsForAllRank(false);
            sysDomains.add(domain);
        }
        sysDomainVo.setEntities(sysDomains);
        sysDomainVo.setProperties(SysDomain.PROP_IS_FOR_ALL_RANK);
        ServiceTool.sysDomainService().batchUpdateOnly(sysDomainVo);

        super.getService().saveRanks(cttDomainRankVo);
        return getVoMessage(cttDomainRankVo);
    }
    //endregion your codes 3

}