<%@ page import="org.soul.commons.lang.DateQuickPickerTool" %>
<%@ page import="org.soul.commons.lang.DateTool" %><%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.VActivityMessageListListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/activityHall/vActivityMonitor/list.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <!--//region your codes 2-->
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['运营']}&nbsp;&nbsp;/</span><span>${views.operation['活动效果监控']}</span>
            <soul:button tag="a" target="goToLastPage" text="" opType="function"
                         cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <!--筛选条件-->
                <div class="clearfix filter-wraper border-b-1">

                    <div class="clearfix filter-wraper border-b-1">
                        <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                            <div class="input-group">
                                <span class="input-group-addon bg-gray">${views.operation['优惠订单号']}</span>
                                <input type="text" name="search.transactionNo" class="form-control"
                                       placeholder="${views.operation['优惠订单号']}"
                                       value=""/>
                                </span>

                            </div>
                        </div>

                        <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                            <div class="input-group">
                                <span class="input-group-addon bg-gray">${views.fund['playerDetect.view.playerAccount']}</span>
                                <input type="text" name="search.playerName" class="form-control"
                                       placeholder="${views.player_auto['多个账号，用半角逗号隔开']}"
                                       value="${command.search.playerName}"/>
                                </span>

                            </div>
                        </div>


                        <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                            <div class="input-group">
                                <span class="input-group-addon bg-gray">${views.column['VActivityPlayerApply.applyTime']}</span>
                                <gb:dateRange format="${DateFormat.DAY_SECOND}" useRange="true" style="width:42%;"
                                              useToday="true" btnClass="search" minDate="<%=DateTool.addDays(DateQuickPickerTool.getInstance().getToday(),-60)%>"
                                              startDate="<%=DateTool.addDays(DateQuickPickerTool.getInstance().getToday(),-60)%>"
                                              endDate="<%=DateQuickPickerTool.getInstance().getNow()%>"
                                              startName="search.startApplyTime" endName="search.endApplyTime"/>
                            </div>
                        </div>
                        <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                            <div class="input-group">
                                <span class="input-group-addon bg-gray">${views.operation['申请IP']}</span>
                                <input type="text" name="search.ipApplyStr" class="form-control"
                                       placeholder="${views.operation['申请IP']}"
                                       value="${command.search.ipApply}"/>
                                </span>

                            </div>
                        </div>

                        <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                            <div class="input-group">
                                <span class="input-group-addon bg-gray">${views.column['VActivityMessage.activityName']}</span>
                                <input type="text" name="search.activityName" class="form-control"
                                       placeholder="${views.column['VActivityMessage.activityName']}"
                                       value="${command.search.activityName}"/>
                                </span>

                            </div>
                        </div>
                        <div class="form-group clearfix pull-rigth col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                            <soul:button target="query" precall="" opType="function"
                                         cssClass="btn btn-filter btn-query-css search_btn"
                                         tag="button" text="">
                                <i class="fa fa-search"></i>
                                <span class="hd">&nbsp;${views.common['search']}</span>
                            </soul:button>
                        </div>
                        <div class="form-group clearfix pull-right col-md-2 col-sm-12 m-b-sm padding-r-none-sm function-menu-show hide">
                            <div class="function-menu-show hide">
                                <soul:button permission="operate:activityHall_checkapply"  target="successDialog" text="${views.operation['批量通过']}" opType="function" cssClass="btn btn-outline btn-filter"/>
                                <soul:button permission="operate:activityHall_checkapply"  target="${root}/activityHall/vActivityPlayerApply/auditStatus.html?&result.checkState=3&activityType="
                                             text="${views.operation['批量拒绝']}" opType="ajax" post="getSelectIds" precall="hasFailReason" callback="query"
                                             cssClass="btn btn-outline btn-filter"/>
                            </div>
                        </div>

                    </div>

                </div>
                <!--表格内容-->
                <div id="editable_wrapper" class="dataTables_wrapper search-list-container" role="grid">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
            </div>
        </div>
    </div>
    <!--//endregion your codes 2-->
</form:form>

<!--//region your codes 3-->
<soul:import res="site/operation/activityHall/activityPlayerApply"/>
<!--//endregion your codes 3-->