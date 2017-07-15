<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-9-16
  Time: 下午2:25
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<table class="table table-striped table-bordered table-hover dataTable m-b-none" aria-describedby="editable_info">
    <thead>
    <tr>
        <th class="bg-gray" style="width: 35%">${views.role['TopAgent.edit.ratioProject']}</th>
        <th class="bg-gray">${views.role['TopAgent.edit.ratioNumber']}</th>
    </tr>
    </thead>
    <tbody>
    <c:set var="_apiId" value=""></c:set>
    <c:forEach items="${command.someGames}" var="someGame" varStatus="_gameStatus">
        <c:set var="_gameCount" value="0"></c:set>
        <%--<c:forEach var="p" varStatus="status" items="${command.result}">
            <c:if test="${someGame['apiId'] eq p.apiId && someGame['gameType'] eq p.gameType}">
                <c:set var="_gameCount" value="1"></c:set>
                <tr>
                    <c:if test="${empty _apiId || _apiId ne someGame['apiId']}">
                        <th rowspan="${command.groupSomeGames[someGame['apiId']].size()}">
                                ${gbFn:getApiName(someGame['apiId'].toString())}
                        </th>
                    </c:if>
                    <td>
                        <div class="form-group clearfix m-b-xxs col-xs-3 p-x line-hi34">
                            <b> ${dicts.game.game_type[someGame['gameType']]}</b>
                        </div>
                        <div class="form-group clearfix m-b-xxs col-xs-3 p-x line-hi34">
                            <label class="al-right">
                                <span class="co-red m-r-sm"></span>
                                    ${views.role['topAgent.detail.ratioEdit.self']} :
                            </label>
                            <span class="co-red _self"> ${empty p.ratio ? '100':(100-p.ratio)}%</span>
                        </div>
                        <div class="form-group clearfix m-b-xxs col-xs-6 p-x">
                            <div class="input-group date">
                                <span class="input-group-addon bg-gray"><b>${views.role['topAgent.detail.ratioEdit.topAgent']} :</b></span>
                                <input type="text" class="form-control _batch" name="userAgentApis[${gameStatus.index}].ratio" value="${empty p.ratio ? '0':p.ratio}">
                                <input type="hidden" name="userAgentApis[${_gameStatus.index}].apiId" value="${p.apiId}">
                                <input type="hidden" name="UserAgentApis[${_gameStatus.index}].gameType" value="${p.gameType}">
                                <input type="hidden" name="UserAgentApis[${_gameStatus.index}].userId" value="${command.search.userId}">
                                <span class="input-group-addon">%</span>
                            </div>
                        </div>
                    </td>
                </tr>
            </c:if>
        </c:forEach>--%>
        <c:if test="${_gameCount eq 0}">
            <tr>
                <c:if test="${empty _apiId || _apiId ne someGame['apiId']}">
                    <th rowspan="${command.groupSomeGames[someGame['apiId']].size()}">
                            ${gbFn:getSiteApiName(someGame['apiId'].toString())}
                    </th>
                </c:if>
                <td>
                    <div class="form-group clearfix m-b-xxs col-xs-3 p-x line-hi34">
                        <b>
                            ${command.gameTypeMap[someGame['gameType']].value}
                        </b>
                    </div>
                    <div class="form-group clearfix m-b-xxs col-xs-3 p-x line-hi34">
                        <label class="al-right">
                            <span class="co-red m-r-sm"></span>
                                ${views.role['topAgent.detail.ratioEdit.self']} :
                        </label>
                        <span class="co-red _self"> ${empty p.ratio ? '100':(100-p.ratio)}%</span>
                    </div>
                    <div class="form-group clearfix m-b-xxs col-xs-6 p-x">
                        <div class="input-group date">
                            <span class="input-group-addon bg-gray"><span style="color: red">*</span><b>${views.role['topAgent.detail.ratioEdit.topAgent']} :</b></span>
                            <input type="text" class="form-control _batch" name="userAgentApis[${_gameStatus.index}].ratio" value="${empty p.ratio ? '':p.ratio}">
                            <input type="hidden" name="userAgentApis[${_gameStatus.index}].apiId" value="${someGame['apiId']}">
                            <input type="hidden" name="UserAgentApis[${_gameStatus.index}].gameType" value="${someGame['gameType']}">
                            <input type="hidden" name="UserAgentApis[${_gameStatus.index}].userId" value="${command.search.userId}">
                            <span class="input-group-addon">%</span>
                        </div>
                    </div>
                </td>
            </tr>
        </c:if>
        <c:set var="_apiId" value="${someGame['apiId']}"></c:set>
    </c:forEach>
    </tbody>
</table>