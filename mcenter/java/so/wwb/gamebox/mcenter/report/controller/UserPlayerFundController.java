package so.wwb.gamebox.mcenter.report.controller;

import net.sf.jxls.transformer.XLSTransformer;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Workbook;
import org.soul.commons.bean.Pair;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.DateQuickPicker;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.net.ServletTool;
import org.soul.commons.query.sort.Direction;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.mcenter.report.form.UserPlayerFundSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.CacheBase;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.boss.enums.TemplateCodeEnum;
import so.wwb.gamebox.model.master.report.vo.UserPlayerFund;
import so.wwb.gamebox.model.master.report.vo.VPlayerFundsRecordListVo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.*;


/**
 * 控制器
 *
 * @author younger
 * @time 2018-1-7 14:42:07
 */
@Controller
//region your codes 1
@RequestMapping("/userPlayerFund")
public class UserPlayerFundController {
//endregion your codes 1

    @RequestMapping(value = "search")
    public String search(VPlayerFundsRecordListVo listVo, Model model, HttpServletRequest request){

        String templateCode = TemplateCodeEnum.USER_PLAYER_FUND.getCode();
        model.addAttribute("searchTempCode", templateCode);
        model.addAttribute("searchTemplates", CacheBase.getSysSearchTempByCondition(SessionManager.getUserId(), templateCode));
        List<Pair> userTypeSearchKeys = initUserTypeSearchKeys();
        model.addAttribute("userTypeSearchKeys", userTypeSearchKeys);
        String queryParamsJson = JsonTool.toJson(listVo.getSearch());
        model.addAttribute("queryParamsJson", queryParamsJson);
        model.addAttribute("validateRule", JsRuleCreator.create(UserPlayerFundSearchForm.class));

        Date today = DateQuickPicker.getInstance().getTomorrow();
        if(listVo.getFundSearch().getSearchStartDate()==null){
            Date startDate = DateTool.addDays(today, -7);
            listVo.getFundSearch().setSearchStartDate(startDate);
        }
        if(listVo.getFundSearch().getSearchEndDate()==null){
            listVo.getFundSearch().setSearchEndDate(today);
        }
        listVo.getQuery().addOrder(UserPlayerFund.PROP_CREATE_TIME, Direction.DESC);
        listVo = ServiceSiteTool.vPlayerFundsRecordService().queryUserPlayerFund(listVo);
        model.addAttribute("command",listVo);
        if(!ServletTool.isAjaxSoulRequest(request)){
            return "/report/playerFund/Index";
        }else{
            return "/report/playerFund/IndexPartial";
        }

    }

    private List<Pair> initUserTypeSearchKeys() {
        List<Pair> searchKeys;
        searchKeys = new ArrayList<>();
        searchKeys.add(new Pair("fundSearch.playerName", LocaleTool.tranView(Module.COLUMN.getCode(), "playerAccount")));
        searchKeys.add(new Pair("fundSearch.agentName", LocaleTool.tranView(Module.COLUMN.getCode(), "agentAccount")));
        searchKeys.add(new Pair("fundSearch.topagentName", LocaleTool.tranView(Module.COLUMN.getCode(), "agentTopAccount")));
        return searchKeys;
    }


    @RequestMapping("/exportData")
    @ResponseBody
    public Map exportData(VPlayerFundsRecordListVo listVo, HttpServletRequest request, HttpServletResponse response){

        Map resMap = new HashMap(2,1f);
        resMap.put("state",false);
        Date today = DateQuickPicker.getInstance().getTomorrow();
        if(listVo.getFundSearch().getSearchStartDate()==null){
            Date startDate = DateTool.addDays(today, -7);
            listVo.getFundSearch().setSearchStartDate(startDate);
        }
        if(listVo.getFundSearch().getSearchEndDate()==null){
            listVo.getFundSearch().setSearchEndDate(today);
        }
        listVo.getQuery().addOrder(UserPlayerFund.PROP_CREATE_TIME, Direction.DESC);
        listVo = ServiceSiteTool.vPlayerFundsRecordService().queryExportData(listVo);

        //模拟数据
        Map<String,Object> beans = new HashMap(1,1f);
        beans.put("dataList",listVo.getFundList());

        String templateFileName= request.getServletContext().getRealPath("/") + "/report/playerFund/playerFund.xlsx";
        XLSTransformer transformer = new XLSTransformer();
        InputStream in=null;
        OutputStream out=null;

        //设置响应s
        String destFileName = "playerFund.xlsx";
        response.setHeader("Content-Disposition", "attachment;filename=" + destFileName);
        response.setContentType("application/vnd.ms-excel");
        try {
            File exportFile = File.createTempFile("export_user_player_fund", ".xlsx");
            FileOutputStream fileOutputStream = new FileOutputStream(exportFile);

            in=new BufferedInputStream(new FileInputStream(templateFileName));
            Workbook workbook=transformer.transformXLS(in, beans);
            //out=response.getOutputStream();
            //将内容写入输出流并把缓存的内容全部发出去
            //workbook.write(out);
            workbook.write(fileOutputStream);
            //out.flush();
            resMap.put("state",true);
            resMap.put("filePath",exportFile.getAbsolutePath());
        } catch (InvalidFormatException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (in!=null){try {in.close();} catch (IOException e) {}}
            if (out!=null){try {out.close();} catch (IOException e) {}}
        }
        System.out.println(resMap);
        return resMap;
    }

}