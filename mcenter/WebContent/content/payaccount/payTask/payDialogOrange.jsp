<%@ page import="java.util.Date" %><%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.PayAccountVo"--%>
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
    <div class="modal-body">
        <dl class="clearfix thaw_tip">
            <dt><i class="fa fa-exclamation-circle"></i></dt>
            <dd>
                <input type="hidden" id="startTime" value="${soulFn:formatDateTz(updateTime, DateFormat.DAY,timeZone)}"/>
                <input type="hidden" id="endTime" value="${soulFn:formatDateTz(updateTime, DateFormat.DAY_SECOND,timeZone)}"/>
                <div class="m-b-xs">${views.content['您的收款账户']}<span class="co-yellow">${soulFn:overlayName(payName)}</span>${views.content['已于北京时间']}${soulFn:formatDateTz(updateTime, DateFormat.DAY_SECOND,timeZone)}</div>
                <div class="m-b-xs"><b>${views.content['达到停用金额的']}<span class="co-yellow">${warningVal}%</span></b>${views.content['即将被冻结！']}</div>
                <div class="m-b-xs co-grayc2">${views.content['为预防账户被冻结，建议提高该账户停用金额！']}</div>
            </dd>
        </dl>
    </div>
<div class="modal-footer">
    <%--&lt;%&ndash;去提高&ndash;%&gt;--%>
    <%--<soul:button title="${views.role['playerrank.toimprove']}" target="${root}/payAccount/getDisableInfo.html?search.id=${command.result.id}&startTime=${soulFn:formatDateTz(command.result.frozenTime, DateFormat.DAY,timeZone)}&endTime=${soulFn:formatDateTz(command.result.frozenTime, DateFormat.DAY_SECOND,timeZone)}" text="${views.content['payAccount.thaw.toImprove']}"--%>
                 <%--opType="dialog" cssClass="btn btn-filter" callback="saveCallbak"/>--%>
        <div class="modal-footer">
            <input id="updateTime" value="${updateTime}" hidden>
                <%--去提高--%>
            <soul:button title="${views.role['playerrank.toimprove']}" precall="" target="${root}/payAccount/getDisableInfo.html?search.id=${payId}&reminder.id=${taskId}&startTime=${soulFn:formatDateTz(updateTime, DateFormat.DAY,timeZone)}&endTime=${soulFn:formatDateTz(updateTime, DateFormat.DAY_SECOND,timeZone)}" text="${views.content['payAccount.thaw.toImprove']}"
                         opType="dialog" cssClass="btn btn-filter" callback="saveCallbak"/>
        </div>
</div>
    </form:form>
</body>
<!--//region your codes 4-->
<%@ include file="/include/include.js.jsp" %>
<soul:import type="edit"/>
</html>
<!--//endregion your codes 4-->
