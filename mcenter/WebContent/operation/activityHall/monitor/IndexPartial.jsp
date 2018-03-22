<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.VActivityMessageListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th><input type="checkbox" class="i-checks"></th>
            <th>${views.operation['优惠订单号']}</th>
            <th>${views.column['VActivityPlayerApply.playerName']}</th>
            <th>${views.column['VActivityMessage.activityName']}</th>
            <th>${views.operation['申请IP']}</th>
            <th>${views.column['VActivityPlayerApply.applyTime']}</th>
            <th>${views.operation['申请优惠金额']}</th>
            <th>${views.operation['Activity.step.audit']}</th>
            <th>${views.operation['脚本校验情况']}</th>
            <th class="inline">
                <gb:select name="search.code" value="${command.search.code}"
                           cssClass="btn-group chosen-select-no-single" callback="query"
                           prompt="${views.operation['Activity.list.allType']}" list="${activityType}"></gb:select>
            </th>
            <th class="inline">
                <gb:select name="search.activityClassifyKey" value="${command.search.activityClassifyKey}"
                           cssClass="btn-group chosen-select-no-single" callback="query"
                           prompt="${views.operation['Activity.list.allCategory']}" list="${siteI18ns}" listKey="key"
                           listValue="value"></gb:select>
            </th>
            <th>
                <gb:select name="search.checkState" value="${command.search.checkState}" prompt="${views.operation['活动审批']}" list="${checkStatusDicts}" callback="query"/>
            </th>
            <th>${views.operation['backwater.settlement.view.operator']}</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <tr class="tab-detail">
                <td>
                    <input type="checkbox" class="i-checks" value="${p.id}" ${p.checkState ne '1'?'disabled="disabled"':''}>
                    <label>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</label>
                </td>
                <td>
                    ${p.id}
                </td>
                <td>
                    <a href="/player/playerView.html?search.id=${p.playerId}" nav-Target="mainFrame">${p.playerName}</a>
                </td>
                <td>${p.activityName}</td>
                <td>
                    ${soulFn:formatIp(p.ipApply)}
                </td>
                <td>${soulFn:formatDateTz(p.applyTime,DateFormat.DAY_SECOND,timeZone)}</td>
                <td>${p.preferentialValue}</td>
                <td>${p.preferentialAudit}</td>
                <td></td>
                <td>${views.operation[p.code]}</td>
                <td>${siteI18nMap[p.activityClassifyKey].value}</td>

                <td>
                    <c:if test="${p.checkState eq '0'}">
                        <span class="label label-info">${dicts.operation.activity_apply_check_status[p.checkState]}</span>
                    </c:if>
                    <c:if test="${p.checkState eq '1'}">
                        <span class="label label-warning">${dicts.operation.activity_apply_check_status[p.checkState]}</span>
                        <soul:button target="${root}/operation/vActivityPlayerApply/successDialog.html?code=${p.code}&ids=${p.id}&sumPerson=1"
                                     text="${views.common['checkPass']}" opType="dialog" callback="callBackQuery"/>
                        <soul:button target="${root}/operation/vActivityPlayerApply/failDialog.html?ids=${p.id}&search.activityName=${p.activityName}&search.activityTypeCode=${p.code}" text="${views.common['checkFailure']}" opType="dialog" callback="callBackQuery"/>

                    </c:if>
                    <c:if test="${p.checkState eq '2'}">
                        <span class="label label-success">${dicts.operation.activity_apply_check_status[p.checkState]}</span>
                    </c:if>
                    <c:if test="${p.checkState eq '3'}">
                        <span class="label label-danger">${dicts.operation.activity_apply_check_status[p.checkState]}</span>
                    </c:if>

                </td>
                <td>
                        ${p.username}
                </td>

            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
