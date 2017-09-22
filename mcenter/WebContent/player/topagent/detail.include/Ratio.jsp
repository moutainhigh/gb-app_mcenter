<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.UserAgentApiListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form id="fundForm" action="${root}/userAgent/topagent/ratio.html" method="post">
    <div id="tab-2" class="tab-pane">
        <div class="">
            <div class="form-group clearfix m-b-sm p-x  al-right">
                <soul:button target="${root}/userAgent/topagent/ratioEdit.html?search.userId=${command.search.userId}" text="${views.role['topAgent.detail.ratioEdit.changeRatio']}" size="size-wide" opType="dialog" callback="reloadCurrentTab">
                    ${views.role['topAgent.detail.ratioEdit.changeRatio']}
                </soul:button>
                <a href="/operation/stationbill/generalBill.html" class="m-l-sm" nav-target="mainFrame">${views.role['TopAgent.detail.ratioBill']}</a>
            </div>

            <table class="table table-striped table-bordered table-hover dataTable m-b-none" aria-describedby="editable_info">
                <thead>

                <tr>
                    <th class="bg-gray">${views.role['topAgent.detail.ratioEdit.ratioProject']}</th>
                    <th class="bg-gray">${views.role['topAgent.detail.ratioEdit.ratioNumber']}</th>
                </tr>
                </thead>
                <tbody>
                <%--上次 api_id--%>
                <c:set var="_apiId" value=""></c:set>
                <c:forEach items="${command.someGames}" var="someGame" varStatus="_gameStatus">
                    <c:set var="_gameCount" value="0"></c:set>
                    <c:forEach items="${command.result}" var="p" varStatus="st">
                        <c:if test="${someGame['apiId'] eq p.apiId && someGame['gameType'] eq p.gameType}">
                            <c:set var="_gameCount" value="1"></c:set>
                            <tr>
                                <%--<c:choose>--%>
                                    <c:if test="${empty _apiId || _apiId ne someGame['apiId']}">
                                        <td rowspan="${command.groupSomeGames[someGame['apiId']].size()}">${gbFn:getApiName(someGame['apiId'].toString())}</td>
                                    </c:if>
                                <%--</c:choose>--%>
                                <td>
                                    <label class="al-right"><span class="m-r-sm"></span>${dicts.game.game_type[p.gameType]}</label>
                                    <label class="al-right"><span class="m-r-sm"></span>${views.role['topAgent.detail.ratioEdit.self']} :</label><span class="co-red"> ${empty p.ratio ? '100':100 - p.ratio}%</span>
                                    <label class="al-right"><span class="m-r-sm"></span>${views.role['topAgent.detail.ratioEdit.topAgent']} :</label><span class="co-red"> ${empty p.ratio ? '0':p.ratio}%</span>
                                </td>

                            </tr>
                        </c:if>
                    </c:forEach>
                    <c:if test="${_gameCount eq 0}">
                        <tr>
                            <%--<c:choose>--%>
                                <c:if test="${empty _apiId || _apiId ne someGame['apiId']}">
                                    <td rowspan="${command.groupSomeGames[someGame['apiId']].size()}">${gbFn:getApiName(someGame['apiId'].toString())}</td>
                                </c:if>
                            <%--</c:choose>--%>
                            <td>
                                <label class="al-right"><span class="m-r-sm"></span>${dicts.game.game_type[someGame['gameType']]}</label>
                                <label class="al-right"><span class="m-r-sm"></span>${views.role['topAgent.detail.ratioEdit.self']} :</label><span class="co-red"> ${empty p.ratio ? '100':100 - p.ratio}%</span>
                                <label class="al-right"><span class="m-r-sm"></span>${views.role['topAgent.detail.ratioEdit.topAgent']} :</label><span class="co-red"> ${empty p.ratio ? '0':p.ratio}%</span>
                            </td>
                        </tr>
                    </c:if>
                    <c:set var="_apiId" value="${someGame['apiId']}"></c:set>
                </c:forEach>
                </tbody>
            </table>


        </div>

    </div>
</form:form>
<script type="text/javascript">
    curl(["site/player/agent/Funds"], function (Funds) {
        page.funds = new Funds();
    });
</script>