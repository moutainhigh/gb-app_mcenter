<%@ page import="so.wwb.gamebox.model.master.report.vo.UserPlayerFund" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.VPlayerFundsRecordListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set value="<%=UserPlayerFund.class%>" var="poType"></c:set>
<c:set value="" var="agent"></c:set>
<c:set value="" var="topagent"></c:set>
<c:if test="${empty command.search.fundSearch.agentName && command.search.userTypes == 'search.fundSearch.agentName'}">
    <c:set value="agent" var="agent"></c:set>
</c:if>
<c:if test="${empty command.search.fundSearch.topagentName && command.search.userTypes == 'search.fundSearch.topagentName'}">
    <c:set value="topagent" var="topagent"></c:set>
</c:if>
<!--//region your codes 1-->
<div class="dataTables_wrapper white-bg" role="grid">
    <div class="tab-content">
        <div class="table-responsive">
            <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
                <thead>
                <tr class="bg-gray">
                    <th colspan="9">
                        <span class="pull-left">${views.fund['资金汇总']}</span>
                    </th>
                </tr>
                <tr>
                    <th>
                        <span title="" data-original-title="" data-content="${views.fund['存款金额提示']}" data-html="true" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover m-l-sm" tabindex="0"><i class="fa fa-question-circle"></i></span>
                        ${views.player_auto['存款金额']}
                    </th>
                    <th>
                        <span title="" data-original-title="" data-content="${views.fund['取款金额提示']}" data-html="true" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover m-l-sm" tabindex="0"><i class="fa fa-question-circle"></i></span>
                        ${views.player_auto['取款金额']}
                    </th>
                    <th>
                        <span title="" data-original-title="" data-content="${views.fund['优惠金额提示']}" data-html="true" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover m-l-sm" tabindex="0"><i class="fa fa-question-circle"></i></span>
                        ${views.player_auto['优惠金额']}
                    </th>
                    <th>
                        <span title="" data-original-title="" data-content="${views.fund['返水金额提示']}" data-html="true" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover m-l-sm" tabindex="0"><i class="fa fa-question-circle"></i></span>
                        ${views.player_auto['返水金额']}
                    </th>
                    <th>${views.player_auto['有效投注额']}</th>
                    <th>${views.player_auto['损益']}</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <c:set var="m" value="${command.fundTotalMap}"/>
                    <td>${soulFn:formatCurrency(m.get('depositamounttotal'))}</td>
                    <td>${soulFn:formatCurrency(m.get('withdrawamounttotal'))}</td>
                    <td>${soulFn:formatCurrency(m.get('favorableamounttotal'))}</td>
                    <td>${soulFn:formatCurrency(m.get('rakebackamounttotal'))}</td>
                    <td>${soulFn:formatCurrency(m.get('effectivetransactiontotal'))}</td>
                    <td>${soulFn:formatCurrency(m.get('profitlosstotal'))}</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
        <thead>
            <tr role="row" class="bg-gray">
                <th>${views.common['number']}</th>
                <th>${views.fund['账号']}</th>
                <c:if test="${empty agent && empty topagent}">
                    <soul:orderColumn poType="${poType}" property="createTime" column="${views.player_auto['注册时间']}"></soul:orderColumn>
                </c:if>
                <soul:orderColumn poType="${poType}" property="depositCount" column="${views.player_auto['存款次数']}"></soul:orderColumn>
                <soul:orderColumn poType="${poType}" property="depositAmount" column="${views.player_auto['存款金额']}"></soul:orderColumn>
                <soul:orderColumn poType="${poType}" property="withdrawCount" column="${views.player_auto['取款次数']}"></soul:orderColumn>
                <soul:orderColumn poType="${poType}" property="withdrawAmount" column="${views.player_auto['取款金额']}"></soul:orderColumn>
                <soul:orderColumn poType="${poType}" property="favorableAmount" column="${views.player_auto['优惠金额']}"></soul:orderColumn>
                <soul:orderColumn poType="${poType}" property="rakebackAmount" column="${views.player_auto['返水金额']}"></soul:orderColumn>
                <soul:orderColumn poType="${poType}" property="effectiveTransaction" column="${views.player_auto['有效投注额']}"></soul:orderColumn>
                <soul:orderColumn poType="${poType}" property="profitLoss" column="${views.player_auto['损益']}"></soul:orderColumn>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${command.fundList}" var="p" varStatus="status">
                <tr class="tab-detail">
                    <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                    <td>
                        <c:choose>
                            <c:when test="${!empty agent}">
                                <a href="/userAgent/agent/detail.html?search.id=${p.agentId}" nav-target="mainFrame">${p.playerName}</a>
                            </c:when>
                            <c:when test="${!empty topagent}">
                                <a href="/userAgent/topagent/detail.html?search.id=${p.topagentId}" nav-target="mainFrame">${p.playerName}</a>
                            </c:when>
                            <c:otherwise>
                                <shiro:hasPermission name="role:player_detail">
                                    <a href="/player/playerView.html?search.id=${p.id}" nav-target="mainFrame">${p.playerName}</a>
                                </shiro:hasPermission>
                            </c:otherwise>
                        </c:choose>
                        ${gbFn:riskImgByName(p.playerName)}

                    </td>
                    <c:if test="${empty agent && empty topagent}">
                        <td>${soulFn:formatDateTz(p.createTime, DateFormat.DAY_SECOND, timeZone)}</td>
                    </c:if>
                    <th>${p.depositCount}</th>
                    <th>${soulFn:formatCurrency(p.depositAmount)}</th>
                    <th>${p.withdrawCount}</th>
                    <th>${soulFn:formatCurrency(p.withdrawAmount)}</th>
                    <th>${soulFn:formatCurrency(p.favorableAmount)}</th>
                    <th>${soulFn:formatCurrency(p.rakebackAmount)}</th>
                    <th>${soulFn:formatCurrency(p.effectiveTransaction)}</th>
                    <th>${soulFn:formatCurrency(p.profitLoss)}</th>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
