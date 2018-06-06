<%@ page import="org.soul.commons.lang.DateQuickPickerTool" %>
<%@ page import="org.soul.commons.lang.DateTool" %><%--@elvariable id="command" type="org.soul.model.sys.vo.SysAuditLogListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/report/log/logList.html?search.roleType=${command.search.roleType}&search.entityUserId=${command.search.entityUserId}" method="post">
    <div id="validateRule" style="display: none">${validateRule}</div>
    <c:if test="${not empty command.search.moduleTypes}">
        <c:forEach var="type" items="${command.search.moduleTypes}">
            <input type="hidden" name="search.moduleTypes" value="${type}">
        </c:forEach>
    </c:if>

    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['统计']}</span>
            <span>/</span><span>${views.sysResource['日志查询']}</span>
            <c:if test="${hasReturnhasReturn}">
                <soul:button tag="a" target="goToLastPage" text="" opType="function" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn">
                    <em class="fa fa-caret-left"></em>${views.common['return']}
                </soul:button>
            </c:if>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow clearfix">
                <ul class="clearfix sys_tab_wrap">
                    <li data-logtype="master" class="${command.search.roleType=='master'||empty command.search.roleType?'active':''}"><a href="/report/log/logList.html?search.roleType=master" nav-target="mainFrame">${views.report['log.logType.site']}</a></li>
                    <li data-logtype="top_agent" class="${command.search.roleType=='top_agent'?'active':''}"><a href="/report/log/logList.html?search.roleType=top_agent" nav-target="mainFrame">${views.report['log.logType.topagent']}</a></li>
                    <li data-logtype="agent" class="${command.search.roleType=='agent'?'active':''}"><a href="/report/log/logList.html?search.roleType=agent" nav-target="mainFrame">${views.report['log.logType.agent']}</a></li>
                    <li data-logtype="player" class="${command.search.roleType=='player'?'active':''}"><a href="/report/log/logList.html?search.roleType=player" nav-target="mainFrame">${views.report['log.logType.player']}</a></li>
                </ul>
                <div class="clearfix m-t-xs m-b-sm">
                    <div class="col-lg-10 clearfix">
                        <div class="form-group clearfix pull-left content-width-limit-500 m-t-sm m-b-none">
                            <div class="input-group daterangepickers">
                                <span class="input-group-addon abroder-no"><b>${views.report['log.query.time']}</b></span>
                                <gb:dateRange format="${DateFormat.DAY_SECOND}" style="width:160px;" useRange="true"
                                              opens="right" position="down"
                                              minDate="<%=DateTool.addMonths(DateQuickPickerTool.getInstance().getToday(),-6)%>"
                                              startName="search.operatorBegin" endName="search.operatorEnd"
                                              startDate="${command.search.operatorBegin}" endDate="${command.search.operatorEnd}"/>
                            </div>
                        </div>
                        <div class="form-group clearfix pull-left content-width-limit-250 m-t-sm m-b-none">
                            <div class="input-group">
                                <span class="input-group-addon abroder-no"><b>${views.report['log.query.type']}</b></span>
                                <gb:select name="search.moduleType" value="${command.search.moduleType}" cssClass="chosen-select-no-single" list="${moduleTypes}" prompt="${views.common['pleaseSelect']}"/>
                            </div>
                        </div>
                        <div class="form-group clearfix pull-left content-width-limit-30 m-t-sm m-b-none">
                            <div class="input-group sel_parent">
                                <span class="input-group-addon abroder-no"><b>${views.report['log.query.key']}</b></span>
                                <span class="input-group-btn">
                                    <gb:select name="keys" cssClass="chosen-select-no-single" callback="changeKey"
                                               list="${keys}" value="${searchKey}" listKey="key" listValue="value"/>
                                </span>
                                <input type="text" class="form-control list-search-input-text sel_input" name="${searchKey}"
                                       value="${empty command.search.operator?command.search.ip:command.search.operator}" id="operator"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2">
                        <div class="form-group clearfix m-t-sm m-b-none">
                            <c:if test="${command.search.entityUserId!=null && command.search.entityUserId!=''}">
                                <input type="hidden" name="search.entityUserId" value="${command.search.entityUserId}"/>
                            </c:if>
                            <soul:button target="query" precall="validateForm" opType="function" text="${views.common['query']}" cssClass="btn btn-filter pull-right btnQuery _enter_submit" />
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
<soul:import res="site/report/log/index" />
<!--//endregion your codes 3-->