<%--@elvariable id="siteI18ns" type="java.util.List<org.soul.model.sys.po.SiteI18n>"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div class="col-sm-5 input-group _i18n">
    <gb:select value="${activityMessageVo.result.activityClassifyKey}" name="activityMessage.activityClassifyKey" cssClass="btn-group chosen-select-no-single" prompt="${views.operation['Activity.pop.chooseClass']}" list="${siteI18ns}" listKey="key" listValue="value"/>
    <span class="bdn">
        <soul:button target="${root}/activityHall/activity/classificationManager.html" text="${views.operation['Activity.pop.manageClass']}" opType="dialog" title="${views.operation['Activity.pop.activityManageClass']}" cssClass="m-l-sm" callback="changeClassification"/>
    </span>
</div>
<!--//endregion your codes 1-->

