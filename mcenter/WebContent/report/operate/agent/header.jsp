<%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.OperatePlayerListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="so.wwb.gamebox.model.SubSysCodeEnum" %>
<%@ include file="/include/include.inc.jsp" %>

<div class="wrapper white-bg shadow clearfix">
    <div class="clearfix m-t-xs m-b-sm">
        <div class="clearfix col-lg-10">
            <c:choose>
                <c:when test="${command.sites.size() > 0}">
                    <div class="form-group clearfix pull-left content-width-limit-250 m-t-sm m-b-none site">
                        <div class="input-group date">
                            <span class="input-group-addon abroder-no"><b>${views.report['operate.search.site']}</b></span>
                            <div class="">
                                <gb:select name="search.siteId" list="${command.sites}" listKey="id" listValue="siteNameI18n" value="${command.search.siteId}" callback="changeSite"
                                           prompt="${views.report['operate.search.site.hint']}" cssClass="chosen-select-no-single"/>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <input type="hidden" name="search.siteId" value="${command.search.siteId}" />
                </c:otherwise>
            </c:choose>
            <div class="form-group clearfix pull-left content-width-limit-400 m-t-sm m-b-none">
                <div class="input-group date">
                    <span class="input-group-addon abroder-no"><b>${views.report['operate.search.payout.time']}</b></span>
                    <gb:dateRange format="${DateFormat.DAY}" style="width:100px" useRange="true"
                                  minDate="${minDate}" maxDate="${maxDate}"
                                  startName="search.startDate" endName="search.endDate"
                                  startDate="${startDate}" endDate="${endDate}"/>
                </div>
            </div>
            <div class="form-group clearfix pull-left content-width-limit-30 m-t-sm m-b-none role">
                <div class="input-group">
                    <span class="input-group-addon abroder-no"><b>${views.report['operate.search.account']}</b></span>
                    <span class="bg-gray input-group-addon bdn" style="width: 70px">
                    <gb:select name="roleName" list="${command.roles}" listKey="key" listValue="value" value="${command.roleName}" callback="changeRole" prompt="" cssClass="chosen-select-no-single"/>
                    </span>
                    <input type="text" class="form-control list-search-input-text role" name="search.topagentName" value="${command.userTop.username}" placeholder="${views.report['operate.search.account.hint']}">
                </div>
            </div>
        </div>
        <div class="col-lg-2">
            <div class="form-group clearfix m-t-sm m-b-none">
                <input type="hidden" name="search.masterId" value="${command.master.id}" />
                <input type="hidden" name="search.topagentId" value="${command.userTop.id}" />
                <input type="hidden" name="search.agentId" value="${command.userAgent.id}" />
                <input type="hidden" name="subSysCode" value="<%=SubSysCodeEnum.MCENTER_AGENT.getCode() %>" />
                <soul:button target="query" opType="function" text="${views.common['query']}" cssClass="btn btn-filter pull-right" />
            </div>
        </div>
    </div>
</div>