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

        <a href="/report/vPlayerFundsRecord/fundsLog.html?search.usernames=${username}&search.userTypes=username&search.transactionWays=<%=TransactionWayEnum.FIRST_DEPOSIT.getCode()%>,<%=TransactionWayEnum.SECOND_DEPOSIT.getCode()%>,<%=TransactionWayEnum.THIRD_DEPOSIT.getCode()%>,<%=TransactionWayEnum.EVERYDAY_FIRST_DEPOSIT.getCode()%>,<%=TransactionWayEnum.DEPOSIT_SEND.getCode()%>,<%=TransactionWayEnum.REGIST_SEND.getCode()%>,<%=TransactionWayEnum.RELIEF_FUND.getCode()%>,<%=TransactionWayEnum.PROFIT_LOSS.getCode()%>,<%=TransactionWayEnum.EFFECTIVE_TRANSACTION.getCode()%>,<%=TransactionWayEnum.MONEY.getCode()%>,<%=TransactionWayEnum.SINGLE_REWARD.getCode()%>,<%=TransactionWayEnum.BONUS_AWARDS.getCode()%>&search.manualSaves=<%=TransactionWayEnum.MANUAL_FAVORABLE.getCode()%>,<%=TransactionWayEnum.MANUAL_PAYOUT.getCode()%>,<%=TransactionWayEnum.MANUAL_OTHER.getCode()%>&search.outer=-1&search.hasReturn=true&search.orderType=playerFavable" nav-target="mainFrame">
            <span class="pull-right co-blue">${favorableVal}</span>
        </a>

    </li>
    <li>
        <b>
            <span tabindex="0" class=" help-popover m-r-xs" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                  data-max="" data-html="true" data-content="${views.fund_auto['为优惠活动次数']}">
                                    <i class="fa fa-question-circle"></i>
                                </span>
            ${views.fund['playerDetect.view.discountNum']}：
        </b>
        <a href="/report/vPlayerFundsRecord/fundsLog.html?search.usernames=${username}&search.userTypes=username&search.transactionWays=<%=TransactionWayEnum.FIRST_DEPOSIT.getCode()%>,<%=TransactionWayEnum.SECOND_DEPOSIT.getCode()%>,<%=TransactionWayEnum.THIRD_DEPOSIT.getCode()%>,<%=TransactionWayEnum.EVERYDAY_FIRST_DEPOSIT.getCode()%>,<%=TransactionWayEnum.DEPOSIT_SEND.getCode()%>,<%=TransactionWayEnum.REGIST_SEND.getCode()%>,<%=TransactionWayEnum.RELIEF_FUND.getCode()%>,<%=TransactionWayEnum.PROFIT_LOSS.getCode()%>,<%=TransactionWayEnum.EFFECTIVE_TRANSACTION.getCode()%>,<%=TransactionWayEnum.MONEY.getCode()%>,<%=TransactionWayEnum.SINGLE_REWARD.getCode()%>,<%=TransactionWayEnum.BONUS_AWARDS.getCode()%>&search.manualSaves=<%=TransactionWayEnum.MANUAL_FAVORABLE.getCode()%>,<%=TransactionWayEnum.MANUAL_PAYOUT.getCode()%>,<%=TransactionWayEnum.MANUAL_OTHER.getCode()%>&search.outer=-1&search.hasReturn=true&search.orderType=playerFavable" nav-target="mainFrame">
            <span class="pull-right co-blue">${favorableCount}${views.fund['fund.playerDetect.index.second']}</span>
        </a>
    </li>
    <li>
        <b>
            <span tabindex="0" class=" help-popover m-r-xs" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                 data-max="" data-html="true" data-content="${views.content['annotation.backWater']}">
                                    <i class="fa fa-question-circle"></i>
                                </span>
        ${views.fund['playerDetect.view.totalAmount']}：</b>
        <span class="pull-right co-blue">
            <a href="/report/vPlayerFundsRecord/fundsLog.html?search.usernames=${username}&search.userTypes=username&search.transactionWays=<%=TransactionWayEnum.BACK_WATER.getCode()%>&search.manualSaves=<%=TransactionWayEnum.MANUAL_RAKEBACK.getCode()%>&search.outer=-1" nav-target="mainFrame">${soulFn:formatCurrency(rakeback)}</a>
        </span>
    </li>
</ul>