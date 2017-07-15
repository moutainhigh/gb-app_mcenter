<%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.VRakebackReportListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/report/rakeback/detail/reportDetail.html" method="post" id="mainFrame">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['统计']}</span>
            <span>/</span><span>${views.sysResource['返水统计']}</span>
            <a class="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" href="/report/rakeback/rakebackIndex.html" nav-target="mainFrame">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow clearfix">
                <div class="clearfix m-t-xs m-b-sm">
                    <div class="col-lg-10 clearfix">
                        <c:if test="${noSub}">
                            <div class="form-group clearfix pull-left content-width-limit-200 m-t-sm m-b-none">
                                <div class="input-group">
                                    <span class="input-group-addon abroder-no"><b>${views.report['operate.search.site']}</b></span>
                                    <div class="pull-left content-width-limit-8">
                                        <gb:select name="search.siteId" list="${command.sites}" listKey="id" listValue="siteNameI18n" value="${command.search.siteId}" callback="siteChange" prompt="" cssClass="chosen-select-no-single"/>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <div class="form-group clearfix pull-left content-width-limit-250 m-t-sm m-b-none role" style="<c:if test="${noSub}">display: none;</c:if>">
                            <div class="input-group" id="account">
                                <c:set var="role" value="${command.search.roleName == null ? 'search.playerName' : command.search.roleName}"/>
                                <span class="input-group-btn">
                                    <gb:select name="search.roleName" list="${command.roles}" listKey="key" listValue="value" value="${role}" callback="changeRole" prompt="" cssClass="chosen-select-no-single"/>
                                </span>
                                <c:choose>
                                    <c:when test="${command.search.roleName == 'search.playerName'}">
                                        <c:set var="rn" value="${command.search.playerName}"/>
                                    </c:when>
                                    <c:when test="${command.search.roleName == 'search.agentName'}">
                                        <c:set var="rn" value="${command.search.agentName}"/>
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="rn" value="${command.search.topagentName}"/>
                                    </c:otherwise>
                                </c:choose>
                                <input type="text" class="form-control role" placeholder="${views.report['operate.search.account.hint']}" name="${role}" value="${rn}">
                            </div>
                        </div>
                        <div class="form-group clearfix pull-left content-width-limit-10 m-t-sm m-b-none state">
                            <div class="input-group">
                                <span class="input-group-addon abroder-no"><b>${views.report['rakeback.search.state']}</b></span>
                                <gb:select name="search.settlementState" list="${command.stateMap}" value="${command.search.settlementState}" prompt="${views.common['all']}" cssClass="chosen-select-no-single"/>
                            </div>
                        </div>
                        <div class="form-group clearfix pull-left content-width-limit-500 m-t-sm m-b-none">
                            <div class="input-group clearfix">
                                <span class="input-group-addon abroder-no"><b>${views.report['operate.search.time']}</b></span>
                                <div class="pull-left">
                                    <gb:select name="search.rakebackYear" list="${command.yearMap}" callback="changeYear" value="${command.search.rakebackYear}" prompt="" cssClass="chosen-select-no-single"/>
                                </div>
                                <div class="pull-left m-l content-width-limit-5">
                                    <gb:select name="search.rakebackMonth" list="${command.monthMap}" callback="changeMonth" value="${command.search.rakebackMonth}" prompt="" cssClass="chosen-select-no-single" />
                                </div>
                                <div class="pull-left m-l period">
                                    <gb:select name="search.id" list="${command.periods}" listKey="id" listValue="periodName" value="${command.search.id}" prompt="" cssClass="chosen-select-no-single"/>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="col-lg-2">
                        <div class="form-group clearfix m-t-sm m-b-none">
                            <soul:button target="query" opType="function" text="${views.common['query']}" cssClass="btn btn-filter pull-right look" />
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
<soul:import res="site/report/rakeback/detail/index" />
<!--//endregion your codes 3-->