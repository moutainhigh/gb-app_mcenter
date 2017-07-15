<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VPlayerGameOrderListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="row">
    <form:form name="gameOrderForm" action="${root}/report/gameTransaction/list.html" method="post">
        <form:hidden id="apitypeList" cssClass="search" path="search.apiTypeList"/>
       <%-- <form:hidden id="apiList" cssClass="search" path="search.apiList"/>--%>
        <input type="hidden" name="search.apiTypeId" value="${command.search.apiTypeId}"/>
        <div id="validateRule" style="display: none">${command.validateRule}</div>
        <input type="hidden" id="profitAmount" value="${command.search.profitAmount}"/>
        <%--<input type="hidden" id="orderState" value="${command.search.orderState}"/>--%>
        <input name="chooseGameText" type="hidden"/>
        <%-- 角色管理-玩家管理- 交易详情链接--%>
        <input type="hidden" name="search.playerId" value="${command.search.playerId}"/>

        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['统计']}</span><span>/</span>
            <span>${views.sysResource['投注记录']}</span>
            <c:if test="${command.link}">
                <soul:button tag="a" target="goToLastPage" text="" opType="function" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn">
                    <em class="fa fa-caret-left"></em>${views.common['return']}
                </soul:button>
            </c:if>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow clearfix">
                <ul class="clearfix sys_tab_wrap">
                    <li class="${empty command.search.apiTypeId?"active":''}">
                        <soul:button target="linkType" url="/report/gameTransaction/init.html?isLink=${command.link}" text="${views.report_auto['全部']}" opType="function"/>
                    </li>
                    <li class="${command.search.apiTypeId eq 1?'active':''}">
                        <soul:button target="linkType" url="/report/gameTransaction/init.html?search.apiTypeId=1&isLink=${command.link}" text="${views.report_auto['真人']}" opType="function"/>
                    </li>
                    <li class="${command.search.apiTypeId eq 2?'active':''}">
                        <soul:button target="linkType" url="/report/gameTransaction/init.html?search.apiTypeId=2&isLink=${command.link}" text="${views.report_auto['电子']}" opType="function"/>
                    </li>
                    <li class="${command.search.apiTypeId eq 3?'active':''}">
                        <soul:button target="linkType" url="/report/gameTransaction/init.html?search.apiTypeId=3&isLink=${command.link}" text="${views.report_auto['体育']}" opType="function"/>
                    </li>
                    <li class="${command.search.apiTypeId eq 4?'active':''}">
                        <soul:button target="linkType" url="/report/gameTransaction/init.html?search.apiTypeId=4&isLink=${command.link}" text="${views.report_auto['彩票']}" opType="function"/>
                    </li>
                  <%--  <li>
                        <soul:button target="linkType" url="/report/betting/vPlayerGameTipOrder/vPlayerGameTipOrderList.html?link=${command.link}" text="${views.report_auto['小费']}" opType="function"/>
                    </li>--%>
                </ul>
                <%@include file="SearchConditions.jsp"%>
            </div>
        </div>
        <div class="col-lg-12 m-t">
            <div class="wrapper white-bg shadow">
                <div class="sys_tab_wrap clearfix">
                    <div class="m-sm">
                        <b>${views.report_auto['已选']}：</b>
                        <span class="co-yellow" id="selectGame">
                            <c:choose>
                                <c:when test="${!empty command.chooseGameText && !empty command.search.apiTypeList}">
                                    ${command.chooseGameText}
                                </c:when>
                                <c:when test="${!empty command.search.apiTypeList}">
                                    <%--为空，在js回填--%>
                                </c:when>
                                <c:when test="${!empty command.chooseGameText && !empty command.search.apiList}">
                                    ${command.chooseGameText}
                                </c:when>
                                <c:when test="${!empty command.search.apiList}">
                                    <c:if test="${!empty command.search.apiTypeId}">
                                        <c:set var="siteId" value="${command._getSiteId()}"/>
                                        <c:forEach items="${command.search.apiList}" var="i">
                                            [${gbFn:getSiteApiNameByApiType(command.search.apiTypeId, i, siteId)}]
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${empty command.search.apiTypeId}">
                                        <c:set var="siteId" value="${command._getSiteId()}"/>
                                        <c:forEach items="${command.search.apiList}" var="i">
                                            [${gbFn:getSiteApiName(i)}]
                                        </c:forEach>
                                    </c:if>
                                </c:when>
                                <c:otherwise>
                                    ${messages.report['operate.list.all']}
                                </c:otherwise>
                            </c:choose>
                        </span>
                        <div class="pull-right m-t-n-xxs">
                            <%--<soul:button target="total" text="${views.column['VPlayerGameOrder.tjsj']}" opType="function" cssClass="btn btn-outline btn-filter m-r-sm btn-total"/>--%>
                            <soul:button permission="report:betorder_export" tag="button" cssClass="btn btn-export-btn btn-primary-hide" text="${views.common['export']}" callback="gotoExportHistory" precall="validExportCount" post="getCurrentFormData" title="${views.column['VPlayerGameOrder.dcsj']}" target="${root}/report/gameTransaction/export.html?result.siteId=${command.search.siteId}" opType="ajax">
                                <i class="fa fa-sign-out"></i><span class="hd">${views.common['export']}</span>
                            </soul:button>

                            <a href="/exports/exportHistoryList.html?search.hasReturn=true" nav-target="mainFrame" class="hide" id="toExportHistory"></a>
                        </div>
                    </div>
                </div>
                <div class="dataTables_wrapper">
                    <div class="p-sm bet-total">
                       <%-- <b>${views.report_auto['总计']}：</b>
                        ${command.paging.totalCount}笔--%>
                        <b class="m-l">${views.report_auto['投注额']}：</b>
                        <span id="singleSpan"><i class="fa fa-refresh fa-spin"></i></span>
                        <b class="m-l">${views.report_auto['有效投注额']}：</b>
                        <span id="effectSpan"><i class="fa fa-refresh fa-spin"></i></span>
                        <b class="m-l">${views.report_auto['派彩']}：</b>
                        <span id="profitSpan"><i class="fa fa-refresh fa-spin"></i></span>
                        <b class="m-l">${views.report_auto['彩池贡献金']}：</b>
                        <span id="contributionSpan">
                           <i class="fa fa-refresh fa-spin"></i>
                        </span>
                        <b class="m-l">${views.report_auto['彩池奖金']}：</b>
                        <span id="jackpotSpan">
                           <i class="fa fa-refresh fa-spin"></i>
                        </span>
                    </div>
                    <div class="search-list-container">
                        <%@ include file="IndexPartial.jsp" %>
                    </div>
                    <div id="paginationDiv"></div>
                </div>
            </div>
        </div>
    </form:form>
</div>
<script type="text/javascript">
    curl(["site/report/betting/Index",'gb/sysSearchTemplate/SysSearchTemplate'], function(Page,SysSearchTemplate) {
        page =new Page();
        page.bindButtonEvents();
        page.sysSearchTmp = new SysSearchTemplate();
    });
</script>
