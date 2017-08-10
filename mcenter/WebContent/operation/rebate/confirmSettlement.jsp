<%--@elvariable id="objectVo" type="so.wwb.gamebox.model.master.operation.vo.RebateBillVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<html lang="zh-CN">
<head>
    <title>${views.operation['Rebate.confirmSettlement']}</title>
    <%@ include file="/include/include.head.jsp" %>
    <!--//region your codes 2-->

    <!--//endregion your codes 2-->
</head>
<body>
<form:form id="editForm" action="${root}/rebateAgent/confirmSettlement.html" method="post">
    <gb:token/>
    <input type="hidden" value="${objectVo.result.id}" name="id"/>
    <input type="hidden" value="${ids}" name="ids"/>
    <input type="hidden" value="${sum}" name="total"/>

    <!--RebateBill-->
    <input type="hidden" value="${objectVo.result.period}" name="rebateBillVo.settlementName"/>
    <input type="hidden" value="${soulFn:formatDateTz(objectVo.result.startTime,DateFormat.DAY_SECOND,timeZone)}" name="rebateBillVo.startTime"/>
    <input type="hidden" value="${soulFn:formatDateTz(objectVo.result.endTime,DateFormat.DAY_SECOND,timeZone)}" name="rebateBillVo.endTime"/>

    <div class="modal-body">
        <div class="form-group clearfix line-hi34 m-b-sm">
            <label class="col-xs-3 al-right">${views.operation['Rebate.commissionCycle']}：</label>
            <div class="col-xs-8">${soulFn:formatDateTz(objectVo.result.startTime,DateFormat.DAY , timeZone)} ~ ${soulFn:formatDateTz(objectVo.result.endTime,DateFormat.DAY , timeZone)}</div>
        </div>
        <div class="form-group clearfix line-hi34 m-b-sm">
            <label class="col-xs-3 al-right">${views.operation['Rebate.pop.commissionAgency']}：</label>
            <div class="col-xs-8"><span class="p-r-sm">${views.operation['Rebate.pop.theSettlement']}${thisPay}${views.operation['Rebate.pop.people']}(${views.operation['Rebate.pop.total']}${objectVo.result.agentCount}${views.operation['Rebate.pop.people']})</span></div>
        </div>
        <div class="form-group clearfix line-hi34 m-b-sm">
            <label class="col-xs-3 al-right">${views.operation['Rebate.pop.totalCommission']}<%=SessionManager.getUser().getDefaultCurrency()%>：</label>
            <div class="col-xs-8 fs24">${soulFn:formatCurrency(sum)}</div>
        </div>
        <div class="p-xs bg-gray co-yellow">
            <i class="fa fa-exclamation-circle"></i>
                ${views.operation['Rebate.pop.message2']}
        </div>
    </div>
    <div class="modal-footer">
        <soul:button callback="saveCallbak" target="${root}/rebateAgent/confirmSettlement.html" text="${views.common['OK']}" opType="ajax" cssClass="btn btn-outline btn-filter" post="getCurrentFormData"/>
        <soul:button target="closePage" text="${views.common['cancel']}" opType="function" cssClass="btn btn-outline btn-filter"/>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import type="edit"/>
<!--//endregion your codes 4-->
</html>