<%@ page import="so.wwb.gamebox.model.master.analyze.po.VAnalyzePlayer" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.analyze.vo.VAnalyzePlayerListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="poType" value="<%= VAnalyzePlayer.class %>"></c:set>
<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable" id="editable" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th>${views.analyze['序号']}</th>
            <th >${views.analyze['代理账号']}</th>
            <soul:orderColumn poType="${poType}" property="agentNewPlayerCount" column='${views.analyze_auto[\'玩家总数\']}'/>
            <%--<soul:orderColumn poType="${poType}" property="agentNewEffectivePlayerCount" column='${views.analyze_auto['总有效玩家']}'/>--%>
            <soul:orderColumn poType="${poType}" property="agentNewDepositPlayerCount" column='${views.analyze_auto[\'总存款玩家\']}'/>
            <soul:orderColumn poType="${poType}" property="allDepositCount" column='${views.analyze_auto[\'存款总额\']}'/>
            <soul:orderColumn poType="${poType}" property="allWithdrawCount" column='${views.analyze_auto[\'取款总额\']}'/>
            <soul:orderColumn poType="${poType}" property="payoutAmount" column='
            <span
                tabindex="0" class="m-l-sm help-popover analyze" role="button" data-container="body"
                data-toggle="popover" data-trigger="focus" data-placement="top"
                data-content="${views.analyze_auto[\'这个代理旗下玩家总派彩\']}" data-original-title="" title=""><i
                class="fa fa-question-circle"></i>
            </span>
            ${views.analyze_auto[\'损益\']}'/>
            <soul:orderColumn poType="${poType}" property="difference" column='
            <span
                tabindex="0" class="m-l-sm help-popover analyze" role="button" data-container="body"
                data-toggle="popover" data-trigger="focus" data-placement="top"
                data-content="${views.analyze_auto[\'这个代理旗下玩家的存款总额\']}；" data-original-title="" title=""><i
                class="fa fa-question-circle"></i>
            </span>
            ${views.analyze_auto[\'存取差额\']}'/>

            <%--<soul:orderColumn poType="${poType}" property="accountBalance" column='${views.analyze_auto['账户余额']}'/>--%>

            <soul:orderColumn poType="${poType}" property="rebateActual" column='${views.analyze_auto[\'返佣总额\']}'/>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="p" varStatus="status">
                <tr class="tab-detail">
                    <td>${(command.paging.pageNumber - 1) * command.paging.pageSize + status.count}</td>
                    <td><a href="/userAgent/agent/detail.html?search.id=${p.agentId }" nav-target="mainFrame" class="co-blue">${p.agentName}</a></td>
                    <td>${p.agentNewPlayerCount}</td>
                    <%--<td>${p.agentNewEffectivePlayerCount}</td>--%>
                    <td>
                        <soul:button target="${root}/player/popup/list.html.html?search.hasReturn=true&search.agentId=${p.agentId}&analyzeNewAgent=true&searchType=1" size="open-dialog-95p"
                                     callback="" text="" title="玩家" opType="dialog">
                            ${p.agentNewDepositPlayerCount}
                        </soul:button>
                    </td>
                    <td>
                        <%--<a href="/report/vPlayerFundsRecord/fundsLog.html?search.agentid=${p.agentId}&search.transactionType=deposit&analyzeNewAgent=true&searchType=5" nav-target="mainFrame" class="co-blue">${soulFn:formatCurrency(p.allDepositCount)}</a>--%>

                    <soul:button target="${root}/report/vPlayerFundsRecordLinkPopup/fundsRecord.html?linkType=analyzeNewAgent&search.agentid=${p.agentId}&search.transactionType=deposit&analyzeNewAgent=true&searchType=5" size="open-dialog-95p"
                                 callback="" text="" title="" opType="dialog">
                        <span class="co-blue" id="rechargeCount">${soulFn:formatCurrency(p.allDepositCount)}</span>
                    </soul:button>
                    </td>
                    <td>
                        <%--<a href="/report/vPlayerFundsRecord/fundsLog.html?search.agentid=${p.agentId}&search.transactionType=withdraw&analyzeNewAgent=true&searchType=6" nav-target="mainFrame" class="co-blue">${soulFn:formatCurrency(p.allWithdrawCount)}</a>--%>

                        <soul:button target="${root}/report/vPlayerFundsRecordLinkPopup/fundsRecord.html?linkType=analyzeNewAgent&search.agentid=${p.agentId}&search.transactionType=withdraw&analyzeNewAgent=true&searchType=6" size="open-dialog-95p"
                                     callback="" text="" title="" opType="dialog">
                            <span class="co-blue" id="rechargeCount">${soulFn:formatCurrency(p.allWithdrawCount)}</span>
                        </soul:button>


                    </td>
                    <td>${soulFn:formatCurrency(p.payoutAmount)}</td>
                    <td>${soulFn:formatCurrency(p.difference)}</td>
                    <%--<td>${soulFn:formatCurrency(p.accountBalance)}</td>--%>
                    <td>${soulFn:formatCurrency(p.rebateActual)}</td>
                </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
