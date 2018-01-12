package so.wwb.gamebox.mcenter.report.controller;

import net.sf.jxls.transformer.XLSTransformer;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Workbook;
import org.soul.commons.bean.Pair;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.http.HttpClient;
import org.soul.commons.http.PostParameter;
import org.soul.commons.http.Response;
import org.soul.commons.init.context.ContextParam;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.DateQuickPicker;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
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
import so.wwb.gamebox.model.company.setting.po.SysExport;
import so.wwb.gamebox.model.company.setting.vo.SysExportVo;
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

    private final static Log LOG = LogFactory.getLog(UserPlayerFundController.class);

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
            workbook.write(fileOutputStream);
            resMap.put("state",true);
            resMap.put("filePath",exportFile.getAbsolutePath());
            uploadFileAndUpdateStatus(exportFile);
        } catch (InvalidFormatException e) {
            LOG.error(e,"导出出错1");
        } catch (IOException e) {
            LOG.error(e,"导出出错2");
        } catch (Exception ex){
            LOG.error(ex,"导出出错3");
        }finally {
            if (in!=null){try {in.close();} catch (IOException e) {}}
            if (out!=null){try {out.close();} catch (IOException e) {}}
        }
        System.out.println(resMap);
        return resMap;
    }

    //上传文件并更新导出状态
    private void uploadFileAndUpdateStatus(File file) throws Exception {
        try{
            ArrayList<PostParameter> arrayList = new ArrayList<>();
            arrayList.add(new PostParameter(SysExportVo.FSERVER_PARAM_CATEPATH, "exportFile"));
            arrayList.add(new PostParameter(SysExportVo.FSERVER_PARAM_OBJID, 1));
            arrayList.add(new PostParameter("siteId", SessionManager.getSiteId()));
            arrayList.add(new PostParameter(SysExportVo.FSERVER_PARAM_USERNAME, SessionManager.getUser().getUsername()));
            String fsserverPath = file.getAbsolutePath();
            Response response = new HttpClient().multPartURL(file.getName(),fsserverPath,
                    arrayList.toArray(new PostParameter[arrayList.size()]), file, false);
            LOG.info("调用文件上传接口，接口返回值为{0}}",response);
            HashMap hashMap = JsonTool.fromJson(response.getResponseAsString().replaceAll("'", "\""), HashMap.class);
            String state = String.valueOf(hashMap.get(SysExportVo.FSERVER_RETURN_STATE));
            String url = String.valueOf(hashMap.get(SysExportVo.FSERVER_RETURN_URL));

            LOG.info("调用文件上传接口，接口返回值状态为{0},完成更新导出记录的文件路径{1}。",state,url);
        }catch (Exception e){
            LOG.error(e,"上传文件出错");
        }

    }

}