package so.wwb.gamebox.mcenter.setting.support;

import jxl.*;
import org.apache.commons.collections.map.HashedMap;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.data.xls.AbstractExcelImporter;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.enums.UserTypeEnum;
import so.wwb.gamebox.model.master.player.po.*;
import so.wwb.gamebox.model.master.player.vo.*;

import java.io.InputStream;
import java.lang.reflect.Method;
import java.util.*;

/**
 * Excel2003ImportSupport
 *
 * @author River
 * @date 15-12-29 上午9:31
 */

public class UserPlayerImportSupport extends AbstractExcelImporter {

    private static final Log LOG = LogFactory.getLog(UserPlayerImportSupport.class);

    private List<TreeMap<Integer,Map<String,Object>>> errorList = new ArrayList<>();
    private String fileName;
    private Map<String,Object> errorMap = new HashedMap();
    private List accountList;

    private Map<Object,VUserAgent> agentMap;
    private Map<Object,VUserAgent> topagentMap;
    private Map<Object,UserPlayerTransfer> playerMap;
    private Map<Object,PlayerRank> playerRankMap;
    private Map<Object,UserBankcard> userBankcardMap;
    private VUserAgent defaultTopagent;
    private VUserAgent defaultAgent;

    public Map<String, Object> getErrorMap() {
        return errorMap;
    }

