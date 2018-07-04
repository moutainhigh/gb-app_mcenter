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
                ${views.analyze['新增有效玩家']}
                <soul:button target="effectivePlayerCountAll" text="${views.analyze_auto['分析']}" opType="function"/></th>
            <soul:orderColumn poType="${poType}" property="agentNewDepositPlayerCount" column='
            <span
                        tabindex="0" class="m-l-sm help-popover analyze" role="button" data-container="body"
                        data-toggle="popover" data-trigger="focus" data-placement="top"
                        data-content="${views.analyze[\'筛选时间段内，这个代理旗下各天新增玩家里\']}<br/><span class=\'co-grayc2\'>PS：${views.analyze[\'仅统计“免稽核”和“存款稽核”类的“派彩/其他“订单;\']}</span>" data-original-title="" title=""><i
                class="fa fa-question-circle"></i>
            </span>
            ${views.analyze[\'新增存款玩家\']}'/>
            <soul:orderColumn poType="${poType}" property="agentNewPlayerDepositCount" column='
            <span
                tabindex="0" class="m-l-sm help-popover analyze" role="button" data-container="body"
                data-toggle="popover" data-trigger="focus" data-placement="top"
                data-content="${views.analyze[\'筛选时间段内，这个代理旗下各天新增玩家\']}<br/><span class=\'co-grayc2\'>PS：${views.analyze[\'仅统计“免稽核”和“存款稽核”类的“派彩/其他“订单;\']}</span>"
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
                data-content="${views.analyze[\'筛选时间段内，这个代理旗下各天有进行存\']}<br/><span class=\'co-grayc2\'>PS：${views.analyze[\'仅统计“免稽核”和“存款稽核”类的“派彩/其他“订单;\']}</span>" data-original-title="" title=""><i
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
                <tr class="tab-detail">
                    <td>${(command.paging.pageNumber - 1) * command.paging.pageSize + status.count}</td>
                    <td><a href="/userAgent/agent/detail.html?search.id=${p.agentId}" nav-target="mainFrame" class="co-blue">${p.agentName}</a></td>
                    <td>
                        <soul:button target="${root}/player/popup/list.html.html?search.hasReturn=true&search.agentId=${p.agentId}&search.createTimeBegin=${soulFn:formatDateTz(command.timeStart,DateFormat.DAY,timeZone)}&search.createTimeEnd=${soulFn:formatDateTz(command.timeEnd,DateFormat.DAY ,timeZone )}" size="open-dialog-95p"
                                     callback="" text="" title="玩家" opType="dialog">
                            ${p.agentNewPlayerCount}
                        </soul:button>
                    </td>
                    <td data-value="&search.agentId=${p.agentId}">
                        <a href="/player/list.html?search.hasReturn=true&search.agentId=${p.agentId}&startTime=${soulFn:formatDateTz(command.timeStart,DateFormat.DAY,timeZone)}&endTime=${soulFn:formatDateTz(command.timeEnd,DateFormat.DAY ,timeZone )}&rechargeCount=${command.depositParam.paramValue}&rechargeTotal=${command.depositCountParam.paramValue}&totalEffectiveVolume=${command.effectiveParam.paramValue}&analyzeNewAgent=true&searchType=2" nav-target='mainFrame'></a>
                        <soul:button target="effectivePlayerCount" text="${views.analyze_auto['分析']}" opType="function" cssClass="analyzeButton"/>
                    </td>
                    <td>
                        <soul:button target="${root}/player/popup/list.html?search.hasReturn=true&search.agentId=${p.agentId}&startTime=${soulFn:formatDateTz(command.timeStart,DateFormat.DAY,timeZone)}&endTime=${soulFn:formatDateTz(command.timeEnd,DateFormat.DAY ,timeZone )}&analyzeNewAgent=true&searchType=3" size="open-dialog-95p"
                                     callback="" text="" title="玩家" opType="dialog">
                            ${p.agentNewDepositPlayerCount}
                        </soul:button>
                    </td>
                    <td>
                        <%--存款--%>
                        <%--<a href="/report/vPlayerFundsRecord/fundsLog.html?search.hasReturn=true&search.agentid=${p.agentId}&analyzeStartTime=${soulFn:formatDateTz(command.timeStart,DateFormat.DAY,timeZone)}&analyzeEndTime=${soulFn:formatDateTz(command.timeEnd,DateFormat.DAY ,timeZone )}&analyzeNewAgent=true&searchType=1&search.outer=-1" nav-target='mainFrame'>${soulFn:formatCurrency(p.agentNewPlayerDepositCount)}</a>--%>

                            <soul:button target="${root}/report/vPlayerFundsRecordLinkPopup/fundsRecord.html?linkType=analyzeNewAgent&search.agentid=${p.agentId}&analyzeStartTime=${soulFn:formatDateTz(command.timeStart,DateFormat.DAY,timeZone)}&analyzeEndTime=${soulFn:formatDateTz(command.timeEnd,DateFormat.DAY ,timeZone )}&analyzeNewAgent=true&searchType=1&search.outer=-1" size="open-dialog-95p"
                                         callback="" text="" title="" opType="dialog">
                                <span class="co-blue" id="rechargeCount">${soulFn:formatCurrency(p.agentNewPlayerDepositCount)}</span>
                            </soul:button>

                    </td>
                    <td>
                        <%--取款--%>
                        <%--<a href="/report/vPlayerFundsRecord/fundsLog.html?search.hasReturn=true&search.agentid=${p.agentId}&analyzeStartTime=${soulFn:formatDateTz(command.timeStart,DateFormat.DAY,timeZone)}&analyzeEndTime=${soulFn:formatDateTz(command.timeEnd,DateFormat.DAY ,timeZone )}&analyzeNewAgent=true&searchType=2&search.outer=-1" nav-target='mainFrame'>${soulFn:formatCurrency(p.agentNewPlayerWithdrawCount)}</a>--%>

                            <soul:button target="${root}/report/vPlayerFundsRecordLinkPopup/fundsRecord.html?linkType=analyzeNewAgent&search.agentid=${p.agentId}&analyzeStartTime=${soulFn:formatDateTz(command.timeStart,DateFormat.DAY,timeZone)}&analyzeEndTime=${soulFn:formatDateTz(command.timeEnd,DateFormat.DAY ,timeZone )}&analyzeNewAgent=true&searchType=2&search.outer=-1" size="open-dialog-95p"
                                         callback="" text="" title="" opType="dialog">
                                <span class="co-blue" id="rechargeCount">${soulFn:formatCurrency(p.agentNewPlayerWithdrawCount)}</span>
                            </soul:button>
                    </td>
                    <td>${p.allDepositPlayerCount}</td>
                    <td><%-- 存款总额--%>
                        <%--<a href="/report/vPlayerFundsRecord/fundsLog.html?search.hasReturn=true&search.agentid=${p.agentId}&analyzeStartTime=${soulFn:formatDateTz(command.timeStart,DateFormat.DAY,timeZone)}&analyzeEndTime=${soulFn:formatDateTz(command.timeEnd,DateFormat.DAY ,timeZone )}&analyzeNewAgent=true&searchType=3&search.outer=-1" nav-target='mainFrame'>${soulFn:formatCurrency(p.allDepositCount)}</a>--%>

                        <soul:button target="${root}/report/vPlayerFundsRecordLinkPopup/fundsRecord.html?linkType=analyzeNewAgent&search.agentid=${p.agentId}&analyzeStartTime=${soulFn:formatDateTz(command.timeStart,DateFormat.DAY,timeZone)}&analyzeEndTime=${soulFn:formatDateTz(command.timeEnd,DateFormat.DAY ,timeZone )}&analyzeNewAgent=true&searchType=3&search.outer=-1" size="open-dialog-95p"
                                     callback="" text="" title="" opType="dialog">
                            <span class="co-blue" id="rechargeCount">${soulFn:formatCurrency(p.allDepositCount)}</span>
                        </soul:button>

                    </td>
                    <td><%--取款总额 --%>
                        <%--<a href="/report/vPlayerFundsRecord/fundsLog.html?search.hasReturn=true&search.agentid=${p.agentId}&analyzeStartTime=${soulFn:formatDateTz(command.timeStart,DateFormat.DAY,timeZone)}&analyzeEndTime=${soulFn:formatDateTz(command.timeEnd,DateFormat.DAY ,timeZone )}&analyzeNewAgent=true&searchType=4&search.outer=-1" nav-target='mainFrame'>${soulFn:formatCurrency(p.allWithdrawCount)}</a>--%>


                        <soul:button target="${root}/report/vPlayerFundsRecordLinkPopup/fundsRecord.html?linkType=analyzeNewAgent&search.agentid=${p.agentId}&analyzeStartTime=${soulFn:formatDateTz(command.timeStart,DateFormat.DAY,timeZone)}&analyzeEndTime=${soulFn:formatDateTz(command.timeEnd,DateFormat.DAY ,timeZone )}&analyzeNewAgent=true&searchType=4&search.outer=-1" size="open-dialog-95p"
                                     callback="" text="" title="" opType="dialog">
                            <span class="co-blue" id="rechargeCount">${soulFn:formatCurrency(p.allWithdrawCount)}</span>
                        </soul:button>

                    </td>
                    <td>${soulFn:formatCurrency(p.payoutAmount)}</td>
                </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
