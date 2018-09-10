package so.wwb.gamebox.mcenter.fund.controller.validate;

import so.wwb.gamebox.model.master.player.po.PlayerTransaction;
import sun.misc.BASE64Encoder;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class ValidateVo {
    public static final String KEYSTORE = "";
    private String tid;
    private Double relValue;
    private Integer plid;
    private String keyStr;

    public ValidateVo(PlayerTransaction playerTransaction) {
        this.plid = playerTransaction.getPlayerId();
        this.tid = playerTransaction.getTransactionNo();
        this.relValue = playerTransaction.getTransactionMoney();
        //TODO
    }

    public ValidateVo() {
    }

    public static ValidateVo desc(String text) {
        ValidateVo vVo = new ValidateVo();
        vVo.setKeyStr(text);
        return vVo;
    }

    public static String getKEYSTORE() {
        return KEYSTORE;
    }

    public String genKey() {
        try {
            //交易号@玩家ID@交易金额
            String md5Str = this.tid + "@" + this.plid + "@" + this.relValue;
            System.out.println(md5Str);
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            md5.update((md5Str).getBytes("UTF-8"));
            byte b[] = md5.digest();
            int i;
            StringBuffer buf = new StringBuffer("");
            for (int offset = 0; offset < b.length; offset++) {
                i = b[offset];
                if (i < 0) {
                    i += 256;
                }
                if (i < 16) {
                    buf.append("0");
                }
                buf.append(Integer.toHexString(i));
            }
            return buf.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public String getTid() {
        return tid;
    }

    public void setTid(String tid) {
        this.tid = tid;
    }

    public Double getRelValue() {
        return relValue;
    }

    public void setRelValue(Double relValue) {
        this.relValue = relValue;
    }

    public String getKeyStr() {
        return keyStr;
    }

    public void setKeyStr(String keyStr) {
        this.keyStr = keyStr;
    }

    public Integer getPlid() {
        return plid;
    }

    public void setPlid(Integer plid) {
        this.plid = plid;
    }

}
