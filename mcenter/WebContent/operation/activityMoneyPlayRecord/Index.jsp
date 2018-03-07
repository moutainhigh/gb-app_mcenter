<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>

<div class="row">
    <form:form action="${root}/activityMoneyPlayRecord/list.html" method="post" name="playerOnlineForm">
        <input type="hidden" name="search.activityMessageId" class="form-control" value="${command.search.activityMessageId}"/>
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['运营']}&nbsp;&nbsp;/</span><span>${views.sysResource['活动管理']}</span>
            <soul:button target="goToLastPage" refresh="false" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>

        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <div class="detect-wrap clearfix p-sm">

                    <div class="pull-left col-sm-5 p-x">
                        <div class="line-hi25 col-sm-12">
                            <b>${views.column['红包']}：</b>

                        </div>
                        <div class="line-hi25 col-sm-12">
                            ${views.column['通过抢红包,玩家有一定几率获取优惠']}

                        </div>
                    </div>

                    <div class="pull-left col-sm-5 p-x">
                        <div class="line-hi25 col-sm-12">
                            <b>${views.operation_auto['活动名称']}：${command.activityMessage.activityName}</b>

                        </div>
                        <div class="line-hi25 col-sm-12">
                            <b>${views.operation_auto['活动时间']}：${soulFn:formatDateTz(command.activityMessage.startTime, DateFormat.DAY_SECOND,timeZone)}~${soulFn:formatDateTz(command.activityMessage.endTime, DateFormat.DAY_SECOND,timeZone)}</b>

                        </div>
                    </div>


                </div>




                <div class="detect-wrap clearfix p-sm">
                     <b>
                     ${views.column['参与人数：']}　　${command.statisticsRecord.allPlayerCount}
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        ${views.column['中奖总金额：']}   ${siteCurrencySign}${command.statisticsRecord.allWinAmount}
                     </b>
                </div>
                <div class="detect-wrap clearfix p-sm">
                <b>开放时间段统计</b>


                <div class="clearfix filter-wraper border-b-1">
                    <div class="search-wrapper btn-group pull-left m-r-n-xs">
                        <div class="input-group">
                            <%--<input type="text" name="search.username" class="form-control" placeholder="${views.fund['playerDetect.view.playerAccount']}" value="${command1.search.username}"/>--%>

                            <span class="input-group-addon bg-gray">${views.fund['创建时间']}</span>
                            <%--<gb:dateRange format="${DateFormat.DAY}" minDate="${minDate}" maxDate="${maxDate}" useRange="true" style="width:42%;" useToday="true" btnClass="search" startName="search.startTime" endName="search.endTime" startDate="" endDate=""/>--%>

                            <span class="input-group-btn">
                                <soul:button target="query" opType="function" cssClass="btn btn-filter btn-query-css" tag="button" text="">
                                    <i class="fa fa-search"></i>
                                    <span class="hd">&nbsp;${views.common['search']}</span>
                                </soul:button>
                            </span>
                        </div>
                    </div>
                </div>
                <div id="editable_wrapper2" class="dataTables_wrapper" role="grid">
                    <div class="search-list-container2">
                        <%@ include file="IndexPartialTime.jsp" %>
                    </div>
                </div>
                </div>
                <div class="detect-wrap clearfix p-sm">

                <b>玩家参与记录</b>


                <div class="clearfix filter-wraper border-b-1">
                    <div class="search-wrapper btn-group pull-left m-r-n-xs">
                        <div class="input-group">
                            <input type="text" name="search.username" class="form-control" placeholder="${views.fund['playerDetect.view.playerAccount']}" value="${command1.search.username}"/>

                            <span class="input-group-btn">
                                <soul:button target="query" opType="function" cssClass="btn btn-filter btn-query-css" tag="button" text="">
                                    <i class="fa fa-search"></i>
                                    <span class="hd">&nbsp;${views.common['search']}</span>
                                </soul:button>
                            </span>
                        </div>
                    </div>
                </div>

                <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
                    <div class="search-list-container">
                        <%@ include file="IndexPartial.jsp" %>
                    </div>
                </div>
                </div>
            </div>
        </div>
    </form:form>
</div>
<soul:import res="site/player/playeronline/Playeronline"/>