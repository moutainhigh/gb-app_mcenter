<%@ page import="so.wwb.gamebox.model.master.fund.enums.TransactionWayEnum" %>
<%@ page import="so.wwb.gamebox.model.master.fund.enums.TransactionTypeEnum" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="detect-title m-l-n m-r-n">${views.fund['playerDetect.view.discountRecord']}</div>
<ul>
    <li>
        <b>

            <span tabindex="0" class=" help-popover m-r-xs" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                  data-max="" data-html="true" data-content="${views.fund_auto['为优惠活动']}">
                                    <i class="fa fa-question-circle"></i>
                                </span>
            ${views.fund['fund.playerDetect.index.totalFavorable']}
        </b>

        <soul:button target="${root}/report/vPlayerFundsRecordLinkPopup/fundsRecord.html?search.usernames=${username}&search.userTypes=username&search.transactionWays=first_deposit,second_deposit,third_deposit,everyday_first_deposit,deposit_send,regist_send,relief_fund,profit_loss,effective_transaction,money,single_reward,bonus_awards&search.manualSaves=manual_favorable,manual_payout,manual_other&search.orderType=playerFavable" size="open-dialog-95p"
                     callback="" text="" title="优惠详情" opType="dialog">
            <span class="pull-right co-blue">${favorableVal}</span>
        </soul:button>
    </li>
    <li>
        <b>
            <span tabindex="0" class=" help-popover m-r-xs" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                  data-max="" data-html="true" data-content="${views.fund_auto['为优惠活动次数']}">
                                    <i class="fa fa-question-circle"></i>
                                </span>
            ${views.fund['playerDetect.view.discountNum']}：
        </b>
        <soul:button target="${root}/report/vPlayerFundsRecordLinkPopup/fundsRecord.html?search.usernames=${username}&search.userTypes=username&search.transactionWays=first_deposit,second_deposit,third_deposit,everyday_first_deposit,deposit_send,regist_send,relief_fund,profit_loss,effective_transaction,money,single_reward,bonus_awards&search.manualSaves=manual_favorable,manual_payout,manual_other&search.orderType=playerFavable" size="open-dialog-95p"
                     callback="" text="" title="优惠详情" opType="dialog">
            <span class="pull-right co-blue">${favorableCount}${views.fund['fund.playerDetect.index.second']}</span>
        </soul:button>
    </li>
    <li>
        <b>
            <span tabindex="0" class=" help-popover m-r-xs" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                 data-max="" data-html="true" data-content="${views.content['annotation.backWater']}">
                                    <i class="fa fa-question-circle"></i>
                                </span>
        ${views.fund['playerDetect.view.totalAmount']}：</b>
        <span class="pull-right co-blue">
            <soul:button target="${root}/report/vPlayerFundsRecordLinkPopup/fundsRecord.html?search.usernames=${username}&search.userTypes=username&search.transactionWays=back_water&search.manualSaves=manual_rakeback&search.outer=-1" size="open-dialog-95p"
                         callback="" text="" title="返水详情" opType="dialog">
                ${soulFn:formatCurrency(rakeback)}
            </soul:button>
        </span>
    </li>
</ul>