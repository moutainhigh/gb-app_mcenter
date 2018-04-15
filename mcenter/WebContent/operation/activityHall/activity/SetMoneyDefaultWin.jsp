<%--@elvariable id="command" type="java.util.Map<java.lang.String, java.util.Map<java.lang.String,so.wwb.gamebox.model.company.site.po.SiteI18n>>"--%>
<%--@elvariable id="siteLang" type="java.util.Map<java.lang.String,so.wwb.gamebox.model.company.site.po.SiteLanguage>>"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${views.common['edit']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form>
    <gb:token/>
    <div class="modal-body">
        <div id="validateRule" style="display: none">${validateRule}</div>
        <input type="hidden" name="result.activityMessageId" value="${activityMessageVo.result.id}">
        <input type="hidden" name="result.amount">
        <div class="form-group clearfix" style="text-align: center;font-size: 20px;padding: 10px 0px;background-color: #e5e7ec">
            ${views.operation['Activity.money.default.tips1']}
        </div>
        <div class="form-group clearfix">
            <label class="col-xs-2 al-right line-hi34" >${views.column['VActivityPlayerApply.playerName']}：</label>
            <div class="col-xs-9">
                <%--<form:input path="result.name" cssClass="form-control m-b-xs"/>--%>
                <textarea style="width: 100%;height: 100px;" name="usernames" placeholder="${views.fund_auto['多个账号，用半角逗号隔开']}"></textarea>
            </div>
        </div>
        <div class="form-group clearfix">
            <label class="col-xs-2 al-right line-hi34" >${views.operation['Activity.money.default.item']}：</label>
            <div class="col-xs-9">
                <div class="input-group date">
                <gb:select name="result.activityMoneyAwardsRulesId" list="${activityMoneyAwardsRules}"
                           listKey="id" listValue="amount" callback="setAmount"></gb:select>
                </div>
            </div>
        </div>
        <div class="form-group clearfix">
            <label class="col-xs-2 al-right line-hi34" >
                <span tabindex="0" class="" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                      data-html="true" data-content="${views.operation['Activity.money.default.tips2']}">
                    <i class="fa fa-question-circle" ></i>
                </span>
                ${views.operation['Activity.money.default.wincount']}：
            </label>
            <div class="col-xs-9">
                <div class="input-group date">
                <input type="number" name="result.winCount" class="form-control m-b-xs">
                </div>
            </div>
        </div>
        <div>
            <c:if test="${not empty winListVo.result}">
                <c:forEach var="record" items="${recordListVo.result}" varStatus="avs">
                    <c:forEach var="item" items="${winListVo.result}" varStatus="vs">
                        <c:if test="${record.defaultWinId eq item.id}">
                            ${soulFn:formatDateTz(record.operateTime, DateFormat.DAY_SECOND,timeZone)} - <span class="co-grayc2">${soulFn:formatTimeMemo(record.operateTime, locale)}</span>
                            <c:set var="playerCount" value="${fn:length(winListVo.playerMap[item.id])}"></c:set>
                            <c:set var="playernames" value=""></c:set>
                            <c:if test="${playerCount>5}">
                                <c:forEach begin="0" end="4" var="player" items="${winListVo.playerMap[item.id]}" varStatus="vss">
                                    <c:set value="${playernames.concat(' ').concat(player.username)}" var="playernames"></c:set>
                                </c:forEach>
                            </c:if>
                            <c:if test="${playerCount<=5}">
                                <c:forEach var="player" items="${winListVo.playerMap[item.id]}" varStatus="vss">
                                    <c:set value="${playernames.concat(' ').concat(player.username)}" var="playernames"></c:set>
                                </c:forEach>
                            </c:if>

                            [${record.operateOrgin=='1'?record.operateUsername:views.fund['fund.playerDetect.index.system']}]
                            <c:if test="${record.operateType=='1'}">
                                <c:if test="${playerCount>5}">
                                    ${fn:replace(fn:replace(fn:replace(views.operation['Activity.money.default.set.tips2'], "{0}", playernames), "{1}", item.winCount), "{2}", item.amount)}
                                </c:if>
                                <c:if test="${playerCount<=5}">
                                    ${fn:replace(fn:replace(fn:replace(views.operation['Activity.money.default.set.tips1'], "{0}", playernames), "{1}", item.winCount), "{2}", item.amount)}
                                </c:if>

                            </c:if>

                            <c:if test="${record.operateType=='2'}">
                                ${fn:replace(views.operation['Activity.money.default.cancel'], "{0}", playernames)}
                                <c:if test="${playerCount>5}">
                                    <soul:button cssClass="open-player-div-${record.id}" target="showAllPlayerUsername" dataId="${record.id}" text="${views.common['view']}" opType="function"></soul:button>
                                    <soul:button cssClass="hide-player-div-${record.id} hide" target="hideAllPlayerUsername" dataId="${record.id}" text="${messages.setting['basic.stop']}" opType="function"></soul:button>
                                </c:if>
                                <br>
                            </c:if>

                            <c:if test="${record.operateType=='1'}">
                                <c:if test="${playerCount>5}">
                                    <soul:button cssClass="open-player-div-${record.id}" target="showAllPlayerUsername" dataId="${record.id}" text="${views.common['view']}" opType="function"></soul:button>
                                    <soul:button cssClass="hide-player-div-${record.id} hide" target="hideAllPlayerUsername" dataId="${record.id}" text="${messages.setting['basic.stop']}" opType="function"></soul:button>
                                </c:if>
                                <c:if test="${item.status=='1'}">
                                <soul:button target="cancelDefaultWin" precall="isPlayerWin"
                                             text="${views.operation['Activity.money.default.cancel_button']}" dataId="${item.id}" opType="function"></soul:button>
                                </c:if>
                                <br>

                            </c:if>
                            <c:if test="${playerCount>5}">
                                <div class="hide" id="all-player-username-${record.id}">
                                    <c:forEach var="player" items="${winListVo.playerMap[item.id]}" varStatus="vss">
                                        ${player.username}<c:if test="${vss.index<playerCount-1}">，</c:if>
                                    </c:forEach>
                                </div>
                            </c:if>
                        </c:if>
                    </c:forEach>
                </c:forEach>
            </c:if>
            <c:if test="${empty winListVo.result}">
                <c:forEach begin="0" end="4" varStatus="vss">
                    <br/>
                </c:forEach>
            </c:if>
        </div>

    </div>
    <div class="modal-footer">
        <soul:button precall="myValidateFrom" cssClass="btn btn-filter btn-save-defaultwin" callback="saveCallbak"
                     text="${views.common['OK']}" opType="ajax" dataType="json"
                     target="${root}/activityHall/activityMoneyDefaultWin/persist.html" post="getCurrentFormData"/>
        <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter"
                     opType="function"/>
    </div>
</form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/operation/activityHall/SetMoneyDefaultWin"/>
</html>