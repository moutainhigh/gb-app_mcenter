<%--@elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.VNoticeEmailRankListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div id="editable_wrapper" class="dataTables_wrapper" role="grid">
    <div class="table-responsive table-min-h">
        <table class="table table-striped table-hover dataTable m-b-sm" aria-describedby="editable_info">
            <thead>
            <tr role="row" class="bg-gray">
                <th class="user_checkbox"><label><input type="checkbox" class="i-checks"/></label></th>
                <th>${views.setting['mail.Index.name']}</th>
                <th>${views.setting['mail.Index.createTime']}</th>
                <th>${views.setting['mail.Index.rankName']}</th>
                <th>${views.setting['mail.Index.sendNumber']}</th>
                <th class="inline">
                    <select class="btn-group chosen-select-no-single" name="search.status" id="selectStatus"
                            data-placeholder="${views.setting['mail.Index.status']}" callback="query">
                        <option value="">${views.setting['mail.Index.status']}</option>
                        <option value="1" ${command.search.status=='1'?"selected":""}>${views.setting['status.normal']}</option>
                        <option value="0" ${command.search.status=='0'?"selected":""}>${views.setting['status.disable']}</option>
                    </select>
                </th>
                <th>${views.setting['mail.Index.switch']}</th>
                <th>${views.setting['common.operate']}</th>
            </tr>
            <tr class="bd-none hide">
                <th colspan="${fn:length(command.fields)+3}">
                    <div class="select-records"><i
                            class="fa fa-exclamation-circle"></i>${views.role['player.cancelSelectAll.prefix']}&nbsp;<span
                            id="page_selected_total_record"></span>${views.role['player.cancelSelectAll.middlefix']}
                        <soul:button target="cancelSelectAll" opType="function"
                                     text="${views.role['player.cancelSelectAll']}"/>${views.role['player.cancelSelectAll.suffix']}
                    </div>
                </th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${command.result}" var="p" varStatus="status">
                <tr class="tab-detail">
                    <td>
                        <c:if test="${!p.builtIn}"><label><input type="checkbox" class="i-checks"
                                                                 value="${p.emailAccount}"></label></c:if>
                    </td>
                    <td>${p.name}</td>
                    <td>
                            ${soulFn:formatDateTz(p.createTime, DateFormat.DAY_SECOND,timeZone)}
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${p.builtIn}">
                                ${views.setting_auto['全部层级']}
                            </c:when>
                            <c:otherwise>
                                <div class="btn-group" ajaxid="522">
                                    <button data-toggle="dropdown" class="btn btn-warning dropdown-toggle btn-xs"
                                            aria-expanded="false"> ${fn:length(p.getRanks())}<i class="fa fa-angle-down"></i></button>
                                    <ul class="dropdown-menu lang" style="top: 280px; left: 682px;">
                                        <c:forEach items="${p.getRanks()}" var="r">
                                            <li style="display: block;">
                                                <a href="javascript:void(0)">${r}</a>
                                            </li>
                                        </c:forEach>


                                    </ul>
                                </div>
                            </c:otherwise>
                        </c:choose>

                    </td>
                    <td>${empty p.sendCount?0:p.sendCount}</td>
                    <td>
                        <c:if test="${p.status=='1'}"><span
                                class="label label-success">${views.setting['status.normal']}</span></c:if>
                        <c:if test="${p.status=='0'}"><span
                                class="label label-danger">${views.setting['status.disable']}</span></c:if>
                    </td>
                    <td>
                        <c:if test="${!p.builtIn}"><input type="checkbox" name="my-checkbox" tt="${p.emailAccount}"
                                                          data-size="mini" ${p.status=='1'?'checked':''}></c:if>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${p.builtIn}">
                                <soul:button target="${root}/vNoticeEmailInterface/editBuiltInEmail.html?search.id=-1"
                                             title="${views.setting['mail.Index.edit']}" text="${views.setting['common.edit']}"
                                             opType="dialog" callback="query"/>
                            </c:when>
                            <c:otherwise>
                                <soul:button target="${root}/vNoticeEmailInterface/editEmail.html?search.emailAccount=${p.emailAccount}"
                                             title="${views.setting['mail.Index.edit']}" text="${views.setting['common.edit']}"
                                             opType="dialog" callback="query"/>
                            </c:otherwise>
                        </c:choose>

                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <soul:pagination/>
</div>
<!--//endregion your codes 1-->
