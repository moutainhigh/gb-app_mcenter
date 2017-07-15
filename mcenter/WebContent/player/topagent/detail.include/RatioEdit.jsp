<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-9-15
  Time: 下午5:00
--%>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.UserAgentApiListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form:form>
    <div id="validateRule" style="display:none">${command.validateRule}</div>
        <div class="modal-body">
            <div class="clearfix">
                <div class="form-group clearfix m-b-sm col-xs-6 p-x">
                    <label class="form_lab_block line-hi34 m-r-sm"><b>${views.role['topAgent.detail.ratioEdit.topAgentAccount']} : </b></label>
                    <div class="col-xs-6 p-x line-hi34">
                        <a href="javascript:void(0)">${command.userName}</a>
                    </div>
                </div>
                <div class="form-group clearfix m-b-sm col-xs-4 p-x pull-right">
                    <div class="input-group date">
                        <input type="text" class="form-control" id="batchSetInput" name="batchSetInput">
                        <span class="input-group-addon">%</span>
                    <span class="input-group-btn">
                        <soul:button target="setBatch" tag="button" text="" opType="function" cssClass="btn btn-filter">
                            <span class="hd">${views.role['topAgent.detail.ratioEdit.batchSet']}</span>
                        </soul:button>
                    </span>
                    </div>
                </div>
            </div>
            <table class="table table-striped table-bordered table-hover dataTable m-b-none" aria-describedby="editable_info">
                <thead>
                <tr>
                    <th class="bg-gray" style="width: 30%">${views.role['topAgent.detail.ratioEdit.ratioProject']}</th>
                    <th class="bg-gray">${views.role['topAgent.detail.ratioEdit.ratioNumber']}</th>
                </tr>
                </thead>
                <tbody>
                <c:set var="_apiId" value=""></c:set>
                <c:forEach items="${command.someGames}" var="someGame" varStatus="_gameStatus">
                    <c:set var="_gameCount" value="0"></c:set>
                    <c:forEach var="p" varStatus="status" items="${command.result}">
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
                                        <b>${command.gameTypeMap[someGame['gameType']].value}</b>
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
                                            <input type="text" class="form-control _batch" name="userAgentApis[${_gameStatus.index}].ratio" value="${empty p.ratio ? '0':p.ratio}">
                                            <input type="hidden" name="userAgentApis[${_gameStatus.index}].apiId" value="${p.apiId}">
                                            <input type="hidden" name="UserAgentApis[${_gameStatus.index}].gameType" value="${p.gameType}">
                                            <input type="hidden" name="UserAgentApis[${_gameStatus.index}].userId" value="${command.search.userId}">
                                            <span class="input-group-addon">%</span>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                    <c:if test="${_gameCount eq 0}">
                        <tr>
                            <c:if test="${empty _apiId || _apiId ne someGame['apiId']}">
                                <th rowspan="${command.groupSomeGames[someGame['apiId']].size()}">
                                        ${gbFn:getApiName(someGame['apiId'].toString())}
                                </th>
                            </c:if>
                            <td>
                                <div class="form-group clearfix m-b-xxs col-xs-3 p-x line-hi34">
                                    <b>${command.gameTypeMap[someGame['gameType']].value}</b>
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
                                        <input type="text" class="form-control _batch" name="userAgentApis[${_gameStatus.index}].ratio" value="${empty p.ratio ? '0':p.ratio}">
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
            </div>

        <div class="modal-footer">
            <soul:button target="${root}/userAgent/topagent/ratioPersist.html" precall="validateForm" post="getCurrentFormData" cssClass="btn btn-filter" callback="saveCallbak" tag="button" text="" opType="ajax">
                ${views.common['OK']}
            </soul:button>
            <soul:button target="closePage" text="" opType="function" cssClass="btn btn-outline btn-filter">
                ${views.common['cancel']}
            </soul:button>
        </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/agent/RatioEdit"/>
</html>
