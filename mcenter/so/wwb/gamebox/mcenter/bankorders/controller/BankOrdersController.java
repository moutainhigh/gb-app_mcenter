package so.wwb.gamebox.mcenter.bankorders.controller;

import org.soul.commons.data.json.JsonTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.master.bankorders.IBankOrdersService;
import so.wwb.gamebox.mcenter.bankorders.form.BankOrdersForm;
import so.wwb.gamebox.mcenter.bankorders.form.BankOrdersSearchForm;
import so.wwb.gamebox.model.master.bankorders.po.BankOrders;
import so.wwb.gamebox.model.master.bankorders.vo.BankOrdersListVo;
import so.wwb.gamebox.model.master.bankorders.vo.BankOrdersVo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.Map;

import static org.soul.commons.net.ServletTool.getIpAddr;


/**
 * 控制器
 *
 * @author Administrator
 * @time 2016-8-24 11:02:34
 */
@Controller
//region your codes 1
@RequestMapping("/bankOrders")
public class BankOrdersController extends BaseCrudController<IBankOrdersService, BankOrdersListVo, BankOrdersVo, BankOrdersSearchForm, BankOrdersForm, BankOrders, String> {
    private static final Log LOG = LogFactory.getLog(BankOrdersController.class);
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/bankorders/";
        //endregion your codes 2
    }

    @Override
    @RequestMapping({"/index"})
    public String index(HttpServletRequest request, HttpServletResponse response) {
        return super.index(request, response);
    }

    //region your codes 3
    @RequestMapping("/saveData")
    @ResponseBody
    public String saveData(BankOrdersVo objectVo, @Valid BankOrdersForm form, BindingResult result, HttpServletRequest request) {
        LOG.debug("接收到调用请求，参数为{0},请求方IP：{1}", objectVo, getIpAddr(request));
        Map persist = super.persist(objectVo, form, result);
        String json = JsonTool.toJson(persist);
        LOG.debug("返回结果：{0}", json);
        return json;
    }
    //endregion your codes 3

}