    public void setErrorMap(Map<String, Object> errorMap) {
        this.errorMap = errorMap;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public List<TreeMap<Integer, Map<String,Object>>> getErrorList() {
        return errorList;
    }

    public void setErrorList(List<TreeMap<Integer, Map<String,Object>>> errorList) {
        this.errorList = errorList;
    }

    @Override
    protected Class getRowObjectClass() {
        return UserPlayerTransfer.class;
    }

    @Override
    protected void initFieldList() {
        fieldList.add(UserPlayerTransfer.PROP_TOPAGENT);
        fieldList.add(UserPlayerTransfer.PROP_AGENT);
        fieldList.add(UserPlayerTransfer.PROP_PLAYER_RANK);
        fieldList.add(UserPlayerTransfer.PROP_PLAYER_ACCOUNT);
        fieldList.add(UserPlayerTransfer.PROP_ACCOUNT_BALANCE);
        fieldList.add(UserPlayerTransfer.PROP_REAL_NAME);
        fieldList.add(UserPlayerTransfer.PROP_MOBILE_PHONE);
        fieldList.add(UserPlayerTransfer.PROP_EMAIL);
        fieldList.add(UserPlayerTransfer.PROP_BANK_CODE);
        fieldList.add(UserPlayerTransfer.PROP_BANKCARD_NUMBER);
        fieldList.add(UserPlayerTransfer.PROP_BANK_DEPOSIT);
        fieldList.add(UserPlayerTransfer.PROP_IS_ACTIVE);
    }

    @Override
    protected String getSheetName() {
        return "导入资料";
    }

    /**
     * 验证
     */
    @Override
    protected void check() {
        if(rowObjectList==null||rowObjectList.size()==0){
            return;
        }
        try{
            int row = 0;
            getAllTopagent();
            getAllAgent();
            getAllTransferPlayer();
            getAllPlayerRank();
            getAllBankcardNumber();
            defaultTopagent = getDefaultTopagent();
            defaultAgent = getDefaultAgent();
            for (Iterator it = rowObjectList.iterator(); it.hasNext();) {
                UserPlayerTransfer rowObj = (UserPlayerTransfer) it.next();
                row = rowObj.getExcelRow();
                checkRecord(rowObj,row);
            }
        }catch (Exception ex){
            LOG.error(ex);
            errorMap.put("errmsg", LocaleTool.tranMessage("setting", "sysParam.playerImport.importFileDataError"));
        }
    }

    private void getAllTransferPlayer(){
        UserPlayerTransferListVo transferVo = new UserPlayerTransferListVo();
        transferVo.getSearch().setIsActive("0");
        transferVo.setPaging(null);
        transferVo = ServiceTool.userPlayerTransferService().search(transferVo);
        if(transferVo!=null&&transferVo.getResult()!=null){
            playerMap = CollectionTool.toEntityMap(transferVo.getResult(),UserPlayerTransfer.PROP_PLAYER_ACCOUNT);
        }else{
            playerMap = new HashMap<>();
        }
    }

    private void getAllTopagent(){
        VUserAgentListVo agentListVo = new VUserAgentListVo();
        agentListVo.getSearch().setUserType(UserTypeEnum.TOP_AGENT.getCode());
        agentListVo.setPaging(null);
        agentListVo = ServiceTool.vUserAgentService().search(agentListVo);
        if(agentListVo!=null&&agentListVo.getResult()!=null){
            topagentMap = CollectionTool.toEntityMap(agentListVo.getResult(), VUserAgent.PROP_USERNAME);
        }else{
            topagentMap = new HashMap<>();
        }

    }

    private void getAllAgent(){
        VUserAgentListVo agentListVo = new VUserAgentListVo();
        agentListVo.getSearch().setUserType(UserTypeEnum.AGENT.getCode());
        agentListVo.setPaging(null);
        agentListVo = ServiceTool.vUserAgentService().search(agentListVo);
        if(agentListVo!=null&&agentListVo.getResult()!=null){
            agentMap = CollectionTool.toEntityMap(agentListVo.getResult(),VUserAgent.PROP_USERNAME);
        }else{
            agentMap = new HashMap<>();
        }

    }

    private void getAllPlayerRank(){
        List<PlayerRank> playerRanks = ServiceTool.playerRankService().queryUsableList(new PlayerRankVo());
        playerRankMap = CollectionTool.toEntityMap(playerRanks,PlayerRank.PROP_RANK_NAME);
    }

    private VUserAgent getDefaultTopagent(){
        VUserAgentVo topAgent  = new VUserAgentVo();
        topAgent.getSearch().setBuiltIn(true);
        topAgent.getSearch().setUserType(UserTypeEnum.TOP_AGENT.getCode());
        topAgent = ServiceTool.vUserAgentService().search(topAgent);
        if(topAgent==null||topAgent.getResult() == null){
            return null;
        }
        return topAgent.getResult();
    }

    private VUserAgent getDefaultAgent(){
        VUserAgentVo agentVo  = new VUserAgentVo();
        agentVo.getSearch().setBuiltIn(true);
        agentVo.getSearch().setUserType(UserTypeEnum.AGENT.getCode());
        agentVo = ServiceTool.vUserAgentService().search(agentVo);
        if(agentVo==null||agentVo.getResult() == null){
            return null;
        }
        return agentVo.getResult();
    }

    private void getAllBankcardNumber(){
        UserBankcardListVo listVo = new UserBankcardListVo();
        listVo.getSearch().setIsDefault(true);
        listVo = ServiceTool.userBankcardService().search(listVo);
        if(listVo.getResult()!=null){
            userBankcardMap = CollectionTool.toEntityMap(listVo.getResult(),UserBankcard.PROP_BANKCARD_NUMBER);
        }else{
            userBankcardMap = new HashMap<>();
        }
    }

    @Override
    protected void save() {
        if(rowObjectList!=null&&rowObjectList.size()>0){
            UserPlayerImportVo userPlayerImportVo = buildImportRecord();
            List<UserPlayerTransfer> list = buildUserPlayer();
            userPlayerImportVo.setPlayerList(list);
            ServiceTool.userPlayerImportService().savePlayerImport(userPlayerImportVo);
        }

    }
    /**
     * 组装导入记录
     */
    private UserPlayerImportVo buildImportRecord(){
        UserPlayerImportVo importVo = new UserPlayerImportVo();
        UserPlayerImport userPlayerImport = new UserPlayerImport();
        userPlayerImport.setFileName(getFileName());
        userPlayerImport.setImportPlayerCount(rowObjectList.size());
        userPlayerImport.setImportUserId(SessionManager.getUserId());
        userPlayerImport.setImportTime(new Date());
        importVo.setResult(userPlayerImport);
        return importVo;
    }

    /**
     * 验证记录值 修改上次的提交备注
     * @param transfer
     * @param row
     * @return
     */
    private String checkRecord(UserPlayerTransfer transfer,int row){
        if(transfer==null){
            return "";
        }
        String msg = "";

        /*if(StringTool.isBlank(transfer.getPlayerRank())){
            setErrorMessage(row,"层级不能为空",transfer.getPlayerAccount());
        }*/

        if(StringTool.isBlank(transfer.getPlayerAccount())){
            msg = LocaleTool.tranMessage("setting", "sysParam.playerImport.emptyPlayerAccount");//"未填写玩家账号";
            setErrorMessage(row,msg,transfer.getPlayerAccount());
        }

        if(transfer.getAccountBalance()==null){
            msg = LocaleTool.tranMessage("setting", "sysParam.playerImport.emptyAccountBalance");//"未填写账号余额";
            setErrorMessage(row,msg,transfer.getPlayerAccount());
        }
        if(transfer.getAccountBalance()!=null&&transfer.getAccountBalance()!=0&& StringTool.isBlank(transfer.getRealName())){
            msg = LocaleTool.tranMessage("setting", "sysParam.playerImport.balanceAndEmptyRealName");
            setErrorMessage(row,msg,transfer.getPlayerAccount());
        }
        if((StringTool.isBlank(transfer.getAgent())&&StringTool.isNotBlank(transfer.getTopagent()))||
                StringTool.isBlank(transfer.getTopagent())&&StringTool.isNotBlank(transfer.getAgent())){
            msg = LocaleTool.tranMessage("setting", "sysParam.playerImport.agentNotCompleteness");
            setErrorMessage(row,msg,transfer.getPlayerAccount());
        }

        if(StringTool.isNotBlank(transfer.getTopagent())){
            if(!topagentMap.containsKey(transfer.getTopagent())){
                msg = LocaleTool.tranMessage("setting", "sysParam.playerImport.topAgentNotExist");
                setErrorMessage(row,msg,transfer.getPlayerAccount());
            }

        }
        if (StringTool.isNotBlank(transfer.getAgent())){
            if(!agentMap.containsKey(transfer.getAgent())){
                msg = LocaleTool.tranMessage("setting", "sysParam.playerImport.agentNotExist");//"该代理不存在";
                setErrorMessage(row,msg,transfer.getPlayerAccount());
            }

        }
        if(StringTool.isNotBlank(transfer.getAgent())&&StringTool.isNotBlank(transfer.getTopagent())){
            VUserAgent topagent = topagentMap.get(transfer.getTopagent());
            VUserAgent agent = agentMap.get(transfer.getAgent());


            if(topagent!=null&&agent!=null){
                if(!agent.getParentId().equals(topagent.getId())){
                    msg = LocaleTool.tranMessage("setting", "sysParam.playerImport.topAgentAndAgentNoMatch");//"所属总代和代理不匹配";
                    setErrorMessage(row,msg,transfer.getPlayerAccount());
                }
            }
        }
        if(StringTool.isBlank(transfer.getTopagent())&&StringTool.isBlank(transfer.getAgent())){
            if(defaultTopagent==null){
                msg = LocaleTool.tranMessage("setting", "sysParam.playerImport.systemNotDefaultTopAgent");//"系统中没有默认总代";
                setErrorMessage(row,msg,transfer.getPlayerAccount());
            }
            if(defaultAgent == null){
                msg = LocaleTool.tranMessage("setting", "sysParam.playerImport.systemNotDefaultAgent");//"系统中没有默认代理";
                setErrorMessage(row,msg,transfer.getPlayerAccount());
            }

            if(defaultTopagent!=null&&defaultAgent!=null){
                if(defaultAgent.getParentId()!=defaultTopagent.getId()){
                    msg = LocaleTool.tranMessage("setting", "sysParam.playerImport.defaultTopAgentAndAgentNoMatch");//"默认总代和默认代理不匹配";
                    setErrorMessage(row,msg,transfer.getPlayerAccount());
                }
            }
        }


        if(StringTool.isNotBlank(transfer.getPlayerRank())&&!playerRankMap.containsKey(transfer.getPlayerRank())){
            setErrorMessage(row,"没有名称为【"+transfer.getPlayerRank()+"】的层级",transfer.getPlayerAccount());
        }


        if(StringTool.isNotBlank(transfer.getPlayerAccount())&&playerMap.containsKey(transfer.getPlayerAccount())){
            msg = LocaleTool.tranMessage("setting", "sysParam.playerImport.playerAccountIsExist");//"该账号已存在";
            setErrorMessage(row,msg,transfer.getPlayerAccount());
        }

        if(StringTool.isNotBlank(transfer.getBankcardNumber())&&userBankcardMap.containsKey(transfer.getBankcardNumber())){
            setErrorMessage(row,"银行卡号【"+transfer.getBankcardNumber()+"】已经存在",transfer.getPlayerAccount());
        }

        return msg;
    }

    /**
     * 组装玩家信息
     * @return
     */
    private List<UserPlayerTransfer> buildUserPlayer() {
        List<UserPlayerTransfer> result = new ArrayList<>();
        for (int index = 0; index < rowObjectList.size(); index++) {
            UserPlayerTransfer transfer = (UserPlayerTransfer)rowObjectList.get(index);
            if(StringTool.isBlank(transfer.getTopagent())&&StringTool.isBlank(transfer.getAgent())){
                transfer.setTopagent(defaultTopagent.getUsername());
                transfer.setAgent(defaultAgent.getUsername());
            }
            String rankName = transfer.getPlayerRank();
            PlayerRank playerRank = playerRankMap.get(rankName);
            if(playerRank!=null){
                transfer.setPlayerRankId(playerRank.getId());
            }
            transfer.setIsActive("0");
            transfer.setInsertTime(new Date());
            result.add(transfer);
        }
        return result;
    }

    /**
     * 验证Excel2003格式文件
     * @param sheet
     * @return
     */
    private boolean checkExcel2003(Sheet sheet){
        int rows = sheet.getRows();
        if(rows<1){
            return false;
        }
        Cell[] rowCells = sheet.getRow(0);
        if(rowCells==null){
            return false;
        }
        String errColumn = "";
        if(SessionManager.getLocale().toString().equals("zh_CN")){
            for (int column = 0; column < fieldList.size()-1; column++){
                Cell cell = rowCells[column];
                Object val = getCell2003Value(cell,column);
                if(val==null||val.toString().indexOf(ImportSupport.COLUMNNAMES_ZH_CN[column])==-1){
                    errColumn += ImportSupport.COLUMNNAMES_ZH_CN[column]+",";
                }
            }
        }else{
            //TODO:其它语言版本验证
        }
        if(errColumn.length()>0){
            //errColumn = errColumn.substring(0,errColumn.length()-1);
            errorMap.put("errmsg", LocaleTool.tranMessage("setting", "sysParam.playerImport.loseColumnError"));
            return false;
        }
        return true;
    }
    /**
     * 解析2003 Excel
     */
    @Override
    protected void wrapRowObjects() {
        try {
            Workbook workbook = Workbook.getWorkbook(inputStream);
            sheet = workbook.getSheet(0);
            if(!checkExcel2003(sheet)){
                return;
            }
            importExcel2003();

        }catch (Exception ex) {
            LOG.error(ex);
            errorMap.put("errmsg", LocaleTool.tranMessage("setting", "sysParam.playerImport.parseFileError"));
        }
    }

    /**
     * 导入2003版本的excel
     * @param inputStream
     * @return
     */
    @Override
    public String doImport(InputStream inputStream) {
        String msg = "";
        this.inputStream = inputStream;
        wrapRowObjects();
        check();
        if(errorList==null||errorList.size()==0){
            if(rowObjectList!=null&&rowObjectList.size()>0){
                save();
            }else{
                msg = LocaleTool.tranMessage("setting","sysParam.playerImport.importEmptyFile");
            }
        }else{
            msg = LocaleTool.tranMessage("setting", "sysParam.playerImport.errorPlayerData");
        }

        return msg;
    }

    /**
     * 导入2007版本以上的excel
     * @param inputStream
     * @return
     */
    public String importExcel(InputStream inputStream) {
        String msg = "";
        try {
            parseExcel2007(inputStream);
            check();
            if(errorList==null||errorList.size()==0){
                if(rowObjectList!=null&&rowObjectList.size()>0){
                    save();
                }else{
                    msg = LocaleTool.tranMessage("setting", "sysParam.playerImport.importEmptyFile");
                }
            }else{
                msg = LocaleTool.tranMessage("setting", "sysParam.playerImport.errorPlayerData");
            }
        }catch (Exception ex) {
            LOG.error(ex);
            errorMap.put("errmsg", LocaleTool.tranMessage("setting", "sysParam.playerImport.parseFileError"));
        }
        return msg;
    }

    /**
     * 验证Excel2007格式文件
     * @param sheet
     * @return
     */
    private boolean checkExcel2007(XSSFSheet sheet){
        int rows = sheet.getPhysicalNumberOfRows();
        if(rows<1){
            return false;
        }
        XSSFRow row = sheet.getRow(0);
        if(row==null){
            return false;
        }
        String errColumn = "";
        if(SessionManager.getLocale().toString().equals("zh_CN")){
            for (int column = 0; column < fieldList.size()-1; column++){
                XSSFCell cell = row.getCell(column);
                if(cell==null){
                    errColumn += ImportSupport.COLUMNNAMES_ZH_CN[column]+",";
                }else{
                    String val = cell.toString();
                    if(StringTool.isBlank(val)||val.indexOf(ImportSupport.COLUMNNAMES_ZH_CN[column])==-1){
                        errColumn += ImportSupport.COLUMNNAMES_ZH_CN[column]+",";
                    }
                }

            }
        }else{
            //TODO:其它语言版本验证
        }
        if(errColumn.length()>0){
            //errColumn = errColumn.substring(0,errColumn.length()-1);
            //String msg =  MessageFormat.format(LocaleTool.tranMessage("setting", "sysParam.playerImport.loseColumnError"), errColumn);
            //errorMap.put("errmsg",msg);
            errorMap.put("errmsg", LocaleTool.tranMessage("setting", "sysParam.playerImport.loseColumnError"));
            return false;
        }
        return true;
    }

    /**
     * 解析Excel2007文件
     * @param is
     * @throws Exception
     */
    private void parseExcel2007(InputStream is) throws Exception {
        try{
            XSSFWorkbook workBook = new XSSFWorkbook(is);
            XSSFSheet sheet = workBook.getSheetAt(0);
            if(!checkExcel2007(sheet)){
                return;
            }
            rowObjectList = new ArrayList<Object>(sheet.getPhysicalNumberOfRows() - 1);
            int maxRowCount = sheet.getLastRowNum();
            accountList = new ArrayList();
            for (int rowCount = 1; rowCount <= maxRowCount; rowCount++){

                XSSFRow row = sheet.getRow(rowCount);
                if(row==null){
                    continue;
                }
                if(isNullRow(row)){
                    continue;
                }
                int columns = fieldList.size()-1;
                String errorColumn = "";
                String account = ImportSupport.getAccountValue(row,null);
                for(int col =0;col<columns;col++){
                    XSSFCell cell = row.getCell(col);
                    Object val = getCellValue(cell,col);
                    String fieldName = fieldList.get(col);
                    if(UserPlayerTransfer.PROP_PLAYER_ACCOUNT.equals(fieldName)){
                        if(accountList.contains(val)){
                            String msg = LocaleTool.tranMessage("setting", "sysParam.playerImport.accountExist",val);
                            setErrorMessage(rowCount, msg, account);
                        }else{
                            accountList.add(val);
                        }

                    }
                    String column = ImportSupport.validExcelDataFormat(val, col, fieldName);
                    if(StringTool.isNotBlank(column)){
                        errorColumn = errorColumn + column + ",";
                    }

                }
                if(errorColumn.length()>0){
                    errorColumn = errorColumn.substring(0,errorColumn.length()-1);
                    String msg = LocaleTool.tranMessage("setting", "sysParam.playerImport.errorDataFormat",errorColumn);

                    setErrorMessage(rowCount, msg, account);
                }
                tranExcelDataToObject(row,rowCount);
            }

        }catch (Exception ex) {
            LOG.error(ex);
            errorMap.put("errmsg", LocaleTool.tranMessage("setting", "sysParam.playerImport.parseFileError"));
        }

    }

    private boolean isNullRow(XSSFRow row){
        int columns = fieldList.size()-1;
        boolean allCellIsNull = true;
        for(int col =0;col<columns;col++){
            XSSFCell cell = row.getCell(col);
            Object val = getCellValue(cell,col);
            if(val!=null&&StringTool.isNotBlank(val.toString())){
                allCellIsNull = false;
            }
        }
        return allCellIsNull;
    }



    /**
     * 将excel行转为对象
     * @param row
     */
    private void tranExcelDataToObject(XSSFRow row,int rowCount ){
        try{
            Class<Object> rowObjectClass = getRowObjectClass();
            Object rowObject = rowObjectClass.newInstance();
            int columns = fieldList.size()-1;
            for(int col =0;col<columns;col++) {
                XSSFCell cell = row.getCell(col);
                Object val = getCellValue(cell,col);
                String fieldName = fieldList.get(col);
                buildMethod(fieldName,val,rowObject,col);
            }
            buildMethod(UserPlayerTransfer.PROP_EXCELROW,rowCount,rowObject,11);
            rowObjectList.add(rowObject);
        }catch (Exception e){
            LOG.error(e);
        }

    }

    private void buildMethod(String fieldName,Object val,Object rowObject,int col){
        Method method = ImportSupport.getFieldSetMethod(fieldName,getRowObjectClass());
        if(method!=null&&val!=null&&StringTool.isNotBlank(val.toString())){
            try{
                method.invoke(rowObject, new Object[]{val});
            }catch (Exception e1){
                LOG.error(e1,"{0}的类型与数据库类型不匹配",ImportSupport.COLUMNNAMES_ZH_CN[col]);
            }
        }
    }

    /**
     * 获取Excel2007单元格值
     * @param cell
     * @param col
     * @return
     */
    private Object getCellValue(XSSFCell cell,int col){
        if(cell==null){
            return "";
        }
        String value = cell.toString();
        if(StringTool.isBlank(value)){
            return "";
        }
        Object val = value;
        int cellType = cell.getCellType();
        if(fieldList.get(col).equals(UserPlayerTransfer.PROP_ACCOUNT_BALANCE)){
            if(StringTool.isNotBlank(value)){
                if(value.indexOf(",")>-1){
                    value = value.replaceAll(",","");
                }
                if(cellType == XSSFCell.CELL_TYPE_NUMERIC){
                    val = Double.valueOf(value);
                }else if(cellType == XSSFCell.CELL_TYPE_STRING){
                    try{
                        val = Double.valueOf(value);
                    }catch (Exception ex){

                    }

                }
            }

            //
        }else if(cellType == XSSFCell.CELL_TYPE_NUMERIC){
            val = cell.getRawValue();
        }

        return val;
    }

    /**
     * 解析Excel2003文件
     */
    public void importExcel2003(){
        int rows = sheet.getRows();
        rowObjectList = new ArrayList<Object>(rows - 1);
        accountList = new ArrayList();
        for (int row = 1; row < rows; row++) {
            Cell[] rowCells = sheet.getRow(row);
            if(rowCells.length==0){
                continue;
            }
            int cols = fieldList.size()-1;
            if(rowCells.length<cols){
                cols = rowCells.length;
            }
            String account = ImportSupport.getAccountValue(null, rowCells);
            for (int column = 0; column < cols; column++) {
                Cell cell = rowCells[column];
                String errorColumn = "";
                Object val = getCell2003Value(cell, column);
                String fieldName = fieldList.get(column);
                if(UserPlayerTransfer.PROP_PLAYER_ACCOUNT.equals(fieldName)){
                    if(accountList.contains(val)){
                        String msg = LocaleTool.tranMessage("setting", "sysParam.playerImport.accountExist",val);
                        setErrorMessage(row, msg, account);
                    }else{
                        accountList.add(val);
                    }

                }
                String errCoumnName = ImportSupport.validExcelDataFormat(val, column,fieldName);
                if(StringTool.isNotBlank(errCoumnName)){
                    errorColumn = errorColumn + errCoumnName + ",";
                }
                if(errorColumn.length()>0){
                    errorColumn = errorColumn.substring(0,errorColumn.length()-1);
                    String msg = LocaleTool.tranMessage("setting", "sysParam.playerImport.errorDataFormat",errorColumn);

                    setErrorMessage(row,msg,account);
                }
            }
            tranExcel2003DataToObject(rowCells,row);
        }

    }

    /**
     * Excel行转对象
     * @param rowCells
     */
    private void tranExcel2003DataToObject(Cell[] rowCells,int rowCount){
        try{
            Class<Object> rowObjectClass = getRowObjectClass();
            Object rowObject = rowObjectClass.newInstance();
            int columns = fieldList.size()-1;
            if(rowCells.length<columns){
                columns = rowCells.length;
            }
            for (int col = 0; col < columns; col++) {
                Cell cell = rowCells[col];
                Object val = getCell2003Value(cell,col);
                String fieldName = fieldList.get(col);
                buildMethod(fieldName,val,rowObject,col);
            }
            buildMethod(UserPlayerTransfer.PROP_EXCELROW,rowCount,rowObject,10);
            rowObjectList.add(rowObject);
        }catch (Exception e){
            LOG.error(e,"值转换出错");
        }

    }

    /**
     * Excel2003单元格值
     * @param cell
     * @param col
     * @return
     */
    private Object getCell2003Value(Cell cell,int col){
        if(cell==null){
            return "";
        }
        String value = cell.getContents();
        Object val = value;
        CellType type = cell.getType();
        if(fieldList.get(col).equals(UserPlayerTransfer.PROP_ACCOUNT_BALANCE)
                &&StringTool.isNotBlank(value)&&type == CellType.NUMBER){
            NumberCell numberCell = (NumberCell) cell;
            val =numberCell.getValue();
        }
        return val;
    }

    /**
     * 设置错误信息
     * @param row
     * @param message
     * @param account
     */
    private void setErrorMessage(int row,String message,String account){
        TreeMap<Integer,Map<String,Object>> rowMap = null;
        boolean flag = false;
        for(TreeMap<Integer,Map<String,Object>> errMap : errorList){
            if(errMap.containsKey(row)){
                rowMap = errMap;
                flag = true;
                break;
            }
        }
        if(rowMap == null){
            rowMap = new TreeMap<>();
        }
        Map<String,Object> map = rowMap.get(row);
        if(map==null){
            map = new HashMap<>();
        }
        map.put("account",account);
        List<String> msgList = null;
        if(map.get("msgList")==null){
            msgList = new ArrayList<>();
        }else{
            msgList = (List<String>)map.get("msgList");
        }
        msgList.add(message);
        map.put("msgList",msgList);
        rowMap.put(row,map);
        if(errorList==null){
            errorList = new ArrayList<>();
        }
        if(!flag){
            errorList.add(rowMap);
        }

    }
}
