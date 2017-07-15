package so.wwb.gamebox.mcenter.player.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.constraints.AtLeast;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.GroupSequence;
import javax.validation.constraints.Pattern;


/**
 * 玩家地址表单验证对象
 *
 * @author cheery
 * @time 2015-8-17 11:57:00
 */
//region your codes 1
@Comment("修改玩家地址")
@GroupSequence({PlayerAddressForm.Contact.class, PlayerAddressForm.class})
public class PlayerAddressForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String result_consignee;
    private String result_nation;
    private String result_province;
    private String result_city;
    private String result_address;
    private String result_zipCode;
    private String result_phone;
    private String result_mobile;

    @NotBlank
    public String getResult_consignee() {
        return result_consignee;
    }

    public void setResult_consignee(String result_consignee) {
        this.result_consignee = result_consignee;
    }

    @NotBlank(message = "player.pleaseSelectNation")
    public String getResult_nation() {
        return result_nation;
    }

    public void setResult_nation(String result_nation) {
        this.result_nation = result_nation;
    }

    @NotBlank(message = "player.pleaseSelectProvince")
    public String getResult_province() {
        return result_province;
    }

    public void setResult_province(String result_province) {
        this.result_province = result_province;
    }

    @NotBlank(message = "player.pleaseSelectCity")
    public String getResult_city() {
        return result_city;
    }

    public void setResult_city(String result_city) {
        this.result_city = result_city;
    }

    @NotBlank
    public String getResult_address() {
        return result_address;
    }

    public void setResult_address(String result_address) {
        this.result_address = result_address;
    }

    @NotBlank
    public String getResult_zipCode() {
        return result_zipCode;
    }

    public void setResult_zipCode(String result_zipCode) {
        this.result_zipCode = result_zipCode;
    }

    @AtLeast(message = "player.address.phoneOrMobileAtLast", groups = Contact.class)
    @Pattern(message = "player.address.mobile.isCorrect", regexp = FormValidRegExps.TEL)
    public String getResult_phone() {
        return result_phone;
    }

    public void setResult_phone(String result_phone) {
        this.result_phone = result_phone;
    }

    @AtLeast(message = "player.address.phoneOrMobileAtLast", groups = Contact.class)
    @Pattern(message = "player.address.phone.isCorrect", regexp = FormValidRegExps.MOBILE)
    public String getResult_mobile() {
        return result_mobile;
    }

    public void setResult_mobile(String result_mobile) {
        this.result_mobile = result_mobile;
    }

    interface Contact {

    }
    //endregion your codes 2

}