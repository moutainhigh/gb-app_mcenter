<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.vo.VAgentWithdrawOrderVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${views.fund['withdraw.index.auditOK']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form:form action="${root}/fund/vAgentWithdrawOrder/agentList.html" method="post">
    <input type="hidden" name="remarkContent" value="${remark.remarkContent}"/>
    <input type="hidden" name="username" value="${command.result.username}"/>
    <form:input type="hidden" path="search.id" value="${command.result.id}"/>
    <form:input type="hidden" path="search.transactionStatus" value="2"/>

    <div class="modal-body clearfix">
        <div class="m-b">
        ${views.fund['withdraw.edit.AgentWithdraw.agent']}：<span class="co-blue">${command.result.username}</span>
            <a name="copy" data-clipboard-text="${command.result.username}"
               class="btn btn-sm btn-info btn-stroke m-l-sm"><li class="fa fa-copy" title="${views.fund_auto['复制']}"></li></a>
        </div>
        <div class="m-b">${views.column['realName']}：${command.result.agentRealname}
            <a name="copy" data-clipboard-text="${command.result.agentRealname}"
               class="btn btn-sm btn-info btn-stroke m-l-sm"><li class="fa fa-copy" title="${views.fund_auto['复制']}"></li></a>
        </div>
        <div class="m-b">${views.column['VPlayerWithdraw.payeeBank']}：${dicts.common.bankname[command.result.agentBank]}</div>
        <div class="m-b">
                ${views.fund_auto['开户行']}：${agentBankCard.bankDeposit}
            <a name="copy" data-clipboard-text="${agentBankCard.bankDeposit}"
               class="btn btn-sm btn-info btn-stroke m-l-sm"><li class="fa fa-copy" title="${views.fund_auto['复制']}"></li></a>
        </div>
        <div class="m-b">
            ${views.fund['withdraw.edit.AgentWithdraw.agentWithdrawAccount']}：${command.result.agentBankcard}
                <a name="copy" data-clipboard-text="${command.result.agentBankcard}"
                   class="btn btn-sm btn-info btn-stroke m-l-sm"><li class="fa fa-copy" title="${views.fund_auto['复制']}"></li></a>
        </div>

        <div class="m-b">
                ${views.column['VPlayerWithdraw.withdrawActualAmount']}：
            <b class="co-yellow">${command.result.actualAmount}</b>
        </div>
        <%--<div class="m-b">${views.fund['withdraw.edit.AgentWithdraw.proposedPaymentToTheAgent']}：<b class="co-yellow">${command.result.actualAmount}</b></div>
        <div class="co-yellow"><i class="fa fa-exclamation-circle m-r-sm"></i>${views.fund['withdraw.edit.AgentWithdraw.auditOkNotice']}</div>--%>
    </div>
    <div class="modal-footer">
        <soul:button cssClass="btn btn-filter btn-withdraw-result-btn" tag="button" text="${views.common['confirmPass']}" callback="saveCallbak" opType="function" target="putAuditStatus"/>
        <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/fund/agent/AgentAuditSubmit"/>
</html>

