<%--@elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.VRakebackSetListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable m-b-sm" aria-describedby="editable_info">
        <thead>
        <tr class="bg-gray">
            <th>${views.column['VRakebackSet.name']}</th>
            <th>${views.column['VRakebackSet.createTime']}</th>
            <th>${views.column['VRakebackSet.userRank']}</th>
            <th>${views.column['VRakebackSet.playerCount']}</th>
            <th>${views.common['status']}</th>
            <th>${views.setting['rakeback.list.switch']}</th>
            <th>${views.common['operate']}</th>
        </tr>
        <tr class="bd-none hide">
            <th colspan="5">
                <div class="select-records"><i class="fa fa-exclamation-circle"></i>${views.role['player.cancelSelectAll.prefix']}&nbsp;<span id="page_selected_total_record"></span>${views.role['player.cancelSelectAll.middlefix']}
                    <soul:button target="cancelSelectAll" opType="function" text="${views.role['player.cancelSelectAll']}"/>${views.role['player.cancelSelectAll.suffix']}
                </div>
            </th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" varStatus="status" var="r">
            <tr>
                <td><a href="/setting/vRakebackSet/view.html?id=${r.id}" nav-target="mainFrame">${r.name}</a></td>
                <td>${soulFn:formatDateTz(r.createTime,DateFormat.DAY_SECOND ,timeZone)}</td>
                    <c:choose>
                        <c:when test="${r.rankCount>0}">
                            <td class="co-blue"><a nav-target="mainFrame" href="/vPlayerRankStatistics/list.html?search.rakebackId=${r.id}&hasReturn=true">${r.rankCount}</a></td>
                        </c:when>
                        <c:otherwise>
                            <td> ${r.rankCount}</td>
                        </c:otherwise>
                    </c:choose>
                    <c:choose>
                        <c:when test="${r.playerCount>0}">
                            <td class="co-blue"><a nav-target="mainFrame" href="/player/list.html?search.rakebackId=${r.id}&search.hasReturn=true"> ${r.playerCount}</a></td>
                        </c:when>
                        <c:otherwise>
                            <td> ${r.playerCount}</td>
                        </c:otherwise>
                    </c:choose>
                <td class="${r.status eq '0' ?'co-red':''} _status" data-value1="{value:'${dicts.setting.program_settingsrake['1']}',class:''}" data-value0="{value:'${dicts.setting.program_settingsrake['0']}',class:'co-red'}">
                    ${dicts.setting.program_settingsrake[r.status]}
                </td>
                <td><input type="checkbox" name="my-checkbox" data-size="mini" ${r.status eq '1' ? 'checked':''} value="${r.id}"></td>
                <td>
                    <a href="/setting/rakebackSet/edit.html?id=${r.id}" nav-target="mainFrame" class="co-blue">${views.common['edit']}</a>
                    <span class="dividing-line m-r-xs m-l-xs">|</span>
                    <a href="/setting/vRakebackSet/view.html?id=${r.id}" nav-target="mainFrame">${views.common['detail']}</a>
                    <c:if test="${r.id ne 0}">
                        <c:if test="${r.rankCount eq 0 && r.playerCount eq 0}">
                            <span class="dividing-line m-r-xs m-l-xs">|</span>
                            <soul:button target="${root}/setting/rakebackSet/delete.html?id=${r.id}" text="${views.common['delete']}" confirm="${views.common['confirm.deletescheme']}" tag="a" opType="ajax" callback="query">${views.common['delete']}</soul:button>
                        </c:if>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<soul:pagination/>
<!--//endregion your codes 1-->
