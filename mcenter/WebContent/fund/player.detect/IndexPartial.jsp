<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:if test="${not empty error }">
    <div class="present_wrap"><b>${error}</b></div>
</c:if>
<c:if test="${not empty command1.result}">
    <input type="hidden" name="playerId" value="${command1.result.id}" class="form-control"/>
    <div class="detect-wrap clearfix p-sm">
        <div class="pull-left col-sm-5 p-x">
            <div class="line-hi25 col-sm-12">
                <b>${views.fund['playerDetect.view.agent']}：</b>
                <a href="/userAgent/topagent/detail.html?search.id=${command1.result.generalAgentId}" class="m-r-sm"
                   nav-target="mainFrame">${command1.result.generalAgentName}</a>&gt;
                <a href="/userAgent/agent/detail.html?search.id=${command1.result.agentId}" class="m-l-sm"
                   nav-target="mainFrame">${command1.result.agentName}</a>
            </div>
            <div class="line-hi25 col-sm-12">
                <b>${views.fund['playerDetect.view.playerAccount']}：</b>
                <a href="/player/playerView.html?search.id=${command1.result.id}" class="m-r-sm" nav-target="mainFrame">${command1.result.username}</a>
                <c:if test="${command1.result.onLineId>0}">
                    <i class="fa fa-flash" title="${views.fund_auto['在线']}"></i>
                </c:if>
                ${gbFn:riskImgById(command1.result.id)}
                <c:if test="${not empty command1.result.riskDataType}">
                    <soul:button text="${views.player_auto['添加风控人员至总控']}" opType="ajax"
                             target="${root}/player/addRiskToBoss.html?search.id=${command1.result.id}" />
                </c:if>
            </div>
                <%--<div class="line-hi25 col-sm-12"><b>${views.fund['playerDetect.view.area']}：</b>
                    ${dicts.region.region[command1.result.country]}-${dicts.state[command1.result.country][command1.result.region]}
                    <c:if test="${not empty command1.result.city}">-${dicts.city[(command1.result.country).concat("_").concat(command1.result.region)][command1.result.city]}</c:if>
                </div>--%>
            <div class="line-hi25 col-sm-12">
                <b>${views.fund['playerDetect.view.registTime']}：</b>${soulFn:formatDateTz(command1.result.createTime, DateFormat.DAY_SECOND,timeZone)}
            </div>
            <div class="line-hi25 col-sm-12"><b>${views.fund['playerDetect.view.rank']}：</b>
                <a href="/vPlayerRankStatistics/view.html?id=${command1.result.rankId}"
                   nav-target="mainFrame">${command1.result.rankName}</a>
                <c:if test="${command1.result.riskMarker}">
                    <span class="label label-danger m-l-sm">${views.fund['fund.playerDetect.index.dangerous']}</span>
                </c:if>
            </div>
        </div>
        <div class="pull-left col-sm-5 p-x">

            <div class="line-hi25 col-sm-12">
                <b>${views.fund['fund.playerDetect.index.ip']}<a
                    href="/player/list.html?search.registerIp=${command1.result.registerIp}&search.hasReturn=true"
                    nav-target="mainFrame">${soulFn:formatIp(command1.result.registerIp)}</a>
                </b>
                (${views.fund['fund.playerDetect.index.sameIP']}
                <c:choose>
                    <c:when test="${command1.repeatMap.registerIp gt 0}">
                        <a href="/player/list.html?search.registerIp=${command1.result.registerIp}&search.hasReturn=true"
                        nav-target="mainFrame"> <b class="fs13">&nbsp;${command1.repeatMap.registerIp}&nbsp;</b>
                    </a>
                    </c:when>
                    <c:otherwise><b
                        class="co-blue fs13">${command1.repeatMap.registerIp}</b>
                    </c:otherwise>
                </c:choose>${views.fund['fund.playerDetect.index.position']})
            </div>
            <div class="line-hi25 col-sm-12"><b>${views.fund['playerDetect.view.realName']}：</b>
                <c:if test="${ not empty command1.result.realName}">
                    <a href="/player/list.html?search.realName=${command1.convertRealName}&search.hasReturn=true"
                       nav-target="mainFrame">${command1.result.realName}</a>
                </c:if>
                (${views.fund['fund.playerDetect.index.sameName']}
                <c:choose>
                    <c:when test="${command1.repeatMap.realName gt 0}">
                        <a href="/player/list.html?search.realName=${command1.convertRealName}&search.hasReturn=true"
                            nav-target="mainFrame">
                            <b class="fs13">${command1.repeatMap.realName}</b>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <b class="fs13">&nbsp;${command1.repeatMap.realName}&nbsp;</b>
                    </c:otherwise>
                </c:choose>
                    ${views.fund['fund.playerDetect.index.position']})
            </div>
            <shiro:hasPermission name="role:player_personal_detail">
            <div class="line-hi25 col-sm-12"><b>${views.fund['playerDetect.view.phone']}：</b>
                <c:if test="${not empty command1.result.mobilePhone}">
                    <a href="/player/list.html?search.mobilePhone=${command1.result.mobilePhone}&search.hasReturn=true"
                       nav-target="mainFrame">
                            ${soulFn:overlayTel(command1.result.mobilePhone)}
                    </a>
                </c:if>
                (${views.fund['fund.playerDetect.index.sameNumber']}
                <c:choose>
                    <c:when test="${command1.repeatMap.mobilePhone gt 0}">
                        <a href="/player/list.html?search.mobilePhone=${command1.result.mobilePhone}&search.hasReturn=true"
                           nav-target="mainFrame">
                            <b class="fs13">${command1.repeatMap.mobilePhone}</b>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <b class="fs13">&nbsp;${command1.repeatMap.mobilePhone}&nbsp;</b>
                    </c:otherwise>
                </c:choose>
                ${views.fund['fund.playerDetect.index.individual']})
            </div>

            <div class="line-hi25 col-sm-12"><b>${views.fund['playerDetect.view.mail']}：</b>
                <c:if test="${not empty command1.result.mail}">
                    <a href="/player/list.html?search.mail=${command1.result.mail}&search.hasReturn=true"
                       nav-target="mainFrame">${soulFn:overlayEmaill(command1.result.mail)}</a>
                </c:if>
                (${views.fund['fund.playerDetect.index.sameEmail']}
                <c:choose>
                    <c:when test="${command1.repeatMap.mail gt 0}">
                            <a href="/player/list.html?search.mail=${command1.result.mail}&search.hasReturn=true"
                               nav-target="mainFrame">
                                <b class="fs13">${command1.repeatMap.mail}</b>
                            </a>
                    </c:when>
                    <c:otherwise>
                        <b class="fs13">&nbsp;${command1.repeatMap.mail}&nbsp;</b>
                    </c:otherwise>
                </c:choose>
                ${views.fund['fund.playerDetect.index.individual']})
            </div>
            </shiro:hasPermission>
        </div>
    </div>
    <div class="detect-wrap">
        <div class="fund-record">
                <%--  <%@include file="FundRecord.jsp"%>--%>
        </div>
        <div id="tab-1" class="">
            <table class="table dataTable m-b-none">
                <tbody>
                <tr>
                    <th class="bg-tbcolor" style="width: 120px;text-align: right">
                        <span tabindex="0" class="" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                          data-html="true" data-content="${views.fund_auto['包含人工存入的“人工存取/派彩/其他”']}；<br><span class='ps-color'>PS：${views.fund_auto['仅统计“免稽核”和“存款稽核”类的“派彩/其他“订单']}。</span>">
                                <i class="fa fa-question-circle"></i>
                        </span>
                        ${views.fund['playerDetect.view.totalDeposit']}：
                    </th>
                    <td style="width: 150px">
                        <a href="/report/vPlayerFundsRecord/fundsLog.html?search.outer=-1&search.transactionType=deposit&search.hasReturn=true&search.usernames=${command1.result.username}&search.userTypes=username" nav-target="mainFrame">
                            ${empty playerMoneyData.depositcounttime?'0':playerMoneyData.depositcounttime}
                        </a>
                    </td>
                    <th class="bg-tbcolor" style="width: 150px;text-align: right">${views.fund['playerDetect.view.totalDepositAmount']}：</th>
                    <td style="width: 150px">
                        <a href="/report/vPlayerFundsRecord/fundsLog.html?search.outer=-1&search.transactionType=deposit&search.hasReturn=true&search.usernames=${command1.result.username}&search.userTypes=username" nav-target="mainFrame">
                            ${empty playerMoneyData.deposittotalmoney?'0':playerMoneyData.deposittotalmoney}
                        </a>
                    </td>
                    <th class="bg-tbcolor" style="width: 150px;text-align: right">${views.fund['playerDetect.view.recentRecharge']}：</th>
                    <td>${soulFn:formatDateTz(transactionMap.despoit_time, DateFormat.DAY_SECOND,timeZone)}</td>
                </tr>
                <tr>
                    <th class="bg-tbcolor" style="text-align: right">
                        <span tabindex="0" class="" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                              data-html="true" data-content="${views.fund_auto['包含人工取出的所有类型']}。">
                                <i class="fa fa-question-circle"></i>
                        </span>
                        ${views.fund['playerDetect.view.totalWithdraw']}：
                    </th>
                    <td>
                        <a href="/report/vPlayerFundsRecord/fundsLog.html?search.outer=-1&search.hasReturn=true&search.usernames=${command1.result.username}&search.userTypes=username&search.transactionWays=<%=TransactionWayEnum.PLAYER_WITHDRAW.getCode()%>&search.manualWithdraws=<%=TransactionWayEnum.MANUAL_DEPOSIT.getCode()%>,<%=TransactionWayEnum.MANUAL_FAVORABLE.getCode()%>,<%=TransactionWayEnum.MANUAL_RAKEBACK.getCode()%>,<%=TransactionWayEnum.MANUAL_PAYOUT.getCode()%>,<%=TransactionWayEnum.MANUAL_OTHER.getCode()%>" nav-target="mainFrame">
                            ${empty playerMoneyData.withdrawcounttime?'0':playerMoneyData.withdrawcounttime}
                        </a>
                    </td>
                    <th class="bg-tbcolor" style="text-align: right">${views.fund['playerDetect.view.totalWithdrawAmount']}：</th>
                    <td>
                        <a href="/report/vPlayerFundsRecord/fundsLog.html?search.outer=-1&search.hasReturn=true&search.usernames=${command1.result.username}&search.userTypes=username&search.transactionWays=<%=TransactionWayEnum.PLAYER_WITHDRAW.getCode()%>&search.manualWithdraws=<%=TransactionWayEnum.MANUAL_DEPOSIT.getCode()%>,<%=TransactionWayEnum.MANUAL_FAVORABLE.getCode()%>,<%=TransactionWayEnum.MANUAL_RAKEBACK.getCode()%>,<%=TransactionWayEnum.MANUAL_PAYOUT.getCode()%>,<%=TransactionWayEnum.MANUAL_OTHER.getCode()%>" nav-target="mainFrame">
                            ${empty playerMoneyData.withdrawtotalmoney?'0':playerMoneyData.withdrawtotalmoney}
                        </a>
                    </td>
                    <th class="bg-tbcolor" style="text-align: right">${views.fund['playerDetect.view.recentWithdraw']}：</th>
                    <td>${soulFn:formatDateTz(transactionMap.withdraw_time, DateFormat.DAY_SECOND,timeZone)}</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="clearfix">
        <%--投注统计--%>
        <div class="detect-wrap col-xs-5" id="gameOrderDiv">
            <%@include file="GameOrder.jsp"%>
        </div>
        <%--优惠统计--%>
        <div class="detect-wrap col-xs-5" id="saleDiv" rakeback="${command1.result.rakeback}">
            <%@include file="Sale.jsp"%>
        </div>
    </div>

    <%--IP--%>
    <div id="loginIpDiv" class="detect-wrap">
        <%@ include file="LoginIpList.jsp" %>
    </div>
    <%--银行卡--%>
    <div id="bankDiv" class="detect-wrap search-list-container">
        <%@ include file="BankList.jsp" %>
    </div>
    <%--备注--%>
    <div id="remarkDiv" class="detect-wrap m-b-lg search-list-container" role="grid">
        <%@ include file="RemarkList.jsp" %>
    </div>
</c:if>