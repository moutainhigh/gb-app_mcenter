<%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.VRebateReportListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/report/rebate/detail/reportDetail.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['统计']}</span>
            <span>/</span><span>${views.sysResource['返佣统计']}</span>
            <a class="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" href="/report/rebate/rebateIndex.html?search.siteId=${command.search.siteId}&search.username=${command.search.username}" nav-target="mainFrame">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow clearfix">
                <div class="clearfix m-t-xs m-b-sm">
                    <div class="col-lg-10 clearfix">
                        <div class="form-group clearfix pull-left content-width-limit-400 m-t-sm m-b-none">
                            <div class="input-group">
                                <c:if test="${noSub}">
                                    <span class="input-group-addon abroder-no"><b>${views.report['operate.search.site']}</b></span>
                                    <div class="pull-left content-width-limit-8">
                                        <gb:select name="siteId" list="${command.sites}" listKey="id" listValue="siteNameI18n" prompt="" value="${command.siteId}" cssClass="chosen-select-no-single"/>
                                    </div>
                                </c:if>
                                <div class="pull-left m-l-sm content-width-limit-200" id="qcRole">
                                    <div class="input-group" id="account">
                                        <span class="input-group-btn">
                                            <gb:select callback="changeRole" name="role" list="${command.roles}" listKey="key" listValue="value" value="search.agentName" prompt="" cssClass="chosen-select-no-single"/>
                                        </span>
                                        <input type="text" class="form-control" name="search.agentName" placeholder="${views.report['operate.search.account.hint']}" id="roleName">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group clearfix pull-left content-width-limit-10 m-t-sm m-b-none">
                            <div class="input-group">
                                <span class="input-group-addon abroder-no"><b>${views.report['rakeback.search.state']}</b></span>
                                <gb:select name="search.settlementState" list="${command.stateMap}" value="${command.search.settlementState}" prompt="${views.common['all']}" cssClass="chosen-select-no-single"/>
                            </div>
                        </div>

                        <div class="form-group clearfix pull-left content-width-limit-500 m-t-sm m-b-none">
                            <div class="input-group clearfix">
                                <span class="input-group-addon abroder-no"><b>${views.report['operate.search.time']}</b></span>
                                <div class="pull-left">
                                    <gb:select callback="changeYear" name="search.rebateYear" list="${command.yearMap}" value="${command.search.rebateYear}" prompt="-- ${views.common['year']} --" cssClass="chosen-select-no-single"/>
                                </div>
                                <div class="pull-left m-l content-width-limit-5">
                                    <gb:select callback="changeMonth" name="search.rebateMonth" list="${command.monthMap}" value="${command.search.rebateMonth}" prompt="-- ${views.common['month']} --" cssClass="chosen-select-no-single" />
                                </div>
                                <div class="pull-left m-l" id="qcPeriod">
                                    <gb:select name="search.id" list="${command.periods}" listKey="id" listValue="periodName" value="${command.search.id}" prompt="" cssClass="chosen-select-no-single"/>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-2">
                        <div class="form-group clearfix m-t-sm m-b-none">
                            <soul:button target="query" opType="function" text="${views.common['query']}" cssClass="btn btn-filter pull-right" />
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-12 m-t">
            <div class="wrapper white-bg shadow">
                <div class="dataTables_wrapper search-list-container" role="grid">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
            </div>
        </div>
    </div>
</form:form>

<!--//region your codes 3-->
<soul:import res="site/report/rebate/detail/index" />
<!--//endregion your codes 3-->