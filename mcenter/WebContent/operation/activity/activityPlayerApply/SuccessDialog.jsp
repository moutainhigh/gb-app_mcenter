<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.VActivityPlayerApplyListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${views.operation['activity.okDiscount']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form:form method="post">
    <input type="hidden" name="ids" value="${ids}"/>
    <input type="hidden" name="activityType" value="${code}"/>
    <input type="hidden" name="result.checkState" value="2"/>
    <div class="modal-body clearfix">
        <div class="m-b">${views.operation['Activity.name']}：${command.activityName}</div>
        <div class="m-b">${views.operation['Activity.type']}：${dicts.common.transaction_way[command.code]}</div>
        <div class="m-b">${views.operation['Activity.apply.list.offerPlayers']}：${views.operation['Activity.apply.list.theAudit']}${length}${views.operation['operation.people']}（${views.operation['operation.total2']}${sumPerson}${views.operation['operation.people']}）</div>
        <div class="m-b">${views.operation['Activity.apply.list.totalPrize']}${siteCurrency}：<b
                class="co-yellow">${soulFn:formatCurrency(total)}</b></div>
        <div class="m-b">
            ${views.operation_auto['备注']}：<textarea class="form-control" name="result.remark"></textarea>
        </div>
        <div class="co-yellow"><i
                class="fa fa-exclamation-circle m-r-sm"></i>${views.operation['Activity.apply.list.message1']}</div>
    </div>
    <div class="modal-footer">
        <soul:button cssClass="btn btn-filter" text="${views.common['confirmPass']}" opType="function"
                     target="auditStatus"/>
        <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter"
                     opType="function"/>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/operation/activity/editActivityPlayerApply"/>
</html>

