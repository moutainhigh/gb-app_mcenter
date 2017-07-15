<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.CttLogoListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div id="editable_wrapper" class="dataTables_wrapper" role="grid">
    <input type="hidden" value="${hasUsing}" id="hasUsing">
    <div class="table-responsive table-min-h">
        <table class="table table-striped table-hover dataTable" aria-describedby="editable_info">
            <thead>
            <tr role="row" class="bg-gray">
                <th width="40"><input type="checkbox" class="i-checks "></th>
                <th width="60">${views.common['number']}</th>
                <th>${views.column['CttLogo.name']}</th>
                <th>${views.column['CttLogo.path']}</th>
                <th>${views.content['logo.flash']}</th>
                <th>${views.column['CttLogo.useTime']}</th>
                <th>${views.column['CttLogo.status']}</th>
                <th>${views.column['CttLogo.publishTime']}</th>
                <%--<th>${views.column['CttLogo.checkStatus']}</th>--%>
                <th width="120px">${views.common['operate']}</th>
            </tr>
            <tr class="bd-none hide">
                <th colspan="10">
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
            <c:forEach items="${command.result}" var="p" varStatus="status">
                <tr class="tab-detail">
                    <td>
                        <c:if test="${p.isDefault == false}">
                        <input type="checkbox" class="i-checks _hideDelete" value="${p.id}">
                        </c:if>
                    </td>
                    <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                    <td>
                        <soul:button target="${root}/cttLogo/showLogoDetail.html?search.id=${p.id}"
                                     opType="dialog" text="${p.name}"
                                     title="${p.name}-${views.common['detail']}"></soul:button>

                    </td>
                    <td class="logo-size-h24">
                        <c:if test="${not empty p.path}">
                        <a href="javascript:void(0)">
                            <img data-src="${soulFn:getImagePath(domain,p.path)}" src="${soulFn:getThumbPath(domain,p.path,66,24)}" alt="${p.name}">
                        </a>
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${empty p.flashLogoPath}">--</c:if>
                        <c:if test="${not empty p.flashLogoPath}">${views.content['已上传']}</c:if>
                    </td>
                    <td>${soulFn:formatDateTz(p.startTime, DateFormat.DAY_SECOND,timeZone)} ${views.content['logo.zhi']} ${p.isDefault?"----":soulFn:formatDateTz(p.endTime, DateFormat.DAY_SECOND,timeZone)}</td>
                    <td id="${p.id}">
                            <c:if test="${p.isDefault == true}">
                                <span id="default" class=""></span>
                            </c:if>
                            <c:if test="${p.isDefault != true}">
                                <c:if test="${p.isRemove}"><span class="co-red">${views.analyze['']}${views.content['已下架']}</span></c:if>
                                <c:if test="${p.isRemove==null||p.isRemove==false}">
                                    <c:if test="${date>=p.startTime && date<=p.endTime}">
                                        <span class="co-green">${views.content['logo.stauts.using']}</span>
                                    </c:if>
                                    <c:if test="${date<=p.startTime}">
                                        <span class="_wait">${views.content['logo.status.toBeUse']}</span>
                                    </c:if>
                                    <c:if test="${date>p.endTime}">
                                        <span class="co-grayd">${views.content['logo.status.past']}</span>
                                    </c:if>
                                </c:if>
                            </c:if>
                    </td>
                    <td>${soulFn:formatDateTz(p.publishTime, DateFormat.DAY_SECOND,timeZone)}</td>
                    <%--<td>
                        <c:if test="${p.checkStatus!='2'}">
                            ${dicts.content.check_status[p.checkStatus]}
                        </c:if>
                        <c:if test="${p.checkStatus=='2'}">
                            <span class="co-red">${dicts.content.check_status[p.checkStatus]}</span>

                        </c:if>
                    </td>--%>
                    <td>
                        <c:if test="${p.checkStatus!='0'}">
                            <div class="joy-list-row-operations">
                                <soul:button target="${root}/cttLogo/edit.html?id=${p.id}" text="${views.common['edit']}" opType="dialog" callback="callBackQuery"/>
                            </div>
                        </c:if>
                        <c:if test="${p.checkStatus=='0'}">
                            <span class="co-grayd">${views.content['编辑']}</span>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<soul:pagination cssClass="bdtop3"/>
<!--//endregion your codes 1-->
