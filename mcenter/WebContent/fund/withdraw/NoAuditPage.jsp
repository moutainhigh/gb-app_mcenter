<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.vo.VPlayerRechargeVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${views.fund['withdraw.index.notPass']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
    <form:form>
        <div class="modal-body">
            <div class="form-group clearfix line-hi34">
                ${views.fund['withdraw.check.playerWithdraw.player']}：${command.username}
            </div>
            <div class="form-group clearfix line-hi34">
                ${views.fund['withdraw.check.playerWithdraw.audit']}：<span class="co-red3">${views.fund['withdraw.check.playerWithdraw.noReached']}</span>
            </div>
            <div class="form-group clearfix line-hi34">
                ${views.fund['withdraw.check.playerWithdraw.deductedForAdministrationCost']}：<span class="fs25 ft-bold">${command.administrativeFee}</span>
            </div>
            <div class="form-group clearfix line-hi34">
                ${views.fund['withdraw.check.playerWithdraw.deductedFavourable']}：<span class="fs25 ft-bold">${command.deductFavorable}</span>
            </div>
        </div>
        <div class="modal-footer">
            <input type="hidden" name="result.id" value="${command.id}"/>
            <input type="hidden" name="result.playerId" value="${command.playerId}"/>
            <input type="hidden" name="result.createTime"  value="${soulFn:formatDateTz(command.createTime, DateFormat.DAY_SECOND,timeZone)}"/>
            <input type="hidden" name="remarkContent" value="${remark.remarkContent}"/>
            <input type="hidden" name="username" value="${command.username}"/>
            <input type="hidden" name="result.administrativeFee" value="${command.administrativeFee}">
            <input type="hidden" name="result.deductFavorable"  value="${command.deductFavorable}">
            <input type="hidden" name="result.withdrawAmount"  value="${command.withdrawAmount}">
            <input type="hidden" name="result.transactionNo" value="${command.transactionNo}"/>
            <input type="hidden" name="result.withdrawActualAmount" value="${command.withdrawActualAmount}"/>
            <soul:button cssClass="btn btn-filter" text="${views.common['OK']}" opType="ajax" dataType="json"
                         target="${root}/fund/withdraw/auditWithdraw.html" post="getCurrentFormData" callback="saveCallbak"/>
            <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
        </div>
    </form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/fund/withdraw/WithdrawAuditView"/>

</html>
