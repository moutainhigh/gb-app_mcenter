<%@ page import="so.wwb.gamebox.model.master.operation.po.RakebackBill" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.RakebackBillListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="poType" value="<%=RakebackBill.class%>"></c:set>
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th>${views.column['SettlementBackwater.settlementName']}</th>
            <th>${views.column['SettlementBackwater.startTime']}</th>
            <th>${views.column['SettlementBackwater.playerPendingCount']}/${views.column['SettlementBackwater.playerLssuingCount']}/${views.column['SettlementBackwater.playerRejectCount']}</th>
            <%--<soul:orderColumn poType="${poType}" property="rakebackTotal" column="${views.column['SettlementBackwater.backwaterTotal']}"></soul:orderColumn>
            <soul:orderColumn poType="${poType}" property="rakebackActual" column="${views.column['SettlementBackwater.backwaterActual']}"></soul:orderColumn>--%>
            <th>
                ${views.column['SettlementBackwater.backwaterTotal']}
                <span tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                    data-content="${views.report['rakeback.help.total']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
            </th>
            <th>
                ${views.column['SettlementBackwater.backwaterActual']}
                <span tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                        data-content="${views.report['rakeback.help.actual']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
            </th>
            <th class="inline">
                <gb:select name="search.lssuingState" prompt="${views.common['all']}"
                           cssClass="btn-group chosen-select-no-single" list="${lssuingStates}" listKey="key"
                           listValue="${dicts.operation.lssuing_state[key]}" value="${command.search.lssuingState}" callback="query"/>
            </th>
            <th>${views.common['operate']}</th>
        </tr>
        </thead>
        <tbody>
            <c:forEach items="${command.result}" var="i">
                <tr>
                    <td>
                        ${i.settlementName}
                    </td>
                    <td>${soulFn:formatDateTz(i.startTime, DateFormat.DAY,timeZone)} ~ ${soulFn:formatDateTz(i.endTime, DateFormat.DAY,timeZone)}</td>
                    <td>
                        <c:choose>
                            <c:when test="${(i.playerCount-i.playerLssuingCount-i.playerRejectCount) eq 0}">
                                ${i.playerCount-i.playerLssuingCount-i.playerRejectCount}
                            </c:when>
                            <c:otherwise>
                                <a href="/operation/rakebackBill/backwaterView.html?search.rakebackBillId=${i.id}&search.settlementState=pending_lssuing" nav-target="mainFrame">${i.playerCount-i.playerLssuingCount-i.playerRejectCount}</a>
                            </c:otherwise>
                        </c:choose>
                        /
                        <c:choose>
                            <c:when test="${i.playerLssuingCount eq 0}">
                                ${i.playerLssuingCount}
                            </c:when>
                            <c:otherwise>
                                <a href="/operation/rakebackBill/backwaterView.html?search.rakebackBillId=${i.id}&search.settlementState=lssuing" nav-target="mainFrame">${i.playerLssuingCount}</a>
                            </c:otherwise>
                        </c:choose>
                        /
                        <c:choose>
                            <c:when test="${i.playerRejectCount eq 0}">
                                ${i.playerRejectCount}
                            </c:when>
                            <c:otherwise>
                                <a href="/operation/rakebackBill/backwaterView.html?search.rakebackBillId=${i.id}&search.settlementState=reject_lssuing" nav-target="mainFrame">${i.playerRejectCount}</a>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${soulFn:formatCurrency(i.rakebackTotal)}</td>
                    <td>${soulFn:formatCurrency(i.rakebackActual)}</td>
                    <td><span class="label ${i.lssuingState=='pending_pay'?'label-orange':''} ${i.lssuingState=='part_pay'?'label-success':''}">${dicts.operation.lssuing_state[i.lssuingState]}</span></td>
                    <td>
                        <a href="/operation/rakebackBill/backwaterView.html?search.rakebackBillId=${i.id}" nav-target="mainFrame">${views.common['detail']}</a>
                        <c:if test="${i.lssuingState!='all_pay'}">
                            <span class="dividing-line m-r-xs m-l-xs">|</span>
                            <shiro:hasPermission name="operate:rakeback_settle">
                                <a href="/operation/rakebackBill/settlement.html?search.rakebackBillId=${i.id}" nav-target="mainFrame">${views.common['clearing']}</a>
                            </shiro:hasPermission>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
<soul:pagination/>