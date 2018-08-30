<%@ page import="org.soul.commons.dict.DictTool" %>
<%@ page import="so.wwb.gamebox.model.DictEnum" %><%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.VPlayerApiTransactionListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/report/fundsTrans/apiTrans.html" method="post" id="fundsLog" name="apiTrans">
    <div id="validateRule" style="display: none">${validateRule}</div>
    <input type="hidden" name="search.transactionType" value="${command.search.transactionType}">
    <input type="hidden" name="search.type" value="${command.search.type}">
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['统计']}</span>
            <span>/</span><span>${views.sysResource['转账记录']}</span>
            <soul:button target="goToLastPage"
                         cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text=""
                         opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>

        <div class="col-lg-12">
            <div class="wrapper white-bg shadow clearfix">
                <div class="m-t-md">
                    <div class="m-b-xs clearfix">
                        <div class="col-sm-12 clearfix" style="padding-left: 0;">
                            <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group">
                                    <span class="bg-gray input-group-addon bdn">
                                        <gb:select name="search.userTypes" list="${userTypeSearchKeys}" listKey="key"
                                                   value="${command.search.userTypes}" listValue="value" callback="changeKey"
                                                   prompt=""/>
                                    </span>
                                    <c:if test="${not empty command.search.username||(empty command.search.username&&empty command.search.agentname&&empty command.search.topagentusername)}">
                                        <input type="text" class="form-control account_input list-search-input-text"
                                               name="search.username" id="operator" value="${command.search.username}"
                                               placeholder="${views.report['多个账号，用半角逗号隔开']}">
                                    </c:if>
                                    <c:if test="${not empty command.search.agentname}">
                                        <input type="text" class="form-control account_input list-search-input-text"
                                               name="search.username" id="operator" value="${command.search.agentname}"
                                               placeholder="${views.report['多个账号，用半角逗号隔开']}">
                                    </c:if>
                                    <c:if test="${not empty command.search.topagentusername}">
                                        <input type="text" class="form-control account_input list-search-input-text"
                                               name="search.username" id="operator"
                                               value="${command.search.topagentusername}" placeholder="${views.report['多个账号，用半角逗号隔开']}">
                                    </c:if>
                                </div>
                            </div>

                            <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group date">
                                    <span class="input-group-addon bg-gray">${views.common['orderNum']}</span>
                                    <input type="text" class="form-control" id="operator2" name="search.transactionNo"
                                           value="${command.search.transactionNo}">
                                </div>
                            </div>

                            <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group">
                                    <span class="input-group-addon bg-gray">${views.report_auto['游戏类型']}</span>
                                    <span class="bdn right-btn-down">
                                        <div class="btn-group table-desc-right-t-dropdown" initprompt="10条"
                                             callback="query">
                                            <button type="button" class="btn btn btn-default right-radius rank-btn">
                                                <span class="rankText" prompt="prompt">${views.report_auto['请选择']}</span>
                                                <span class="caret-a pull-right"></span>
                                            </button>
                                            <c:forEach items="${command.search.apiList}" var="p">
                                                <input type="hidden" class="playerRanks" data-value="${p}"/>
                                            </c:forEach>
                                            <div class="dropdown-menu playerRank">
                                                <div class="search-top-menu"
                                                     style="margin-top: 10px;margin-left: 10px;">
                                                    <button type="button" data-type="all"
                                                            class="btn btn-filter btn-xs">${views.operation['backwater.settlement.choose.allChoose']}</button>
                                                    <button type="button" data-type="clear"
                                                            class="btn btn-outline btn-filter btn-xs">${views.operation['backwater.settlement.choose.clear']}</button>
                                                </div>
                                                <div class="m-t">
                                                    <table class="table table-bordered m-b-xxs">
                                                        <tbody>
                                                        <tr>
                                                            <td class="al-left">
                                                                <c:forEach items="${api}" var="pr" varStatus="api">
                                                                    <label class="m-r-sm">
                                                                        <input type="checkbox" name="search.apiList"
                                                                               class="i-checks" value="${pr.key}">
                                                                        <span class="m-l-xs">${gbFn:getSiteApiName(pr.key)}</span>
                                                                    </label>
                                                                </c:forEach>
                                                            </td>
                                                        </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>

                                        </div>
                                    </span>
                                </div>
                            </div>

                            <div class="form-group clearfix pull-left col-md-6 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group">
                                    <span class="input-group-addon bg-gray">${views.report_auto['完成时间']}</span>
                                    <gb:dateRange format="${DateFormat.DAY_SECOND}" style="width:44%" useRange="true"
                                                  opens="right" position="down"
                                                  startDate="${command.search.startTime}"
                                                  endDate="${command.search.endTime}"
                                                  startName="search.startTime" endName="search.endTime"/>
                                </div>
                            </div>

                            <div class="form-group clearfix pull-left col-md-6 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group date time-select-a">
                                    <span class="input-group-addon bg-gray">${views.report_auto['创建时间']}</span>
                                    <gb:dateRange format="${DateFormat.DAY_SECOND}" style="width:44%" useRange="true"
                                                  opens="right" position="down"
                                                  startDate="${command.search.beginCreateTime}"
                                                  endDate="${command.search.endCreateTime}"
                                                  startName="search.beginCreateTime" endName="search.endCreateTime"/>
                                </div>
                            </div>

                            <div class="show-demand-a">

                                <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                                    <div class="input-group time-select-a">
                                        <span class="input-group-addon bg-gray">${views.report_auto['金额']}</span>
                                        <span class="input-group-addon time-select-ico">${views.report_auto['起']}</span>
                                        <input type="text" class="form-control jp_distance" name="search.startMoney"
                                               value="${command.search.startMoney}">
                                        <span class="input-group-addon time-select-t">~</span>
                                        <span class="input-group-addon time-select-ico">${views.report_auto['止']}</span>
                                        <input type="text" class="form-control jp_distance" name="search.endMoney"
                                               value="${command.search.endMoney}">
                                    </div>
                                </div>

                                <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                                    <div class="input-group">
                                        <span class="input-group-addon bg-gray">${views.report_auto['来源终端']}</span>
                                        <gb:select name="search.origin" list="<%=DictTool.get(DictEnum.COMMON_TERMINAL_TYPE)%>" prompt="${views.player_auto['全部']}"/>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-12 clearfix template-menu">
                            <button type="button" class="btn btn-filter btn-outline pull-right  show-demand-b"><i
                                    class="fa fa-chevron-down"></i> ${views.common['advancedFilter']}
                            </button>
                            <soul:button precall="validateForm" target="query" text="" cssClass="btn btn-filter mediate-search-btn _enter_submit"
                                         opType="function">
                                <i class="fa fa-search"></i><span class="hd">&nbsp;${views.common['search']}</span>
                            </soul:button>
                            <soul:button target="reset" opType="function" text="${views.report_auto['重置']}"
                                         cssClass="btn btn-filter reset-condition-button"/>
                            <%@include file="/sysSearchTemplate/SearchTemplate.jsp" %>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-12 m-t">
            <div class="wrapper white-bg shadow">
                <div class="sys_tab_wrap clearfix">
                    <div class="clearfix m-sm">
                        <b>${views.report_auto['已选']}：</b>
                        <span class="co-yellow rankDisplay">${views.report_auto['未筛选游戏类型']}</span>
                    </div>
                </div>
                <div class="dataTables_wrapper search-list-container">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
            </div>
        </div>
    </div>
    <!--//endregion your codes 2-->
</form:form>


<!--//region your codes 3-->
<script type="text/javascript">
    curl(["site/report/apiFund/Index", 'gb/sysSearchTemplate/SysSearchTemplate'], function (Page, SysSearchTemplate) {
        page = new Page();
        page.bindButtonEvents();
        page.sysSearchTmp = new SysSearchTemplate();
    });
</script>
<!--//endregion your codes 3-->