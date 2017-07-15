<%--@elvariable id="command" type="so.wwb.gamebox.model.company.sys.vo.SysDomainListVo"--%>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable m-b-sm" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th>${views.common['number']}</th>
            <th>${views.content['domain.dl']}</th>
            <th>${views.content['domain.bdym']}</th>
            <th>${views.content['domain.bd']}</th>
            <th>${views.content['domain.bdsj']}</th>
            <th>${views.content['domain.status']}</th>
            <th>${views.content['isEnable']}</th>
            <th>${views.common['operate']}</th>
        </tr>
        <tr class="bd-none hide">
            <th colspan="6">
                <div class="select-records"><i class="fa fa-exclamation-circle"></i>${views.role['player.cancelSelectAll.prefix']}&nbsp;<span id="page_selected_total_record"></span>${views.role['player.cancelSelectAll.middlefix']}
                    <soul:button target="cancelSelectAll" opType="function" text="${views.role['player.cancelSelectAll']}"/>${views.role['player.cancelSelectAll.suffix']}
                </div>
            </th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${empty command.result}">
            <td colspan="7" class="no-content_wrap">
                <div>
                    <i class="fa fa-exclamation-circle"></i> ${views.common['noResult']}
                </div>
            </td>
        </c:if>
        <c:forEach items="${command.result}" varStatus="status" var="s">
            <tr>
                <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                <td>
                    <%--<c:forEach items="${command.domainTypes}" var="types">--%>
                        <%--<c:if test="${types.defaultValue eq s.pageUrl}">--%>
                            <%--${views.content[types.resourceKey]}--%>
                        <%--</c:if>--%>
                    <%--</c:forEach>--%>
                        <a href="/userAgent/agent/detail.html?search.id=${s.agentId}" nav-target="mainFrame">${command.userAgentMap.get(s.agentId).username}</a>
                </td>
                <td>${s.domain}</td>
                <td class="resolve" style="color: ${s.resolveStatus=='6'?'red':''};">${dicts.content.resolveStatus[s.resolveStatus]}</td>

                <td>
                        ${soulFn:formatDateTz(s.createTime, DateFormat.DAY_SECOND,timeZone)}
                </td>
                <c:choose>
                    <%--绑定中，解绑中，失败的域名状态显示为“--”；--%>
                    <c:when test="${s.resolveStatus=='5'}">
                        <td class="_enable${s.isEnable ? '':' hide'}">
                            <span class="label label-green">${views.content['domain.enable']}</span>
                        </td>
                        <td class="co-grayc2 _disabled${not s.isEnable ? '':' hide'}">
                            <span class="label">${views.content['domain.disallow']}</span>
                        </td>
                    </c:when>
                    <c:otherwise>
                        <td>
                            <span>---</span>
                        </td>
                    </c:otherwise>
                </c:choose>
                <td>

                    <%--<input ${s.resolveStatus eq "5"?'':'hidden'} type="checkbox" name="${s.resolveStatus eq "5"?'my-checkbox':''}" value="${s.id}" data-size="mini" ${s.isEnable?'checked':''} >--%>
                        <c:choose>
                            <c:when test="${s.resolveStatus eq '5'}">
                                <input  type="checkbox" name="my-checkbox" value="${s.id}" data-size="mini"  ${s.isEnable?'checked':''} >
                            </c:when>
                            <c:otherwise>
                                ---
                            </c:otherwise>
                        </c:choose>
                </td>
                <td>
                        <%--删除--%>
                    <c:choose>
                        <c:when test="${s.resolveStatus=='1'||s.resolveStatus=='6'}">
                            <soul:button target="${root}/content/sysDomain/delDomain.html?result.id=${s.id}&result.code=${s.code}"
                                         precall="deleteMessage" callback="query" text="${views.common['delete']}"
                                         opType="ajax" cssClass="co-blue"/>
                            <%--<soul:button target="${root}/content/sysDomain/mainManagerEdit.html?search.id=${s.id}" text="${views.common['delete']}" tag="a" opType="dialog" callback="query"></soul:button>--%>
                        </c:when>
                        <c:otherwise>
                            <%--解绑--%>
                            <c:if test="${s.resolveStatus=='5'}">
                                <soul:button
                                        target="${root}/content/sysDomain/changeResolveStatus.html?result.id=${s.id}&result.resolveStatus=3&result.domain=${s.domain}&domainPlatform=agent&result.code=${s.code}&result.agentId=${s.agentId}"
                                        text="${views.content['sysdomain.unbundling']}"
                                        precall="resolveConfirmMessage" callback="query" opType="ajax"
                                        cssClass="co-blue"/>
                            </c:if>
                            <%--取消--%>
                            <c:if test="${s.resolveStatus=='3'}">
                                <soul:button
                                        target="${root}/content/sysDomain/changeResolveStatus.html?result.code=${s.code}&result.id=${s.id}&result.resolveStatus=5"
                                        precall="cancelMessage" callback="query" text="${views.common['cancel']}"
                                        opType="ajax" cssClass="co-blue"/>
                            </c:if>
                            <c:if test="${s.resolveStatus=='2'||s.resolveStatus=='4'}">
                                ---
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination cssClass="bdtop3"/>
<!--//endregion your codes 1-->
