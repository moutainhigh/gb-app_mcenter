<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.vo.VPlayerWithdrawVo"--%>
<%--@elvariable id="userBankcard" type="so.wwb.gamebox.model.master.player.po.UserBankcard"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${views.fund['withdraw.index.auditOK']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form:form action="${root}/fund/withdraw/withdrawList.html" method="post">
    <input type="hidden" name="remarkContent"/>
    <input type="hidden" name="username" value="${command.result.username}"/>
    <input type="hidden" name="search.id" value="${command.result.id}"/>
    <input type="hidden" name="search.withdrawStatus" value="4"/>

    <div class="modal-body">
        <table class="table no-border table-desc-list">
            <tbody>
            <tr>
                <td scope="row" class="text-right" style="width: 120px">${views.fund['withdraw.view.player']}：</td>
                <td><span class="co-blue">${command.result.username}</span></td>
            </tr>
            <tr>
                <td scope="row" class="text-right">${views.column['realName']}：</td>
                <td>
                    ${command.result.realName}
                    <a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-target="" data-clipboard-text="${command.result.realName}" name="copy">
                        <i class="fa fa-copy" title="${views.fund_auto['复制']}"></i>
                    </a>
                </td>
            </tr>
            <tr>
                <td scope="row" class="text-right">${views.column['VPlayerWithdraw.payeeBank']}：</td>
                <td>
                        ${dicts.common.bankname[command.result.payeeBank]}
                </td>
            </tr>
            <tr>
                <td scope="row" class="text-right">${views.fund_auto['开户行']}：</td>
                <td>
                    ${userBankcard.bankDeposit}
                    <a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-target="" data-clipboard-text="${userBankcard.bankDeposit}" name="copy">
                        <i class="fa fa-copy" title="${views.fund_auto['复制']}"></i>
                    </a>
                </td>
            </tr>
            <tr>
                <td scope="row" class="text-right">${views.column['VPlayerWithdraw.payeeBankcard']}：</td>
                <td>
                    ${command.result.payeeBankcard}
                    <a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-target="" data-clipboard-text="${command.result.payeeBankcard}" name="copy">
                        <i class="fa fa-copy" title="${views.fund_auto['复制']}"></i>
                    </a>
                </td>
            </tr>
            <tr>
                <td scope="row" class="text-right">${views.column['VPlayerWithdraw.withdrawActualAmount']}：</td>
                <td>
                    <b class="co-red" style="font-size: 16px">${sysCurrency[command.result.withdrawMonetary].currencySign}&nbsp;</b><b class="co-red" style="font-size: 22px">${soulFn:formatInteger(command.withdrawActualAmount)}${soulFn:formatDecimals(command.withdrawActualAmount)}</b>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
    <div class="modal-footer">
        <soul:button cssClass="btn btn-warning btn-withdraw-result-btn" tag="button" text="${views.common['confirmPass']}" opType="function" target="withdrawSuccess" callback="saveCallbak"/>
        <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-default" opType="function"/>
    </div>
    <div id="feeList" style="display: none"></div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/fund/withdraw/WithdrawAuditSubmit"/>
</html>

