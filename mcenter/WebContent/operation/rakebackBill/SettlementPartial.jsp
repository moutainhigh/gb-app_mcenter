<%@ page import="so.wwb.gamebox.model.master.operation.po.RakebackPlayer" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.RakebackPlayerListVo"--%>
<%--@elvariable id="map" type="java.util.MapMap<java.lang.Integer, Map<java.lang.Integer,so.wwb.gamebox.model.master.operation.vo.BackwaterApi>>"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="poType" value="<%=RakebackPlayer.class%>"></c:set>
<div class="table-responsive table-min-h">
    <textarea style="display: none" name="originData">${command.originData}</textarea>
    <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th><c:if test="${fn:length(command.result)>0}"><input type="checkbox" class="i-checks" id="ichecks_0"></c:if></th>
            <th>${views.operation['backwater.settlement.username']}</th>
            <th>
                <gb:select name="search.rankId" prompt="${views.operation['backwater.settlement.allRank']}" cssClass="btn-group chosen-select-no-single" list="${ranks}" value="${command.search.rankId}" listKey="id" listValue="rankName" callback="query"/>
            </th>
            <c:set var="tabLen" value="0"/>
            <c:forEach items="${command.tabTitles}" var="i" varStatus="vs">
                <c:choose>
                    <c:when test="${!empty i.gameType}">
                        <c:if test="${i.state}">
                            <th>${gbFn:getSiteApiName(i.id.toString())}</th>
                            <c:set var="tabLen" value="${tabLen+1}"/>
                        </c:if>
                        <c:forEach items="${i.gameType}" var="j">
                            <th>${gbFn:getSiteApiName(i.id.toString())}<br>${gbFn:getGameTypeName(j)}</th>
                            <c:set var="tabLen" value="${tabLen+1}"/>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <th>${gbFn:getSiteApiName(i.id.toString())}</th>
                        <c:set var="tabLen" value="${tabLen+1}"/>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:set value="<span tabindex=\"0\" class=\"m-l-sm help-popover\" role=\"button\" data-container=\"body\" data-toggle=\"popover\" data-trigger=\"focus\" data-placement=\"top\" data-content=\"${views.report['rakeback.help.total']}\"><i class=\"fa fa-question-circle\"></i></span>" var="tips1"></c:set>
            <soul:orderColumn poType="${poType}" property="rakebackTotal" column="${tips1} ${views.column['SettlementBackwater.backwaterTotal']}"></soul:orderColumn>
            <soul:orderColumn poType="${poType}" property="rakebackPaid" column="${views.fund['rakebackwater.haspaid']}"></soul:orderColumn>
            <c:set var="tips2" value="<span tabindex=\"0\" class=\"m-l-sm help-popover\" role=\"button\" data-container=\"body\" data-toggle=\"popover\" data-trigger=\"focus\" data-placement=\"top\" data-content=\"${views.report['rakeback.help.paythistime']}\" ><i class=\"fa fa-question-circle\"></i></span>"></c:set>
            <soul:orderColumn poType="${poType}" property="rakebackActual" column="${tips2} ${views.fund['rakebackwater.paythistime']}"></soul:orderColumn>
            <soul:orderColumn poType="${poType}" property="rakebackPending" column="${views.fund['rakebackwater.pendingpay']}"></soul:orderColumn>
        <%--<soul:orderColumn poType="${poType}" property="rakebackTotal" column="${views.column['SettlementBackwater.backwaterTotal']}"></soul:orderColumn>
            <soul:orderColumn poType="${poType}" property="rakebackActual" column="${views.column['SettlementBackwater.backwaterActual']}"></soul:orderColumn>--%>
            <%--<th>${views.column['SettlementBackwater.backwaterTotal']}</th>
            <th>${views.column['SettlementBackwater.backwaterActual']}</th>--%>
        </tr>
        <tr class="bd-none hide">
            <th colspan="${tabLen+5}">
                <div class="select-records">
                    <i class="fa fa-exclamation-circle"></i>
                    ${views.role['player.cancelSelectAll.prefix']}&nbsp;
                    <span id="page_selected_total_record"></span>${views.role['player.cancelSelectAll.middlefix']}
                    <soul:button target="cancelSelectAll" opType="function" text="${views.role['player.cancelSelectAll']}"/>${views.role['player.cancelSelectAll.suffix']}
                </div>
            </th>
        </tr>
        </thead>
        <tbody>
        <c:set var="rakebackTotal" value="0"/>
        <c:set var="rakebackActual" value="0"/>
        <c:set var="rakebackPaid" value="0"/>
        <c:set var="rakebackPending" value="0"/>

        <c:forEach items="${command.result}" var="i">
            <c:set var="rakebackTotal" value="${rakebackTotal+i.rakebackTotal}"/>
            <c:set var="rakebackActual" value="${rakebackActual+i.rakebackActual}"/>
            <c:set var="rakebackPaid" value="${rakebackPaid+i.rakebackPaid}"/>
            <c:set var="rakebackPending" value="${rakebackPending+i.rakebackPending}"/>
            <tr>
                <td><input type="checkbox" id="ichecks_item_${i.id}" class="i-checks" value="${i.id}"></td>
                <td>
                    <shiro:hasPermission name="role:player_detail">
                    <a href="/player/playerView.html?search.id=${i.playerId}" nav-target="mainFrame">
                    </shiro:hasPermission>
                    ${i.username}
                    <shiro:hasPermission name="role:player_detail"></a>${gbFn:riskImgByName(i.username)}
                        </shiro:hasPermission>
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
                <td>${soulFn:formatCurrency(i.rakebackPaid)}</td>
                <td style="padding-left: 25px">
                    <soul:button target="${root}/operation/rakebackBill/editBackwaterActual.html?search.id=${i.id}"
                                 text=""
                                 title="${views.operation['backwater.update.actual']}"
                                 opType="dialog"
                                 callback="query">
                        <span class="fa fa-pencil"></span>
                        ${soulFn:formatCurrency(i.rakebackActual)}
                    </soul:button>
                </td>
                <td>${soulFn:formatCurrency(i.rakebackPending)}</td>
            </tr>
        </c:forEach>
        <tr>
            <th>${views.operation['backwater.settlement.pageTotal']}</th>
            <td></td>
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
            <td style="">${rakebackActual==0?'0.00':soulFn:formatCurrency(rakebackPaid)}</td>
            <td style="padding-left: 40px">${rakebackActual==0?'0.00':soulFn:formatCurrency(rakebackActual)}</td>
            <td style="">${rakebackActual==0?'0.00':soulFn:formatCurrency(rakebackPending)}</td>
        </tr>
        </tbody>
    </table>
</div>
<soul:pagination />
