<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VPlayerApiListVo"--%>
<%--@elvariable id="player" type="so.wwb.gamebox.model.master.player.po.VUserPlayer"--%>
<!DOCTYPE html>
<html>
<head>
    <title>${views.role['player.view.fund.recoveryFunds']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<!--资金查看更多-->
<div class="modal-body">
    <form:form>
        <div class="clearfix line-hi25 m-b">
            <div class="pull-left">
                <div>
                    <b>${views.role['player.view.funds.playerAccount']}：</b>
                    <span class="co-blue3 m-l-xs">${player.username}</span>
                </div>
                <div>
                    <b>${views.role['player.view.funds.realName']}：</b>
                    <span class="co-blue3 m-l-xs">${player.realName}</span>
                </div>
            </div>
            <div class="pull-left m-l-lg">
                <soul:button target="${root}/playerFunds/recovery.html?search.playerId=${player.id}" text="${views.role['player.view.funds.allRecovery']}"
                             confirm="${fn:replace(views.role['player.view.funds.confirmPlayerAllGameRecoveryWallect'], '{}', player.username)}"
                             opType="ajax" cssClass="btn btn-outline btn-filter m-t-sm" callback="refresh" placement="right"/>
            </div>
        </div>
        <table class="table table-striped table-hover dataTable">
            <tbody>
                <c:forEach items="${apis}" var="api">
                    <tr>
                        <td><span class="content-width-no content-width-limit-10">${gbFn:getSiteApiName(api.apiId.toString())}</span></td>
                        <td class="co-orange">${soulFn:formatCurrency(api.money)}</td>
                        <td>
                            <c:choose>
                                <c:when test="${api.taskStatus}">
                                    <span>${views.role['player.view.funds.recoveryProcess']}</span>
                                </c:when>
                                <c:when test="${!api.taskStatus}">
                                    <soul:button target="${root}/playerFunds/recovery.html?type=singlePlayerApi&search.id=${api.id}&search.apiId=${api.apiId}&search.playerId=${player.id}"
                                                 text="${views.role['player.view.funds.recoveryFunds']}" opType="ajax" callback="refresh"
                                                 confirm="${fn:replace(fn:replace(views.role['player.view.funds.confirmPlayerGameRecoveryWallect'], '{username}', player.username), '{api}', gbFn:getApiName(api.apiId.toString()))}" />
                                </c:when>
                               <%-- <c:otherwise>
                                    <span>${views.role['player.view.funds.recoveryFunds']}</span>
                                </c:otherwise>--%>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </form:form>
</div>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/funds/RecoveryFunds"/>
</html>