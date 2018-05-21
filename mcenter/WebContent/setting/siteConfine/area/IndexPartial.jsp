<%--@elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.SiteConfineAreaListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div id="editable_wrapper" class="dataTables_wrapper" role="grid">
    <div class="table-responsive table-min-h">
        <table class="table table-striped table-hover dataTable m-b-sm" id="editable" aria-describedby="editable_info">
            <thead>
                <tr role="row" class="bg-gray">
                    <th class="user_checkbox"><label><input type="checkbox" class="i-checks"></label></th>
                    <th>${views.setting['siteConfine.confineArea']}</th>
                    <th>${views.column['SiteConfineArea.timeType']}</th>
                    <th>${views.column['SiteConfineArea.endTime']}</th>
                    <th>${views.column['SiteConfineArea.createTime']}</th>
                    <th>${views.column['SiteConfineArea.remark']}</th>
                    <th class="">
                        <gb:select name="search.status" value="${command.search.status}" list="${command.status}" cssClass="btn-group chosen-select-no-single" prompt="${views.common['all']}"  callback="query"/>
                    </th>
                    <th>${views.common['operate']}${dicts.setting['site_confine_status.using']}</th>
                </tr>
                <tr class="bd-none hide">
                    <th colspan="${fn:length(command.fields)+3}">
                        <div class="select-records"><i class="fa fa-exclamation-circle"></i>${views.role['player.cancelSelectAll.prefix']}&nbsp;<span id="page_selected_total_record"></span>${views.role['player.cancelSelectAll.middlefix']}
                            <soul:button target="cancelSelectAll" opType="function" text="${views.role['player.cancelSelectAll']}"/>${views.role['player.cancelSelectAll.suffix']}
                        </div>
                    </th>
                </tr>

            </thead>
            <tbody>
            <c:forEach items="${command.result}" var="p" varStatus="status">
                <tr class="tab-detail">
                    <th><input type="checkbox" value="${p.id}" ${p.builtIn?'disabled':''}></th>
                    <td>${dicts.region.region[p.nation]}${p.province.length()>0?"-":""}${dicts.state[p.nation][p.province]}${p.city.length()>0?"-":""}${dicts.city[p.nation.concat("_").concat(p.province)][p.city]}</td>
                    <td>${dicts.setting.siteConfine[p.timeType]}</td>
                    <c:choose>
                        <c:when test="${p.timeType==1}">
                            <td>----</td>
                        </c:when>
                        <c:otherwise>

                            <td>${soulFn:formatDateTz(p.endTime, DateFormat.DAY_SECOND,timeZone)}</td>
                        </c:otherwise>
                    </c:choose>
                    <td>${soulFn:formatDateTz(p.createTime, DateFormat.DAY_SECOND,timeZone)}</td>
                    <td>${p.remark}</td>
                    <td><span class="${p.status=='expired'?"label label-danger":"label label-success"}">${dicts.setting.site_confine_status[p.status]}</span></td>
                    <td>
                        <c:if test="${!p.builtIn}">
                            <soul:button target="${root}/siteConfineArea/edit.html?id=${p.id}" size="open-dialog-50" text="${views.common['edit']}" cssClass="co-blue m-r-xs m-l-xs" opType="dialog" callback="query" />
                        </c:if>

                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <soul:pagination/>
</div>


<!--//endregion your codes 1-->
