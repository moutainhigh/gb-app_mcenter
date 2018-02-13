<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.RebateAgentListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<div class="row">
    <form action="${root}/rebateAgent/list.html" method="post">
        <input type="hidden" name="search.agentIds" value="${command.search.agentIds}">
        <div id="validateRule" style="display: none">${command.validateRule}</div>
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.fund_auto['资金管理']}</span>
            <span>/</span><span>${views.fund_auto['返佣结算']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <!--筛选条件-->
                <div class="m-t-md">
                    <div class="m-b-xs clearfix">
                        <div class="col-sm-12 clearfix" style="padding-left: 0;">
                            <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group">
                                    <span class="input-group-addon bg-gray">${views.wc_fund['期数选择']}</span>
                                    <span class=" input-group-addon bdn  right-btn-down">
                                        <gb:select name="search.rebateBillId" prompt="" cssClass="chosen-select-no-single" value="${command.search.rebateBillId}" list="${periodMap}" />
                                    </span>
                                </div>
                            </div>

                            <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group date">
                                    <span>
                                        <gb:select name="search.agentRank" prompt="${views.wc_fund['所有代理']}" value="${command.search.agentRank}" list="${agentRanks}" listKey="key" listValue="value" />
                                    </span>
                                        <%--${views.fund_auto['代理账号']}--%>
                                    <span class=" input-group-addon bdn  right-btn-down">
                                        <input type="text" class="form-control content-width-limit-8" name="search.agentName">
                                    </span>
                                </div>
                            </div>

                            <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group time-select-a">
                                    <span class="input-group-addon bg-gray">${views.wc_fund['可获返佣']}</span>
                                    <span class="input-group-addon border-right-none">${views.player_auto['起']}</span>
                                    <input type="type" class="form-control border-left-none" name="search.rebateTotalBegin" value="">
                                    <span class="input-group-addon time-select-t">~</span>
                                    <span class="input-group-addon border-right-none">${views.player_auto['止']}</span>
                                    <input type="type" class="form-control border-left-none" name="search.rebateTotalEnd" value="">
                                </div>
                            </div>

                            <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm function-menu-show hide">
                                <soul:button tag="button" target="${root}/rebateAgent/batchSettled.html" opType="ajax" precall=""
                                             text="${views.fund_auto['结算']}" post="getSelectIds" cssClass="btn btn-filter" callback="query" confirm="${views.fund_auto['确认要批量结算吗？']}">${views.fund_auto['结算']}
                                </soul:button>
                                <soul:button tag="button" target="${root}/rebateAgent/batchClear.html" opType="ajax" precall=""
                                             text="${views.fund_auto['清除']}" post="getSelectIds" cssClass="btn btn-filter" callback="query" confirm="${views.fund_auto['确认要批量清除吗？']}">${views.fund_auto['清除']}
                                </soul:button>
                                <soul:button tag="button" target="${root}/rebateAgent/batchSignBill.html" opType="ajax" precall=""
                                             text="${views.wc_fund['挂账']}" post="getSelectIds" cssClass="btn btn-filter" callback="query" confirm="${views.fund_auto['确认要批量挂账吗？']}">${views.wc_fund['挂账']}
                                </soul:button>
                            </div>

                            <soul:button target="query" opType="function" tag="button" text="${views.common['search']}" cssClass="btn btn-filter" precall="validateForm">
                                <i class="fa fa-search"></i>
                                <span class="hd">&nbsp;${views.common['search']}</span>
                            </soul:button>

                            <soul:button tag="button" cssClass="btn btn-export-btn btn-primary-hide"
                                         text="${views.common['export']}" callback="gotoExportHistory"
                                         precall="validExportCount" post="getCurrentFormData" title="${views.role['player.dataExport']}"
                                         target="${root}/rebateAgent/exportRecords.html" opType="ajax">
                                <i class="fa fa-sign-out"></i><span class="hd">${views.common['export']}</span>
                            </soul:button>

                            <%--<a href="/fund/rebate/list.html" nav-target="mainFrame" class="btn btn-filter btn-outline pull-right">${views.fund_auto['旧版入口']}</a>--%>
                        </div>
                    </div>
                </div>
                <!--表格内容-->
                <div id="editable_wrapper" class="dataTables_wrapper" role="grid">

                    <div class="search-list-container">
                        <%@ include file="IndexPartial.jsp" %>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<!--//region your codes 3-->
<soul:import res="site/operation/rebate/Index"/>
<!--//endregion your codes 3-->