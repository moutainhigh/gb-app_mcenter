<%--suppress ALL --%>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.vo.VPlayerDepositVo"--%>
<%--@elvariable id="failReasons" type="java.util.List<org.soul.model.msg.notice.vo.NoticeLocaleTmpl>"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${views.fund['despoit.check.selectFailureReason']}</title>
    <%@ include file="/include/include.head.jsp" %>
    <link href="${resComRoot}/themes/${curTheme}/chosen/chosen.css" rel="stylesheet">
</head>

<body>
<form:form>
    <c:set var="r" value="${command.result}" />
    <c:set var="t" value="${command.failTmpls}" />
    <form:input type="hidden" path="search.id" value="${r.id}" />
    <form:input type="hidden" path="search.transactionNo" value="${r.transactionNo}" />
    <form:input type="hidden" path="search.checkStatus" value="${r.checkStatus}" />
    <form:input type="hidden" path="search.rechargeStatus" value="${r.rechargeStatus}" />
    <form:input type="hidden" path="search.rechargeTypeParent" value="${r.rechargeTypeParent}" />
    <input type="hidden" name="search.checkRemark" />
    <c:set var="url" value="${r.rechargeTypeParent=='company_deposit'?'fund/deposit/company/confirmCheck.html':'fund/deposit/online/confirmCheck.html'}" />
    <c:choose>
        <c:when test="${command.publish}">
            <c:choose>
                <c:when test="${fn:length(t) > 0}">
                    <div class="modal-body clearfix">
                        <div class="form-group clearfix line-hi34 m-b-sm">
                            <label class="col-xs-3 al-right">${views.common['reasonTitle']}：</label>
                            <div class="col-xs-8 p-x">
                                <select callback="reasonTitleChange" name="failureTitle" class="btn-group chosen-select-no-single"  tabindex="9">
                                    <c:forEach items="${t}" var="i">
                                        <option value="${i.title}" holder="${i.content}" groupCode="${i.groupCode}">${i.title}</option>
                                    </c:forEach>
                                </select>
                                <div class="clearfix">
                                    <soul:button target="reasonPreviewMore.editTmpl" text="${views.common['editTmpl']}" opType="function" cssClass="pull-right" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group clearfix line-hi34 m-b-sm">
                            <label class="col-xs-3 al-right">${views.common['content']}：</label>
                            <div class="col-xs-8 p-x">
                                <textarea class="form-control m-t" name="search.failureTitle">${t[0].content}</textarea>
                                <input type="hidden" name="groupCode" value="${t[0].groupCode}"/>
                                <soul:button target="reasonPreviewMore.previewMore" text="" opType="function" toggle="false" cssClass="dropdown-toggle account-pull-down pull-right btn-advanced-down">
                                    <i class="fa fa-angle-double-down m-r-sm"></i> ${views.common['previewMore']}
                                </soul:button>
                            </div>
                        </div>
                        <div id="previewMore" class="panel blank-panel p-b-sm" style="display:none">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <soul:button target="${root}/${url}" opType="ajax" cssClass="btn btn-warning btn-deposit-result-btn" tag="button" text="${views.common['confirmFailure']}" dataType="json" post="getCurrentFormData" callback="saveCallbak" />
                        <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-default" opType="function" />
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-content_wrap">
                        <i class="fa fa-exclamation-circle"></i> ${views.common['noResaon']}
                    </div>
                </c:otherwise>
            </c:choose>
        </c:when>
        <c:otherwise>
            <div class="modal-body clearfix">
                <center style="font-size: 16px; line-height: 50px;">
                    <i class="fa fa-exclamation-circle"></i>${views.fund['确认失败？']}
                </center>
            </div>
            <div class="modal-footer">
                <soul:button target="${root}/${url}" opType="ajax" cssClass="btn btn-warning btn-deposit-result-btn" tag="button" text="${views.common['confirmFailure']}" dataType="json" post="getCurrentFormData" callback="saveCallbak" />
                <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-default" opType="function" />
            </div>
        </c:otherwise>
    </c:choose>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<script type="text/javascript">
    curl(['site/fund/deposit/check/ConfirmCheck',"site/share/ReasonPreviewMore"], function(Page, ReasonPreviewMore) {
        page = new Page();
        page.bindButtonEvents();
        page.reasonPreviewMore  = new ReasonPreviewMore();
    });
</script>
</html>

