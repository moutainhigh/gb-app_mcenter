<%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.VPlayerFundsRecordListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="m-t-md">
    <div class="m-b-xs clearfix">
        <div class="col-sm-12 clearfix" style="padding-left: 0;">
            <%--玩家--%>
            <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                <div class="input-group">
                    <span class="bg-gray input-group-addon bdn">
                        <gb:selectPure name="search.userTypes" list="${userTypeSearchKeys}"
                                       listKey="key"
                                       value="" listValue="value"
                                       callback="changeKey"
                                       prompt="" cssClass="chosen-select-no-single"/>
                    </span>
                    <c:if test="${not empty command.fundSearch.playerName||(empty command.fundSearch.playerName&&empty command.fundSearch.agentName&&empty command.fundSearch.topagentName)}">
                        <input type="text" class="form-control account_input list-search-input-text" name="fundSearch.playerName" id="operator"
                               value="${command.fundSearch.playerName}" placeholder="">
                    </c:if>
                    <c:if test="${not empty command.fundSearch.agentName}">
                        <input type="text" class="form-control account_input list-search-input-text" name="fundSearch.agentName" id="operator"
                               value="${command.fundSearch.agentName}" placeholder="">
                    </c:if>
                    <c:if test="${not empty command.fundSearch.topagentName}">
                        <input type="text" class="form-control account_input list-search-input-text" name="fundSearch.topagentName" id="operator"
                               value="${command.fundSearch.topagentName}" placeholder="">
                    </c:if>
                </div>
            </div>
                <%--查询时间--%>
                <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                    <div class="input-group date time-select-a">
                        <span class="input-group-addon bg-gray">${views.player_auto['查询时间']}</span>
                        <gb:dateRange format="${DateFormat.DAY}" style="width:38%" useRange="true"
                                      maxDate="${maxDate}" opens="right" position="down"
                                      startDate="${command.fundSearch.searchStartDate}"
                                      endDate="${command.fundSearch.searchEndDate}"
                                      startName="fundSearch.searchStartDate" endName="fundSearch.searchEndDate"/>
                    </div>
                </div>
                <%--注册时间ok--%>
                <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                    <div class="input-group date time-select-a">
                        <span class="input-group-addon bg-gray">${views.player_auto['注册时间']}</span>
                        <gb:dateRange format="${DateFormat.DAY_SECOND}" style="width:38%" useRange="true"
                                      opens="right" position="down"
                                      startDate="${command.fundSearch.registeStartDate}"
                                      endDate="${command.fundSearch.registeEndDate}"
                                      startName="fundSearch.registeStartDate" endName="fundSearch.registeEndDate"/>
                    </div>
                </div>
                <div class="show-demand-a">
                    <%--存款次数--%>
                    <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                        <div class="input-group time-select-a">
                            <span class="input-group-addon bg-gray">${views.player_auto['存款次数']}</span>
                            <span class="input-group-addon border-right-none">${views.player_auto['起']}</span>
                            <input type="type" class="form-control border-left-none" name="fundSearch.depositStartNum"
                                   id="depositStartNum"
                                   value="${command.fundSearch.depositStartNum}">
                            <span class="input-group-addon time-select-t">~</span>
                            <span class="input-group-addon border-right-none">${views.player_auto['止']}</span>
                            <input type="type" class="form-control border-left-none" name="fundSearch.depositEndNum"
                                   id="depositEndNum"
                                   value="${command.fundSearch.depositEndNum}">
                        </div>
                    </div>
                        <%--存款金额--%>
                        <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                            <div class="input-group time-select-a">
                                <span class="input-group-addon bg-gray">${views.player_auto['存款金额']}</span>
                                <span class="input-group-addon border-right-none">${views.player_auto['起']}</span>
                                <input type="type" class="form-control border-left-none" name="fundSearch.depositStartAmount"
                                       id="depositStartAmount"
                                       value="${command.fundSearch.depositStartAmount}">
                                <span class="input-group-addon time-select-t">~</span>
                                <span class="input-group-addon border-right-none">${views.player_auto['止']}</span>
                                <input type="type" class="form-control border-left-none" name="fundSearch.depositEndAmount"
                                       id="depositEndAmount"
                                       value="${command.fundSearch.depositEndAmount}">
                            </div>
                        </div>
                        <%--取款次数--%>
                        <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                            <div class="input-group time-select-a">
                                <span class="input-group-addon bg-gray">${views.player_auto['取款次数']}</span>
                                <span class="input-group-addon border-right-none">${views.player_auto['起']}</span>
                                <input type="type" class="form-control border-left-none" name="fundSearch.withdrawStartNum"
                                       id=""
                                       value="${command.fundSearch.withdrawStartNum}">
                                <span class="input-group-addon time-select-t">~</span>
                                <span class="input-group-addon border-right-none">${views.player_auto['止']}</span>
                                <input type="type" class="form-control border-left-none" name="fundSearch.withdrawEndNum" id=""
                                       value="${command.fundSearch.withdrawEndNum}">
                            </div>
                        </div>
                        <%--取款金额--%>
                        <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                            <div class="input-group time-select-a">
                                <span class="input-group-addon bg-gray">${views.player_auto['取款金额']}</span>
                                <span class="input-group-addon border-right-none">${views.player_auto['起']}</span>
                                <input type="type" class="form-control border-left-none" name="fundSearch.withdrawStartAmount"
                                       id=""
                                       value="${command.fundSearch.withdrawStartAmount}">
                                <span class="input-group-addon time-select-t">~</span>
                                <span class="input-group-addon border-right-none">${views.player_auto['止']}</span>
                                <input type="type" class="form-control border-left-none" name="fundSearch.withdrawEndAmount" id=""
                                       value="${command.fundSearch.withdrawEndAmount}">
                            </div>
                        </div>

                        <%--有效投注额--%>
                        <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                            <div class="input-group time-select-a">
                                <span class="input-group-addon bg-gray">${views.column['VPlayerGameOrder.effectiveTradeAmount']}</span>
                                <span class="input-group-addon time-select-ico">${views.report_auto['起']}</span>
                                <input class="form-control search jp_distance" type="text" name="fundSearch.effectiveStartAmount"
                                       value="${command.fundSearch.effectiveStartAmount}">
                                <span class="input-group-addon time-select-t">~</span>
                                <span class="input-group-addon time-select-ico">${views.report_auto['止']}</span>
                                <input class="form-control search jp_distance" type="text" name="fundSearch.effectiveEndAmount"
                                       value="${command.fundSearch.effectiveEndAmount}">
                            </div>
                        </div>
                        <%--优惠金额--%>
                        <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                            <div class="input-group time-select-a">
                                <span class="input-group-addon bg-gray">${views.player_auto['优惠金额']}</span>
                                <span class="input-group-addon time-select-ico">${views.report_auto['起']}</span>
                                <input class="form-control search jp_distance" type="text" name="fundSearch.favorableStartAmount"
                                       value="${command.fundSearch.favorableStartAmount}">
                                <span class="input-group-addon time-select-t">~</span>
                                <span class="input-group-addon time-select-ico">${views.report_auto['止']}</span>
                                <input class="form-control search jp_distance" type="text" name="fundSearch.favorableEndAmount"
                                       value="${command.fundSearch.favorableEndAmount}">
                            </div>
                        </div>
                        <%--返水金额--%>
                        <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                            <div class="input-group time-select-a">
                                <span class="input-group-addon bg-gray">${views.player_auto['返水金额']}</span>
                                <span class="input-group-addon time-select-ico">${views.report_auto['起']}</span>
                                <input class="form-control search jp_distance" type="text" name="fundSearch.rakebackStartAmount"
                                       value="${command.fundSearch.rakebackStartAmount}">
                                <span class="input-group-addon time-select-t">~</span>
                                <span class="input-group-addon time-select-ico">${views.report_auto['止']}</span>
                                <input class="form-control search jp_distance" type="text" name="fundSearch.rakebackEndAmount"
                                       value="${command.fundSearch.rakebackEndAmount}">
                            </div>
                        </div>
                        <%--损益--%>
                        <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                            <div class="input-group time-select-a">
                                <span class="input-group-addon bg-gray">${views.player_auto['损益']}</span>
                                <span class="input-group-addon time-select-ico">${views.report_auto['起']}</span>
                                <input class="form-control search jp_distance" type="text" name="fundSearch.profitLossStartAmount"
                                       value="${command.fundSearch.profitLossStartAmount}">
                                <span class="input-group-addon time-select-t">~</span>
                                <span class="input-group-addon time-select-ico">${views.report_auto['止']}</span>
                                <input class="form-control search jp_distance" type="text" name="fundSearch.profitLossEndAmount"
                                       value="${command.fundSearch.profitLossEndAmount}">
                            </div>
                        </div>
                </div>
        </div>
    </div>
    <div class="col-sm-12 clearfix template-menu">
        <button type="button" class="btn btn-filter btn-outline pull-right  show-demand-b">
            <i class="fa fa-chevron-down"></i> ${views.player_auto['高级搜索']}
        </button>
        <soul:button precall="validateForm" target="query" opType="function"
                     text="${views.report_auto['搜索']}" cssClass="btn btn-filter mediate-search-btn"/>
        <soul:button target="reset" opType="function" text="${views.report_auto['重置']}"
                     cssClass="btn btn-filter reset-condition-button"/>
        <%@include file="/sysSearchTemplate/SearchTemplate.jsp" %>
    </div>
</div>
</div>