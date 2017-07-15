<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.vo.VPlayerWithdrawVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
    <form:form id="noAuditForm" action="fund/withdraw/noAuditPage.html" method="post">
        <div class="modal-body">
            <div class="bg-gray clearfix p-xs m-b">
                <div id="validateRule" style="display: none">${command.validateRule}</div>
                <div class="co-yellow pull-left fs36"><i class="fa fa-exclamation-circle m-r-sm"></i></div>
                <div class="pull-left line-hi25">
                    <div class="co-black">${views.fund['withdraw.check.playerWithdraw.plaseNoAuditWrite']}</div>
                    <div class="co-grayc2">${views.fund['withdraw.check.playerWithdraw.okAudit']}</div>
                </div>
            </div>
            <div class="form-group clearfix">
                <label class="col-xs-3 ft-bold al-right line-hi34" style="width:26%">${views.fund['withdraw.check.playerWithdraw.deductedForAdministrationCost']}${siteCurrency}</label>
                <div class="col-xs-8">
                    <input type="text" name="administrativeFee" class="form-control">
                </div>
            </div>
            <div class="form-group clearfix">
                <label class="col-xs-3 ft-bold al-right line-hi34">${views.fund['withdraw.check.playerWithdraw.deductedFavourable']}${siteCurrency}</label>
                <div class="col-xs-8">
                    <input type="text" name="deductFavorable" class="form-control">
                </div>
            </div>
     </div>
        <div class="modal-footer">
            <input type="hidden" name="id" value="${command.result.id}"/>
            <input type="hidden" name="username" value="${command.result.username}"/>
            <input type="hidden" name="playerId" value="${command.result.playerId}"/>
            <input type="hidden" name="withdrawActualAmount" value="${command.result.withdrawActualAmount}"/>
            <input type="hidden" name="withdrawAmount" value="${command.result.withdrawAmount}"/>
            <input type="hidden" name="transactionNo" value="${command.result.transactionNo}"/>
            <input type="hidden" name="createTime"  value="${soulFn:formatDateTz(command.result.createTime, DateFormat.DAY_SECOND,timeZone)}"/>
            <input type="hidden" name="remarkContent" value="${remark.remarkContent}"/>

            <soul:button precall="validateForm" target="noAuditPage" cssClass="btn btn-filter" text="${views.fund_auto['提交']}" opType="function"></soul:button>
            <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
        </div>
    </form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/fund/withdraw/WithdrawAuditView"/>
</html>
