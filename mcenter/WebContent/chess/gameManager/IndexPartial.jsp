<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th>序号</th>
            <th>游戏大厅陈列项</th>
            <th>所属API</th>
            <th>图标</th>
            <th>展示状态</th>
            <th>上下架管理</th>
        </tr>
        <tr class="bd-none hide">
            <th colspan="5">
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
                    <%--序号--%>
                <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                    <%--游戏大厅陈列项--%>
                <td>${gbFn:getGameName(p.gameId).toString()}</td>
                <td>${gbFn:getSiteApiName(p.apiId)}</td>
                    <%--图标--%>
                <td>
                    <c:if test="${not empty siteGames[p.gameId.toString()].cover}">
                        <soul:button target="previewImg" text="" opType="function" tag="a">
                            <img id="cover${p.gameId}"
                                 data-src="${soulFn:getImagePath(domain,siteGames[p.gameId.toString()].cover)}"
                                 src="${soulFn:getThumbPath(domain, siteGames[p.gameId.toString()].cover,66,24)}"/>
                        </soul:button>
                    </c:if>
                    <c:if test="${empty siteGames[p.gameId.toString()].cover}">
                        <soul:button target="previewImg" text="" opType="function" tag="a">
                            <img id="cover${p.gameId}"
                                 data-src="${soulFn:getImagePath(domain,game[p.gameId.toString()].cover)}"
                                 src="${soulFn:getThumbPath(domain, game[p.gameId.toString()].cover,66,24)}"/>
                        </soul:button>
                    </c:if>
                </td>
                    <%--展示状态--%>
                <td>
                    <c:if test="${p.status=='normal'}">
                        <c:if test="${p.gameRealStatus =='normal'}">
                            <span class="label label-success">${dicts.game.status['normal']}</span>
                        </c:if>
                        <c:if test="${p.gameRealStatus =='maintain'}">
                            <span class="label label-warning">${dicts.game.status['maintain']}</span>
                            ${soulFn:formatDateTz(p.maintainEndTime, DateFormat.DAY_SECOND,timeZone)}
                            ${views.content['game.endOfMaintain']}
                        </c:if>
                    </c:if>
                    <c:if test="${p.status=='disable'}">
                        <span class="label label-danger">${dicts.game.status['disable']}</span>
                    </c:if>
                </td>
                    <%--上下架管理--%>
                <td>
                    <input type="checkbox" name="my-checkbox" tt="${status.index}"
                           siteId="${p.siteId}"
                           gameId="${p.gameId}"
                           apiId="${p.apiId}"
                           apiTypeId="${p.apiTypeId}"
                           data-size="mini" ${p.status=='normal'? 'checked' : ''}>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
