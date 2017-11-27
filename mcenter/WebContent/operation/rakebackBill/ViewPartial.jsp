<%@ page import="so.wwb.gamebox.model.master.operation.po.RakebackPlayer" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.RakebackPlayerListVo"--%>
<%--@elvariable id="map" type="java.util.MapMap<java.lang.Integer, Map<java.lang.Integer,so.wwb.gamebox.model.master.operation.vo.BackwaterApi>>"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<textarea style="display: none" name="originData">${command.originData}</textarea>
<c:set var="poType" value="<%=RakebackPlayer.class%>"></c:set>
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info" name="backwaterTable">
        <thead>
        <tr role="row" class="bg-gray">
            <th>${views.operation['backwater.settlement.username']}</th>
            <th>
                <gb:select cssStyle="max-height:200px;" name="search.rankId" prompt="${views.operation['backwater.settlement.allRank']}" cssClass="btn-group chosen-select-no-single" list="${ranks}" value="${command.search.rankId}" listKey="id" listValue="rankName" callback="query"/>
            </th>
            <c:set var="tab" value=""/>
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
            <c:set value="<span tabindex=\"0\" class=\"m-l-sm help-popover\" role=\"button\" data-container=\"body\" data-toggle=\"popover\" data-trigger=\"focus\" data-placement=\"top\" data-content=\"${views.report['rakeback.help.total']}\"><i class=\"fa fa-question-circle\"></i></span>" var="tips1"></c:set>
            <soul:orderColumn poType="${poType}" property="rakebackTotal" column="${tips1} ${views.column['SettlementBackwater.backwaterTotal']}"></soul:orderColumn>
            <c:set var="tips2" value="<span tabindex=\"0\" class=\"m-l-sm help-popover\" role=\"button\" data-container=\"body\" data-toggle=\"popover\" data-trigger=\"focus\" data-placement=\"top\" data-content=\"${views.report['rakeback.help.actual']}\" ><i class=\"fa fa-question-circle\"></i></span>"></c:set>
            <soul:orderColumn poType="${poType}" property="rakebackActual" column="${tips2} ${views.fund['rakebackwater.haspaid']}"></soul:orderColumn>

        <%--<soul:orderColumn poType="${poType}" property="rakebackTotal" column="${views.column['SettlementBackwater.backwaterTotal']}"></soul:orderColumn>
            <soul:orderColumn poType="${poType}" property="rakebackActual" column="${views.column['SettlementBackwater.backwaterActual']}"></soul:orderColumn>--%>
            <%--<th>${views.column['SettlementBackwater.backwaterTotal']}</th>
            <th>${views.column['SettlementBackwater.backwaterActual']}</th>--%>
            <th>${views.common['status']}</th>
            <th>${views.common['operate']}</th>
        </tr>
        </thead>
        <tbody>
        <c:set var="rakebackTotal" value="0"/>
        <c:set var="rakebackActual" value="0"/>
        <c:forEach items="${command.result}" var="i">
            <c:set var="rakebackTotal" value="${rakebackTotal+i.rakebackTotal}"/>
            <c:set var="rakebackActual" value="${rakebackActual+i.rakebackPaid}"/>
            <tr>
                <td>
                    <shiro:hasPermission name="role:player_detail"><a href="/player/playerView.html?search.id=${i.playerId}" nav-target="mainFrame"></shiro:hasPermission>
                    ${i.username}
                        <shiro:hasPermission name="role:player_detail"></a></shiro:hasPermission>
                    <c:if test="${i.riskMarker}">
                        <span class="ico-lock co-red3"><i class="fa fa-warning"></i></span>
                    </c:if>
                    <a href="/fund/playerDetect/userPlayView.html?search.username=${i.username}" class="m-l-sm" nav-target="mainFrame">${views.common['detection']}</a>
                </td>
                <td>${i.rankName}</td>
                <!--api返水-->
                <c:forEach items="${command.tabTitles}" var="t" varStatus="vs">
                    <c:choose>
                        <c:when test="${!empty t.gameType}">
                            <c:if test="${t.state}">
                                <td>${soulFn:formatCurrency(map[i.playerId][t.id].backwater)}</td>
                            </c:if>
                            <c:forEach items="${t.gameType}" var="j">
                                <td>${empty map[i.playerId][t.id].gameTypeWater[j]?'0.00':soulFn:formatCurrency(map[i.playerId][t.id].gameTypeWater[j])}</td>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <td>${soulFn:formatCurrency(map[i.playerId][t.id].backwater)}</td>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <td style="padding-left: 40px">${soulFn:formatCurrency(i.rakebackTotal)}</td>
                <td style="padding-left: 40px">${soulFn:formatCurrency(i.rakebackPaid)}</td>
                <td>
                    <span class="label  ${i.settlementState=='reject_lssuing'?'label-danger':''}  ${i.settlementState=='pending_lssuing'?'label-warning':''}">
                        ${dicts.operation.settlement_state[i.settlementState]}
                    </span>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${i.settlementState=='lssuing'}">
                            <a href="/operation/rakebackBill/backwaterDetail.html?search.id=${i.id}" nav-target="mainFrame">${views.common['detail']}</a>
                        </c:when>
                        <c:otherwise>
                            --
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>
        <tr>
            <th>${views.operation['backwater.settlement.pageTotal']}</th>
            <td></td>
            <c:forEach items="${command.tabTitles}" var="i" varStatus="vs">
                <c:choose>
                    <c:when test="${!empty i.gameType}">
                        <c:if test="${i.state}">
                            <td>
                                <c:set var="money" value="0"></c:set>
                                <c:forEach items="${command.result}" var="k">
                                    <c:set var="money" value="${money+map[k.playerId][i.id].backwater}"></c:set>
                                </c:forEach>
                                    ${money==0?'0.00':soulFn:formatCurrency(money)}
                            </td>
                        </c:if>
                        <c:forEach items="${i.gameType}" var="j">
                            <td>
                                <c:set var="money" value="0"></c:set>
                                <c:forEach items="${command.result}" var="k">
                                    <c:set var="money" value="${money+map[k.playerId][i.id].gameTypeWater[j]}"></c:set>
                                </c:forEach>
                                    ${money==0?'0.00':soulFn:formatCurrency(money)}
                            </td>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <td>
                            <c:set var="money" value="0"></c:set>
                            <c:forEach items="${command.result}" var="k">
                                <c:set var="money" value="${money+map[k.playerId][i.id].backwater}"></c:set>
                            </c:forEach>
                                ${money==0?'0.00':soulFn:formatCurrency(money)}
                        </td>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <td style="padding-left: 40px">${rakebackTotal==0?'0.00':soulFn:formatCurrency(rakebackTotal)}</td>
            <td style="padding-left: 40px">${rakebackActual==0?'0.00':soulFn:formatCurrency(rakebackActual)}</td>
            <td></td>
            <td></td>
        </tr>
    </table>
</div>
<soul:pagination/>
