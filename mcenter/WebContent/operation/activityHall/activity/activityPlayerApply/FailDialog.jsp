<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.VActivityPlayerApplyListVo"--%>
<%--@elvariable id="i" type="so.wwb.gamebox.model.master.fund.po.VFailReason"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${views.operation['Activity.apply.title']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form:form method="post">
    <input type="hidden" name="ids" value="${ids}"/>
    <input type="hidden" name="result.checkState" value="3"/>
    <input type="hidden" name="activityType" value="${command.search.activityTypeCode}"/>

    <!--选择优惠失败原因-->
    <c:if test="${fn:length(failReasons)>0}">
        <div class="modal-body clearfix">
            <div class="form-group clearfix">
                <label class="col-sm-2 p-x al-right line-hi34">${views.common['reasonTitle']}：</label>
                <div class="col-sm-9 p-x">
                    <div class="input-group">
                        <form:select callback="reasonTitleChange" path="result.reasonTitle"
                                     class="btn-group chosen-select-no-single" tabindex="9">
                            <c:forEach items="${failReasons}" var="i">
                                <option value="${i.title}" holder="${i.content}"
                                        groupCode="${i.groupCode}">${i.title}</option>
                            </c:forEach>
                        </form:select>
                    </div>

                    <textarea class="form-control m-t" name="result.reasonContent"
                              style="height: 200px;">${failReasons[0].content}</textarea>
                    <input type="hidden" name="groupCode" value="${failReasons[0].groupCode}"/>
                    <soul:button target="reasonPreviewMore.editTmpl" text="${views.common['editTmpl']}"
                                 opType="function" cssClass="pull-left"></soul:button>
                    <soul:button target="reasonPreviewMore.previewMore" text="" opType="function" toggle="false"
                                 cssClass="dropdown-toggle account-pull-down pull-right btn-advanced-down">
                        <i class="fa fa-angle-double-down m-r-sm"></i>${views.common['previewMore']}
                    </soul:button>
                </div>
            </div>
            <div class="panel blank-panel p-b-sm" style="display:none" id="previewMore"></div>
            <label class="col-sm-2 p-x al-right line-hi34">${views.operation_auto['备注']}：</label>
            <div class="col-sm-9 p-x">
                <textarea class="form-control" name="result.remark"></textarea>
            </div>
        </div>
        <div class="modal-footer">
            <soul:button cssClass="btn btn-filter" text="${views.common['confirmFailure']}" opType="function"
                         target="auditStatus" callback="saveCallbak"/>
            <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter"
                         opType="function"/>
        </div>
        </div>
    </c:if>
    <c:if test="${fn:length(failReasons)<=0}">
        <div class="no-content_wrap">
            <i class="fa fa-exclamation-circle"></i> ${views.common['noResaon']}
        </div>
    </c:if>


    <%--<div class="modal-body clearfix">
      <div class="form-group m-b-xs">
        <label>${views.fund['despoit.check.failureReason']}：</label>
        <c:if test="${fn:length(failReasons)>0}">
          <form:select path="result.reasonTitle" class="chosen-select-no-single"  tabindex="9">
            <c:forEach items="${failReasons}" var="i">
              <option value="${i.title}">${i.title}</option>
            </c:forEach>
          </form:select>
          <c:forEach items="${failReasons}" var="i">
            <div style="display: none" name="failContent${i.title}">${i.content}</div>
          </c:forEach>
        </c:if>
        <textarea class="form-control m-t" name="result.reasonContent">${failReasons[0].content}</textarea>
        <input type="hidden" name="groupCode" value="${failReasons[0].groupCode}"/>
      </div>
      <a href="javascript:void(0)">${views.fund['despit.check.editTemplate']}</a>
    </div>
    <div class="modal-footer">
      <soul:button cssClass="btn btn-filter" text="${views.common['confirmFailure']}" opType="function" target="auditStatus" callback="saveCallbak"/>
      <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
    </div>--%>

</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<script type="text/javascript">
    curl(['site/operation/activityHall/editActivityPlayerApply', "site/share/ReasonPreviewMore"], function (Page, ReasonPreviewMore) {
        page = new Page();
        page.bindButtonEvents();
        page.reasonPreviewMore = new ReasonPreviewMore();
    });
</script>
</html>

