<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.RakebackBillVo"--%>
<%--@elvariable id="noticeLocaleTmpls" type="java.util.List<org.soul.model.msg.notice.vo.NoticeLocaleTmpl>"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
    <!--拒绝结算选择失败原因-->
    <form:form method="post">
        <div id="validateRule" style="display: none">${validateRule}</div>
        <input type="hidden" name="search.id" value="${command.search.id}"/>
        <input type="hidden" name="hasRason" value="yes"/>
        <c:if test="${fn:length(noticeLocaleTmpls)>0}">
            <div class="modal-body">
                <div class="form-group clearfix line-hi34 m-b-sm">
                    <label class="col-xs-3 al-right">${views.common['reasonTitle']}：</label>
                    <div class="col-xs-8">
                        <select callback="reasonTitleChange" class="btn-group chosen-select-no-single" name="reasonTitle">
                            <c:forEach items="${noticeLocaleTmpls}" var="i">
                                <option value="${i.title}" holder="${i.content}" groupCode="${i.groupCode}">${i.title}</option>
                            </c:forEach>
                        </select>
                        <div class="clearfix m-t-sm">${views.common['content']}：
                            <soul:button target="reasonPreviewMore.editTmpl" text="${views.common['editTmpl']}" opType="function" cssClass="pull-right"/>
                        </div>
                        <textarea class="form-control m-t-sm" readonly name="reasonContent">${noticeLocaleTmpls[0].content}</textarea>
                        <input type="hidden" name="groupCode" value="${noticeLocaleTmpls[0].groupCode}"/>
                        <soul:button target="reasonPreviewMore.previewMore" text="" opType="function" toggle="false" cssClass="dropdown-toggle account-pull-down pull-right btn-advanced-down">
                            <i class="fa fa-angle-double-down m-r-sm"></i>${views.common['previewMore']}
                        </soul:button>
                    </div>
                </div>
                <div class="panel blank-panel p-b-sm" style="display:none" id="previewMore">

                </div>
            </div>
            <c:forEach items="${ids}" var="i">
                <input name="ids" value="${i}" type="hidden"/>
            </c:forEach>
            <div class="modal-footer">
                <gb:token/>
                <soul:button cssClass="btn btn-filter" text="${views.common['OK']}" opType="ajax" target="${root}/operation/rakebackBill/settlementReject.html"
                             dataType="json" callback="saveCallbak" post="getCurrentFormData" tag="button" precall="validateForm"/>
                <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter" opType="function" tag="button"/>
            </div>
        </c:if>
        <c:if test="${fn:length(noticeLocaleTmpls)<=0}">
            <div class="no-content_wrap">
                <i class="fa fa-exclamation-circle"></i> ${views.common['noResaon']}
            </div>
        </c:if>
    </form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<script type="text/javascript">
    curl(['site/operation/rakebackBill/BackwaterFailure', "site/share/ReasonPreviewMore"], function(Page, ReasonPreviewMore) {
        page = new Page();
        page.bindButtonEvents();
        page.reasonPreviewMore  = new ReasonPreviewMore();
    });
</script>
</html>