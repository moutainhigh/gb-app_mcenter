package so.wwb.gamebox.mcenter.content.controller;


import org.soul.commons.collections.CollectionTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.enums.EnumTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.model.sys.po.SysDict;
import org.soul.model.sys.po.SysParam;
import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.content.IVCttCarouselService;
import so.wwb.gamebox.mcenter.content.form.VCttCarouselForm;
import so.wwb.gamebox.mcenter.content.form.VCttCarouselSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.SiteParamEnum;
import so.wwb.gamebox.model.master.content.enums.IntervalTimeEnum;
import so.wwb.gamebox.model.master.content.po.CttCarouselI18n;
import so.wwb.gamebox.model.master.content.po.VCttCarousel;
import so.wwb.gamebox.model.master.content.vo.CttCarouselI18nListVo;
import so.wwb.gamebox.model.master.content.vo.VCttCarouselListVo;
import so.wwb.gamebox.model.master.content.vo.VCttCarouselVo;
import so.wwb.gamebox.model.master.enums.CarouselTypeEnum;

import java.util.*;


/**
 * 内容管理-轮播管理控制器
 *
 * @author jeff
 * @time 2015-7-29 16:08:32
 */
@Controller
//region your codes 1
@RequestMapping("/content/vCttCarousel")
public class VCttCarouselController extends BaseCrudController<IVCttCarouselService, VCttCarouselListVo, VCttCarouselVo, VCttCarouselSearchForm, VCttCarouselForm, VCttCarousel, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/content/carousel/";
        //endregion your codes 2
    }

    //region your codes 3
    private static final String CAROUSEL_SET = "/content/carousel/Setting";

    @Override
    protected VCttCarouselListVo doList(VCttCarouselListVo listVo, VCttCarouselSearchForm form, BindingResult result, Model model) {
        listVo = searchByName(listVo);
        listVo = super.doList(listVo, form, result, model);
        Map<String, SysDict> types = DictTool.get(DictEnum.CONTENT_CAROUSEL_TYPE);
        Map<String, SysDict> useStatus = DictTool.get(DictEnum.CAROUSEL_STATE);
        listVo.setTypes(types);
        listVo.setUseStatus(useStatus);
        getCurrentLangCarousel(listVo);
        return listVo;
    }
    //手动设置根据名称查询
    private VCttCarouselListVo searchByName(VCttCarouselListVo listVo){
        if(StringTool.isBlank(listVo.getSearch().getName())){
            return listVo;
        }
        CttCarouselI18nListVo cttCarouselI18nListVo = new CttCarouselI18nListVo();
        cttCarouselI18nListVo.getSearch().setName(listVo.getSearch().getName());
        cttCarouselI18nListVo.setPaging(null);
        cttCarouselI18nListVo.setProperties(CttCarouselI18n.PROP_CAROUSEL_ID);
        List<Integer> list = ServiceTool.cttCarouselI18nService().searchProperty(cttCarouselI18nListVo);
        if(list!=null&&list.size()>0){
            listVo.getSearch().setIds(list);
        }else{
            //为空时添加为空查询，要不然会查出所有
            list = new ArrayList<Integer>();
            list.add(-1);
            listVo.getSearch().setIds(list);
        }

        return listVo;
    }
    //获取当前语言的广告
    private void getCurrentLangCarousel(VCttCarouselListVo listVo){
        CttCarouselI18nListVo cttCarouselI18nListVo = new CttCarouselI18nListVo();
        cttCarouselI18nListVo.getSearch().setLanguage(SessionManager.getLocale().toString());
        cttCarouselI18nListVo.setPaging(null);
        cttCarouselI18nListVo = ServiceTool.cttCarouselI18nService().search(cttCarouselI18nListVo);
        List<CttCarouselI18n> i18nList = cttCarouselI18nListVo.getResult();
        Map<Object, CttCarouselI18n> i18nMap= CollectionTool.toEntityMap(i18nList, CttCarouselI18n.PROP_CAROUSEL_ID);
        listVo.setCurrentLang(i18nMap);
    }

    @RequestMapping("/setting")
    public String setting(Model model,VCttCarouselListVo vCttCarouselListVo){
        /*广告管理类别*/
        Map<String, SysDict> types = DictTool.get(DictEnum.CONTENT_CAROUSEL_TYPE);
        types.remove(CarouselTypeEnum.CAROUSEL_TYPE_REGISTER.getCode());
        types.remove(CarouselTypeEnum.CAROUSEL_TYPE_AD_DIALOG.getCode());
        vCttCarouselListVo.setTypes(types);

        Iterator<String> iter = types.keySet().iterator();
        if(iter.hasNext()){
            String type = iter.next();
            vCttCarouselListVo.getSearch().setType(type);
        }

        vCttCarouselListVo.getSearch().setUseStatus("using");
        vCttCarouselListVo.setPaging(null);
        vCttCarouselListVo = getService().search(vCttCarouselListVo);
        List<VCttCarousel> vCttCarousels = vCttCarouselListVo.getResult();
        vCttCarouselListVo.setResult(vCttCarousels);
        getCurrentLangCarousel(vCttCarouselListVo);



        Collection<SysParam> c2 = ParamTool.getSysParams(SiteParamEnum.CONTENT_CAROUSEL_INTERVAL_TIME);
        Iterator<SysParam> ie = c2.iterator();
        List<SysParam> list2 = new ArrayList();
        do{
          list2.add(ie.next());
        }while (ie.hasNext());
        vCttCarouselListVo.setIntervalTimes(list2);


        model.addAttribute("intervalTime", EnumTool.getEnumList(IntervalTimeEnum.class));
        model.addAttribute("vCttCarouselListVo",vCttCarouselListVo);
        return CAROUSEL_SET;
    }
    @RequestMapping("/queryCarouselByType")
    public String queryCarouselByType(VCttCarouselListVo vCttCarouselListVo,Model model){
        vCttCarouselListVo.getSearch().setUseStatus("using");
        vCttCarouselListVo.setPaging(null);
        vCttCarouselListVo = getService().search(vCttCarouselListVo);
        List<VCttCarousel> vCttCarousels = vCttCarouselListVo.getResult();
        vCttCarouselListVo.setResult(vCttCarousels);
        getCurrentLangCarousel(vCttCarouselListVo);
        model.addAttribute("vCttCarouselListVo",vCttCarouselListVo);
        return getViewBasePath() + "/CarouselSettingList";
    }

    //endregion your codes 3

}