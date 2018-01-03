<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.RakebackPlayerVo"--%>
<%--@elvariable id="sysUserVo" type="org.soul.model.security.privilege.vo.SysUserVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
    <!--修改实付返水-->
    <form:form method="post">
        <div id="validateRule" style="display: none">${validateRule}</div>
        <input type="hidden" name="result.id" value="${command.result.id}"/>
        <div class="modal-body">
            <div class="form-group clearfix line-hi34 m-b-xxs">
                <label class="col-xs-3 al-right">${views.operation['backwater.settlement.username']}：</label>
                <div class="col-xs-8 p-x">
                    <a href="javascript:void(0)">${command.result.username}</a>
                    <c:if test="${command.result.riskMarker}">
                        <span class="ico-lock co-red3 m-l-sm"><i class="fa fa-warning"></i></span>
                    </c:if>
                </div>
            </div>
            <div class="form-group clearfix line-hi34 m-b-xxs">
                <label class="col-xs-3 al-right">${views.operation['backwater.settlement.defaultLocale']}：</label>
                <div class="col-xs-8 p-x">${dicts.common.local[sysUserVo.result.defaultLocale]}</div>
            </div>
            <div class="form-group clearfix line-hi34 m-b-xxs">
                <label class="col-xs-3 al-right">${views.column['SettlementBackwater.backwaterTotal']}：</label>
                <input type="hidden" value="${command.result.rakebackTotal}" name="result.rakebackTotal"/>
                <input type="hidden" value="${command.result.rakebackPending}" name="result.rakebackPending"/>

                <div class="col-xs-8 p-x"><b><fmt:formatNumber value="${command.result.rakebackTotal}" pattern="0.00"/></b></div>
            </div>
            <div class="form-group clearfix line-hi34 m-b-xxs">
                <label class="col-xs-3 al-right">${views.fund['rakebackwater.pendingpay']}：</label>
                <div class="col-xs-8 p-x"><b><fmt:formatNumber value="${command.result.rakebackPaid}" pattern="0.00"/></b></div>
            </div>
            <div class="form-group clearfix line-hi34 m-b-sm">
                <label class="col-xs-3 al-right" for="result.rakebackActual"><span class="co-red3">*</span>${views.column['SettlementBackwater.backwaterActual']}：</label>
                <div class="col-xs-8 p-x input-group">
                    <form:input type="text" class="form-control" path="result.rakebackActual"/>
                    <span class="input-group-addon bdn">&nbsp;&nbsp;≤<fmt:formatNumber value="${command.result.rakebackPending}" pattern="0.00"/></span>
                </div>
            </div>
            <div class="form-group clearfix line-hi34 m-b-xxs">
                <label class="col-xs-3 al-right"><span class="co-red3"></span>${views.operation['backwater.settlement.remark']}：</label>
                <div class="col-xs-8 p-x">
                    <textarea class="form-control" placeholder="${views.operation['backwater.actual']}" name="result.remark">${command.result.remark}</textarea>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <soul:button cssClass="btn btn-filter" precall="validateForm" text="${views.common['OK']}" opType="ajax" target="${root}/operation/rakebackBill/saveBackwaterActual.html" tag="button" post="getCurrentFormData" dataType="json" callback="saveCallbak"/>
            <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter" opType="function" tag="button"/>
        </div>
    </form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import type="edit"/>
</html>