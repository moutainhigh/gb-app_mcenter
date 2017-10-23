<%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.VPlayerApiTransactionListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<%@ page import="so.wwb.gamebox.model.master.report.po.VPlayerApiTransaction" %>
<c:set var="poType" value="<%= VPlayerApiTransaction.class %>" />
<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <input type="hidden" value="${conditionJson}" id="conditionJson">
    <div class="search-params-div hide"></div>
    <div class="p-sm total_content">
        <b class="m-l">${views.report['fund.list.total']}</b><span class="total_count">${command.paging.totalCount}</span>${views.report['fund.list.totalUnit']}
        <b class="m-l">${views.report['fund.list.money']}：</b><span class="total_money">0</span>
    </div>
    <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray tab-detail">
            <th>${views.common['number']}</th>
            <th>${views.report['fund.list.playerAccount']}</th>
            <soul:orderColumn poType="${poType}" property="createTime" column="${views.report['fund.list.createTime']}"/>
            <th>
                <gb:select name="search.fundType" value="${command.search.fundType}" cssClass="btn-group chosen-select-no-single" prompt="${views.common['all']}"
                           list="${command.dictFundType}" listKey="key" listValue="value" callback="query"/>
            </th>
            <th style="padding-left: 35px;">${views.report['fund.list.transactionNo']}</th>
            <soul:orderColumn poType="${poType}" property="transactionMoney" column="${views.report['fund.list.money']}"/>
            <soul:orderColumn poType="${poType}" property="balance" column="${views.report['fund.list.balance']}"/>
            <soul:orderColumn poType="${poType}" property="apiMoney" column="${views.report['fund.list.apiMoney']}"/>
            <th>
                <gb:select name="search.status" value="${command.search.status}" cssClass="btn-group chosen-select-no-single" prompt="${views.common['all']}"
                           list="${command.dictCommonStatus}" listKey="key" listValue="value" callback="query"/>
            </th>
            <th>${views.report_auto['操作']}</th>
        </tr>
        </thead>



        <tbody>
        <c:forEach items="${command.result}" var="pt" varStatus="status">
            <c:set value="" var="_desc"></c:set>
            <c:set value="" var="_symbol"></c:set>
            <c:choose>
                <c:when test="${pt.transactionType eq 'transfers'}">
                    <c:choose>
                        <c:when test="${pt.fundType eq 'transfer_into'}">
                            <c:set value="+" var="_symbol"></c:set>
                            <c:set value="${gbFn:getSiteApiName(pt.apiId.toString())}->${views.report['fund.list.wallect']}" var="_desc"></c:set>
                            <%--转入--%>
                        </c:when>
                        <c:when test="${pt.fundType eq 'transfer_out'}">
                            <c:set value="${views.report['fund.list.wallect']}->
                            ${gbFn:getSiteApiName(pt.apiId.toString())}" var="_desc"></c:set>
                            <%--转出--%>
                        </c:when>
                    </c:choose>
                </c:when>
            </c:choose>

            <tr class="tab-detail">
                <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                <td class="co-blue"><a href="/player/playerView.html?search.id=${pt.playerId}" nav-target="mainFrame">${pt.username}</a></td>
                <td>
                    <c:set value="${soulFn:formatDateTz(pt.createTime, DateFormat.DAY_SECOND,timeZone)}" var="createTime"></c:set>
                    <c:if test="${empty createTime}">
                        --
                    </c:if>
                        ${createTime}
                </td>

                <td>
                    ${_desc}
                </td>

                <td>
                    <c:choose>
                        <c:when test="${pt.origin eq 'MOBILE'}">
                            <span class="fa fa-mobile mobile" data-content="${views.report_auto['手机订单']}" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span style="width:8px; display: inline-block"></span>
                        </c:otherwise>
                    </c:choose>&nbsp;
                        ${empty pt.transactionNo?'---':pt.transactionNo}
                </td>
                <%-- 金额 --%>
                <td
                    <c:choose>
                        <c:when test="${pt.status eq 'failure'}">class="co-grayc2"</c:when>
                        <c:otherwise>class="${pt.transactionMoney < 0 ? 'co-red3':'co-green'}"</c:otherwise>
                    </c:choose> class="${_symbol eq '-' ? 'co-red3':'co-green'}">
                    <c:if test="${pt.transactionMoney > 0}">
                        ${_symbol}
                    </c:if>
                        ${soulFn:formatCurrency(pt.transactionMoney)}
                </td>
                <%--钱包余额--%>
                <td>
                    <c:set value="${soulFn:formatCurrency(pt.balance)}" var="balanceData"></c:set>
                        ${empty pt.balance ? '---' : balanceData}
                </td>
                <%--api余额--%>
                <td>
                    <c:set value="${soulFn:formatCurrency(pt.apiMoney)}" var="apiMoneyData"></c:set>
                        ${empty pt.apiMoney ? '---' :apiMoneyData}
                </td>
                <td>
                    <c:set value="" var="status_class"></c:set>
                    <c:choose>
                        <c:when test='${pt.status eq "process"}'> 	<%--状态：处理中 --%> <c:set var="status_class" value="label label-info"></c:set></c:when>
                        <c:when test='${pt.status eq "success"}'> 	<%--状态：成功 --%> <c:set var="status_class" value="label label-success"></c:set></c:when>
                        <c:when test='${pt.status eq "failure" || pt.status eq "cancel"}'> 	<%--状态：失败 --%> <c:set var="status_class" value="label"></c:set></c:when>
                    </c:choose>
                    <span class="${status_class}" title="${dicts.common.status[pt.status]}">${dicts.common.status[pt.status]}</span>
                </td>
                <td>
                    <a href="/report/fundsTrans/view.html?id=${pt.id}" nav-target="mainFrame">${views.common['detail']}</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<soul:pagination/>
<!--//endregion your codes 1-->

