<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VPlayerGameOrderVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>

<div class="row">
    <form:form action="${root}/report/gameTransaction/list.html" method="post">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['统计']}</span><span>/</span>
            <span>${views.sysResource['投注记录']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
            <soul:button target="goToLastPage" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow clearfix">
                <div class="sys_tab_wrap clearfix">
                    <b class="m-l">${views.column['VPlayerGameOrder.jyjlxx']}</b>
                </div>
                <div class="clearfix m-l-lg line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.column['VPlayerGameOrder.playerAccount']}：</label>
                <div class="col-sm-5 co-blue3">${command.result.username}</div>
            </div>
                <div class="clearfix m-l-lg line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.column['VPlayerGameOrder.orderNo']}：</label>
                    <div class="col-sm-5 co-blue3">
                        ${command.result.betId}
                        <c:if test="${command.result.terminal eq '2'}">
                            &nbsp;
                            <span class="fa fa-mobile mobile" data-content="${views.report_auto['手机投注']}" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                            </span>
                        </c:if>
                    </div>
                </div>
                <c:set value="${gbFn:getApiName(command.result.apiId.toString())}" var="apiName"/>
                <c:set value="${gbFn:getSiteApiName(command.result.apiId.toString())}" var="siteApiName"/>
                <c:set value="${gbFn:getGameTypeName(command.result.gameType.toString())}" var="gameType"/>

                <div class="clearfix m-l-lg line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.column['VPlayerGameOrder.yxgys']}：</label>
                    <div class="col-sm-5">${empty siteApiName?apiName:siteApiName}</div>
                </div>
                <div class="clearfix m-l-lg line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.column['VPlayerGameOrder.yxzl']}：</label>
                    <div class="col-sm-5">${empty siteApiName?apiName:siteApiName} &gt;&gt; ${gameType}</div>
                </div>
                <div class="clearfix m-l-lg line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.column['VPlayerGameOrder.createTime']}：</label>
                    <div class="col-sm-5">${soulFn:formatDateTz(command.result.betTime, DateFormat.DAY_SECOND,timeZone)}</div>
                </div>
                <div class="clearfix m-l-lg line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.column['VPlayerGameOrder.singleAmount']}：</label>
                    <div class="col-sm-5">${soulFn:formatCurrency(command.result.singleAmount)}</div>
                </div>
                <div class="clearfix m-l-lg line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.column['VPlayerGameOrder.payoutTime']}：</label>
                    <div class="col-sm-5">${soulFn:formatDateTz(command.result.payoutTime, DateFormat.DAY_SECOND,timeZone)}</div>
                </div>
                <div class="clearfix m-l-lg line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.column['VPlayerGameOrder.payout']}：</label>
                    <div class="col-sm-5"><span class="co-red">${empty command.result.profitAmount?'-':command.result.profitAmount}</span></div>
                </div>
                <c:if test="${! empty command.result.winningAmount}">
                    <div class="clearfix m-l-lg line-hi34">
                        <label class="ft-bold col-sm-3 al-right">${views.report_auto['彩池奖金']}：</label>
                        <div class="col-sm-5"><span class="co-red">${soulFn:formatCurrency(command.result.winningAmount)}</span></div>
                    </div>
                </c:if>
                <div class="clearfix m-l-lg line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.column['VPlayerGameOrder.effectiveTradeAmount']}：</label>
                    <div class="col-sm-5">${empty command.result.effectiveTradeAmount?'--':soulFn:formatCurrency(command.result.effectiveTradeAmount)}</div>
                </div>
                <div class="clearfix m-l-lg line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.column['VPlayerGameOrder.gameApi']}：</label>
                    <div class="col-sm-5">
                        <%@ include file="/gameOrder/detail.jsp" %>
                    </div>
                </div>
            </div>
        </div>
    </form:form>
</div>
<soul:import res="site/report/gameOrder/Details"/>
