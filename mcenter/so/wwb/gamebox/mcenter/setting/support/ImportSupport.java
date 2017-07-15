package so.wwb.gamebox.mcenter.setting.support;

import jxl.Cell;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import so.wwb.gamebox.model.master.player.po.UserPlayerTransfer;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * ImportSupport
 *
 * @author River
 * @date 16-1-31 下午4:40
 */

public class ImportSupport {
    public final static String[] COLUMNNAMES_ZH_CN = new String[]{"所属总代","所属代理","层级","玩家账号","账户余额CNY","真实姓名","手机号码","邮箱地址","银行","收款银行卡号","开户行","行号"};
    private static final Log LOG = LogFactory.getLog(ImportSupport.class);

    public static String validExcelDataFormat(Object val,int column,String fieldName){
        String value = "";
        if(val!=null){
            value = val.toString();
        }
        boolean topAgentFormat = true;
        boolean agentFormat = true;
        boolean playerRankFormat = true;
        boolean playerAccountFormat = true;
        boolean balanceFormat = true;
        boolean realNameFormat = true;
        boolean phoneFormat = true;
        boolean emailFormat = true;
        boolean bankCodeFormat=true;
        boolean bankcardFormat = true;
        boolean bankdepositFormat = true;
        String errorColumn = "";
        if(UserPlayerTransfer.PROP_TOPAGENT.equals(fieldName)){
            if(StringTool.isBlank(value)){
                topAgentFormat =  true;
            }else{
                topAgentFormat = checkAccountData(value);
            }
            if(!topAgentFormat){
                errorColumn = COLUMNNAMES_ZH_CN[column];
            }
        }
        if(UserPlayerTransfer.PROP_AGENT.equals(fieldName)){
            if(StringTool.isBlank(value)){
                agentFormat =  true;
            }else{
                agentFormat = checkAccountData(value);
            }
            if(!agentFormat){
                errorColumn = COLUMNNAMES_ZH_CN[column];
            }
        }
        if(UserPlayerTransfer.PROP_PLAYER_RANK.equals(fieldName)){
            if(StringTool.isBlank(value)){
                playerRankFormat =  true;
            }else{
                if(value.length()<1||value.length()>20){
                    playerRankFormat = false;
                }
            }
            if(!playerRankFormat){
                errorColumn = COLUMNNAMES_ZH_CN[column];
            }
        }
        if(UserPlayerTransfer.PROP_PLAYER_ACCOUNT.equals(fieldName)){
            if(StringTool.isBlank(value)){
                playerAccountFormat =  true;
            }else{
                playerAccountFormat = checkAccountData(value);
            }
            if(!playerAccountFormat){
                errorColumn = COLUMNNAMES_ZH_CN[column];
            }
        }
        if(UserPlayerTransfer.PROP_ACCOUNT_BALANCE.equals(fieldName)){
            if(StringTool.isBlank(value)){
                balanceFormat =  true;
            }else{
                balanceFormat = checkBalanceData(value);
            }
            if(!balanceFormat){
                errorColumn = COLUMNNAMES_ZH_CN[column];
            }
        }
        if(UserPlayerTransfer.PROP_REAL_NAME.equals(fieldName)){
            if(StringTool.isBlank(value)){
                realNameFormat =  true;
            }else{
                realNameFormat = checkRealNameData(value);
            }
            if(!realNameFormat){
                errorColumn = COLUMNNAMES_ZH_CN[column];
            }
        }
        if(UserPlayerTransfer.PROP_MOBILE_PHONE.equals(fieldName)){
            if(StringTool.isBlank(value)){
                phoneFormat =  true;
            }else{
                phoneFormat = checkNumberData(value, null,20);
            }
            if(!phoneFormat){
                errorColumn = COLUMNNAMES_ZH_CN[column];
            }
        }
        if(UserPlayerTransfer.PROP_EMAIL.equals(fieldName)){
            if(StringTool.isBlank(value)){
                emailFormat =  true;
            }else{
                emailFormat = checkEmailData(value);
            }
            if(!emailFormat){
                errorColumn = COLUMNNAMES_ZH_CN[column];
            }
        }
        if(UserPlayerTransfer.PROP_BANK_CODE.equals(fieldName)){
            bankCodeFormat = checkBankCode(value);
            if(!bankCodeFormat){
                errorColumn = COLUMNNAMES_ZH_CN[column];
            }
        }
        if(UserPlayerTransfer.PROP_BANKCARD_NUMBER.equals(fieldName)){
            if(StringTool.isBlank(value)){
                bankcardFormat =  true;
            }else{
                bankcardFormat = checkNumberData(value, 10, 25);
            }
            if(!bankcardFormat){
                errorColumn = COLUMNNAMES_ZH_CN[column];
            }
        }
        if(UserPlayerTransfer.PROP_BANK_DEPOSIT.equals(fieldName)){
            if(StringTool.isBlank(value)){
                bankdepositFormat =  true;
            }else{
                bankdepositFormat = checkBankDepositData(value);
            }
            if(!bankdepositFormat){
                errorColumn = COLUMNNAMES_ZH_CN[column];
            }
        }
        return errorColumn;
    }

