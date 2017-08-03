<%@ page import="so.wwb.gamebox.model.master.fund.enums.TransactionTypeEnum" %><%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.VPlayerFundsRecordListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/report/vPlayerFundsRecord/fundsLog.html" method="post" name="fundRecordForm">
    <div id="validateRule" style="display: none">${validateRule}</div>
    <input type="hidden" id="outer" name="search.outer" value="${empty command.search.outer?-1:command.search.outer}" />
    <input type="hidden" id="originMemory" />
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['统计']}</span>
            <span>/</span><span>${views.sysResource['资金记录']}</span>
                <soul:button target="goToLastPage" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                    <em class="fa fa-caret-left"></em>${views.common['return']}
                </soul:button>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow clearfix">
                <div class="m-t-md">
                    <div class="m-b-xs clearfix">
                        <div class="clearfix" style="padding-right: 15px;">
                            <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group">
                                    <span class="bg-gray input-group-addon bdn">
                                        <gb:selectPure cssClass="chosen-select-no-single" name="search.userTypes"
                                                       list="${userTypeSearchKeys}" listKey="key" value="${command.search.userTypes}"
                                                       listValue="value" callback="changeKey"/>
                                    </span>
                                    <input type="text" class="form-control account_input list-search-input-text"
                                           name="search.usernames" id="operator" placeholder="${views.report_auto['多个账号']}" value="${command.search.usernames}">

                                </div>
                            </div>
                            <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group date">
                                    <span class="input-group-addon bg-gray">${views.report_auto['交易号']}</span>
                                    <input type="text" class="form-control" id="operator2" name="search.transactionNo" value="${command.search.transactionNo}">
                                </div>
                            </div>
                            <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group">
                                    <span class="input-group-addon bg-gray">${views.report_auto['资金类型']}</span>
                                    <span class=" input-group-addon bdn right-btn-down">
                                        <div class="btn-group table-desc-right-t-dropdown" initprompt="10${views.report_auto['条']}" callback="query">
                                            <button type="button" class="btn btn btn-default right-radius type-search-btn">
                                                <span prompt="prompt" class="tranTypeNum">${views.report_auto['请选择']}</span>
                                                <span class="caret-a pull-right"></span>
                                            </button>
                                        </div>
                                    </span>
                                </div>
                                <input type="hidden" id="fundTypeMemory" value='[<c:forEach items="${command.search.transactionWays}" var="tw" varStatus="loop">{"name":"search.transactionWays","value":"${tw}"}<c:if test="${!loop.last}">,</c:if><c:if test="${loop.last && (!empty command.search.manualSaves || !empty command.search.manualWithdraws)}">,</c:if> </c:forEach><c:forEach items="${command.search.manualSaves}" var="tw" varStatus="loop">{"name":"search.manualSaves","value":"${tw}"}<c:if test="${!loop.last}">,</c:if><c:if test="${loop.last && !empty command.search.manualWithdraws}">,</c:if></c:forEach><c:forEach items="${command.search.manualWithdraws}" var="tw" varStatus="loop">{"name":"search.manualWithdraws","value":"${tw}"}<c:if test="${!loop.last}">,</c:if></c:forEach>]'/>
                                <div class="type-search">
                                    <div class="m-b-sm">
                                        <button type="button" class="btn btn-filter btn-xs" data-type="all">${views.report_auto['全选']}</button>
                                        <button type="button" class="btn btn-outline btn-filter btn-xs" data-type="clear" style="margin-right: 10px;">${views.report_auto['清空']}</button>
                                        <button type="button" class="btn btn-outline btn-filter btn-xs" data-type="deposit">${views.report_auto['所有存款']}</button>
                                        <button type="button" class="btn btn-outline btn-filter btn-xs" data-type="withdraw">${views.report_auto['所有取款']}</button>
                                        <button type="button" class="btn btn-outline btn-filter btn-xs" data-type="checkCompany">${views.report_auto['公司入款']}</button>
                                        <button type="button" class="btn btn-outline btn-filter btn-xs" data-type="checkOnline">${views.report_auto['线上支付']}</button>
                                    </div>
                                    <div class="m-t">
                                        <table class="table table-bordered m-b-xxs">
                                            <tbody>
                                            <tr class="title-search">
                                                <td class=" al-left">
                                                    <label>
                                                        <input type="checkbox" class="i-checks Ptype" data-type="1">
                                                            <span class="search-game-title m-l-xs">
                                                                <b>${views.report_auto['玩家存取']}</b>
                                                            </span>
                                                    </label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="al-left" style="padding-left: 15px;">
                                                    <c:set var="depositType" value="<%=TransactionTypeEnum.DEPOSIT.getCode()%>"/>
                                                    <c:set var="withdrawType" value="<%=TransactionTypeEnum.WITHDRAWALS.getCode()%>"/>
                                                    <label class="fwn m-r-sm">
                                                        <input type="checkbox" class="i-checks tranType deposit checkOnline" transaction-type="${depositType}" data-type="1" name="search.transactionWays" value="online_deposit">
                                                        <span class="m-l-xs">${views.report_auto['线上支付']}</span>
                                                    </label>
                                                    <label class="fwn m-r-sm">
                                                        <input type="checkbox" class="i-checks tranType deposit checkCompany" transaction-type="${depositType}" data-type="1" name="search.transactionWays" value="online_bank">
                                                        <span class="m-l-xs">${views.report_auto['网银存款']}</span>
                                                    </label>
                                                    <label class="fwn m-r-sm">
                                                        <input type="checkbox" class="i-checks tranType deposit checkOnline" transaction-type="${depositType}" data-type="1" name="search.transactionWays" value="wechatpay_scan">
                                                        <span class="m-l-xs">${views.report_auto['微信扫码支付']}</span>
                                                    </label>
                                                    <label class="fwn m-r-sm">
                                                        <input type="checkbox" class="i-checks tranType deposit checkOnline" transaction-type="${depositType}" data-type="1" name="search.transactionWays" value="alipay_scan">
                                                        <span class="m-l-xs">${views.report_auto['支付宝扫码支付']}</span>
                                                    </label>
                                                    <label class="fwn m-r-sm">
                                                        <input type="checkbox" class="i-checks tranType deposit checkOnline" transaction-type="${depositType}" data-type="1" name="search.transactionWays" value="qqwallet_scan">
                                                        <span class="m-l-xs">${views.report_auto['QQ钱包扫码支付']}</span>
                                                    </label>
                                                    <label class="fwn m-r-sm">
                                                        <input type="checkbox" class="i-checks tranType deposit checkCompany" transaction-type="${depositType}" data-type="1" name="search.transactionWays" value="wechatpay_fast">
                                                        <span class="m-l-xs">${views.report_auto['微信电子支付']}</span>
                                                    </label>
                                                    <label class="fwn m-r-sm">
                                                        <input type="checkbox" class="i-checks tranType deposit checkCompany" transaction-type="${depositType}" data-type="1" name="search.transactionWays" value="alipay_fast">
                                                        <span class="m-l-xs">${views.report_auto['支付宝电子支付']}</span>
                                                    </label>
                                                    <label class="fwn m-r-sm">
                                                        <input type="checkbox" class="i-checks tranType deposit checkCompany" transaction-type="${depositType}" data-type="1" name="search.transactionWays" value="alipay_fast">
                                                        <span class="m-l-xs">比特币支付</span>
                                                    </label>
                                                    <label class="fwn m-r-sm">
                                                        <input type="checkbox" id="atm_money" class="i-checks tranType deposit checkCompany" transaction-type="${depositType}" data-type="1" name="search.transactionWays" value="atm_money">
                                                        <input type="hidden" value="atm_counter" />
                                                        <input type="hidden" value="atm_recharge" />
                                                        <span class="m-l-xs">${views.report_auto['柜员机']}</span>
                                                    </label>
                                                    <label class="fwn m-r-sm">
                                                        <input type="checkbox" class="i-checks tranType deposit checkCompany" transaction-type="${depositType}" data-type="1" name="search.transactionWays" value="other_fast">
                                                        <span class="m-l-xs">${views.report_auto['其他电子支付']}</span>
                                                    </label>
                                                    <%--<label class="fwn m-r-sm">
                                                        <input type="checkbox" class="i-checks tranType" data-type="1" name="search.transactionWays">
                                                        <span class="m-l-xs">${views.report_auto['点卡支付']}</span>
                                                    </label>--%>
                                                    <label class="fwn m-r-sm">
                                                        <input type="checkbox" class="i-checks tranType withdraw" data-type="1" transaction-type="${depositType}"  name="search.transactionWays" value="player_withdraw">
                                                        <span class="m-r-xs">${views.report_auto['玩家取款']}</span>
                                                    </label>
                                                </td>
                                            </tr>
                                            </tbody>
                                            <tbody>
                                                <tr class="title-search">
                                                    <td class=" al-left">
                                                        <label>
                                                            <input type="checkbox" class="i-checks Ptype" data-type="2">
                                                            <span class="search-game-title m-l-xs">
                                                                <b>${views.report_auto['人工存入']}</b>
                                                            </span>
                                                        </label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="al-left" style="padding-left: 15px;">
                                                        <label class="fwn m-r-sm">
                                                            <input type="checkbox" class="i-checks tranType deposit" transaction-type="${depositType}" data-type="2" name="search.manualSaves" value="manual_deposit">
                                                            <span class="m-l-xs">${views.report_auto['人工存取']}</span>
                                                        </label>
                                                        <label class="fwn m-r-sm">
                                                            <input type="checkbox" class="i-checks tranType" data-type="2" transaction-type="${depositType}" name="search.manualSaves" value="manual_favorable">
                                                            <span class="m-l-xs">${views.report_auto['优惠活动']}</span>
                                                        </label>
                                                        <label class="fwn m-r-sm">
                                                            <input type="checkbox" class="i-checks tranType" data-type="2" transaction-type="${depositType}" name="search.manualSaves" value="manual_rakeback">
                                                            <span class="m-l-xs">${views.report_auto['返水']}</span>
                                                        </label>
                                                        <label class="fwn m-r-sm">
                                                            <input type="checkbox" class="i-checks tranType deposit" transaction-type="${depositType}" data-type="2" name="search.manualSaves" value="manual_payout">
                                                            <span class="m-l-xs">${views.report_auto['派彩']}</span>
                                                        </label>
                                                        <label class="fwn m-r-sm">
                                                            <input type="checkbox" class="i-checks tranType deposit" transaction-type="${depositType}" data-type="2" name="search.manualSaves" value="manual_other">
                                                            <span class="m-l-xs">${views.report_auto['其他']}</span>
                                                        </label>
                                                    </td>
                                                </tr>
                                            </tbody>
                                            <tbody>
                                            <tr class="title-search">
                                                <td class="al-left">
                                                    <label>
                                                        <input type="checkbox" class="i-checks Ptype" data-type="3">
                                                        <span class="search-game-title m-l-xs">
                                                            <b>${views.report_auto['人工取出']}</b>
                                                        </span>
                                                    </label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="al-left" style="padding-left: 15px;">
                                                    <label class="fwn m-r-sm">
                                                        <input type="checkbox" class="i-checks tranType withdraw" transaction-type="${depositType}" data-type="3" name="search.manualWithdraws" value="manual_deposit">
                                                        <span class="m-l-xs">${views.report_auto['人工存取']}</span>
                                                    </label>
                                                    <label class="fwn m-r-sm">
                                                        <input type="checkbox" class="i-checks tranType withdraw" transaction-type="${depositType}" data-type="3" name="search.manualWithdraws" value="manual_favorable">
                                                        <span class="m-l-xs">${views.report_auto['优惠活动']}</span>
                                                    </label>
                                                    <label class="fwn m-r-sm">
                                                        <input type="checkbox" class="i-checks tranType withdraw" transaction-type="${depositType}" data-type="3" name="search.manualWithdraws" value="manual_rakeback">
                                                        <span class="m-l-xs">${views.report_auto['返水']}</span>
                                                    </label>
                                                    <label class="fwn m-r-sm">
                                                        <input type="checkbox" class="i-checks tranType withdraw" transaction-type="${depositType}" data-type="3" name="search.manualWithdraws" value="manual_payout">
                                                        <span class="m-l-xs">${views.report_auto['派彩']}</span>
                                                    </label>
                                                    <label class="fwn m-r-sm">
                                                        <input type="checkbox" class="i-checks tranType withdraw" transaction-type="${depositType}" data-type="3" name="search.manualWithdraws" value="manual_other">
                                                        <span class="m-l-xs">${views.report_auto['其他']}</span>
                                                    </label>
                                                </td>
                                            </tr>
                                            </tbody>
                                            <tbody>
                                            <tr class="title-search">
                                                <td class=" al-left">
                                                    <label>
                                                        <input type="checkbox" class="i-checks Ptype" data-type="4">
                                                        <span class="search-game-title m-l-xs">
                                                            <b>${views.report_auto['线上优惠']}</b>
                                                        </span>
                                                    </label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="al-left" style="padding-left: 15px;">
                                                    <label class="fwn m-r-sm">
                                                        <input type="checkbox" class="i-checks tranType" transaction-type="${depositType}" data-type="4" name="search.transactionWays" value="first_deposit">
                                                        <span class="m-l-xs">${views.report_auto['首存送']}</span>
                                                    </label>
                                                    <label class="fwn m-r-sm">
                                                        <input type="checkbox" class="i-checks tranType" transaction-type="${depositType}" data-type="4" name="search.transactionWays" value="deposit_send">
                                                        <span class="m-l-xs">${views.report_auto['存就送']}</span>
                                                    </label>
                                                    <label class="fwn m-r-sm">
                                                        <input type="checkbox" class="i-checks tranType" data-type="4" transaction-type="${depositType}" name="search.transactionWays" value="regist_send">
                                                        <span class="m-l-xs">${views.report_auto['注册送']}</span>
                                                    </label>
                                                    <label class="fwn m-r-sm">
                                                        <input type="checkbox" class="i-checks tranType" data-type="4" transaction-type="${depositType}" name="search.transactionWays" value="relief_fund">
                                                        <span class="m-l-xs">${views.report_auto['救济金']}</span>
                                                    </label>
                                                    <label class="fwn m-r-sm">
                                                        <input type="checkbox" class="i-checks tranType" data-type="4" transaction-type="${depositType}" name="search.transactionWays" value="profit_loss">
                                                        <span class="m-l-xs">${views.report_auto['盈亏送']}</span>
                                                    </label>
                                                    <label class="fwn m-r-sm">
                                                        <input type="checkbox" class="i-checks tranType" data-type="4" transaction-type="${depositType}" name="search.transactionWays" value="effective_transaction">
                                                        <span class="m-l-xs">${views.report_auto['有效投注额']}</span>
                                                    </label>
                                                    <label class="fwn m-r-sm">
                                                        <input type="checkbox" class="i-checks tranType" data-type="4" transaction-type="${depositType}" name="search.transactionWays" value="money">
                                                        <span class="m-l-xs">${views.report_auto['红包']}</span>
                                                    </label>
                                                </td>
                                            </tr>
                                            </tbody>
                                            <tbody>
                                            <tr class="title-search">
                                                <td class=" al-left">
                                                    <label><input type="checkbox" class="i-checks Ptype" data-type="5">
                                                        <span class="search-game-title m-l-xs">
                                                            <b>${views.report_auto['玩家推荐']}</b></span>
                                                    </label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="al-left" style="padding-left: 15px;">
                                                    <label class="fwn m-r-sm">
                                                        <input type="checkbox" class="i-checks tranType" data-type="5" transaction-type="${depositType}" name="search.transactionWays" value="single_reward">
                                                        <span class="m-r-xs">${views.report_auto['单次奖励']}</span>
                                                    </label>
                                                    <label class="fwn m-r-sm">
                                                        <input type="checkbox" class="i-checks tranType" data-type="5" transaction-type="${depositType}" name="search.transactionWays" value="bonus_awards">
                                                        <span class="m-l-xs">${views.report_auto['推荐红利']}</span>
                                                    </label>
                                                </td>
                                            </tr>
                                            </tbody>
                                            <tbody>
                                            <tr class="title-search">
                                                <td class=" al-left">
                                                    <label>
                                                        <input type="checkbox" class="i-checks tranType backWater" transaction-type="${depositType}" name="search.transactionWays" value="back_water">
                                                        <span class="search-game-title m-l-xs">
                                                            <b>${views.report_auto['返水结算']}</b>
                                                        </span>
                                                    </label>
                                                    <label>
                                                        <input type="checkbox" class="i-checks tranType backMoney" transaction-type="${depositType}" name="search.transactionWays" value="refund_fee">
                                                        <span class="search-game-title m-l-xs">
                                                            <b>${views.report_auto['返手续费']}</b>
                                                        </span>
                                                    </label>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group date time-select-a">
                                    <span class="input-group-addon bg-gray">${views.report_auto['完成时间']}</span>
                                    <gb:dateRange format="${DateFormat.DAY_SECOND}"  minDate="${minDate}" useRange="true" style="width:38%;" useToday="true" btnClass="search" startName="search.startTime" endName="search.endTime" startDate="${command.search.startTime}" endDate="${command.search.endTime}"/>

                                   <%-- <gb:dateRange format="${DateFormat.DAY_SECOND}" style="width:43%" useRange="true"
                                                  opens="right" position="down"
                                                  startDate="${command.search.startTime}"
                                                  endDate="${command.search.endTime}"
                                                  startName="search.startTime" endName="search.endTime"/>--%>
                                </div>
                            </div>
                            <%--<div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group">
                                    <span class="input-group-addon bg-gray">${views.report_auto['层级']}</span>
                                        <span class="bdn right-btn-down">
                                            <div class="btn-group table-desc-right-t-dropdown" initprompt="10条" callback="query">
                                                <button type="button" class="btn btn btn-default right-radius rank-btn">
                                                    <span class="rankText" prompt="prompt">${views.report_auto['请选择']}</span>
                                                    <span class="caret-a pull-right"></span>
                                                </button>
                                                <c:forEach items="${command.search.playerRanks}" var="rank">
                                                    <input type="hidden" class="playerRanks" data-value="${rank}" />
                                                </c:forEach>
                                                <div class="dropdown-menu playerRank">
                                                    <div class="search-top-menu" style="margin-top: 10px;margin-left: 10px;">
                                                        <button type="button" data-type="all" class="btn btn-filter btn-xs"  >${views.operation['backwater.settlement.choose.allChoose']}</button>
                                                        <button type="button" data-type="clear" class="btn btn-outline btn-filter btn-xs" >${views.operation['backwater.settlement.choose.clear']}</button>
                                                    </div>
                                                    <div class="m-t">
                                                        <table class="table table-bordered m-b-xxs">
                                                            <tbody>
                                                            <tr>
                                                                <td class="al-left">
                                                                    <c:forEach items="${playerRanks}" var="pr" varStatus="playerRanks">
                                                                        <label class="m-r-sm">
                                                                            <input type="checkbox" name="search.playerRanks" class="i-checks" value="${pr.id}">
                                                                            <span class="m-l-xs">${pr.rankName}</span>
                                                                        </label>
                                                                    </c:forEach>
                                                                </td>
                                                            </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </span>
                                </div>
                            </div>--%>
                            <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm h-line-a">
                                <div class="input-group">
                                    <span class="input-group-addon bg-gray">${views.report_auto['来源终端']}</span>
                                    <input type="hidden" id="origin" value="${command.search.origin}">
                                    <span class=" input-group-addon bdn  right-btn-down">
                                        <div class="btn-group table-desc-right-t-dropdown">
                                            <ul role="menu">
                                                <li role="presentation">
                                                    <label><input class="allOrigin" type="radio" name="search.origin" value="">${views.report_auto['全部']}</label>
                                                </li>
                                                <li role="presentation">
                                                    <label><input type="radio" name="search.origin" value="PC">${views.report_auto['PC端']}</label>
                                                </li>
                                                <li role="presentation">
                                                    <label><input type="radio" name="search.origin" value="MOBILE">${views.report_auto['手机端']}</label>
                                                </li>
                                            </ul>
                                        </div>
                                    </span>
                                </div>
                            </div>
                            <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group time-select-a">
                                    <span class="input-group-addon bg-gray">${views.report_auto['金额']}</span>
                                    <span class="input-group-addon border-right-none">${views.report_auto['起']}</span>
                                    <input type="text" class="form-control border-left-none" name="search.startMoney" value="${command.search.startMoney}">
                                    <span class="input-group-addon time-select-t">~</span>
                                    <span class="input-group-addon border-right-none">${views.report_auto['止']}</span>
                                    <input type="text" class="form-control border-left-none" name="search.endMoney" value="${command.search.endMoney}">
                                </div>
                            </div>

                            <div class="show-demand-a">
                                <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                                    <div class="input-group date time-select-a">
                                        <span class="input-group-addon bg-gray">${views.report_auto['创建时间']}</span>
                                        <gb:dateRange format="${DateFormat.DAY_SECOND}" style="width:38%" useRange="true"
                                                      maxDate="${maxDate}" opens="right" position="down"
                                                      startDate="${command.search.startCreateTime}"
                                                      endDate="${command.search.endCreateTime}"
                                                      startName="search.startCreateTime" endName="search.endCreateTime"/>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="col-sm-12 clearfix template-menu">
                            <button type="button" class="btn btn-filter btn-outline pull-right  show-demand-b"><i
                                    class="fa fa-chevron-down"></i> ${views.report_auto['高级搜索']}
                            </button>
                            <soul:button target="resetFundsLog" text="${views.report_auto['重置']}" opType="function" cssClass="btn btn-filter reset-condition-button" />
                            <soul:button precall="validateForm" target="query" text="" cssClass="btn btn-filter mediate-search-btn"
                                         opType="function">
                                <i class="fa fa-search"></i><span class="hd">&nbsp;${views.common['search']}</span>
                            </soul:button>

                            <%@include file="/sysSearchTemplate/SearchTemplate.jsp"%>
                        </div>


                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12 m-t">
            <div class="wrapper white-bg shadow summary" style="display: ${isSummary?'block':'none'}">
                <%@ include file="Summary.jsp"%>
            </div>
            <div class="wrapper white-bg shadow fundsLog" style="display: ${isSummary?'none':'block'};">
                <div class="dataTables_wrapper">
                    <div class="sys_tab_wrap clearfix">
                        <div class="clearfix m-sm">
                            <b>${views.report_auto['已选']}：</b>
                            <span class="co-yellow tranDisplay">${views.report_auto['未筛选资金类型']}</span>
                            <%--<span>|</span>
                            <span class="co-yellow rankDisplay">${views.report_auto['未筛选玩家层级']}</span>--%>
                            <div class="pull-right m-t-n-xxs">
                                <soul:button permission="report:fundrecord_export" tag="button" cssClass="btn btn-export-btn btn-primary-hide"
                                             text="${views.common['export']}" callback="gotoExportHistory"
                                             precall="validExportCount" post="getCurrentFormData" title="${views.role['player.dataExport']}"
                                             target="${root}/report/vPlayerFundsRecord/export.html" opType="ajax">
                                    <i class="fa fa-sign-out"></i><span class="hd">${views.report['fund.list.export']}</span>
                                </soul:button>
                            </div>
                        </div>
                    </div>
                    <div class="search-list-container">
                        <%@ include file="IndexPartial.jsp" %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form:form>

<!--//region your codes 3-->
<script type="text/javascript">
    curl(["site/report/funds/Index",'gb/sysSearchTemplate/SysSearchTemplate'], function(Page,SysSearchTemplate) {
        page =new Page();
        page.bindButtonEvents();
        page.sysSearchTmp = new SysSearchTemplate();
    });
</script>
<!--//endregion your codes 3-->