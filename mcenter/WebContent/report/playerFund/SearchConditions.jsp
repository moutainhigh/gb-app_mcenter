<%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.VPlayerFundsRecordListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="m-t-md">
    <div class="m-b-xs clearfix">
        <div class="col-sm-12 clearfix" style="padding-left: 0;">
            <%--玩家--%>
            <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                <div class="input-group">
                    <c:choose>
                        <c:when test="${not empty command.search.fundSearch.topagentName}">
                            <c:set var="fundSearchUserName" value="${command.search.fundSearch.topagentName}"/>
                            <c:set var="searchKeyName" value="search.fundSearch.topagentName"/>
                        </c:when>
                        <c:when test="${not empty command.search.fundSearch.agentName}">
                            <c:set var="fundSearchUserName" value="${command.search.fundSearch.agentName}"/>
                            <c:set var="searchKeyName" value="search.fundSearch.agentName"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="fundSearchUserName" value="${command.search.fundSearch.playerName}"/>
                            <c:set var="searchKeyName" value="search.fundSearch.playerName"/>
                        </c:otherwise>
                    </c:choose>
                    <span class="bg-gray input-group-addon bdn">
                        <gb:selectPure name="search.userTypes" list="${userTypeSearchKeys}"
                                       listKey="key"
                                       value="${searchKeyName}" listValue="value"
                                       callback="changeKey"
                                       prompt="" cssClass="chosen-select-no-single"/>
                    </span>
                    <input class="form-control search list-search-input-text" placeholder="" type="text" id="operator" value="${fundSearchUserName}" name="${searchKeyName}"/>
                </div>
            </div>
                <%--查询时间--%>
                <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                    <div class="input-group date time-select-a">
                        <span class="input-group-addon bg-gray">${views.player_auto['查询时间']}</span>
                        <gb:dateRange format="${DateFormat.DAY}" style="width:38%" useRange="true"
                                      maxDate="${maxDate}" opens="right" position="down"
                                      startDate="${command.search.fundSearch.searchStartDate}"
                                      endDate="${command.search.fundSearch.searchEndDate}"
                                      startName="search.fundSearch.searchStartDate" endName="search.fundSearch.searchEndDate"/>
                    </div>
                </div>
                <%--注册时间ok--%>
                <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                    <div class="input-group date time-select-a">
                        <span class="input-group-addon bg-gray">${views.player_auto['注册时间']}</span>
                        <gb:dateRange format="${DateFormat.DAY_SECOND}" style="width:38%" useRange="true"
                                      opens="right" position="down"
                                      startDate="${command.search.fundSearch.registeStartDate}"
                                      endDate="${command.search.fundSearch.registeEndDate}"
                                      startName="search.fundSearch.registeStartDate" endName="search.fundSearch.registeEndDate"/>
                    </div>
                </div>
                <div class="show-demand-a">
                    <%--存款次数--%>
                    <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                        <div class="input-group time-select-a">
                            <span class="input-group-addon bg-gray">${views.player_auto['存款次数']}</span>
                            <span class="input-group-addon border-right-none">${views.player_auto['起']}</span>
                            <input type="type" class="form-control border-left-none" name="search.fundSearch.depositStartNum"
                                   id="depositStartNum"
                                   value="${command.search.fundSearch.depositStartNum}">
                            <span class="input-group-addon time-select-t">~</span>
                            <span class="input-group-addon border-right-none">${views.player_auto['止']}</span>
                            <input type="type" class="form-control border-left-none" name="search.fundSearch.depositEndNum"
                                   id="depositEndNum"
                                   value="${command.search.fundSearch.depositEndNum}">
                        </div>
                    </div>
                        <%--存款金额--%>
                        <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                            <div class="input-group time-select-a">
                                <span class="input-group-addon bg-gray">${views.player_auto['存款金额']}</span>
                                <span class="input-group-addon border-right-none">${views.player_auto['起']}</span>
                                <input type="type" class="form-control border-left-none" name="search.fundSearch.depositStartAmount"
                                       id="depositStartAmount"
                                       value="${command.search.fundSearch.depositStartAmount}">
                                <span class="input-group-addon time-select-t">~</span>
                                <span class="input-group-addon border-right-none">${views.player_auto['止']}</span>
                                <input type="type" class="form-control border-left-none" name="search.fundSearch.depositEndAmount"
                                       id="depositEndAmount"
                                       value="${command.search.fundSearch.depositEndAmount}">
                            </div>
                        </div>
                        <%--取款次数--%>
                        <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                            <div class="input-group time-select-a">
                                <span class="input-group-addon bg-gray">${views.player_auto['取款次数']}</span>
                                <span class="input-group-addon border-right-none">${views.player_auto['起']}</span>
                                <input type="type" class="form-control border-left-none" name="search.fundSearch.withdrawStartNum"
                                       id=""
                                       value="${command.search.fundSearch.withdrawStartNum}">
                                <span class="input-group-addon time-select-t">~</span>
                                <span class="input-group-addon border-right-none">${views.player_auto['止']}</span>
                                <input type="type" class="form-control border-left-none" name="search.fundSearch.withdrawEndNum" id=""
                                       value="${command.search.fundSearch.withdrawEndNum}">
                            </div>
                        </div>
                        <%--取款金额--%>
                        <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                            <div class="input-group time-select-a">
                                <span class="input-group-addon bg-gray">${views.player_auto['取款金额']}</span>
                                <span class="input-group-addon border-right-none">${views.player_auto['起']}</span>
                                <input type="type" class="form-control border-left-none" name="search.fundSearch.withdrawStartAmount"
                                       id=""
                                       value="${command.search.fundSearch.withdrawStartAmount}">
                                <span class="input-group-addon time-select-t">~</span>
                                <span class="input-group-addon border-right-none">${views.player_auto['止']}</span>
                                <input type="type" class="form-control border-left-none" name="search.fundSearch.withdrawEndAmount" id=""
                                       value="${command.search.fundSearch.withdrawEndAmount}">
                            </div>
                        </div>

                        <%--有效投注额--%>
                        <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                            <div class="input-group time-select-a">
                                <span class="input-group-addon bg-gray">${views.column['VPlayerGameOrder.effectiveTradeAmount']}</span>
                                <span class="input-group-addon time-select-ico">${views.report_auto['起']}</span>
                                <input class="form-control search jp_distance" type="text" name="search.fundSearch.effectiveStartAmount"
                                       value="${command.search.fundSearch.effectiveStartAmount}">
                                <span class="input-group-addon time-select-t">~</span>
                                <span class="input-group-addon time-select-ico">${views.report_auto['止']}</span>
                                <input class="form-control search jp_distance" type="text" name="search.fundSearch.effectiveEndAmount"
                                       value="${command.search.fundSearch.effectiveEndAmount}">
                            </div>
                        </div>
                        <%--优惠金额--%>
                        <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                            <div class="input-group time-select-a">
                                <span class="input-group-addon bg-gray">${views.player_auto['优惠金额']}</span>
                                <span class="input-group-addon time-select-ico">${views.report_auto['起']}</span>
                                <input class="form-control search jp_distance" type="text" name="search.fundSearch.favorableStartAmount"
                                       value="${command.search.fundSearch.favorableStartAmount}">
                                <span class="input-group-addon time-select-t">~</span>
                                <span class="input-group-addon time-select-ico">${views.report_auto['止']}</span>
                                <input class="form-control search jp_distance" type="text" name="search.fundSearch.favorableEndAmount"
                                       value="${command.search.fundSearch.favorableEndAmount}">
                            </div>
                        </div>
                        <%--返水金额--%>
                        <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                            <div class="input-group time-select-a">
                                <span class="input-group-addon bg-gray">${views.player_auto['返水金额']}</span>
                                <span class="input-group-addon time-select-ico">${views.report_auto['起']}</span>
                                <input class="form-control search jp_distance" type="text" name="search.fundSearch.rakebackStartAmount"
                                       value="${command.search.fundSearch.rakebackStartAmount}">
                                <span class="input-group-addon time-select-t">~</span>
                                <span class="input-group-addon time-select-ico">${views.report_auto['止']}</span>
                                <input class="form-control search jp_distance" type="text" name="search.fundSearch.rakebackEndAmount"
                                       value="${command.search.fundSearch.rakebackEndAmount}">
                            </div>
                        </div>
                        <%--损益--%>
                        <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                            <div class="input-group time-select-a">
                                <span class="input-group-addon bg-gray">${views.player_auto['损益']}</span>
                                <span class="input-group-addon time-select-ico">${views.report_auto['起']}</span>
                                <input class="form-control search jp_distance" type="text" name="search.fundSearch.profitLossStartAmount"
                                       value="${command.search.fundSearch.profitLossStartAmount}">
                                <span class="input-group-addon time-select-t">~</span>
                                <span class="input-group-addon time-select-ico">${views.report_auto['止']}</span>
                                <input class="form-control search jp_distance" type="text" name="search.fundSearch.profitLossEndAmount"
                                       value="${command.search.fundSearch.profitLossEndAmount}">
                            </div>
                        </div>
                </div>
        </div>
    </div>
    <div class="col-sm-12 clearfix template-menu">
        <div class="pull-right">
            <soul:button tag="button" cssClass="btn btn-export-btn btn-primary-hide pull-left"
                         text="${views.common['export']}" callback="gotoExportHistory"
                         precall="validExportCount" post="getCurrentFormData"
                         title="${views.role['player.dataExport']}"
                         target="${root}/userPlayerFund/export.html" opType="ajax">
                <i class="fa fa-sign-out"></i><span class="hd">${views.common['export']}</span>
            </soul:button>
            <button type="button" class="btn btn-filter btn-outline pull-right  show-demand-b">
                <i class="fa fa-chevron-down"></i> ${views.player_auto['高级搜索']}
            </button>&nbsp;

        </div>



            <soul:button precall="validateForm" target="query" opType="function"
                         text="${views.report_auto['搜索']}" cssClass="btn btn-filter mediate-search-btn _enter_submit"/>
            <soul:button target="reset" opType="function" text="${views.report_auto['重置']}"
                         cssClass="btn btn-filter reset-condition-button"/>
            <%@include file="/sysSearchTemplate/SearchTemplate.jsp" %>

    </div>
</div>
</div>