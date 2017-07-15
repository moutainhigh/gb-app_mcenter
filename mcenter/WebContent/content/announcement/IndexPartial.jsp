<%@ page import="so.wwb.gamebox.model.master.player.po.VUserPlayer" %>
<%@ page import="so.wwb.gamebox.model.master.content.po.CttAnnouncement" %>
<%@ page import="java.util.Date" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.CttAnnouncementListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable m-b-sm" aria-describedby="editable_info">
        <c:set var="poType" value="<%= CttAnnouncement.class %>"></c:set>
        <thead>
        <tr role="row" class="bg-gray">
            <th width="40"><input type="checkbox" class="i-checks "></th>
            <th width="80">${views.common['number']}</th>
            <th class="inline">
                <gb:select name="search.announcementType" value="${command.search.announcementType}" callback="query"
                           prompt="${views.common['all']}" list="${types}"></gb:select>

            </th>
            <th>${views.column['CttAnnouncement.content']}</th>
            <soul:orderColumn poType="${poType}" property="publishTime" column="${views.column['CttAnnouncement.publishTime']}"/>
            <th>${views.content['前端展示']}</th>
            <th>${views.common['operate']}</th>
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
                <td><input type="checkbox" class="i-checks" value="${p.code}"></td>
                <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                <td>${dicts.content.ctt_announcement_type[p.announcementType]}</td>
                <td><span class="table-t-title">${p.content}</span></td>
                <td>
                    <%--${p.isTask?"将于":""}
                    ${soulFn:formatDateTz(p.publishTime, DateFormat.DAY_SECOND,timeZone)}
                    ${p.isTask?"发布":""}--%>
                    <c:if test="${p.isTask}">
                        <c:set var="nowtime" value="<%=new Date()%>"></c:set>
                        <c:if test="${nowtime.before(p.publishTime)}">
                            ${fn:replace(views.content['announcement.willPublish'], '{time}',soulFn:formatDateTz(p.publishTime, DateFormat.DAY_SECOND,timeZone))}
                        </c:if>
                        <c:if test="${nowtime.after(p.publishTime)}">
                            ${soulFn:formatDateTz(p.publishTime, DateFormat.DAY_SECOND,timeZone)}
                        </c:if>
                    </c:if>
                    <c:if test="${!p.isTask}">
                        ${soulFn:formatDateTz(p.publishTime, DateFormat.DAY_SECOND,timeZone)}
                    </c:if>
                </td>
                <td><input type="checkbox" name="my-checkbox" data-size="mini" ${p.display?'checked':''} value="${p.id}"></td>
                <td>
                    <div class="joy-list-row-operations">
                        <soul:button target="${root}/cttAnnouncement/editByCode.html?search.uuidCodes=${p.code}" title="${views.content['cttAnnouncement.create']}" text="${views.common['edit']}" opType="dialog" callback="callBackQuery"/>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination cssClass="bdtop3"/>
<!--//endregion your codes 1-->