    private static boolean checkBankCode(String value){
        if(StringTool.isBlank(value)){
            return true;
        }else{
            if(value.length()<2||value.length()>50){
                return false;
            }
        }
        return true;
    }

    private static boolean checkBalanceData(String value){
        boolean flag = true;
        try{
            Double balance = Double.valueOf(value);
            if(balance>99999999d){
                flag = false;
            }
        }catch (Exception ex){
            flag = false;
        }
        return flag;
    }

    private static boolean checkBankDepositData(String value){
        boolean flag = true;
        if(value.length()<2||value.length()>200){
            flag = false;
        }
        /*String regex="^[a-zA-Z\u4E00-\u9FA5]+$";
        Pattern pattern = Pattern.compile(regex);
        Matcher match=pattern.matcher(value);
        boolean b=match.matches();
        if(!b){
            flag = false;
        }*/
        return flag;
    }

    private static boolean checkNumberData(String value,Integer minLength,Integer maxLength){
        boolean flag = true;
        if((minLength!=null&&value.length()<minLength)||(maxLength!=null&&value.length()>maxLength)){
            flag = false;
        }
        String regex="^[0-9]*$";
        Pattern pattern = Pattern.compile(regex);
        Matcher match=pattern.matcher(value);
        boolean b=match.matches();
        if(!b){
            flag = false;
        }
        return flag;
    }

    private static boolean checkEmailData(String value){
        boolean flag = true;
        if(value.length()>50){
            flag = false;
        }
        if (value.matches("\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*")==false){
            flag = false;
        }
        return flag;
    }

    private static boolean checkRealNameData(String value){
        boolean flag = true;
        if(value.length()<2||value.length()>30){
            flag = false;
        }
        /*String regex=RegExpConstants.REALNAME;
        Pattern pattern = Pattern.compile(regex);
        Matcher match=pattern.matcher(value);
        boolean b=match.matches();
        if(!b){
            flag = false;
        }*/
        return flag;
    }

    private static boolean checkAccountData(String value){
        boolean flag = true;
        if(value.length()<2||value.length()>32){
            flag = false;
        }
        String regex = "^[a-zA-Z0-9_\\-]{2,32}$";//RegExpConstants.ACCOUNT;
        Pattern pattern = Pattern.compile(regex);
        Matcher match=pattern.matcher(value);
        boolean b=match.matches();
        if(!b){
            flag = false;
        }
        return flag;
    }


    public static Method getFieldSetMethod(String fieldName,Class<Object> rowObjectClass){
        Method setter = null;
        if(rowObjectClass==null){
            return null;
        }
        try{
            Field field = rowObjectClass.getDeclaredField(fieldName);
            String setterName = "set" + Character.toTitleCase(fieldName.charAt(0)) + fieldName.substring(1);
            setter = rowObjectClass.getMethod(setterName, new Class[] { field.getType() });
        }catch (Exception ex){
            LOG.warn("转换方法出错");
        }

        return setter;
    }

    public static String getAccountValue(XSSFRow row, Cell[] rowCells){
        if(row!=null){
            XSSFCell cell = row.getCell(3);
            if(cell!=null){
                return cell.toString();
            }
        }else if(rowCells!=null&&rowCells.length>3){
            Cell cell = rowCells[3];
            if(cell!=null){
                return cell.getContents();
            }
        }

        return "";
    }
}
