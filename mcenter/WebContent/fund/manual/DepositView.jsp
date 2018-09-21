<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.PlayerTransactionVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="org.soul.web.session.SessionManagerBase" %>
<%@ page import="so.wwb.gamebox.model.master.fund.enums.TransactionWayEnum" %>
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
                    <h3 class="co-gray6">${views.fund['存款详细']}</h3>
                </div>
                <div class="panel-body p-sm">
                    <c:set value="${command.result}" var="r"/>
                    <table class="table no-border table-desc-list">
                        <tbody>
                        <tr>
                            <td colspan="2" class="text-right">
                                    ${views.fund['订单号：']}<span id="transactionNo">${r.transactionNo}</span>
                                <a type="button" class="btn btn-sm btn-info btn-stroke m-l-sm" data-clipboard-text="${r.transactionNo}" name="copy"><i class="fa fa-copy" title="${views.fund_auto['复制']}"></i></a>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="text-right">${views.fund['玩家账号：']}</th>
                            <td>
                                <shiro:hasPermission name="role:player_detail">
                                    <a class="btn btn-link co-blue" nav-target="mainFrame" href="/player/playerView.html?search.id=${r.playerId}">
                                </shiro:hasPermission>
                                ${username}<shiro:hasPermission name="role:player_detail"></a></shiro:hasPermission>
                                <a class="btn btn-link" nav-Target="mainFrame" href="/report/vPlayerFundsRecord/fundsLog.html?search.usernames=${username}&search.userTypes=username&search.outer=-1&search.manualSaves=<%=TransactionWayEnum.MANUAL_DEPOSIT.getCode()%>,<%=TransactionWayEnum.MANUAL_FAVORABLE.getCode()%>,<%=TransactionWayEnum.MANUAL_RAKEBACK.getCode()%>,<%=TransactionWayEnum.MANUAL_PAYOUT.getCode()%>,<%=TransactionWayEnum.MANUAL_OTHER.getCode()%>&search.hasReturn=true"><i class="iconfont icon-wanjiaguanli"></i>${views.fund['查看所有订单']}</a>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="text-right">${views.fund['类型：']}</th>
                            <td>
                                <c:choose>
                                    <c:when test="${r.transactionWay=='manual_favorable'}">
                                        ${views.report_auto['人工存入']}-${dicts.fund.recharge_type[r.transactionWay]}-${dicts.common.activity_type[activityType]}
                                    </c:when>
                                    <c:otherwise>
                                        ${dicts.fund.recharge_type[r.transactionWay]}
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <c:if test="${r.transactionWay=='manual_favorable'}">
                        <tr>
                            <th scope="row" class="text-right">${views.fund['优惠活动：']}</th>
                            <td>
                                <c:choose>
                                    <c:when test="${activityId==''||activityId==null}">
                                        <c:choose>
                                            <c:when test="${not empty activityName}">
                                                ${activityName}
                                            </c:when>
                                            <c:when test="${not empty _activityName}">
                                                 ${_activityName}
                                            </c:when>
                                            <c:otherwise>
                                                ——   ——
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <c:if test="${activityMessage.isDeleted}">
                                            ${views.fund['该活动已被删除']}
                                        </c:if>
                                        <c:if test="${!activityMessage.isDeleted}">
                                            <a href="/operation/activityType/viewActivityDetail.html?search.id=${activityId}" nav-target="mainFrame">
                                                <c:if test="${not empty activityName}">
                                                    ${activityName}
                                                </c:if>
                                                <c:if test="${not empty _activityName}">
                                                    ${_activityName}
                                                </c:if>
                                            </a>
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        </c:if>
                        <tr>
                            <th scope="row" class="text-right">${views.fund['稽核：']}</th>
                            <td>
                                <c:choose>
                                    <c:when test="${!empty r.rechargeAuditPoints&&r.rechargeAuditPoints!=0}">
                                        <c:set var="audit" value="${r.rechargeAuditPoints/r.transactionMoney}"/>
                                        ${views.fund['存款稽核']}&nbsp;${soulFn:formatInteger(audit)}${soulFn:formatDecimals(audit)}&nbsp;${views.fund['倍']}
                                    </c:when>
                                    <c:when test="${!empty r.favorableAuditPoints}">
                                        ${views.fund['优惠稽核']}&nbsp;${soulFn:formatInteger(favorableAudit)}${soulFn:formatDecimals(favorableAudit)}&nbsp;${views.fund['倍']}
                                    </c:when>
                                    <c:otherwise>
                                        ${views.fund['免稽核']}
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <c:if test="${!empty r.favorableAuditPoints}">
                            <tr>
                                <th scope="row" class="text-right">${views.fund_auto['优惠稽核点']}：</th>
                                <td>${r.favorableAuditPoints}</td>
                            </tr>
                        </c:if>
                        <c:if test="${!empty transactionData['rechargeTransactionNo']}">
                            <tr>
                                <th scope="row" class="text-right">${views.fund_auto['关联存款订单号']}：</th>
                                <td>${transactionData['rechargeTransactionNo']}</td>
                            </tr>
                        </c:if>
                        <tr class="success major">
                            <th scope="row" class="text-right">${views.fund['存款金额：']}</th>
                            <td class="money">
                                <strong>
                                    ${currency} ${soulFn:formatInteger(r.transactionMoney)}
                                    <i>${soulFn:formatDecimals(r.transactionMoney)}</i>
                                </strong>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="text-right">${views.fund['操作时间：']}</th>
                            <td>
                                ${soulFn:formatDateTz(r.createTime, DateFormat.DAY_SECOND, timeZone)}-
                                <span class="co-grayc2">${soulFn:formatTimeMemo(r.createTime, locale)}</span>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="text-right">
                                    ${views.fund['操作人']}
                            </th>
                            <td>${operator}</td>
                        </tr>
                        <tr>
                            <th scope="row" class="text-right" style="vertical-align: top;">${views.fund['备注：']}</th>
                            <td>
                                <textarea class="form-control width-response" maxlength="200" rows="4" name="remarkContent" readonly>${remark}</textarea>
                                <div class="btn-groups text-right p-t-xs width-response">
                                    <soul:button target="editRemark" text="${views.fund_auto['编辑']}" opType="function" cssClass="btn btn-link co-blue">
                                        <span class="fa fa-edit"></span>${views.fund['编辑']}
                                    </soul:button>
                                    <div style="display: none" id="editRemark">
                                        <soul:button target="${root}/fund/manual/updateRemark.html?result.sourceId=${r.sourceId}&result.playerId=${r.playerId}&result.transactionType=${r.transactionType}" callback="updateRemarkBack" text="" opType="ajax" cssClass="btn btn-link co-blue" post="getCurrentFormData">
                                            <span class="fa fa-save"></span> ${views.fund['保存']}
                                        </soul:button>
                                        <soul:button target="cancelEdit" text="" opType="function" cssClass="btn btn-link co-blue">
                                            <span class="fa fa-undo"></span> ${views.common_report['取消']}
                                        </soul:button>
                                        <input name="originRemark" value="${remark}" type="hidden"/>
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