<%@ page import="so.wwb.gamebox.model.master.content.po.VCttCarousel" %>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="poType" value="<%= VCttCarousel.class %>"></c:set>

<!--//region your codes 1-->
<div class="search-list-container">
    <div class="table-responsive table-min-h">
        <table class="table table-striped table-hover dataTable" aria-describedby="editable_info">
            <thead>
            <tr role="row" class="bg-gray">
                <th width="40"><input type="checkbox" class="i-checks"></th>
                <th width="60">${views.common['number']}</th>
                <th>${views.column['VCttCarousel.AdName']}</th>
                <th>${views.column['VCttCarousel.type']}</th>
                <th>${views.content['carousel.showTime']}</th>
                <th class="inline">
                    <gb:select name="search.useStatus" value="${command.search.useStatus}" callback="query"
                               prompt="${views.role['player.list.title.status']}" list="${command.useStatus}"></gb:select>
                </th>
                <th>${views.content['domain.setting']}</th>
                <th>${views.column['VCttCarousel.publishTime']}</th>
                <th>${views.common['operate']}</th>
            </tr>

            <tr class="bd-none hide">
                <th colspan="5"><div class="select-records"><i class="fa fa-exclamation-circle"></i>${views.common['cancelSelectAll.prefix']}<span id="page_selected_total_record"></span>${views.common['cancelSelectAll.middlefix']}，
                    <soul:button target="cancelSelectAll" tag="a" opType="function" text="${views.common['cancelSelectAll']}">${views.common['cancelSelectAll']}</soul:button>
                    ${views.common['cancelSelectAll.suffix']}</div></th>
            </tr>

            </thead>
            <tbody>
            <c:if test="${empty command.result}">
                <td colspan="9" class="no-content_wrap">
                    <div>
                        <i class="fa fa-exclamation-circle"></i> ${views.common['noResult']}
                    </div>
                </td>
            </c:if>
            <c:forEach items="${command.result}" var="p" varStatus="status">
                <tr class="tab-detail">
                    <td>
                        <input type="checkbox" class="i-checks" value="${p.id}" data-use-status="${p.useStatus}">
                    </td>
                    <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                    <td>
                            ${command.currentLang.get(p.id).name}
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${p.contentType != 1}">
                                ${views.column['VCttCarousel.word']}
                            </c:when>
                            <c:otherwise>
                                ${views.column['VCttCarousel.picture']}
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                            ${soulFn:formatDateTz(p.startTime, DateFormat.DAY_SECOND, timeZone)} ${views.content_auto['至']} ${soulFn:formatDateTz(p.endTime, DateFormat.DAY_SECOND,timeZone)}
                    </td>
                    <td<c:choose>
                        <c:when test="${now.compareTo(p.endTime)==-1 && now.compareTo(p.startTime)==1}"> class="co-green"</c:when>
                        <c:when test="${now.compareTo(p.endTime)==1}"> class="co-grayc2"</c:when>
                    </c:choose> data-stop="${dicts.content.carousel_state[p.useStatus]}">
                        <c:choose>
                            <c:when test="${now.compareTo(p.endTime)==-1 && now.compareTo(p.startTime)==1}"> ${dicts.content.carousel_state["using"]}</c:when>
                            <c:when test="${now.compareTo(p.startTime)==-1}">${dicts.content.carousel_state["wait"]}</c:when>
                            <c:when test="${now.compareTo(p.endTime)==1}">${dicts.content.carousel_state["expired"]}</c:when>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${now.compareTo(p.endTime)==1}">
                                <input type="checkbox" name="my-checkbox" data-size="mini" disabled value="${p.id}">
                            </c:when>
                            <c:when test="${now.compareTo(p.endTime)==-1 && now.compareTo(p.startTime)==1}">
                                <input type="checkbox" name="my-checkbox" data-size="mini" ${empty p.status ||p.status?'checked':''} value="${p.id}" useStatus="using">
                            </c:when>
                            <c:when test="${now.compareTo(p.startTime)==-1}">
                                <input type="checkbox" name="my-checkbox" data-size="mini" ${empty p.status ||p.status?'checked':''} value="${p.id}" useStatus="wait">
                            </c:when>
                        </c:choose>

                    </td>
                    <td>
                            ${soulFn:formatDateTz(p.publishTime, DateFormat.DAY_SECOND,timeZone)}
                    </td>
                    <td>
                        <soul:button target="${root}/content/cttCarousel/registerAd/edit.html?search.id=${p.id}" text="${views.common['edit']}" tag="a" opType="dialog" callback="query">${views.common['edit']}</soul:button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<soul:pagination/>
<!--//endregion your codes 1-->
