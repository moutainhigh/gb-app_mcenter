<%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.VPlayerTransactionListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/report/fundsLog/list.html" method="post" id="fundsLog">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <input type="hidden" name="search.type" value="${command.search.type}">
    <input type="hidden" name="search.playerId" value="${command.search.playerId}">
    <input type="hidden" name="search.origin" value="${command.search.origin}" />
    <input type="hidden" name="search.transactionWay" value="${command.search.transactionWay}" />
    <input type="hidden" name="outer" value="${command.outer}">
    <input type="hidden" name="comp" value="${command.comp}" />
            <div class="row">
                <div class="position-wrap clearfix">
                    <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
                    <span>${views.sysResource['统计']}</span>
                    <span>/</span><span>${views.sysResource['资金记录']}</span>
                    <soul:button target="goToLastPage" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                        <em class="fa fa-caret-left"></em>${views.common['return']}
                    </soul:button>
                    <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
                </div>
                <div class="col-lg-12 m-b">
                    <div class="wrapper white-bg shadow clearfix">
                        <div class="clearfix m-t-xs">
                            <c:if test="${command.isMaster}">
                                <div class="form-group clearfix pull-left content-width-limit-250 m-t-sm m-b-none">
                                    <div class="input-group">
                                        <span class="input-group-addon abroder-no"><b>${views.report['fund.list.site']}</b></span>
                                        <select  val="${command._getDataSourceId()}"  style="display: none" class="btn-group chosen-select-no-single" name="siteId">
                                            <c:forEach items="${command.sysSiteListVo.result}" var="site">
                                                <option value="${site.id}">${site.name}</option>
                                            </c:forEach>
                                            <c:choose>
                                                <c:when test="${empty command.sysSiteListVo.result}">
                                                    <option value="">${views.report['fund.list.dataNone']}</option>
                                                </c:when>
                                                <c:otherwise>
                                                </c:otherwise>
                                            </c:choose>
                                        </select>
                                    </div>
                                </div>
                            </c:if>
                            <div class=" clearfix">
                            <div class="form-group clearfix pull-left content-width-limit-400 m-t-sm m-b-none">
                                <div class="input-group account_parent" >
                                    <span class="input-group-addon abroder-no"><b>${views.report['fund.list.account']}</b></span>
                                    <span class="input-group-btn">
                                        <gb:select name="searchKey" list="${userTypeSearchKeys}" listKey="key" value="${command.searchKey}" listValue="value"  callback="changeKey"/>
                                    </span>
                                    <c:if test="${not empty command.search.username||(empty command.search.username&&empty command.search.agentname&&empty command.search.topagentusername)}">
                                        <input type="text" class="form-control account_input list-search-input-text"  name="search.username" id="operator" value="${command.search.username}">
                                    </c:if>
                                    <c:if test="${not empty command.search.agentname}">
                                        <input type="text" class="form-control account_input list-search-input-text"  name="search.username" id="operator" value="${command.search.agentname}">
                                    </c:if>
                                    <c:if test="${not empty command.search.topagentusername}">
                                        <input type="text" class="form-control account_input list-search-input-text"  name="search.username" id="operator" value="${command.search.topagentusername}">
                                    </c:if>
                                </div>
                            </div>
                            <div class="input-group clearfix pull-left content-width-limit-500 m-t-sm m-b-none">
                                <gb:dateRange format="${DateFormat.DAY_SECOND}" style="width:160px" useRange="true"
                                               opens="right" position="down"
                                              startDate="${command.search.beginCreateTime}" endDate="${command.search.endCreateTime}"
                                              startName="search.beginCreateTime"  endName="search.endCreateTime">
                                    <span class="input-group-addon abroder-no"><b>${views.report['fund.list.trTime']}</b></span></gb:dateRange>
                            </div>
                            <div class="input-group clearfix pull-left content-width-limit-500 m-t-sm m-b-none">
                                <gb:dateRange format="${DateFormat.DAY_SECOND}" style="width:160px" useRange="true"
                                              opens="right" position="down"
                                              startDate="${command.search.startTime}" endDate="${command.search.endTime}"
                                              startName="search.startTime"  endName="search.endTime">
                                    <span class="input-group-addon abroder-no"><b>${views.report_auto['完成时间']}：</b></span></gb:dateRange>
                            </div>
                            <%-- 订单号　--%>
                            <div class="form-group clearfix pull-left content-width-limit-30 m-t-sm m-b-none">
                                <div class="input-group order_parent">
                                    <span class="input-group-addon abroder-no"><b>${views.report['fund.list.transactionNo']}：</b></span>
                                    <input type="text" class="form-control list-search-input-text order" id="operator2" name="search.transactionNo">
                                </div>
                            </div>

                            <div class="form-group clearfix pull-left content-width-limit-500 m-t-sm m-b-none">
                                <div class="input-group">
                                    <span class="input-group-addon abroder-no"><b>${views.report['fund.list.moneyRange']}：</b></span>
                                    <input type="text" class="form-control" name="search.startMoney">
                                    <span class="input-group-addon bg-gray">${views.common['TO']}</span>
                                    <input type="text" class="form-control" name="search.endMoney">
                                </div>
                            </div>
                            </div>
                            <div class="form-group clearfix line-hi34 pull-left m-t-sm m-b-none">
                                <div class="input-group">
                                    <input type="hidden" name="outer" value="${outer}" />
                                    <span class="input-group-addon abroder-no" style="width:95px"><b>${views.report['fund.list.typeTitle']}</b></span>
                                    <label class="m-l-sm">
                                        <input type="checkbox" class="i-checks" name="allSelect" value="true"/>${views.common_report['全选']}
                                    </label>
                                    <label class="m-l-sm">
                                        <input type="checkbox" class="i-checks" name="allDeposit" value="true" ${outer > 10 ? 'checked' : ''}/>${views.report_auto['所有存款']}
                                    </label>
                                    <label class="m-l-sm">
                                        <input type="checkbox" class="i-checks" name="allWithdraw" value="true" ${outer > 10 ? 'checked' : ''}/>${views.report_auto['所有取款']}
                                    </label>
                                </div>
                                <div class="input-group" id="fundTypeCheckboxs">
                                    <span class="input-group-addon abroder-no" style="width:95px"><b></b></span>
                                    <c:set var="parentSelect" value="${command.search.type eq 'allParent' ? 'checked':''}"></c:set>
                                    <c:set var="withdrawingSelect" value="${command.search.type eq 'withdrawing' ? 'checked':''}"></c:set>
                                    <c:forEach items="${command.dictFundType}" var="fundType">
                                        <c:set value="0" var="_fundType"></c:set>
                                        <%--存款--%>
                                        <c:set value="${command.depositType}" var="depositType"/>
                                        <%--取款--%>
                                        <c:set value="${command.withdrawType}" var="withdrawType"/>
                                        <%--收入--%>
                                        <c:forEach items="${command.revenueType}" var="re">
                                            <c:if test="${re eq fundType.key && _fundType eq 0}">
                                                <c:set value="1" var="_fundType"></c:set>
                                                <label class="m-l-sm">
                                                    <c:set var="key" value="${fundType.key}"/>
                                                    <input type="checkbox" class="i-checks earning ${depositType[key]?'deposit':''}" name="search.fundTypes" value="${key}"
                                                    <c:forEach items="${command.search.fundTypes}" var="reWriteVarsFromUrl">
                                                        ${key eq reWriteVarsFromUrl ? 'checked':''}
                                                    </c:forEach> >
                                                        ${dicts.common.fund_type[key]}
                                                </label>
                                            </c:if>
                                        </c:forEach>
                                        <%--支出--%>
                                        <c:forEach items="${command.expendType}" var="ex">
                                            <c:if test="${ex eq fundType.key && _fundType eq 0}">
                                                <c:set value="1" var="_fundType"></c:set>
                                                <label class="m-l-sm">
                                                    <c:set var="key" value="${fundType.key}"/>
                                                    <input type="checkbox" class="i-checks expend ${withdrawType[key]?'withdraw':''}" name="search.fundTypes" value="${key}"
                                                    <c:forEach items="${command.search.fundTypes}" var="reWriteVarsFromUrl">
                                                        ${key eq reWriteVarsFromUrl ? 'checked':''}
                                                    </c:forEach>  >
                                                        ${dicts.common.fund_type[key]}
                                                </label>
                                            </c:if>
                                        </c:forEach>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        <div class="operate-btn clearfix">
                            <%--<button class="btn btn-filter">${views.report_auto['查询']}</button>--%>
                            <soul:button target="query"  text="${views.common['search']}" cssClass="btn btn-filter _search_btn" opType="function"/>
                            <a href="/report/vPlayerFundsRecord/fundsLog.html" nav-target="mainFrame" style="margin-left: 14px;">${views.report_auto['切换新版']}</a>
                           <%-- <soul:button target="advancedFilter" text="" opType="function" cssClass="btn btn-outline btn-filter pull-right btn-advanced-down">
                                <i class="fa fa-angle-double-down m-r-sm"></i>${views.common['advancedFilter']}
                            </soul:button>--%>
                            <%--<button class="btn btn-outline btn-filter pull-right btn-advanced-down"><i class="fa fa-angle-double-down m-r-sm"></i>${views.report_auto['高级筛选']}</button>--%>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12 m-t">
                    <div class="wrapper white-bg shadow">

                        <div class="dataTables_wrapper search-list-container">
                            <%@ include file="IndexPartial.jsp" %>
                        </div>
                    </div>
                </div>
            </div>
            <!--//endregion your codes 2-->
        <%--</div>--%>
    <%--</div>--%>
</form:form>

<!--//region your codes 3-->
<soul:import res="site/report/fund/Index"/>
<!--//endregion your codes 3-->