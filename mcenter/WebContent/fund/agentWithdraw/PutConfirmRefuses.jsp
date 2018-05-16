<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.vo.VAgentWithdrawOrderVo"--%>
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
    <input type="hidden" name="remarkContent" value="${remark.remarkContent}"/>
    <input type="hidden" name="username" value="${command.result.username}"/>
    <gb:token></gb:token>
    <form:input type="hidden" path="search.id" value="${command.result.id}"/>
    <form:input type="hidden" path="search.transactionStatus" value="4"/>

    <c:if test="${fn:length(failReasons)>0}">
        <div class="modal-body clearfix">
            <div class="form-group clearfix">
                <label class="col-sm-2 p-x al-right line-hi34">${views.common['reasonTitle']}：</label>
                <div class="col-sm-9 p-x">
                    <div class="input-group">
                        <form:select callback="reasonTitleChange" path="search.reasonTitle" class="btn-group chosen-select-no-single"  tabindex="9">
                            <c:forEach items="${failReasons}" var="i">
                                <option value="${i.title}" holder="${i.content}" groupCode="${i.groupCode}">${i.title}</option>
                            </c:forEach>
                        </form:select>
                        <span class="input-group-addon bdn">

                        </span>
                    </div>
                    <textarea class="form-control m-t" name="search.reasonContent" readonly="readonly" style="height: 200px;">${failReasons[0].content}</textarea>
                    <input type="hidden" name="groupCode" value="${failReasons[0].groupCode}"/>
                    <soul:button target="reasonPreviewMore.editTmpl" text="${views.common['editTmpl']}" opType="function" cssClass="pull-left"></soul:button>
                    <soul:button target="reasonPreviewMore.previewMore" text="" opType="function" toggle="false" cssClass="dropdown-toggle account-pull-down pull-right btn-advanced-down">
                        <i class="fa fa-angle-double-down m-r-sm"></i>${views.common['previewMore']}
                    </soul:button>
                </div>
            </div>
            <%--<div class="form-group clearfix line-hi34 m-b-sm">
                <label class="col-xs-3 al-right">${views.common['reasonTitle']}：</label>
                <div class="col-xs-8">
                    <form:select callback="reasonTitleChange" path="search.reasonTitle" class="btn-group chosen-select-no-single"  tabindex="9">
                        <c:forEach items="${failReasons}" var="i">
                            <option value="${i.title}" holder="${i.content}" groupCode="${i.groupCode}">${i.title}</option>
                        </c:forEach>
                    </form:select>

                    <div class="clearfix m-t-sm">${views.common['content']}：
                        <soul:button target="reasonPreviewMore.editTmpl" text="${views.common['editTmpl']}" opType="function" cssClass="pull-right"></soul:button>
                    </div>
                    <textarea class="form-control m-t" name="search.reasonContent" readonly="readonly" style="width: 100;height: 200px;">${failReasons[0].content}</textarea>
                    <input type="hidden" name="groupCode" value="${failReasons[0].groupCode}"/>
                    <soul:button target="reasonPreviewMore.previewMore" text="" opType="function" toggle="false" cssClass="dropdown-toggle account-pull-down pull-right btn-advanced-down">
                        <i class="fa fa-angle-double-down m-r-sm"></i>${views.common['previewMore']}
                    </soul:button>

                </div>
            </div>--%>
            <div class="panel blank-panel p-b-sm" style="display:none" id="previewMore"></div>
        </div>
        <div class="modal-footer">
            <soul:button cssClass="btn btn-filter btn-withdraw-result-btn" tag="button" text="${views.common['confirmFailure']}" opType="function" target="putAuditStatus" callback="saveCallbak"/>
            <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
        </div>
    </c:if>
    <c:if test="${fn:length(failReasons)<=0}">
        <div class="no-content_wrap">
            <i class="fa fa-exclamation-circle"></i> ${views.common['noResaon']}
        </div>
    </c:if>

</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<script type="text/javascript">
    curl(['site/fund/agent/AgentAuditSubmit',"site/share/ReasonPreviewMore"], function(Page,ReasonPreviewMore) {
        page = new Page();
        page.bindButtonEvents();
        page.reasonPreviewMore  = new ReasonPreviewMore();
    });
</script>
</html>

