<%@ taglib prefix="soulFn" uri="http://soul/fnTag" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.PayAccountVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->
<html>
<!--//endregion your codes 1-->
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form:form id="editForm" action="${root}/payAccount/edit.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <form:hidden id="payAccountId" path="result.id"/>
<div class="modal-body">
    <dl class="clearfix thaw_tip">
        <dt><i class="fa fa-exclamation-circle"></i></dt>
        <dd>
            <input type="hidden" id="startTime" value="${soulFn:formatDateTz(command.result.frozenTime, DateFormat.DAY,timeZone)}"/>
            <input type="hidden" id="endTime" value="${soulFn:formatDateTz(command.result.frozenTime, DateFormat.DAY_SECOND,timeZone)}"/>
            <div class="m-b-xs">${messages.content['payAccount.thaw.1']}<b class="co-yellow">${soulFn:overlayName(command.result.payName)}</b>${messages.content['payAccount.thaw.2']}${dicts.common.time_zone[country.ID]}${messages.content['payAccount.thaw.3']}${soulFn:formatDateTz(command.result.frozenTime, DateFormat.DAY_SECOND,timeZone)}${messages.content['payAccount.thaw.4']}</div>
            <div class="m-b-xs">${messages.content['payAccount.thaw.5']}${dicts.common.time_zone[country.ID]}${soulFn:formatDateTz(command.result.frozenTime, DateFormat.DAY,timeZone)} 00:00:00${messages.content['payAccount.thaw.6']}${soulFn:formatDateTz(command.result.frozenTime, DateFormat.DAY_SECOND,timeZone)}${messages.content['payAccount.thaw.7']}<b class="co-yellow" id="statistics">${messages.content['payAccount.thaw.8']}${command.result.depositCount}${messages.content['payAccount.thaw.9']}${soulFn:formatCurrency(command.result.depositTotal)}</b>
            <%--提高该账户停用金额后可重新开启该账户--%>
            <div class="m-b-xs co-grayc2">${views.content['payAccount.thaw.information']}</div>
        </dd>
    </dl>
</div>
<div class="modal-footer">
    <%--去提高--%>
    <soul:button title="${views.role['playerrank.toimprove']}" target="${root}/payAccount/getDisableInfo.html?search.id=${payId}&reminder.id=${taskId}&startTime=${soulFn:formatDateTz(command.result.frozenTime, DateFormat.DAY,timeZone)}&endTime=${soulFn:formatDateTz(command.result.frozenTime, DateFormat.DAY_SECOND,timeZone)}" text="${views.content['payAccount.thaw.toImprove']}"
                 opType="dialog" cssClass="btn btn-filter" callback="saveCallbak"/>
</div>
    </form:form>
</body>
<!--//region your codes 4-->
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/content/payaccount/Thaw"/>
</html>
<!--//endregion your codes 4-->
