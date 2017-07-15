<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.VActivityMessageListListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<%--返水优惠--%>
<div class="clearfix m-t-md">
    <label class="ft-bold col-sm-3 al-right line-hi34">${views.operation['Activity.step.conditions']}：</label>
        <div class="col-sm-9">
            <div class="tab-content">
                <table class="table border" id="backWaterTable">
                    <tr>
                        <th class="bg-gray">${views.operation['Activity.step.rakebackOffersName']}</th>
                        <th class="bg-gray">${views.operation['Activity.step.create']}</th>
                        <th class="bg-gray">${views.common['status']}</th>
                    </tr>
                    <c:forEach items="${rakebackSets}" var="r">
                        <tr>
                            <td>${r.name}</td>
                            <td>${soulFn:formatDateTz(r.createTime,DateFormat.DAY_SECOND,timeZone)}</td>
                            <td>
                                <span class="label label-danger">
                                    <c:if test="${r.status eq 0}">${views.common['disabled']}</c:if>
                                    <c:if test="${r.status eq 1}">${views.common['normal']}</c:if>
                                    <c:if test="${r.status eq 2}">${views.common['delete']}</c:if>
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
</div>
<div class="clearfix m-t-md line-hi34">
    <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.rakebackBillingCycle']}：</label>
    <div class="col-sm-5" id="backWater">
        <c:choose>
            <c:when test="${rakebackSetting[0] eq 0}">
                ${views.operation['Activity.step.dayBack']}
            </c:when>
            <c:otherwise>
                ${rakebackSetting[0]}${views.common['ci']}
            </c:otherwise>
        </c:choose>
    </div>
</div>
<!--//endregion your codes 1-->

