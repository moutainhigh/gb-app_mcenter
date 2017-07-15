<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VPlayerGameTipOrderListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>

<div class="row">
    <form:form action="${root}/report/betting/vPlayerGameTipOrder/vPlayerGameTipOrderList.html" method="post" name="tipForm">
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
                    <li>
                        <soul:button target="linkType" url="/report/gameTransaction/init.html?isLink=${command.link}" text="${views.report_auto['全部']}" opType="function"/>
                    </li>
                    <li>
                        <soul:button target="linkType" url="/report/gameTransaction/init.html?search.apiTypeId=1&isLink=${command.link}" text="${views.report_auto['真人']}" opType="function"/>
                    </li>
                    <li>
                        <soul:button target="linkType" url="/report/gameTransaction/init.html?search.apiTypeId=2&isLink=${command.link}" text="${views.report_auto['电子']}" opType="function"/>
                    </li>
                    <li>
                        <soul:button target="linkType" url="/report/gameTransaction/init.html?search.apiTypeId=3&isLink=${command.link}" text="${views.report_auto['体育']}" opType="function"/>
                    </li>
                    <li>
                        <soul:button target="linkType" url="/report/gameTransaction/init.html?search.apiTypeId=4&isLink=${command.link}" text="${views.report_auto['彩票']}" opType="function"/>
                    </li>
                    <li class="active">
                        <soul:button target="linkType" url="/report/betting/vPlayerGameTipOrder/vPlayerGameTipOrderList.html?link=${command.link}" text="${views.report_auto['小费']}" opType="function"/>
                    </li>
                </ul>
                <div class="m-t-md">
                    <div class="m-b-xs clearfix">
                        <div class="col-sm-12 clearfix" style="padding-left: 0;">
                            <%--注单号--%>
                            <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group date">
                                    <span class="input-group-addon bg-gray">${views.report_auto['小费流水号']}</span>
                                    <input class="form-control search" type="text" name="search.billNo" value="${command.search.billNo}"/>
                                </div>
                            </div>
                            <%--玩家账号--%>
                            <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group date">
                                    <span class="input-group-addon bg-gray">${views.report_auto['玩家账号']}</span>
                                    <input class="form-control search" type="text" name="search.username" value="${command.search.username}"/>
                                </div>
                            </div>
                            <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm" id="chooseApi">
                                <div class="input-group">
                                    <span class="input-group-addon bg-gray">${views.report_auto['游戏类型']}</span>
                                <span class=" input-group-addon bdn right-btn-down">
                                    <div class="btn-group table-desc-right-t-dropdown">
                                        <input type="hidden" name="" value="">
                                        <soul:button target="openApi" text="" opType="function" cssClass="btn btn btn-default right-radius" tag="button">
                                            <span prompt="prompt">
                                                <c:if test="${!empty command.search.apiIds}">
                                                    ${views.report_auto['已选择']}${fn:length(command.search.apiIds)}${views.report_auto['项']}
                                                </c:if>
                                                <c:if test="${empty command.search.apiIds}">
                                                    ${views.report_auto['请选择']}
                                                </c:if>
                                            </span>
                                            <span class="caret-a pull-right"></span>
                                        </soul:button>
                                    </div>
                                </span>
                                </div>
                                <div class="type-search">
                                    <div class="search-top-menu">
                                        <soul:button target="checkAllApi" text="${views.operation['backwater.settlement.choose.allChoose']}" opType="function" tag="button" cssClass="btn btn-filter btn-xs"/>
                                        <soul:button target="clearAllApi" text="${views.operation['backwater.settlement.choose.clear']}" opType="function" tag="button" cssClass="btn btn-outline btn-filter btn-xs"/>
                                    </div>
                                    <div class="m-t">
                                        <table class="table table-bordered m-b-xxs chooseApiTable">
                                            <tbody>
                                            <tr>
                                                <td class="al-left">
                                                    <c:forEach var="i" items="${apiMap}">
                                                        <c:set var="isContain" value="false"/>
                                                        <label class="m-r-sm">
                                                            <c:forEach var="j" items="${command.search.apiIds}">
                                                                <c:if test="${j eq i.key}">
                                                                    <c:set var="isContain" value="true"/>
                                                                </c:if>
                                                            </c:forEach>
                                                            <input name="search.apiIds" ${isContain eq 'true'?'checked':''} type="checkbox" class="i-checks" value="${i.key}">
                                                            <span class="m-l-xs">${i.value}</span>
                                                        </label>
                                                    </c:forEach>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group date time-select-a">
                                    <span class="input-group-addon bg-gray">${views.report_auto['时间']}</span>
                                    <gb:dateRange format="${DateFormat.DAY_SECOND}" style="width:38%" opens="right" position="down" startDate="${command.search.beginTime}" endDate="${command.search.endTime}" useRange="true"
                                                  useToday="true" startName="search.beginTime" endName="search.endTime"/>
                                </div>
                            </div>
                            <div class="pull-left m-l-sm">
                                <soul:button target="query" tag="button" text="" opType="function" cssClass="btn btn-filter">
                                    <i class="fa fa-search"></i><span class="hd">&nbsp;${views.report_auto['搜索']}</span>
                                </soul:button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12 m-t">
            <div class="wrapper white-bg shadow">
                <div class="sys_tab_wrap clearfix">
                    <div class="m-sm">
                        <b>${views.report_auto['已选']}：</b>
                        <span class="co-yellow" id="apiName">
                            <c:if test="${!empty command.search.apiIds}">
                                <c:forEach items="${command.search.apiIds}" var="i">
                                    [${gbFn:getSiteApiName(i.toString())}]
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty command.search.apiIds}">
                                ${messages.report['operate.list.all']}
                            </c:if>
                        </span>
                    </div>
                </div>

                <div class="dataTables_wrapper search-list-container">
                    <%@include file="IndexPartial.jsp"%>
                </div>
            </div>
        </div>
    </form:form>
</div>


<script language="text/javascript">
    curl(["site/report/betting/tip/Index"], function(Page) {
        page =new Page();
        page.bindButtonEvents();
    });
</script>





