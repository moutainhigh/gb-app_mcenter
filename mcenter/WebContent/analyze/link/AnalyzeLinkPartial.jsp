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
            <th >${views.analyze['推广链接']}</th>
            <th>${views.analyze['代理账号']}</th>
            <soul:orderColumn poType="${poType}" property="agentNewPlayerCount" column='
            <span
                        tabindex="0" class="m-l-sm help-popover" role="button" data-container="body"
                        data-toggle="popover" data-trigger="focus" data-placement="top"
                        data-content="${views.analyze[\'筛选时间段内，这个代理旗下新增的玩家\']}" data-original-title="" title=""><i
                        class="fa fa-question-circle"></i>
                </span>
            ${views.analyze[\'新增玩家\']}'/>
            <th>
                <span
                        tabindex="0" class="m-l-sm help-popover analyze" role="button" data-container="body"
                        data-toggle="popover" data-trigger="focus" data-placement="top"
                        data-content="${fn:replace(fn:replace(fn:replace(views.analyze['筛选时间段内'],"[0]" , command.depositParam.paramValue),"[1]" , command.depositCountParam.paramValue),"[2]" ,command.effectiveParam.paramValue )}" data-original-title="" title=""><i
                        class="fa fa-question-circle"></i>
            </span>
                ${views.analyze['有效新增玩家']}
                <soul:button target="effectivePlayerCountAll" text="${views.analyze['分析']}" opType="function"/></th>
            </th>
            <soul:orderColumn poType="${poType}" property="agentNewDepositPlayerCount" column='
            <span
                        tabindex="0" class="m-l-sm help-popover analyze" role="button" data-container="body"
                        data-toggle="popover" data-trigger="focus" data-placement="top"
                        data-content="${views.analyze[\'筛选时间段内，这个代理旗下各天新增玩家里\']}<br/><span class=\'co-grayc2\'>PS:${views.analyze[\'仅统计“免稽核”和“存款稽核”类的“派彩/其他“订单;\']}</span>" data-original-title="" title=""><i
                class="fa fa-question-circle"></i>
            </span>
            ${views.analyze[\'新增存款玩家\']}'/>
            <soul:orderColumn poType="${poType}" property="agentNewPlayerDepositCount" column='
            <span
                tabindex="0" class="m-l-sm help-popover analyze" role="button" data-container="body"
                data-toggle="popover" data-trigger="focus" data-placement="top"
                data-content="${views.analyze[\'筛选时间段内，这个代理旗下各天新增玩家\']}<br/><span class=\'co-grayc2\'>PS:${views.analyze[\'仅统计“免稽核”和“存款稽核”类的“派彩/其他“订单;\']}</span>"
                data-original-title="" title=""><i
                class="fa fa-question-circle"></i>
            </span>
            ${views.analyze[\'新玩家存款\']}'/>
            <soul:orderColumn poType="${poType}" property="agentNewPlayerWithdrawCount" column='
            <span
                tabindex="0" class="m-l-sm help-popover analyze" role="button" data-container="body"
                data-toggle="popover" data-trigger="focus" data-placement="top"
                data-content="${views.analyze[\'筛选时间\']}" data-original-title="" title=""><i
                class="fa fa-question-circle"></i>
            </span>
            ${views.analyze[\'新玩家取款\']}'/>
            <soul:orderColumn poType="${poType}" property="allDepositPlayerCount" column='
            <span
                tabindex="0" class="m-l-sm help-popover analyze" role="button" data-container="body"
                data-toggle="popover" data-trigger="focus" data-placement="top"
                data-content="${views.analyze[\'筛选时间段内，这个代理旗下各天有进行存\']}<br/><span class=\'co-grayc2\'>PS:${views.analyze[\'仅统计“免稽核”和“存款稽核”类的“派彩/其他“订单;\']}</span>" data-original-title="" title=""><i
                class="fa fa-question-circle"></i>
            </span>
                ${views.analyze[\'总存款玩家/天次\']}'/>
            <soul:orderColumn poType="${poType}" property="allDepositCount" column='
            <span
                tabindex="0" class="m-l-sm help-popover analyze" role="button" data-container="body"
                data-toggle="popover" data-trigger="focus" data-placement="top"
                data-content="${views.analyze[\'筛选时间段内，这个代理旗下玩家存款总额\']}<br/><span class=\'co-grayc2\'>PS：${views.analyze[\'仅统计“免稽核”和“存款稽核”类的“派彩/其他“订单;\']}</span>" data-original-title="" title=""><i
                class="fa fa-question-circle"></i>
            </span>
            ${views.analyze[\'存款总额\']}'/>
            <soul:orderColumn poType="${poType}" property="allWithdrawCount" column='
            <span
                tabindex="0" class="m-l-sm help-popover analyze" role="button" data-container="body"
                data-toggle="popover" data-trigger="focus" data-placement="top"
                data-content="${views.analyze[\'筛选时间段内,这个\']}" data-original-title="" title=""><i
                class="fa fa-question-circle"></i>
            </span>
            ${views.analyze[\'取款总额\']}'/>
            <soul:orderColumn poType="${poType}" property="payoutAmount" column='
            <span
                tabindex="0" class="m-l-sm help-popover analyze" role="button" data-container="body"
                data-toggle="popover" data-trigger="focus" data-placement="top"
                data-content="${views.analyze_auto[\'这个代理旗下玩家总派彩\']}" data-original-title="" title=""><i
                class="fa fa-question-circle"></i>
            </span>
            ${views.analyze[\'损益\']}'/>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <tr>
                <td>${(command.paging.pageNumber - 1) * command.paging.pageSize + status.count}</td>
                <td>${p.promoteLink}</td>
                <td><a href="/userAgent/agent/detail.html?search.id=${p.agentId}" nav-target="mainFrame" class="co-blue">${p.agentName}</a></td>
                <td><a href="/player/list.html?search.hasReturn=true&search.agentId=${p.agentId}&search.createTimeBegin=${soulFn:formatDateTz(command.search.startStaticTime,DateFormat.DAY_SECOND,timeZone)}&search.createTimeEnd=${soulFn:formatDateTz(command.search.endStaticTime,DateFormat.DAY_SECOND ,timeZone )}&search.registerSite=${p.promoteLink}" nav-target='mainFrame'>${p.agentNewPlayerCount}</a></td>
                <%--<td>${p.agentNewEffectivePlayerCount}</td>--%>
                <td data-value="&search.promoteLink=${p.promoteLink}&search.agentId=${p.agentId}"><a href="/player/list.html?search.hasReturn=true&search.agentId=${p.agentId}&startTime=${soulFn:formatDateTz(command.search.startStaticTime,DateFormat.DAY_SECOND,timeZone)}&endTime=${soulFn:formatDateTz(command.search.endStaticTime,DateFormat.DAY_SECOND ,timeZone )}&rechargeCount=${command.depositParam.paramValue}&rechargeTotal=${command.depositCountParam.paramValue}&totalEffectiveVolume=${command.effectiveParam.paramValue}&analyzeNewAgent=true&searchType=2&promoteLink=${p.promoteLink}" nav-target='mainFrame'></a>
                    <soul:button target="effectivePlayerCount" text="${views.analyze['分析']}" opType="function" cssClass="analyzeButton"/>
                </td>
                <td><a href="/player/list.html?search.hasReturn=true&search.agentId=${p.agentId}&startTime=${soulFn:formatDateTz(command.search.startStaticTime,DateFormat.DAY_SECOND,timeZone)}&endTime=${soulFn:formatDateTz(command.search.endStaticTime,DateFormat.DAY_SECOND ,timeZone )}&analyzeNewAgent=true&searchType=3&promoteLink=${p.promoteLink}" nav-target='mainFrame'>${p.agentNewDepositPlayerCount}</a></td>
                <td><a href="/report/vPlayerFundsRecord/fundsLog.html?search.hasReturn=true&search.agentid=${p.agentId}&analyzeStartTime=${soulFn:formatDateTz(command.search.startStaticTime,DateFormat.DAY_SECOND,timeZone)}&analyzeEndTime=${soulFn:formatDateTz(command.search.endStaticTime,DateFormat.DAY_SECOND ,timeZone )}&analyzeNewAgent=true&searchType=1&promoteLink=${p.promoteLink}" nav-target='mainFrame'>${soulFn:formatCurrency(p.agentNewPlayerDepositCount)}</a></td>
                <td><a href="/report/vPlayerFundsRecord/fundsLog.html?search.hasReturn=true&search.agentid=${p.agentId}&analyzeStartTime=${soulFn:formatDateTz(command.search.startStaticTime,DateFormat.DAY_SECOND,timeZone)}&analyzeEndTime=${soulFn:formatDateTz(command.search.endStaticTime,DateFormat.DAY_SECOND ,timeZone )}&analyzeNewAgent=true&searchType=2&promoteLink=${p.promoteLink}" nav-target='mainFrame'>${soulFn:formatCurrency(p.agentNewPlayerWithdrawCount)}</a></td>
                <td>${p.allDepositPlayerCount}</td>
                <td><a href="/report/vPlayerFundsRecord/fundsLog.html?search.hasReturn=true&search.agentid=${p.agentId}&analyzeStartTime=${soulFn:formatDateTz(command.search.startStaticTime,DateFormat.DAY_SECOND,timeZone)}&analyzeEndTime=${soulFn:formatDateTz(command.search.endStaticTime,DateFormat.DAY_SECOND ,timeZone )}&analyzeNewAgent=true&searchType=3&promoteLink=${p.promoteLink}" nav-target='mainFrame'>${soulFn:formatCurrency(p.allDepositCount)}</a></td>
                <td><a href="/report/vPlayerFundsRecord/fundsLog.html?search.hasReturn=true&search.agentid=${p.agentId}&analyzeStartTime=${soulFn:formatDateTz(command.search.startStaticTime,DateFormat.DAY_SECOND,timeZone)}&analyzeEndTime=${soulFn:formatDateTz(command.search.endStaticTime,DateFormat.DAY_SECOND ,timeZone )}&analyzeNewAgent=true&searchType=4&promoteLink=${p.promoteLink}" nav-target='mainFrame'>${soulFn:formatCurrency(p.allWithdrawCount)}</a></td>
                <td>${soulFn:formatCurrency(p.payoutAmount)}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->

