<%--@elvariable id="command" type="java.util.Map<java.lang.String, java.util.Map<java.lang.String,so.wwb.gamebox.model.company.site.po.SiteI18n>>"--%>
<%--@elvariable id="siteLang" type="java.util.Map<java.lang.String,so.wwb.gamebox.model.company.site.po.SiteLanguage>>"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${views.common['edit']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form>
    <gb:token/>
    <div class="modal-body">
        <div id="validateRule" style="display: none">${validate}</div>
        <div class="add-players">
            <c:forEach items="${command}" var="i" varStatus="status">
                <div class="category-list-wrap clearfix" data-key="${i.key}">
                    <div class="clearfix" style="height: 20px">
                        <c:if test="${i.key ne 'default'}">
                            <soul:button target="deleteClassfication" text="" opType="function" tag="button"
                                         cssClass="close" data="${i.key}">
                                <span aria-hidden="true">×</span>
                                <span class="sr-only">${views.common['close']}</span>
                            </soul:button>
                        </c:if>
                    </div>
                    <c:forEach items="${siteLang}" var="j" varStatus="vs">
                        <c:set var="lan" value="${j.value.language}"/>
                        <div class="form-group clearfix m-b-sm">
                            <label class="col-xs-3 al-right line-hi34">${fn:substringBefore(dicts.common.language[lan], '#')}：</label>
                            <div class="col-xs-8 p-x">
                                <input type="text" class="form-control" ${i.key eq 'default' ? 'readonly' : ''}
                                       name="gruop[${status.index}].locale[${vs.index}]"
                                       data-name="gruop[{n}].locale[${vs.index}]" data-locale="${lan}"
                                       data-id="${i.value[lan].id}" value="${i.value[lan].value}">
                            </div>
                        </div>
                    </c:forEach>
                  <%--  <c:forEach items="${i.value}" var="j" varStatus="vs">
                        <div class="form-group clearfix m-b-sm">
                            <label class="col-xs-3 al-right line-hi34">${fn:substringBefore(dicts.common.language[j.locale], '#')}：</label>
                            <div class="col-xs-8 p-x">
                                <input type="text" class="form-control"
                                       name="gruop[${status.index}].locale[${vs.index}]"
                                       data-name="gruop[{n}].locale[${vs.index}]" data-locale="${j.locale}"
                                       data-id="${j.id}" value="${j.value}">
                            </div>
                        </div>
                    </c:forEach>--%>
                </div>
            </c:forEach>
            <soul:button target="addClassfication" text="" opType="function">
                <i class="fa fa-plus"></i>&nbsp;&nbsp;${views.operation['Activity.addClass']}
            </soul:button>
        </div>
    </div>
    <div class="modal-footer">
        <soul:button precall="validateForm" cssClass="btn btn-filter" callback="saveCallbak"
                     text="${views.common['OK']}" opType="ajax" dataType="json"
                     target="${root}/activityHall/activity/saveClassification.html" post="saveClassificationData"/>
        <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter"
                     opType="function"/>
    </div>
</form>
<div style="display: none" id="addClassfication">
    <div class="category-list-wrap clearfix">
        <div class="clearfix">
            <soul:button target="deleteClassfication" text="" opType="function" tag="button" cssClass="close">
                <span aria-hidden="true">×</span>
                <span class="sr-only">${views.common['close']}</span>
            </soul:button>
        </div>
        <c:forEach items="${siteLang}" var="i" varStatus="vs">
            <div class="form-group clearfix m-b-sm">
                <label class="col-xs-3 al-right line-hi34">${fn:substringBefore(dicts.common.language[i.value.language], '#')}：</label>
                <div class="col-xs-8 p-x">
                    <input type="text" class="form-control" name="gruop[0].locale[${vs.index}]"
                           data-name="gruop[{n}].locale[${vs.index}]" data-locale="${i.value.language}"/>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/operation/activityHall/ClassificationManager"/>
</html>