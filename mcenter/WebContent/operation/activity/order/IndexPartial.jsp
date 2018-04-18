<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.ActivityMessageListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable m-b-none dragdd" aria-describedby="editable_info">
        <thead>
            <tr role="row" class="bg-gray">
                <th style="width: 5%">${views.common['number']}</th>
                <th style="width: 20%">${views.column['VActivityMessage.activityName']}</th>
                <th style="width: 20%" class="inline">
                    ${views.column['VActivityMessage.code']}
                </th>
                <th style="width: 20%" class="inline">
                    ${views.column['VActivityMessage.activityClassifyKey']}
                </th>
                <th style="width: 20%">${views.column['VActivityMessage.startAndEndTime']}</th>
            </tr>
        </thead>
        <tbody class="dd-list1">
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <tr class="dd-item1 tab-detail over">
                <input type="hidden" name="activityId" value="${p.id}" class="td-handle1"/>

                <td style="width: 5%" class="td-handle1">${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                <td style="width: 20%" class="td-handle1">${p.activityName}</td>
                <td style="width: 20%" class="td-handle1">${activityType[p.activityTypeCode].remark}</td>
                <td style="width: 20%" class="td-handle1">
                   ${siteI18nMap[p.activityClassifyKey].value}
                </td>
                <td style="width: 20%" class="td-handle1">${soulFn:formatDateTz(p.startTime,DateFormat.DAY_SECOND,timeZone)}${views.common['TO']}${soulFn:formatDateTz(p.endTime,DateFormat.DAY_SECOND,timeZone)}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>


<!--//endregion your codes 1-->
