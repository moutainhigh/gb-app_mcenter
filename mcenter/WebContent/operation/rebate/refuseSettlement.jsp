<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.RebateAgentVo"--%>
<%--@elvariable id="objectVo" type="so.wwb.gamebox.model.master.operation.vo.RebateBillVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<html lang="zh-CN">
<head>
    <title>${views.operation['Rebate.refuseSettlement']}</title>
    <%@ include file="/include/include.head.jsp" %>
    <!--//region your codes 2-->

    <!--//endregion your codes 2-->
</head>
<body>
<form:form id="editForm" action="" method="post">
    <gb:token/>
    <input type="hidden" value="${objectVo.result.id}" name="id"/>
    <input type="hidden" value="${ids}" name="ids"/>
    <!--RebateBill-->
    <input type="hidden" value="${objectVo.result.period}" name="rebateBillVo.settlementName"/>
    <input type="hidden" value="${soulFn:formatDateTz(objectVo.result.startTime,DateFormat.DAY_SECOND,timeZone)}" name="rebateBillVo.startTime"/>
    <input type="hidden" value="${soulFn:formatDateTz(objectVo.result.endTime,DateFormat.DAY_SECOND,timeZone)}" name="rebateBillVo.endTime"/>
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <div class="modal-body">
        <div class="form-group clearfix line-hi34 m-b-sm">
            <label class="col-xs-3 al-right">${views.operation['Rebate.pop.reasonTitle']}：</label>
            <div class="col-xs-8">
                <select class="btn-group chosen-select-no-single" name="reasonTitle" callback="reasonTitleChange">
                    <c:forEach items="${noticeLocaleTmpls}" var="i">
                        <option value="${i.title}" holder="${i.content}" groupCode="${i.groupCode}">${i.title}</option>
                    </c:forEach>
                </select>
                <div class="clearfix m-t-sm">${views.common['content']}：
                    <soul:button target="reasonPreviewMore.editTmpl" text="${views.common['editTmpl']}" opType="function" cssClass="pull-right"/>
                </div>
                <textarea class="form-control m-t-sm" name="reasonContent" readonly>${noticeLocaleTmpls[0].content}</textarea>
                <input type="hidden" name="groupCode" value="${noticeLocaleTmpls[0].groupCode}">
                <soul:button target="reasonPreviewMore.previewMore" text="" opType="function" toggle="false" cssClass="dropdown-toggle account-pull-down pull-right btn-advanced-down">
                    <i class="fa fa-angle-double-down m-r-sm"></i>${views.common['previewMore']}
                </soul:button>
            </div>
        </div>
        <div class="panel blank-panel p-b-sm" style="display:none" id="previewMore"></div>
    </div>
    <div class="modal-footer">
        <soul:button target="${root}/operation/rebateAgent/refuseSettlement.html" text="${views.common['OK']}" opType="ajax" cssClass="btn btn-filter" post="getCurrentFormData" precall="validateForm" callback="saveCallbak"/>
        <soul:button target="closePage" text="${views.common['cancel']}" opType="function" cssClass="btn btn-outline btn-filter"/>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<%--<soul:import res="site/operation/rebate/refuseRebate"/>--%>
<script type="text/javascript">
    curl(['site/operation/rebate/refuseRebate', "site/share/ReasonPreviewMore"], function(Page, ReasonPreviewMore) {
        page = new Page();
        page.bindButtonEvents();
        page.reasonPreviewMore  = new ReasonPreviewMore();
    });
</script>
<!--//endregion your codes 4-->
</html>