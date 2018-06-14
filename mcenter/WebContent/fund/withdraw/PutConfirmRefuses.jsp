<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.vo.VPlayerRechargeVo"--%>
<%--@elvariable id="i" type="so.wwb.gamebox.model.master.fund.po.VFailReason"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${views.fund['withdraw.index.failApply']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form:form action="${root}/fund/withdraw/withdrawList.html" method="post">
    <input type="hidden" name="remarkContent" />
    <input type="hidden" name="username" value="${command.result.username}"/>
    <form:input type="hidden" path="search.id" value="${command.result.id}"/>
    <form:input type="hidden" path="search.withdrawStatus" value="6"/>

    <c:if test="${fn:length(failReasons)>0}">
        <div class="modal-body clearfix">
            <div class="form-group clearfix line-hi34 m-b-sm">
                <label class="col-xs-3 al-right">${views.common['reasonTitle']}：</label>
                <div class="col-xs-8 p-x">
                    <form:select callback="reasonTitleChange" path="search.reasonTitle" class="btn-group chosen-select-no-single"  tabindex="9">
                        <c:forEach items="${failReasons}" var="i">
                            <option value="${i.title}" holder="${i.content}" groupCode="${i.groupCode}" title="${i.title}">
                                    ${fn:substring(i.title, 0, 30)}<c:if test="${fn:length(i.title)>30}">...</c:if>
                            </option>
                        </c:forEach>
                    </form:select>
                    <div class="clearfix">
                        <soul:button target="reasonPreviewMore.editTmpl" text="${views.common['editTmpl']}" opType="function" cssClass="pull-right" />
                    </div>
                </div>
            </div>
            <div class="form-group clearfix line-hi34 m-b-sm">
                <label class="col-xs-3 al-right">${views.common['content']}：</label>
                <div class="col-xs-8 p-x">
                    <textarea class="form-control m-t" name="search.reasonContent" readonly="readonly" style="height: 200px;">${failReasons[0].content}</textarea>
                    <input type="hidden" name="groupCode" value="${failReasons[0].groupCode}"/>
                    <soul:button target="reasonPreviewMore.previewMore" text="" opType="function" toggle="false" cssClass="dropdown-toggle account-pull-down pull-right btn-advanced-down">
                        <i class="fa fa-angle-double-down m-r-sm"></i>${views.common['previewMore']}
                    </soul:button>
                </div>
            </div>
            <div class="panel blank-panel p-b-sm" style="display:none" id="previewMore"></div>
        </div>

        <div class="modal-footer">
            <soul:button cssClass="btn btn-warning btn-withdraw-result-btn" tag="button" text="${views.common['confirmReject']}" opType="function" target="withdrawReject" callback="saveCallbak"/>
            <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-default" opType="function"/>
        </div>
    </c:if>
    <c:if test="${fn:length(failReasons)<=0}">
        <div class="no-content_wrap">
            <i class="fa fa-exclamation-circle"></i> ${views.common['noResaon']}
        </div>
    </c:if>
    <div id="feeList" style="display: none"></div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>

<script type="text/javascript">
    curl(['clipboard','site/fund/withdraw/WithdrawAuditSubmit',"site/share/ReasonPreviewMore"], function(Clipboard, Page,ReasonPreviewMore) {
        window.clipboard = Clipboard;
        page = new Page();
        page.bindButtonEvents();
        page.reasonPreviewMore  = new ReasonPreviewMore();
    });
</script>
</html>

