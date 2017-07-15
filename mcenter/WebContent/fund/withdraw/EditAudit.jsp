<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.PlayerTransactionVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${views.fund['withdraw.index.editAudit']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form:form>
    <div class="modal-dialog">
        <div class="modal-body clearfix">
            <div class="form-group clearfix">
                  <span class="btn btn-link dropdown-toggle account-pull-down m-l-n-sm">
                      <span class="hd">${views.fund['withdraw.edit.playerWithdraw.playerAccount']}：${command.result.username}</span>
                  </span>

                <div class="table-responsive tab-border-1">
                    <table class="table  table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
                        <thead>
                        <tr class="bg-gray">
                            <th class="co-yellow">${views.fund['withdraw.edit.playerWithdraw.despoitTime']}</th>
                            <th>${views.fund['withdraw.edit.playerWithdraw.despoitAmount']}</th>
                            <th>${views.fund['withdraw.edit.playerWithdraw.despoitAudit']}</th>
                            <th>${views.fund['withdraw.edit.playerWithdraw.favourableAmount']}</th>
                            <th>${views.fund['withdraw.edit.playerWithdraw.favourableAudit']}</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${listVo}" var="s">
                        <tr class="auditT">
                            <td>${soulFn:formatDateTz(s.createTime, DateFormat.DAY_SECOND,timeZone)}</td>
                            <td><c:if test="${s.transactionMoney eq null}">${views.fund['withdraw.edit.playerWithdraw.no']}</c:if>
                                <c:if test="${s.transactionMoney != null}">${s.transactionMoney}</c:if></td>
                            <td class="co-blue">
                                <c:if test="${s.rechargeAuditPoints eq null}">-</c:if>
                                <c:if test="${s.rechargeAuditPoints != null}">
                                    <div class="input-group date fixed-width-80">
                                        <input type="hidden" name="id" value="${s.id}"/>
                                        <input type="text" data-name="rechargeAuditPoints" value="${s.rechargeAuditPoints}" class="form-control" placeholder="${views.fund['withdraw.edit.playerWithdraw.blankNoAudit']}">
                                    </div>
                                </c:if>
                            </td>
                            <td class="co-green">
                                <c:if test="${s.transactionMoney eq null}">${views.fund['withdraw.edit.playerWithdraw.no']}</c:if>
                                <c:if test="${s.transactionMoney != null}">${s.transactionMoney}</c:if>
                            </td>
                            <td class="co-blue">
                                <c:if test="${s.favorableAuditPoints eq null}">-</c:if>
                                <c:if test="${s.favorableAuditPoints != null}">
                                    <div class="input-group date fixed-width-80">
                                        <input type="hidden" name="id" value="${s.id}"/>
                                        <input type="text" data-name="favorableAuditPoints" class="form-control" value="${s.favorableAuditPoints}" placeholder="${views.fund['withdraw.edit.playerWithdraw.blankNoAudit']}">
                                    </div>
                                </c:if>
                            </td>
                        </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <soul:button target="submitAudit" cssClass="btn btn-filter" text="${views.common['confirmPass']}"
                         opType="function"></soul:button>
            <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter"
                         opType="function"/>
        </div>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/fund/withdraw/WithdrawAuditView"/>
</html>
