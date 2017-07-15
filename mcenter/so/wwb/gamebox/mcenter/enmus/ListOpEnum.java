package so.wwb.gamebox.mcenter.enmus;

import org.soul.model.listop.vo.SysListOperatorVo;
import org.soul.model.security.privilege.vo.SysRoleListVo;
import org.soul.web.listop.IListOpEnum;
import so.wwb.gamebox.model.master.content.vo.VPayAccountListVo;
import so.wwb.gamebox.model.master.fund.vo.VAgentWithdrawOrderListVo;
import so.wwb.gamebox.model.master.fund.vo.VPlayerDepositListVo;
import so.wwb.gamebox.model.master.fund.vo.VPlayerRechargeListVo;
import so.wwb.gamebox.model.master.fund.vo.VPlayerWithdrawListVo;
import so.wwb.gamebox.model.master.player.vo.VUserPlayerListVo;
/**
 * Created by longer on 6/15/15.
 * 动态列
 */
public enum ListOpEnum implements IListOpEnum {

    SYSROLELISTVO(SysRoleListVo.class.getName()),
    SYSLISTOPERATORVO(SysListOperatorVo.class.getName()),
    /**
     * 玩家列表VO
     */
    VUserPlayerListVo(VUserPlayerListVo.class.getName()),
    VUserAgentManageListVo(so.wwb.gamebox.model.master.player.vo.VUserAgentManageListVo.class.getName()),
    VUserTopAgentManageListVo(so.wwb.gamebox.model.master.player.vo.VUserTopAgentManageListVo.class.getName()),

    VPlayerRechargeListVo(VPlayerRechargeListVo.class.getName()),//玩家充值 TODO 待删除
    CompanyDepositListVo(VPlayerDepositListVo.class.getName()), // 玩家存款
    OnlineRechargeListVo(so.wwb.gamebox.model.master.fund.vo.OnlineRechargeListVo.class.getName()),//线上支付 TODO 待删除
    OnlineDepositListVo(so.wwb.gamebox.model.master.fund.vo.OnlineRechargeListVo.class.getName()),  //线上支付
    VPayAccountListVo(VPayAccountListVo.class.getName()),

    /**
     * 玩家提现
     */
    VPlayerWithdrawListVo(VPlayerWithdrawListVo.class.getName()),

    /**
     * 代理取款审核
     */
    VAgentWithdrawOrderListVo(VAgentWithdrawOrderListVo.class.getName()) ;

//    VAgentTradingOrderListVo(VAgentTradingOrderListVo.class.getName()) ;

    ListOpEnum(String className) {
        this.className = className;
    }
    public static ListOpEnum enumOf(String className) {
        for (ListOpEnum e : ListOpEnum.class.getEnumConstants()) {
            if (e.getClassName().equals(className)) {
                return e;
            }
        }
        return null;
    }
    private String className;

    @Override
    public String getClassName() {
        return className;
    }
}
