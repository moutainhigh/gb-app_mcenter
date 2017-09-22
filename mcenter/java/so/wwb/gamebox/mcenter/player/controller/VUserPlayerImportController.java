package so.wwb.gamebox.mcenter.player.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.player.IVUserPlayerImportService;
import so.wwb.gamebox.mcenter.player.form.VUserPlayerImportForm;
import so.wwb.gamebox.mcenter.player.form.VUserPlayerImportSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.company.sys.po.SysSite;
import so.wwb.gamebox.model.company.sys.vo.SysSiteVo;
import so.wwb.gamebox.model.master.player.po.VUserPlayerImport;
import so.wwb.gamebox.model.master.player.vo.VUserPlayerImportListVo;
import so.wwb.gamebox.model.master.player.vo.VUserPlayerImportVo;


/**
 * 控制器
 *
 * @author River
 * @time 2016-1-7 17:00:55
 */
@Controller
//region your codes 1
@RequestMapping("/vUserPlayerImport")
public class VUserPlayerImportController extends BaseCrudController<IVUserPlayerImportService, VUserPlayerImportListVo, VUserPlayerImportVo, VUserPlayerImportSearchForm, VUserPlayerImportForm, VUserPlayerImport, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/setting/param/importplayer/";
        //endregion your codes 2
    }

    //region your codes 3

    @Override
    protected VUserPlayerImportListVo doList(VUserPlayerImportListVo listVo, VUserPlayerImportSearchForm form, BindingResult result, Model model) {
        listVo = super.doList(listVo, form, result, model);
        findEnableImportPlayerParam(model);
        model.addAttribute("webtype", "3");
        return listVo;
    }


    /**
     * 查询是否可转站参数
     * @param model
     * @return
     */
    private void findEnableImportPlayerParam(Model model){
        SysSiteVo sysSiteVo = new SysSiteVo();
        sysSiteVo.getSearch().setId(SessionManager.getSiteId());
        SysSite sysSite = ServiceTool.sysSiteService().getSiteImport(sysSiteVo);
        if(sysSite!=null){
            model.addAttribute("isEnableImport","1");
            model.addAttribute("endImportTime",sysSite.getImportPlayersTime());
        }
    }
    //endregion your codes 3

}