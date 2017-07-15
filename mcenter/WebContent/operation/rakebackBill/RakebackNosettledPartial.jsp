<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.RakebackPlayerNosettledListVo"--%>
<%--@elvariable id="rakebackApisMap" type="java.util.MapMap<java.lang.Integer, Map<java.lang.Integer,so.wwb.gamebox.model.master.operation.vo.BackwaterApi>>"--%>
<%--@elvariable id="ranks" type="java.util.List<java.util.Map<java.lang.String,java.lang.Object>>"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<textarea style="display: none" name="originData">${command.originData}</textarea>

<div class="table-responsive m-t-sm dataTables_wrapper table-min-h">
    <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th>${views.operation['Rakeback.list.playerAccount']}</th>
            <th class="inline">
                <gb:select name="search.rankId" prompt="${views.operation['backwater.settlement.allRank']}"
                           cssClass="btn-group chosen-select-no-single" list="${ranks}" value="${command.search.rankId}"
                           listKey="id" listValue="rankName" callback="query"/>
            </th>
            <c:forEach items="${command.tabTitles}" var="i" varStatus="vs">
                <c:choose>
                    <c:when test="${!empty i.gameType}">
                        <c:if test="${i.state}">
                            <th>${gbFn:getSiteApiName(i.id.toString())}</th>
                        </c:if>
                        <c:forEach items="${i.gameType}" var="j">
                            <th>${gbFn:getSiteApiName(i.id.toString())}<br>${gbFn:getGameTypeName(j)}</th>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <th>${gbFn:getSiteApiName(i.id.toString())}</th>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <th>${views.operation['Rakeback.list.expectedRakeback']}</th>
        </tr>
        </thead>
        <tbody>
        <c:set var="rakeback" value="0"/>
        <c:forEach items="${command.result}" var="i">
            <tr>
                <c:set var="rakeback" value="${rakeback+i.rakebackTotal}"/>
                <td>
                    <a href="/player/playerView.html?search.id=${i.playerId}" nav-target="mainFrame">${i.username}</a>
                    <c:if test="${i.riskMarker}">
                        <span class="ico-lock co-red3"><i class="fa fa-warning"></i></span>
                    </c:if>
                    <a href="/fund/playerDetect/userPlayView.html?search.username=${i.username}"
                       class="m-l-sm" nav-target="mainFrame">${views.common['detection']}</a>

                </td>
                <td>${i.rankName}</td>
                <c:forEach items="${command.tabTitles}" var="t" varStatus="vs">
                    <c:choose>
                        <c:when test="${!empty t.gameType}">
                            <c:if test="${t.state}">
                                <td>${soulFn:formatCurrency(rakebackApisMap[i.playerId][t.id].backwater)}</td>
                            </c:if>
                            <c:forEach items="${t.gameType}" var="j">
                                <td>${empty rakebackApisMap[i.playerId][t.id].gameTypeWater[j]?'0.00':soulFn:formatCurrency(rakebackApisMap[i.playerId][t.id].gameTypeWater[j])}</td>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <td>${soulFn:formatCurrency(rakebackApisMap[i.playerId][t.id].backwater)}</td>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <td>${soulFn:formatCurrency(i.rakebackTotal)}</td>
            </tr>
        </c:forEach>
        <tr>
            <th>${views.operation['operation.total']}</th>
            <td></td>
            <c:forEach items="${command.tabTitles}" var="i" varStatus="vs">
                <c:choose>
                    <c:when test="${!empty i.gameType}">
                        <c:if test="${i.state}">
                            <td>
                                <c:set var="money" value="0"></c:set>
                                <c:forEach items="${command.result}" var="k">
                                    <c:set var="money" value="${money+rakebackApisMap[k.playerId][i.id].backwater}"></c:set>
                                </c:forEach>
                                    ${money==0?'0.00':soulFn:formatCurrency(money)}
                            </td>
                        </c:if>
                        <c:forEach items="${i.gameType}" var="j">
                            <td>
                                <c:set var="money" value="0"></c:set>
                                <c:forEach items="${command.result}" var="k">
                                    <c:set var="money" value="${money+rakebackApisMap[k.playerId][i.id].gameTypeWater[j]}"></c:set>
                                </c:forEach>
                                    ${money==0?'0.00':soulFn:formatCurrency(money)}
                            </td>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <td>
                            <c:set var="money" value="0"></c:set>
                            <c:forEach items="${command.result}" var="k">
                                <c:set var="money" value="${money+rakebackApisMap[k.playerId][i.id].backwater}"></c:set>
                            </c:forEach>
                                ${money==0?'0.00':soulFn:formatCurrency(money)}
                        </td>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <td>${rakeback==0?'0.00':soulFn:formatCurrency(rakeback)}</td>
        </tr>
        </tbody>
    </table>
</div>
<soul:pagination/>
