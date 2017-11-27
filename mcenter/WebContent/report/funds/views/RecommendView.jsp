<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-11-12
  Time: 下午9:51
--%>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.VPlayerTransactionVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="col-lg-12">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="co-gray6">${views.report['fund.detail.recommend']}</h3>
        </div>
        <div class="panel-body p-sm">
            <table class="table no-border table-desc-list">
                <tbody>
                <tr>
                    <td colspan="2" class="text-right">
                        ${views.report['fund.detail.transactionNo']}：${command.result.transactionNo}
                        <a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button"data-clipboard-text="${command.result.transactionNo}" name="copy">
                            <i class="fa fa-copy" title="${views.common['copy']}"></i>
                        </a>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="text-right">${views.report['fund.detail.playerAccount']}</th>
                    <td>
                        <shiro:hasPermission name="role:player_detail"><a href="/player/playerView.html?search.id=${command.result.playerId}" nav-target="mainFrame"></shiro:hasPermission>
                        ${command.result.username}
                        <shiro:hasPermission name="role:player_detail"></a></shiro:hasPermission>
                        <soul:button target="${root}/fund/withdraw/detect.html?playerId=${command.result.playerId}" text="${views.report_auto['检测']}" opType="dialog" cssClass="btn btn-sm btn-filter btn-outline">
                        </soul:button>
                        <a href="/report/vPlayerFundsRecord/fundsLog.html?search.outer=-1&search.userTypes=username&search.usernames=${command.result.username}&search.transactionWays=<%=TransactionWayEnum.SINGLE_REWARD.getCode()%>,<%=TransactionWayEnum.BONUS_AWARDS.getCode()%>&search.hasReturn=true" nav-target="mainFrame" class="btn btn-link" ><i class="iconfont icon-wanjiaguanli"></i>${views.operation['backwater.settlement.view.queryAllBill']}</a>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="text-right">${views.report_auto['所属代理']}：</th>
                    <td>
                        <a href="/userAgent/agent/detail.html?search.id=${command.result.agentid}" nav-target="mainFrame" class="btn btn-link co-blue">${command.result.agentname}</a>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="text-right">${views.report_auto['钱包余额']}：</th>
                    <td>${siteCurrencySign}${soulFn:formatCurrency(command.result.balance)}</td>
                </tr>
                <tr>
                    <th scope="row" class="text-right">${views.report_auto['类型']}：</th>
                    <td>
                        ${views.report_auto['推荐']}-${dicts.common.transaction_way[command.result.transactionWay]}
                        <span class="co-yellow" style="margin-left: 30px;">
                            <%--单次奖励--%>
                            <c:if test="${command.result.transactionWay eq 'single_reward'}">
                                <c:if test="${command.result._describe['rewardType'] eq 2}">
                                    ${views.report_auto['推荐好友']} ${command.result._describe['username']}
                                </c:if>
                                <c:if test="${command.result._describe['rewardType'] eq 3}">
                                    ${messages.fund['FundRecord.record.recmTip1']}${messages.fund['FundRecord.record.friend']}${command.result._describe['username']}${messages.fund['FundRecord.record.recmTip2']}
                                </c:if>
                            </c:if>
                            <%--红利奖励--%>
                            <c:if test="${command.result.transactionWay eq 'bonus_awards'}">
                                ${messages.fund['FundRecord.record.singleReward']}
                            </c:if>
                        </span>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="text-right">${views.report_auto['稽核']}：</th>
                    <td>
                        <%--推荐稽核倍数=稽核点/奖励金额--%>
                        <c:set var="favorableMultiple" value="0"/>
                        <c:if test="${command.result.transactionMoney != 0}">
                            <c:set var="favorableMultiple" value="${command.result.favorableAuditPoints/command.result.transactionMoney}"/>
                        </c:if>
                        <c:choose>
                            <c:when test="${empty favorableMultiple || favorableMultiple==0}">
                                ${views.report_auto['免稽核']}
                            </c:when>
                            <c:otherwise>
                                ${views.report_auto['优惠稽核']}&nbsp;${soulFn:formatInteger(favorableMultiple)}${soulFn:formatDecimals(favorableMultiple)}${views.report_auto['倍']}
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="text-right">${views.report['fund.detail.createTime']}：</th>
                    <td>${soulFn:formatDateTz(command.result.createTime, DateFormat.DAY_SECOND,timeZone)} - <span class="co-grayc2">${soulFn:formatTimeMemo(command.result.createTime, locale)}</span></td>
                </tr>
                <c:choose>
                    <c:when test='${command.result.status eq "success"}'>
                        <c:set var="status_class" value="co-green"></c:set>
                        <c:set var="tr_class" value="success major"></c:set>
                    </c:when>
                    <c:when test='${command.result.status eq "process"}'>
                        <c:set var="status_class" value="co-yellow"></c:set>
                        <c:set var="tr_class" value="warning major"></c:set>
                    </c:when>
                    <c:otherwise>
                        <c:set var="status_class" value="co-red"></c:set>
                        <c:set var="tr_class" value="danger major"></c:set>
                    </c:otherwise>
                </c:choose>
                <tr class="${tr_class}">
                    <th scope="row" class="text-right">${views.report_auto['奖励金额']}：</th>
                    <td class="money">
                        <strong>${siteCurrencySign}${soulFn:formatCurrency(empty command.result.transactionMoney?0:command.result.transactionMoney)}</strong>
                        <a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button"data-clipboard-text="${command.result.transactionMoney}" name="copy">
                            <i class="fa fa-copy" title="${views.common['copy']}"></i>
                        </a>
                        <span class="${status_class}">[${dicts.common.status[command.result.status]}]</span>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="text-right">${views.report_auto['操作时间']}：</th>
                    <td>${soulFn:formatDateTz(command.result.completionTime, DateFormat.DAY_SECOND,timeZone)} - <span class="co-grayc2">${soulFn:formatTimeMemo(command.result.completionTime, locale)}</span></td>
                </tr>
                <tr>
                    <th scope="row" class="text-right">${views.report['fund.detail.operateUser']}：</th>
                    <td>${command.operator}</td>
                </tr>
                </tbody>
            </table>
        </div>
        <!-- <footer class="panel-footer">
        </footer> -->
    </div>
</div>