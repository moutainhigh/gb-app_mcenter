<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.rebate.vo.AgentRebateListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<div class="row">
    <form action="${root}/fund/rebate/list.html" method="post">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.fund_auto['资金管理']}</span>
            <span>/</span><span>${views.fund_auto['返佣结算']}</span>
            <soul:button target="goToLastPage" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <!--筛选条件-->
                <div class="m-t-md">
                    <div class="m-b-xs clearfix">
                        <div class="col-sm-12 clearfix" style="padding-left: 0;">
                            <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group">
                                    <span class="input-group-addon bg-gray">${views.fund_auto['期数选择']}</span>
                                    <span class=" input-group-addon bdn  right-btn-down">
                                        <gb:select name="search.yearmonth" cssClass="chosen-select-no-single" value="${command.search.yearmonth}"
                                                   list="${command.numberOfPeriods}" listKey="yearmonth" listValue="yearmonth"/>
                                    </span>
                                </div>
                            </div>

                            <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm content-width-limit-400">
                                <div class="input-group date">
                                    <span class="input-group-addon bg-gray">${views.fund_auto['代理账号']}</span>
                                    <input type="text" class="form-control content-width-limit-8" name="search.agentusername">
                                </div>
                            </div>
                            <%--<soul:button permission="role:player_export" tag="button"
                                         cssClass="btn btn-export-btn btn-primary-hide"
                                         text="${views.common['export']}" callback="gotoExportHistory"
                                         precall="validExportCount" post="getCurrentFormData"
                                         title="${views.role['player.dataExport']}"
                                         target="${root}/fund/rebate/export.html" opType="ajax">
                                <i class="fa fa-sign-out"></i><span class="hd">${views.common['export']}</span>
                            </soul:button>--%>
                            <soul:button target="query" opType="function" tag="button" text="${views.common['search']}" cssClass="btn btn-filter">
                                <i class="fa fa-search"></i>
                                <span class="hd">&nbsp;${views.common['search']}</span>
                            </soul:button>
                        </div>
                    </div>
                </div>
                <!--表格内容-->
                <div id="editable_wrapper" class="search-list-container dataTables_wrapper" role="grid">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
            </div>
        </div>
    </form>
</div>

<!--//region your codes 3-->
<soul:import type="list"/>
<!--//endregion your codes 3-->