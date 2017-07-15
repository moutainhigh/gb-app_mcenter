<%@ page import="so.wwb.gamebox.model.master.fund.enums.FundTypeEnum" %>
<%@ page import="so.wwb.gamebox.model.master.fund.enums.TransactionWayEnum" %><%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-10-14
  Time: 下午8:02
--%>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.VPlayerFundsRecordVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<div class="col-lg-12">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="co-gray6">${views.report['fund.detail.backwater']}</h3>
        </div>
        <div class="panel-body p-sm">
            <table class="table no-border table-desc-list">
                <tbody>
                <tr>
                    <td colspan="2" class="text-right">
                        ${views.report['fund.detail.transactionNo']}：${command.result.transactionNo}
                            <a type="button" data-clipboard-text="${command.result.transactionNo}" name="copy" class="btn btn-sm btn-info btn-stroke m-l-sm"><i class="fa fa-copy" title="${views.report_auto['复制']}"></i></a>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="text-right">${views.report['fund.detail.playerAccount']}</th>
                    <td>
                        <a href="/player/playerView.html?search.id=${command.result.playerId}" nav-target="mainFrame">${command.result.username}</a>
                        <soul:button target="${root}/fund/withdraw/detect.html?playerId=${command.result.playerId}" text="${views.report_auto['检测']}" opType="dialog" cssClass="btn btn-sm btn-filter btn-outline">
                        </soul:button>
                        <a href="/report/vPlayerFundsRecord/fundsLog.html?search.outer=-1&search.userTypes=username&search.usernames=${command.result.username}&search.transactionWays=<%=TransactionWayEnum.BACK_WATER.getCode()%>&search.hasReturn=true" nav-target="mainFrame" class="btn btn-link" ><i class="iconfont icon-wanjiaguanli"></i>${views.operation['backwater.settlement.view.queryAllBill']}</a>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="text-right">${views.report_auto['所属代理']}：</th>
                    <td>
                        <a class="btn btn-link co-blue" href="/userAgent/agent/detail.html?search.id=${command.result.agentid}" nav-target="mainFrame">${command.result.agentname}</a>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="text-right">${views.report_auto['钱包余额']}：</th>
                    <td>${siteCurrencySign}${soulFn:formatCurrency(command.result.balance)}</td>
                </tr>
                <tr>
                    <th scope="row" class="text-right">${views.report_auto['类型']}：</th>
                    <td>${command.result.remark}</td>
                </tr>
                <tr>
                    <th scope="row" class="text-right">${views.report_auto['返水周期']}：</th>
                    <td>${command.backwaterCircle}</td>
                </tr>
                <tr>
                    <th scope="row" class="text-right">${views.report_auto['稽核']}：</th>
                    <td>
                        <c:choose>
                            <c:when test="${empty command.auditFavorableMultiple || command.auditFavorableMultiple==0}">
                                ${views.report_auto['免稽核']}
                            </c:when>
                            <c:otherwise>
                                <c:if test="${command.favorableSource eq 'recharge_favorable' or command.favorableSource eq 'artificial_favorable'}">
                                    ${views.report_auto['优惠稽核']}
                                </c:if>
                                <c:if test="${command.favorableSource eq 'activity_favorable' or command.favorableSource eq 'backwater_favorable'}">
                                    ${views.report_auto['优惠稽核']}
                                </c:if>
                                ${command.auditFavorableMultiple}${views.report_auto['倍']}
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="text-right">${views.report_auto['应付返水']}：</th>
                    <td>${siteCurrencySign}${soulFn:formatCurrency(empty command.backwaterTotal?0:command.backwaterTotal)}</td>
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
                    <th scope="row" class="text-right">${views.report_auto['实际返水']}：</th>
                    <td class="money">
                        <div style="float: left;padding-top: 7px"><strong>${siteCurrencySign}</strong></div>
                        <div id="actual-amount-div" style="float: left;padding-top: 7px">
                            <strong> ${soulFn:formatCurrency(empty command.result.transactionMoney?0:command.result.transactionMoney)}</strong><i></i>
                        </div>
                        <a class="btn btn-sm btn-info btn-stroke m-l-sm amount-copy-data" type="button" data-clipboard-text="${command.result.transactionMoney}" name="copy"><i class="fa fa-copy"></i></a>
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