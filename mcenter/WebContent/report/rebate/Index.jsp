<%--@elvariable id="sup" type="so.wwb.gamebox.model.report.rebate.vo.SiteRebateVo"--%>
<%--@elvariable id="sub" type="so.wwb.gamebox.model.master.operation.vo.RebateAgentVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="row">
    <form:form action="${root}/report/rebate/rebateIndex.html" method="post">
        <div id="validateRule" style="display: none">${command.validateRule}</div>
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['统计']}</span><span>/</span><span>${views.sysResource['返佣统计']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow clearfix">
                <div class="clearfix m-t-xs m-b-sm">
                    <div class="col-lg-10 clearfix">
                        <c:set var="isSite" value="${noSub}" />
                        <c:if test="${isSite}">
                            <div class="form-group clearfix pull-left content-width-limit-200 m-t-sm m-b-none">
                                <div class="input-group">
                                    <span class="input-group-addon abroder-no"><b>${views.report['operate.search.site']}</b></span>
                                    <div class="pull-left content-width-limit-8">
                                        <gb:select name="search.siteId" list="${command.sites}" listKey="id" listValue="siteNameI18n" callback="siteChange"
                                                   prompt="${views.report['operate.search.site.hint']}" cssClass="chosen-select-no-single"/>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <input type="hidden" name="siteId" />
                        <div class="form-group clearfix pull-left content-width-limit-250 m-t-sm m-b-none" id="qcRole" style="<c:if test="${isSite}">display: none;</c:if>">
                            <div class="input-group" id="account">
                                <span class="input-group-btn">
                                    <gb:select name="roleSel" list="${isSite ? command.roles : command.roles}" listKey="key" listValue="value" value="search.agentName" callback="changeRole" prompt="" cssClass="chosen-select-no-single"/>
                                </span>
                                <input type="text" class="form-control list-search-input-text role" placeholder="${views.report['operate.search.account.hint']}" id="roleName" name="search.agentName">
                            </div>
                        </div>
                        <div class="form-group clearfix pull-left content-width-limit-10 m-t-sm m-b-none" id="qcState" style="<c:if test="${isSite}">display: none;</c:if>">
                            <div class="input-group">
                                <span class="input-group-addon abroder-no"><b>${views.report['rakeback.search.state']}</b></span>
                                <gb:select name="search.settlementState" list="${isSite ? command.stateMap : command.stateMap}" value="${command.search.settlementState}" prompt="${views.common['all']}" cssClass="chosen-select-no-single"/>
                            </div>
                        </div>
                        <div class="form-group clearfix pull-left content-width-limit-500 m-t-sm m-b-none">
                            <div class="input-group clearfix">
                                <span class="input-group-addon abroder-no"><b>${views.report['operate.search.time']}</b></span>
                                <div class="pull-left">
                                    <gb:select name="search.rebateYear" list="${isSite ? command.yearMap : command.yearMap}" callback="changeYear" prompt="-- ${views.common['year']} --" cssClass="chosen-select-no-single"/>
                                </div>
                                <div class="pull-left m-l content-width-limit-5">
                                    <gb:select name="search.rebateMonth" list="${isSite ? command.monthMap : command.monthMap}" callback="changeMonth" prompt="-- ${views.common['month']} --" cssClass="chosen-select-no-single" />
                                </div>
                                <div class="pull-left m-l" id="qcPeriod" style="<c:if test="${isSite}">display: none;</c:if>">
                                    <gb:select name="search.id" prompt="-- ${views.common['qi']} --" callback="changePeriod" cssClass="chosen-select-no-single"/>
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

        <div class="search-list-container">
            <%@ include file="IndexPartial.jsp" %>
        </div>

    </form:form>
</div>
<soul:import res="site/report/rebate/index"/>