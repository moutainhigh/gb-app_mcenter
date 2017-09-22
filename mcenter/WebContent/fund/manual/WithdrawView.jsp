<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.vo.VPlayerWithdrawVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="org.soul.web.session.SessionManagerBase" %>
<%@ page import="so.wwb.gamebox.model.master.fund.enums.TransactionWayEnum" %>
<%@ page import="so.wwb.gamebox.model.master.fund.enums.TransferStatusEnum" %>
<%@ page import="so.wwb.gamebox.model.master.enums.TransactionStatusEnum" %>
<%@ page import="so.wwb.gamebox.model.master.enums.CommonStatusEnum" %>
<%@ include file="/include/include.inc.jsp" %>

<c:set var="locale" value="<%=SessionManagerBase.getLocale() %>" />

<form:form>
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i></a></h2>
            <span>${views.sysResource['统计']}</span>
            <span>/</span>
            <span>${views.sysResource['资金记录']}</span>
            <soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="co-gray6">${views.fund_auto['取款详细']}</h3>
                </div>
                <div class="panel-body p-sm">
                    <c:set value="${command.result}" var="r"/>
                    <table class="table no-border table-desc-list">
                        <tbody>
                        <tr>
                            <td colspan="2" class="text-right">
                                ${views.fund_auto['交易号']}：<span id="transactionNo">${r.transactionNo}</span>
                                <a type="button" class="btn btn-sm btn-info btn-stroke m-l-sm" data-clipboard-target="transactionNo" name="copy"><i class="fa fa-copy" title="${views.fund_auto['复制']}"></i></a>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="text-right">${views.fund_auto['玩家账号']}：</th>
                            <td>
                                <a class="btn btn-link co-blue" nav-target="mainFrame" href="/player/playerView.html?search.id=${r.playerId}">${r.username}</a>
                                <soul:button target="${root}/fund/withdraw/detect.html?playerId=${r.playerId}" text="${views.fund_auto['检测']}" opType="dialog" cssClass="btn btn-info-hide">
                                    <i class="fa fa-search"></i>${views.fund_auto['检测']}
                                </soul:button>
                                <a class="btn btn-link" nav-Target="mainFrame" href="/report/vPlayerFundsRecord/fundsLog.html?search.usernames=${r.username}&search.userTypes=username&search.manualWithdraws=<%=TransactionWayEnum.MANUAL_DEPOSIT.getCode()%>,<%=TransactionWayEnum.MANUAL_FAVORABLE.getCode()%>,<%=TransactionWayEnum.MANUAL_RAKEBACK.getCode()%>,<%=TransactionWayEnum.MANUAL_PAYOUT.getCode()%>,<%=TransactionWayEnum.MANUAL_OTHER.getCode()%>&search.outer=-1&search.hasReturn=true"><i class="iconfont icon-wanjiaguanli"></i>${views.fund_auto['查看所有订单']}</a>
                                <a class="btn btn-link" nav-Target="mainFrame" href="/report/gameTransaction/list.html?isLink=true&search.username=${r.username}&searchKeys=search.username"><i class="iconfont icon-wanjiaguanli"></i>${views.fund_auto['查看投注记录']}</a>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="text-right">${views.fund_auto['所属代理']}：</th>
                            <td>${r.agentName}</td>
                        </tr>
                        <tr>
                            <th scope="row" class="text-right">${views.fund_auto['玩家层级']}：</th>
                            <td>
                                <c:choose>
                                    <c:when test="${command.result.riskMarker}">
                                        <span data-content="${views.fund_auto['危险层级']}" data-placement="right" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                                            <span class="label label-danger">${command.result.rankName}</span>
                                        </span>
                                        <span class="text-danger">${views.fund_auto['危险层级']}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="label label-info">${command.result.rankName}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="text-right">${views.fund_auto['类型']}：</th>
                            <td>${dicts.fund.withdraw_type[r.withdrawType]}</td>
                        </tr>
                        <tr>
                            <th scope="row" class="text-right">${views.fund_auto['稽核']}：</th>
                            <td>
                                <c:choose>
                                    <c:when test="${r.isClearAudit==true}">
                                        ${views.fund_auto['已清除稽核点']}
                                    </c:when>
                                    <c:otherwise>
                                        ${views.fund_auto['未清除稽核点']}
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr class="success major">
                            <th scope="row" class="text-right">${views.fund_auto['实际取款']}：</th>
                            <td class="money">
                                <strong>
                                    ${currency} ${soulFn:formatInteger(r.withdrawActualAmount)}
                                    <i>${soulFn:formatDecimals(r.withdrawActualAmount)}</i>
                                </strong>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="text-right">${views.fund_auto['操作时间']}：</th>
                            <td>
                                ${soulFn:formatDateTz(r.createTime, DateFormat.DAY_SECOND, timeZone)} - <span class="co-grayc2">${soulFn:formatTimeMemo(r.createTime, locale)}</span>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="text-right">
                                ${views.fund_auto['操作人']}
                            </th>
                            <td>${r.checkUserName}</td>
                        </tr>
                        <tr>
                            <th scope="row" class="text-right" style="vertical-align: top;">${views.fund_auto['备注']}：</th>
                            <td>
                                <textarea class="form-control width-response" maxlength="200" rows="4" name="remarkContent" readonly>${r.checkRemark}</textarea>
                                <div class="btn-groups text-right p-t-xs width-response">
                                    <soul:button target="editRemark" text="${views.fund_auto['编辑']}" opType="function" cssClass="btn btn-link co-blue">
                                        <span class="fa fa-edit"></span>${views.fund_auto['编辑']}
                                    </soul:button>
                                    <div style="display: none" id="editRemark">
                                        <soul:button target="${root}/fund/manual/updateRemark.html?result.sourceId=${r.id}&result.playerId=${r.playerId}&result.transactionType=withdrawals" callback="updateRemarkBack" text="" opType="ajax" cssClass="btn btn-link co-blue" post="getCurrentFormData">
                                            <span class="fa fa-save"></span> ${views.fund_auto['保存']}
                                        </soul:button>
                                        <soul:button target="cancelEdit" text="" opType="function" cssClass="btn btn-link co-blue">
                                            <span class="fa fa-undo"></span> ${views.common_report['取消']}
                                        </soul:button>
                                        <input name="originRemark" value="${r.checkRemark}" type="hidden"/>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</form:form>

<soul:import res="site/fund/manual/DepositView"/>