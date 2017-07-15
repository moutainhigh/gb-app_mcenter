<%--@elvariable id="sup" type="so.wwb.gamebox.model.report.rakeback.vo.SiteRakebackPlayerVo"--%>
<%--@elvariable id="sub" type="so.wwb.gamebox.model.master.operation.vo.RakebackBillVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="row">
    <form:form action="${root}/report/rakeback/rakebackIndex.html" method="post">
        <div id="validateRule" style="display: none">${command.validateRule}</div>
        <div id="${id}" class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['统计']}</span><span>/</span><span>${views.sysResource['返水统计']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow clearfix">
                <div class="clearfix m-t-xs m-b-sm">
                    <div class="col-lg-10 clearfix">
                        <c:if test="${noSub}">
                        <div class="form-group clearfix pull-left content-width-limit-200 m-t-sm m-b-none">
                            <div class="input-group">
                                <span class="input-group-addon abroder-no"><b>${views.report_auto['站点']}：</b></span>
                                <div class="pull-left content-width-limit-8">
                                    <gb:select name="search.siteId" list="${sites}" listKey="id" listValue="siteNameI18n" callback="siteChange" prompt="${views.report_auto['所有站点']}" cssClass="chosen-select-no-single"/>
                                </div>
                            </div>
                        </div>
                        </c:if>
                        <div class="form-group clearfix pull-left content-width-limit-250 m-t-sm m-b-none role <c:if test="${noSub}">hide</c:if>">
                            <div class="input-group">
                                <c:set var="role" value="${command.search.roleName == null ? 'search.playerName' : command.search.roleName}"/>
                                <span class="input-group-btn">
                                    <gb:select name="search.roleName" list="${roles}" listKey="key" listValue="value" value="${role}" callback="changeRole" prompt="" cssClass="chosen-select-no-single"/>
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
                                <input type="text" class="form-control list-search-input-text role" placeholder="${views.report['operate.search.account.hint']}" name="${role}" value="${rn}">
                            </div>
                        </div>
                        <c:if test="${noSub}">
                            <div class="form-group clearfix pull-left content-width-limit-8 m-t-sm m-b-none all-state">
                                <div class="input-group">
                                    <span class="input-group-addon abroder-no"><b>${views.report['rakeback.search.state']}</b></span>
                                    <span style="line-height: 34px;">${views.common['all']}</span>
                                </div>
                            </div>
                        </c:if>
                        <div class="form-group clearfix pull-left content-width-limit-10 m-t-sm m-b-none state <c:if test="${noSub}">hide</c:if>">
                            <div class="input-group">
                                <span class="input-group-addon abroder-no"><b>${views.report['rakeback.search.state']}</b></span>
                                <gb:select name="search.settlementState" value="${(noSub && empty command.search.siteId)?'':command.search.settlementState}" cssClass="btn-group chosen-select-no-single" list="${states}" prompt="${views.common['all']}"/>
                            </div>
                        </div>
                        <div class="form-group clearfix pull-left content-width-limit-500 m-t-sm m-b-none">
                            <div class="input-group clearfix">
                                <span class="input-group-addon abroder-no"><b>${views.report['operate.search.time']}</b></span>
                                <div class="pull-left">
                                    <gb:select name="search.rakebackYear" list="${noSub ? command.yearMap : command.yearMap}" value="${command.search.rakebackYear}" callback="changeYear" prompt="-- ${views.common['year']} --" cssClass="chosen-select-no-single"/>
                                </div>
                                <div class="pull-left m-l content-width-limit-5">
                                    <gb:select name="search.rakebackMonth" list="${months}" value="${command.search.rakebackMonth}" callback="changeMonth" prompt="-- ${views.common['month']} --" cssClass="btn-group chosen-select-no-single" />
                                </div>
                                <div class="pull-left m-l period <c:if test="${noSub}">hide</c:if>">
                                    <gb:select name="search.id" list="" listKey="id" listValue="periodName" value="${command.search.id}" callback="changePeriod" prompt="-- ${views.common['qi']} --" cssClass="chosen-select-no-single"/>
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
<soul:import res="site/report/rakeback/index"/>