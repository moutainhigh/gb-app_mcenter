<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.VActivityMessageListListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div class="clearfix m-t-md line-hi34">
    <label class="ft-bold col-sm-3 al-right line-hi34"><img src="${resRoot}${activityType.result.logo}"></label>
    <div class="col-sm-5">
        <h3>${views.operation[activityType.result.code]}</h3>
        <span>${views.operation["activity.introduce.".concat(activityType.result.code)]}</span>
        <c:set var="size" value=""></c:set>
        <c:if test="${activityType.result.code eq 'profit_loss' }">
            <c:set var="size" value="size-wide"></c:set>
        </c:if>
        <c:if test="${activityType.result.code ne 'content' }">
            <soul:button target="${root}/activityHall/activityType/chooseCaseDialog.html?result.code=${activityType.result.code}" text="${views.operation['Activity.introduction']}" opType="dialog" size="${size}"/>
        </c:if>
    </div>
</div>
<hr>
<!--//endregion your codes 1-->

