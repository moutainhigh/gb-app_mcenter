<%@ page import="org.soul.commons.dict.DictTool" %>
<%@ page import="so.wwb.gamebox.model.DictEnum" %><%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VPlayerGameOrderVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="m-t-md">
    <div class="m-b-xs clearfix">
        <div class="col-sm-12 clearfix" style="padding-left: 0;">
            <%--站长账号展示显示站点--%>
            <%--<c:if test="${fn:length(command.sites)>0}">
                <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                    <div class="input-group">
                        <span class="input-group-addon bg-gray">${views.column['VPlayerGameOrder.site']}</span>
                        <gb:select name="search.siteId" value="${command._getDataSourceId()}" list="${command.sites}" listKey="id" listValue="siteNameI18n"/>
                    </div>
                </div>
            </c:if>--%>
            <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                <div class="input-group">
                    <span class="bg-gray input-group-addon bdn">
                        <c:choose>
                            <c:when test="${!empty command.search.agentusername}">
                                <c:set var="username" value="${command.search.agentusername}"/>
                                <c:set var="searchkey" value="search.agentusername"/>
                            </c:when>
                            <c:when test="${!empty command.search.topagentusername}">
                                <c:set var="username" value="${command.search.topagentusername}"/>
                                <c:set var="searchkey" value="search.topagentusername"/>
                            </c:when>
                            <c:otherwise>
                                <c:set var="username" value="${command.search.username}"/>
                                <c:set var="searchkey" value="search.username"/>
                            </c:otherwise>
                        </c:choose>
                        <gb:select cssClass="btn-group chosen-select-no-single" name="searchKeys" list="${searchKeys}" listKey="key" value="${searchkey}" listValue="value" callback="changeKey"/>
                    </span>
                    <input class="form-control search list-search-input-text" placeholder="${views.column['VPlayerGameOrder.username']}" type="text" id="operator" value="${username}" name="${searchkey}"/>
                </div>
            </div>
            <%--游戏名称--%>
            <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                <div class="input-group date">
                    <span class="input-group-addon bg-gray">${views.report_auto['游戏名称']}</span>
                    <input type="text" class="form-control list-search-input-text" name="search.searchGame" value="${command.search.searchGame}"/>
                </div>
            </div>
            <%--游戏类型--%>
            <c:choose>
                <c:when test="${apiType eq 1 || apiType eq 2 || apiType eq 3 || apiType eq 4 || apiType eq 5}">
                    <%@include file="ChooseApi.jsp"%>
                </c:when>
                <c:otherwise>
                    <%@include file="Choose.jsp" %>
                </c:otherwise>
            </c:choose>
            <%--注单号--%>
            <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                <div class="input-group date">
                    <span class="input-group-addon bg-gray">${views.report_auto['注单号']}</span>
                    <input id="singleVal" class="form-control search list-search-input-text" type="text" name="search.betId" value="${command.search.betId}"/>
                </div>
            </div>
            <%--投注时间--%>
            <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                <div class="input-group">
                    <span class="input-group-addon bg-gray">${views.column['VPlayerGameOrder.createTime']}</span>
                    <gb:dateRange format="${DateFormat.DAY_SECOND}" minDate="${minDate}" useRange="true" style="width:38%;" useToday="true" btnClass="search" startName="search.createStart" endName="search.createEnd" startDate="${command.timeFlag?'':command.search.createStart}" endDate="${command.search.createEnd}"/>
                </div>
            </div>
            <%--派彩时间--%>
            <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                <div class="input-group">
                    <span class="input-group-addon bg-gray">${views.column['VPlayerGameOrder.payoutTime']}</span>
                    <gb:dateRange format="${DateFormat.DAY_SECOND}" useRange="true" style="width:38%;" useToday="true" btnClass="search" startDate="${command.timeFlag?'':command.search.payoutStart}"
                                  endDate="${command.search.payoutEnd}" minDate="${minDate}" startName="search.payoutStart" endName="search.payoutEnd"/>
                </div>
            </div>
            <c:choose>
                <c:when test="${!empty command.search.beginSingleAmount}">
                    <c:set var="flag" value="true"/>
                </c:when>
                <c:when test="${!empty command.search.endSingleAmount}">
                    <c:set var="flag" value="true"/>
                </c:when>
                <c:when test="${!empty command.search.beginEffectiveTradeAmount}">
                    <c:set var="flag" value="true"/>
                </c:when>
                <c:when test="${!empty command.search.endEffectiveTradeAmount}">
                    <c:set var="flag" value="true"/>
                </c:when>
                <c:when test="${!empty command.search.beginProfitAmount}">
                    <c:set var="flag" value="true"/>
                </c:when>
                <c:when test="${!empty command.search.endProfitAmount}">
                    <c:set var="flag" value="true"/>
                </c:when>
                <c:when test="${!empty command.search.profitAmount}">
                    <c:set var="flag" value="true"/>
                </c:when>
                <c:when test="${!empty command.search.terminal}">
                    <c:set var="flag" value="true"/>
                </c:when>
                <c:when test="${!empty command.search.orderState}">
                    <c:set var="flag" value="true"/>
                </c:when>
            </c:choose>
            <div class="show-demand-a" style="${flag?'display:block':''}">
                <%--投注额--%>
                <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                    <div class="input-group time-select-a">
                        <span class="input-group-addon bg-gray">${views.column['VPlayerGameOrder.singleAmount']}</span>
                        <span class="input-group-addon time-select-ico">${views.report_auto['起']}</span>
                        <input class="form-control search jp_distance" type="text" name="search.beginSingleAmount" value="${command.search.beginSingleAmount}">
                        <span class="input-group-addon time-select-t">~</span>
                        <span class="input-group-addon time-select-ico">${views.report_auto['止']}</span>
                        <input class="form-control search jp_distance" type="text" name="search.endSingleAmount" value="${command.search.endSingleAmount}">
                    </div>
                </div>
                <%--有效投注额--%>
                <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                    <div class="input-group time-select-a">
                        <span class="input-group-addon bg-gray">${views.column['VPlayerGameOrder.effectiveTradeAmount']}</span>
                        <span class="input-group-addon time-select-ico">${views.report_auto['起']}</span>
                        <input class="form-control search jp_distance" type="text" name="search.beginEffectiveTradeAmount" value="${command.search.beginEffectiveTradeAmount}">
                        <span class="input-group-addon time-select-t">~</span>
                        <span class="input-group-addon time-select-ico">${views.report_auto['止']}</span>
                        <input class="form-control search jp_distance" type="text" name="search.endEffectiveTradeAmount" value="${command.search.endEffectiveTradeAmount}">
                    </div>
                </div>
                <%--派彩金额--%>
                <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                    <div class="input-group time-select-a">
                        <span class="input-group-addon bg-gray">${views.column['VPlayerGameOrder.profitAmount']}</span>
                        <span class="input-group-addon time-select-ico">${views.report_auto['起']}</span>
                        <input class="form-control search jp_distance" type="text" name="search.beginProfitAmount" value="${command.search.beginProfitAmount}"/>
                        <span class="input-group-addon time-select-t">~</span>
                        <span class="input-group-addon time-select-ico">${views.report_auto['止']}</span>
                        <input class="form-control search jp_distance" type="text" name="search.endProfitAmount" value="${command.search.endProfitAmount}"/>
                    </div>
                </div>
                <%--派彩结果--%>
                <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm h-line-a">
                    <div class="input-group">
                        <span class="input-group-addon bg-gray">${views.report_auto['派彩结果']}</span>
                        <span class=" input-group-addon bdn  right-btn-down">
                        <div class="btn-group table-desc-right-t-dropdown">
                            <ul role="menu">
                                <li role="presentation">
                                    <label><input type="radio" name="search.profitAmount" value="" ${empty command.search.profitAmount?'checked':''}>${views.report_auto['全部']}</label>
                                </li>
                                <li role="presentation">
                                    <label><input type="radio" name="search.profitAmount" value="1.0" ${command.search.profitAmount==1.0?'checked':''}> ${views.report_auto['赢']}</label>
                                </li>
                                <li role="presentation">
                                    <label><input type="radio" name="search.profitAmount" value="2.0" ${command.search.profitAmount==2.0?'checked':''}> ${views.report_auto['亏']}</label>
                                </li>
                                <li role="presentation">
                                    <label><input type="radio" name="search.profitAmount" value="3.0" ${command.search.profitAmount==3.0?'checked':''}> ${views.report_auto['和']}</label>
                                </li>
                            </ul>
                        </div>
                    </span>
                    </div>
                </div>
                <%--来源终端--%>
                <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                    <div class="input-group">
                        <span class="input-group-addon bg-gray">${views.report_auto['来源终端']}</span>
                        <gb:select name="search.terminal" list="<%=DictTool.get(DictEnum.COMMON_TERMINAL_TYPE)%>" prompt="${views.player_auto['全部']}"/>
                    </div>
                </div>
                <%--交易状态--%>
                <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm h-line-a">
                    <div class="input-group">
                        <span class="input-group-addon bg-gray">${views.column['VPlayerGameOrder.status']}</span>
                        <span class=" input-group-addon bdn  right-btn-down">
                        <div class="btn-group table-desc-right-t-dropdown">
                            <ul role="menu">
                                <li role="presentation">
                                    <label><input type="radio" name="search.orderState" value="" ${empty command.search.orderState?'checked':''}/> ${views.report_auto['全部']}</label>
                                </li>
                                <c:forEach items="${command.orderStateMap}" var="i">
                                    <li role="presentation">
                                        <label><input type="radio" name="search.orderState" value="${i.key}" ${command.search.orderState==i.key?'checked':''}>${dicts.game.order_state[i.key]}</label>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </span>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-12 clearfix template-menu">
            <span class="btn btn-filter btn-outline pull-right show-demand-b ${flag?'open':''}">
                <i class="fa fa-chevron-down"></i>${views.common['advancedFilter']}
            </span>
            <soul:button precall="validateForm" target="queryByCondition" opType="function" text="${views.report_auto['搜索']}" cssClass="btn btn-filter mediate-search-btn _enter_submit"/>
            <soul:button target="resetCondition" opType="function" text="${views.report_auto['重置']}" cssClass="btn btn-filter reset-condition-button"/>
            <%@include file="/sysSearchTemplate/SearchTemplate.jsp"%>
        </div>
    </div>
</div>