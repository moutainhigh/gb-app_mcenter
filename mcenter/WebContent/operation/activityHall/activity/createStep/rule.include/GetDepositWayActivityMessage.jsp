<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.po.VActivityMessage"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<c:if test="${fn:length(vActivityMessages)>0}">
    <div class="gray-chunk clearfix">
        <dd class=" p-xxs"><i class="fa fa-exclamation-circle co-orange"></i>${fn:replace(views.operation_auto['已有存款方式创建过'],"[0]",dicts.common.activity_type[activityType.result.code])}</dd>
        <dd class=" p-xxs">
            <c:forEach items="${vActivityMessages}" var="activityPo" varStatus="status">
                <p style="line-height: 30px;">${status.index+1}、
                【
                    <c:forEach items="${fn:split(activityPo.depositWay, ',')}" var="rr" varStatus="status">
                        ${views.operation['Activity.step.depositWay.'.concat(rr)]}、
                    </c:forEach>
                】
                <span class="label label-success">
                ${dicts.operation.activity_state[activityPo.states]}
                </span>
                ${activityPo.activityName}</p>
            </c:forEach>
        </dd>
    </div>
</c:if>

