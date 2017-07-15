<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.RakebackBillVo"--%>
<%--@elvariable id="master" type="org.soul.model.security.privilege.po.SysUser"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
    <!--返水结算确认-->
    <form:form method="post">
        <div class="modal-body">
            <div class="form-group clearfix line-hi34 m-b-sm">
                <label class="col-xs-4 al-right">${views.column['SettlementBackwater.startTime']}：</label>
                <div class="col-xs-8 p-x">${soulFn:formatDateTz(command.result.startTime, DateFormat.DAY,timeZone)} ~ ${soulFn:formatDateTz(command.result.endTime, DateFormat.DAY,timeZone)}</div>
            </div>
            <div class="form-group clearfix line-hi34 m-b-sm">
                <label class="col-xs-4 al-right">${views.operation['backwater.settlement.backwaterPlayer']}：</label>
                <div class="col-xs-8">
                    ${views.operation['backwater.settlement.thisSettlement']}${fn:length(ids)}${views.operation['backwater.settlement.people']}<span class="co-grayc2">(${views.operation['backwater.settlement.total']}${command.result.playerCount}${views.operation['backwater.settlement.people']})</span>
                </div>
            </div>
            <div class="form-group clearfix line-hi34 m-b-sm">
                <label class="col-xs-4 al-right">${views.operation['backwater.settlement.backwaterTotalMoney']}${master.defaultCurrency}：</label>
                <div class="col-xs-8 p-x fs24">${soulFn:formatCurrency(rakebackActual) }</div>
            </div>
            <div class="p-xs bg-gray co-yellow">
                <i class="fa fa-exclamation-circle"></i>
                ${views.operation['backwater.settlement.backwaterWillReturnToPlayerAfterConfirmSettlement']}
            </div>
            <c:forEach items="${ids}" var="i" varStatus="vs">
                <input type="hidden" name="ids" value="${i}"/>
            </c:forEach>
        </div>
        <div class="modal-footer">
            <gb:token/>
            <soul:button cssClass="btn btn-filter" text="${views.common['OK']}" opType="function" target="rakebackSuccess" url="${root}/operation/rakebackBill/settlementSuccess.html?result.id=${command.result.id}&search.id=${command.result.id}" tag="button"/>
            <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter" opType="function" tag="button"/>
        </div>
    </form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/operation/rakebackBill/BackwaterSuccess"/>
</html>