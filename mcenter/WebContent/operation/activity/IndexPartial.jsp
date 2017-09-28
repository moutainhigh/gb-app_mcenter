<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.VActivityMessageListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
        <thead>
            <tr role="row" class="bg-gray">
                <th>${views.common['number']}</th>
                <th>${views.column['VActivityMessage.activityName']}</th>
                <th class="inline">
                    <gb:select name="search.code" value="${command.search.code}" cssClass="btn-group chosen-select-no-single" callback="query" prompt="${views.operation['Activity.list.allType']}" list="${activityType}"></gb:select>
                </th>
                <th class="inline">
                    <gb:select name="search.activityClassifyKey" value="${command.search.activityClassifyKey}" cssClass="btn-group chosen-select-no-single" callback="query" prompt="${views.operation['Activity.list.allCategory']}" list="${siteI18ns}" listKey="key" listValue="value"></gb:select>
                </th>
                <th>${views.column['VActivityMessage.startAndEndTime']}</th>
                <%--<th>${views.column['VActivityMessage.checkStatus']}</th>--%>
                <th class="inline">
                    <gb:select name="search.states" value="${command.search.states}" cssClass="btn-group chosen-select-no-single" callback="query" prompt="${views.common['all']}" list="${activityState}"></gb:select>
                </th>
                <th>${views.column['VActivityMessage.isDisplay']}</th>
                <th>${views.column['VActivityMessage.acount']}</th>
                <th>${views.column['VActivityMessage.defaultSet']}</th>
                <th>${views.common['operate']}</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <tr class="tab-detail">
                <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                <td><a href="/operation/activityType/viewActivityDetail.html?search.id=${p.id}" nav-target="mainFrame">${p.activityName}</a></td>
                <td>${views.operation[p.code]}</td>
                <td>
                   ${siteI18nMap[p.activityClassifyKey].value}
                </td>
                <td>${soulFn:formatDateTz(p.startTime,DateFormat.DAY_SECOND,timeZone)}${views.common['TO']}${soulFn:formatDateTz(p.endTime,DateFormat.DAY_SECOND,timeZone)}</td>
                <%--<td>${views.operation[p.approvalStatus]}</td>--%>
                <td>
                    <span class="${p.activityStatesShow.cssClass}">${views.operation[p.activityStatesShow.activityState]}</span>
                </td>
                <td>
                    <shiro:hasPermission name="operate:activity_edit">
                        <c:choose>
                            <c:when test="${p.isRemove}">
                                <input type="checkbox" name="my-checkbox" data-size="mini" disabled>
                            </c:when>
                            <c:otherwise>
                                <input type="checkbox" name="my-checkbox" data-size="mini" ${p.isDisplay ? 'checked' : ''}
                                       isDisplay="${p.isDisplay}" pid="${p.id}" states="${p.states}" code="${p.code}">
                            </c:otherwise>
                        </c:choose>
                    </shiro:hasPermission>
                    <shiro:lacksPermission name="operate:activity_edit">
                        <input type="checkbox" name="my-checkbox" data-size="mini" disabled ${p.isDisplay ? 'checked' : ''}>
                    </shiro:lacksPermission>

                </td>
                <td>
                    <c:choose>
                        <c:when test="${p.isAudit && p.acount ge 0}">
                            ${p.acount}
                        </c:when>
                        <c:otherwise>
                            ---
                        </c:otherwise>
                    </c:choose>
                </td>
                <th>
                    <c:if test="${p.code eq 'money'}">
                        <soul:button target="${root}/operation/activity/setDefaultWin.html?search.id=${p.id}" title="${views.operation_auto['内定玩家设置']}"
                                     size="open-dialog-1000" text="${views.operation_auto['内定']}" opType="dialog"></soul:button>
                    </c:if>
                    <c:if test="${p.code ne 'money'}">
                        <span class="co-gray">----</span>
                    </c:if>
                </th>
                <td>

                    <shiro:hasPermission name="operate:activity_edit">
                        <c:choose>
                            <%--进行中的有待审核的不能编辑删除 --%>
                            <c:when test="${(p.acount>0 && p.isAudit)}">
                                <span class="co-gray">${p.activityState eq "draft"?views.common['continueEditing']:views.common['edit']}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="/operation/activityType/activityEdit.html?search.id=${p.id}&states=${p.states}" nav-target="mainFrame">${(p.activityState eq "draft")?views.common['continueEditing']:views.common['edit']}</a>
                            </c:otherwise>
                        </c:choose>
                    </shiro:hasPermission>

                    <%--大于0且需要审核的才可以审核--%>
                    <%--<c:choose>
                        <c:when test="${!p.isAudit}">
                            <span class="disabled">${views.common['audit']}</span>
                        </c:when>
                        <c:otherwise>
                            <shiro:hasPermission name="operate:activity_checkapply">
                                <a href="/operation/vActivityPlayerApply/activityPlayerApply.html?search.id=${p.id}" nav-target="mainFrame" name="returnView">${views.common['audit']}</a>
                            </shiro:hasPermission>
                        </c:otherwise>
                    </c:choose>--%>
                    <%--改成全部可以查看审核--%>
                    <shiro:hasPermission name="operate:activity_checkapply">
                        <a href="/operation/vActivityPlayerApply/activityPlayerApply.html?search.id=${p.id}" nav-target="mainFrame" name="returnView">${views.common['audit']}</a>
                    </shiro:hasPermission>
                    <c:choose>
                        <%--进行中且有待审核需要审核的不能删除--%>
                        <c:when test="${(p.isAudit && p.acount>0)}">
                            <span class="co-gray">${views.common['delete']}</span>
                        </c:when>
                        <c:otherwise>
                            <soul:button permission="operate:activity_delete" target="${root}/operation/activity/deleteActivity.html?result.id=${p.id}" text="${views.common['delete']}" opType="ajax" callback="query" confirm="${p.states eq 'notStarted'?views.operation['Activity.list.notStarted']:views.operation['Activity.list.delete']}"/>
                        </c:otherwise>
                        <%--<c:when test="${(p.checkStatus eq '1' and p.states eq 'finished' and p.acount eq 0)
                        || (p.checkStatus eq '1' and p.states eq 'notStarted') || p.checkStatus eq '0' || p.checkStatus eq '2' || p.activityState eq 'draft' || p.isRemove}">
                            <soul:button permission="operate:activity_delete" target="${root}/operation/activity/deleteActivity.html?result.id=${p.id}" text="${views.common['delete']}" opType="ajax" callback="query" confirm="${p.states eq 'notStarted'?views.operation['Activity.list.notStarted']:views.operation['Activity.list.delete']}"/>
                        </c:when>
                        <c:otherwise>
                            <span class="disabled">${views.common['delete']}</span>
                        </c:otherwise>--%>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
