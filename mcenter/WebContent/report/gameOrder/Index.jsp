<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VPlayerGameOrderListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>

<div class="row">
    <form:form action="${root}/report/gameTransaction/list.html" method="post" id="searchForm">
        <input id="gametypeList" cssClass="search" name="search.gametypeList" type="hidden" value="${command.search.gametypeList}"/>
        <input id="apiList" cssClass="search" name="search.apiList" type="hidden" value="${command.search.apiList}"/>
        <div id="validateRule" style="display: none">${command.validateRule}</div>
        <input type="hidden" id="profitAmount" value="${command.search.profitAmount}"/>
        <input type="hidden" id="orderState" value="${command.search.orderState}"/>
        <input name="selectGameTypeText" type="hidden" >
        <%-- 角色管理-玩家管理- 交易详情链接--%>
        <input type="hidden" name="search.playerId" value="${command.search.playerId}"/>
        <%--<form:hidden path="search.isCondition"/>--%>
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['统计']}</span><span>/</span>
            <span>${views.sysResource['投注记录']}${isMaster}</span>
            <c:if test="${command.link}">
                <soul:button tag="a" target="goToLastPage" text="" opType="function" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn">
                    <em class="fa fa-caret-left"></em>${views.common['return']}
                </soul:button>
            </c:if>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow clearfix">
                <div class="clearfix m-t-xs">
                    <%--站点--%>
                    <c:if test="${command.master}">

                    <div class="form-group clearfix pull-left content-width-limit-250 m-t-sm m-b-none">
                        <div class="input-group date">
                            <span class="input-group-addon abroder-no"><b>${views.column['VPlayerGameOrder.site']}：</b></span>
                            <div class="">
                                <select val="${command._getDataSourceId()}"  style="display: none" class="btn-group chosen-select-no-single" name="search.siteId">
                                    <c:forEach items="${command.sites}" var="site">
                                        <option value="${site.id}">${site.siteNameI18n}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>

                    </c:if>
                    <%--游戏类型--%>
                    <div class="form-group clearfix line-hi34 pull-left content-width-limit-30 m-t-sm m-b-none">
                        <div class="input-group date">
                            <span class="input-group-addon abroder-no"><b>${views.column['VPlayerGameOrder.gameType']}：</b></span>
                            <soul:button  target="${root}/report/gameTransaction/Choose.html" callback="apiVal" text="${views.common['select']}${views.column['VPlayerGameOrder.gameType']}" opType="dialog"/>
                        </div>
                    </div>
                </div>
                <div class="clearfix m-t-xs">
                    <div class="form-group clearfix pull-left content-width-limit-500 m-t-sm m-b-none">
                        <div class="input-group" >
                            <span class="input-group-addon abroder-no"><b>${views.report['fund.list.account']}</b></span>
                                    <span class="input-group-btn">
                                        <gb:select name="searchKeys" list="${searchKeys}" listKey="key" value="search.username" listValue="value"  callback="changeKey"/>
                                    </span>
                            <input class="form-control search list-search-input-text" placeholder="${views.column['VPlayerGameOrder.username']}" type="text" id="operator" value="${command.search.username}" name="search.username">
                        </div>
                    </div>

                    <%-- 交易时间 --%>
                    <div class="form-group clearfix pull-left content-width-limit-500 m-t-sm m-b-none">
                        <div class="input-group date">
                            <span class="input-group-addon abroder-no"><b>${views.column['VPlayerGameOrder.createTime']}：</b></span>
                            <gb:dateRange format="${DateFormat.DAY_SECOND}" style="width:160px" useRange="true" useToday="true"
                                          callback="TimeCallBack" position="down" btnClass="search"
                                          startName="search.createStart" endName="search.createEnd"
                                          startDate="${command.search.createStart}" endDate="${command.search.createEnd}" />
                        </div>
                    </div>
                    <%-- 派彩时间 --%>
                    <div class="form-group clearfix pull-left content-width-limit-500 m-t-sm m-b-none">
                        <div class="input-group date">
                            <span class="input-group-addon abroder-no"><b>${views.column['VPlayerGameOrder.payoutTime']}：</b></span>
                            <gb:dateRange format="${DateFormat.DAY_SECOND}" style="width:160px" useRange="true"  useToday="true"
                                          position="down" callback="TimeCallBack" btnClass="search"
                                          startDate="${command.search.payoutStart}" endDate="${command.search.payoutEnd}"
                                          startName="search.payoutStart" endName="search.payoutEnd"/>
                        </div>
                    </div>


                </div>
                <div style="display: none;" class="clearfix advanced-options">
                    <div class="clearfix m-t-xs">
                        <div class="form-group clearfix pull-left content-width-limit-30 m-t-sm m-b-none">
                            <div class="input-group">
                                <span class="input-group-addon abroder-no"><b>${views.column['VPlayerGameOrder.singleAmount']}：</b></span>
                                <input class="form-control search" type="text" name="search.beginSingleAmount">
                                <span class="input-group-addon bg-gray">${views.column['VPlayerGameOrder.-']}</span>
                                <input class="form-control search" type="text" name="search.endSingleAmount">
                            </div>
                        </div>
                        <div class="form-group clearfix pull-left content-width-limit-30 m-t-sm m-b-none">
                            <div class="input-group">
                                <span class="input-group-addon abroder-no"><b>${views.column['VPlayerGameOrder.effectiveTradeAmount']}：</b></span>
                                <input class="form-control search" type="text" name="search.beginEffectiveTradeAmount">
                                <span class="input-group-addon bg-gray">${views.column['VPlayerGameOrder.-']}</span>
                                <input class="form-control search" type="text" name="search.endEffectiveTradeAmount">
                            </div>
                        </div>

                    </div>
                    <div class="clearfix m-t-xs">
                            <%--派彩金额--%>
                        <div class="form-group clearfix pull-left content-width-limit-30 m-t-sm m-b-none">
                            <div class="input-group">
                                <span class="input-group-addon abroder-no"><b>${views.column['VPlayerGameOrder.profitAmount']}：</b></span>
                                <input class="form-control search" type="text" name="search.beginProfitAmount">
                                <span class="input-group-addon bg-gray">${views.column['VPlayerGameOrder.-']}</span>
                                <input class="form-control search" type="text" name="search.endProfitAmount">
                            </div>
                        </div>
                            <%-- 派彩结果　--%>
                        <div class="form-group clearfix line-hi34 pull-left content-width-limit-30 m-t-sm m-b-none">
                            <div class="input-group">
                                <span class="input-group-addon abroder-no"><b>${views.column['VPlayerGameOrder.gameResult']}：</b></span>
                                <label class="m-b-none"><input class="i-checks search" name="search.profitAmount" type="radio" value="0">${views.column['VPlayerGameOrder.all']}</label>
                                <label class="m-b-none m-l-sm"><input class="i-checks search" name="search.profitAmount" type="radio" value="1.0">${views.column['VPlayerGameOrder.ying']}</label>
                                <label class="m-b-none m-l-sm"><input class="i-checks search" name="search.profitAmount" type="radio" value="2.0">${views.column['VPlayerGameOrder.kui']}</label>
                                <label class="m-b-none m-l-sm"><input class="i-checks search" name="search.profitAmount" type="radio" value="3.0">${views.column['VPlayerGameOrder.he']}</label>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix m-t-xs">
                            <%-- 流水号　--%>
                        <div class="form-group clearfix pull-left content-width-limit-30 m-t-sm m-b-none">
                            <div class="input-group">
                                <span class="input-group-addon abroder-no"><b>${views.report_auto['注单号']}：</b></span>
                                <input id="singleVal" class="form-control search" type="text" name="search.betId">
                            </div>
                        </div>
                            <%--　交易状态　--%>
                        <div class="form-group clearfix pull-left content-width-limit-500 m-t-sm m-b-none m-l-sm">
                            <div class="input-group">
                                <span class="input-group-addon abroder-no"><b>${views.column['VPlayerGameOrder.status']}：</b></span>
                                <label class="m-b-none"><input class="i-checks" name="search.orderState" type="radio" value="all">${views.column['VPlayerGameOrder.all']}</label>
                                <c:forEach items="${command.orderStateMap.values()}" var="p">
                                    <label class="m-b-none m-l-sm"><input class="i-checks search" name="search.orderState" type="radio" value="${p.dictCode}">${dicts.game.order_state[p.dictCode]}</label>
                                </c:forEach>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="operate-btn clearfix">
                    <input type="hidden" name="outer" value="${command.outer}" />
                    <soul:button target="queryByCondition" opType="function"  text="${views.report_auto['查询']}" cssClass="btn btn-filter  _search" />
                    <span class="btn btn-outline btn-filter pull-right btn-advanced-down"><i class="fa fa-angle-double-down m-r-sm"></i>${views.common['advancedFilter']}</span>

                </div>
            </div>
        </div>
        <div class="col-lg-12 m-t">
            <div class="wrapper white-bg shadow">
                <div class="dataTables_wrapper search-list-container">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
            </div>
        </div>
    </form:form>
</div>
<soul:import res="site/player/gameOrder/Index"/>
<script id="gameOrderRender" type="text/x-jsrender">
    <b>${views.report_auto['总计']}：</b>
    {{:data.listCount}}${views.report_auto['笔']}
    <b class="m-l">${views.report_auto['有效投注额']}：</b>
    <span  class="{{if data.effective<0}}co-red3{{else}}co-green{{/if}}">{{:data.effective}}</span>
    <b class="m-l">${views.report_auto['派彩']}：</b>
    <span  class="{{if data.profit<0}}co-red3{{else}}co-green{{/if}}">{{:data.profit}}</span>
    <b class="m-l">${views.report_auto['彩池奖金']}：</b>
    <span  class="{{if data.winning<0}}co-red3{{else}}co-green{{/if}}">
        {{if data.winning<=0}}0
        {{else}}
            <soul:button target="winningAmount" text="{{:data.winning}}" opType="function"/>
        {{/if}}
    </span>
    <%--<b class="m-l">${views.report_auto['彩池贡献金']}：</b>--%>
    <%--<span  class="{{if data.contribution<0}}co-red3{{else}}co-green{{/if}}">{{:data.contribution}}</span>--%>
</script>
