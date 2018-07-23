package so.wwb.gamebox.mcenter.player.controller;

import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import so.wwb.gamebox.common.export.core.conf.FileTypeEnum;
import so.wwb.gamebox.iservice.master.player.IUserPlayerImportService;
import so.wwb.gamebox.mcenter.player.form.UserPlayerImportForm;
import so.wwb.gamebox.mcenter.player.form.UserPlayerImportSearchForm;
import so.wwb.gamebox.mcenter.setting.support.UserPlayerImportSupport;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.master.player.po.UserPlayerImport;
import so.wwb.gamebox.model.master.player.vo.UserPlayerImportListVo;
import so.wwb.gamebox.model.master.player.vo.UserPlayerImportVo;
import so.wwb.gamebox.web.init.ConfigBase;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.MessageFormat;
import java.util.HashMap;
import java.util.Map;


/**
 * 玩家导入记录表 by River控制器
 *
 * @author River
 * @time 2015-12-28 16:29:59
 */
@Controller
//region your codes 1
@RequestMapping("/userPlayerImport")
public class UserPlayerImportController extends BaseCrudController<IUserPlayerImportService, UserPlayerImportListVo, UserPlayerImportVo, UserPlayerImportSearchForm, UserPlayerImportForm, UserPlayerImport, Integer> {

    private static final Log LOG = LogFactory.getLog(UserPlayerImportController.class);
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/setting/param/importplayer/";
        //endregion your codes 2
    }

    //region your codes 3

    @RequestMapping(value = "/playerImport")
    public String playerImport(UserPlayerImportVo importVo, Model model){
        importVo.setValidateRule(JsRuleCreator.create(UserPlayerImportForm.class));
        model.addAttribute("command",importVo);
        return getViewBasePath() + "PlayerImport";
    }

    @RequestMapping(value = "/saveImport",method = {RequestMethod.POST,RequestMethod.GET})
    public String saveImport(HttpServletRequest request,Model model){
        Map<String,Object> result = new HashMap<>();
        result.put("state",true);
        InputStream stream = null;
        try{
            String msg = "";
            MultipartHttpServletRequest mulRequest = (MultipartHttpServletRequest)request;
            MultipartFile file = mulRequest.getFile("fileName");
            if(file == null){

                throw new RuntimeException(LocaleTool.tranMessage(Module.COMPANY_SETTING,"sysParam.playerImport.emptyFile"));
            }
            stream = file.getInputStream();
            if(StringTool.isBlank(file.getOriginalFilename())){
                throw new RuntimeException(LocaleTool.tranMessage(Module.COMPANY_SETTING,"sysParam.playerImport.emptyFileName"));
            }
            UserPlayerImportSupport importSupport = new UserPlayerImportSupport();
            importSupport.setFileName(file.getOriginalFilename());
            if(file.getOriginalFilename().endsWith("xls")){
                msg = importSupport.doImport(stream);
            }else if(file.getOriginalFilename().endsWith(FileTypeEnum.XLSX.getCode())){
                msg = importSupport.importExcel(stream);
            }else{
                result.put("state",false);
                result.put("msg",LocaleTool.tranMessage(Module.COMPANY_SETTING,"sysParam.playerImport.errorFileSuffix"));
            }
            if(importSupport.getErrorMap()!=null&&!importSupport.getErrorMap().isEmpty()){
                result.put("state",false);
                result.put("errormsg",importSupport.getErrorMap().get("errmsg"));
            }else if(importSupport.getErrorList()!=null&&importSupport.getErrorList().size()>0){
                model.addAttribute("errorList",importSupport.getErrorList());
                result.put("state",false);
                result.put("msg",LocaleTool.tranMessage(Module.COMPANY_SETTING,"sysParam.playerImport.errorPlayerData"));
            }else{
                if(StringTool.isNotBlank(msg)){
                    result.put("state",false);
                    result.put("msg",msg);
                }
            }

        }catch (Exception ex){
            result.put("state",false);
            result.put("msg",LocaleTool.tranMessage(Module.COMPANY_SETTING,"sysParam.playerImport.importFileError")+","+ex.getMessage());
            LOG.error(ex,"导入文件出错");
        }finally {
            try{
                if(stream!=null){
                    stream.close();
                }
            }catch (Exception e){
                LOG.error("关闭文件流出错");
            }

        }
        model.addAttribute("command",result);
        Object obj = result.get("state");
        if(obj!=null&&"true".equals(obj.toString())){
            return getViewBasePath() + "ImportSuccess";
        }else{
            return getViewBasePath() + "ImportError";
        }

    }

    @RequestMapping("/downloadTemplate")
    public ModelAndView download(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("UTF-8");
        String fileName = request.getParameter("fileName");
        //TODO:不同版本需要不同名称
        if(StringTool.isBlank(fileName)){
            fileName = "导入玩家资料.xlsx";
            fileName = new String(fileName.getBytes("utf-8"), "ISO8859-1");
        }

        java.io.BufferedInputStream bis = null;
        java.io.BufferedOutputStream bos = null;
        try {
            //long fileLength = new File(downLoadPath).length();
            String resRoot = ConfigBase.get().getResRoot();
            LOG.debug("Rcenter路径：{0}", resRoot);
            resRoot = MessageFormat.format(resRoot,request.getServerName());
            LOG.debug("格式化后的路径：{0}", resRoot);
            String ctxPath = resRoot + "/template/user_player_template_zh_CN.xlsx";
            LOG.debug("文件路径:{0}", ctxPath);
            URL url = new URL(ctxPath);
            HttpURLConnection conn = (HttpURLConnection)url.openConnection();
            //设置超时间为3秒
            conn.setConnectTimeout(3*1000);
            //防止屏蔽程序抓取而返回403错误
            conn.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");
            //得到输入流
            InputStream inputStream = conn.getInputStream();

            response.setContentType("application/x-msdownload;");
            response.setHeader("Content-disposition", "attachment; filename=" + fileName);
            //response.setHeader("Content-Length", String.valueOf(fileLength));
            bis = new BufferedInputStream(inputStream);
            bos = new BufferedOutputStream(response.getOutputStream());
            byte[] buff = new byte[2048];
            int bytesRead;
            while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
                bos.write(buff, 0, bytesRead);
            }
            LOG.debug("文件下载完成");
        } catch (Exception e) {
            LOG.error(e,"文件下载出错");
        } finally {
            if (bis != null)
                bis.close();
            if (bos != null)
                bos.close();
        }
        return null;
    }
    //endregion your codes 3
}
