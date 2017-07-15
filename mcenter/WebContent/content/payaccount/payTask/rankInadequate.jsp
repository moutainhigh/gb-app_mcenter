<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.WarningContentVo"--%>
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
    <div class="modal-body">
        <dl class="clearfix thaw_tip">
            <dt><i class="fa fa-exclamation-circle"></i></dt>
            <dd>
                <div class="m-b-xs">${fn:replace(fn:replace(views.content['您今日层级'],"[0]",command.rankName),"[1]",command.accountNum)}</div>
                <div class="m-b-xs"><b>${views.content['建议您马上调整该层级的账户停用金额！']}</b></div>
            </dd>
        </dl>
    </div>
<div class="modal-footer">
    <%--&lt;%&ndash;去提高&ndash;%&gt;--%>
    <%--<soul:button title="${views.role['playerrank.toimprove']}" target="${root}/payAccount/getDisableInfo.html?search.id=${command.result.id}&startTime=${soulFn:formatDateTz(command.result.frozenTime, DateFormat.DAY,timeZone)}&endTime=${soulFn:formatDateTz(command.result.frozenTime, DateFormat.DAY_SECOND,timeZone)}" text="${views.content['payAccount.thaw.toImprove']}"--%>
                 <%--opType="dialog" cssClass="btn btn-filter" callback="saveCallbak"/>--%>
        <div class="modal-footer">
            <soul:button title="${views.role['playerrank.toimprove']}" target="toAdjustment" text="${views.content_auto['去调整']}"
                         opType="function" cssClass="btn btn-filter" callback="saveCallbak"/>
        </div>
</div>
    </form:form>
</body>
<!--//region your codes 4-->
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/content/payaccount/payTask/rankInadequate"/>
</html>
<!--//endregion your codes 4-->
