<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.vo.VPlayerWithdrawVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>出款状态</title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form name="withdrawStatusViewForm">
    <div class="modal-body">
        <table class="table no-border table-desc-list">
            <tbody>
            <tr>
                <th scope="row" class="text-right">订单号：</th>
                <td><span>${command.result.transactionNo}</span></td>
            </tr>
            <tr>
                <th scope="row" class="text-right">出款状态：</th>
                <td>
                    <span class="'co-red">
                        【${dicts.fund.check_status[command.result.checkStatus]}】
                    </span>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
    <div class="modal-footer">
        <soul:button cssClass="btn btn-warning btn-withdraw-result-btn" tag="button" text="确认重新出款" opType="ajax"
                     target="${root}/fund/withdraw/payment.html?search.transactionNo=${command.result.transactionNo}" callback="saveCallbak"/>
        <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-default" opType="function"/>
    </div>
</form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/fund/withdraw/WithdrawStatusView"/>
</html>

