<%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.VPlayerFundsRecordListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<%@ page import="so.wwb.gamebox.model.master.report.po.VPlayerFundsRecord" %>
<c:set var="poType" value="<%= VPlayerFundsRecord.class %>" />
<!--//region your codes 1-->
<%--总计列表数和总金额数--%>
<div class="p-sm con-total total_content" style="display: block;">
    <b>${views.report['fund.list.total']}</b>
    <input type="hidden" name="search.orderType" value="${command.search.orderType}">
    <input type="hidden" name="search.transactionType" value="${command.search.transactionType}" />
    <input type="hidden" name="search.comp" value="${command.search.comp}" />
    <span class="total_count">${command.paging.totalCount}</span>${views.report['fund.list.totalUnit']}
    <b class="m-l">${views.report_auto['金额共']}：</b><span class="total_money fa fa-refresh fa-spin"></span>
</div>
<div class="table-responsive table-min-h">
    <!--conditionJson和queryParamsJson二选1-->
    <input type="hidden" value="${conditionJson}" id="conditionJson">
    <input type="hidden" value='${queryParamsJson}' name="queryParamsJson">
    <div class="search-params-div hide"></div>
    <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th>${views.common['number']}</th>
            <th>${views.report['fund.list.playerAccount']}</th>
            <soul:orderColumn poType="${poType}" property="completionTime" column="${views.report['fund.list.completionTime']}"/>
            <th>
                <gb:select name="search.fundType" value="${command.search.fundType}" cssClass="btn-group chosen-select-no-single" prompt="${views.common['all']}"
                           list="${dictFundType}" listKey="key" listValue="${dicts.common.fund_type[key]}" callback="query"/>
            </th>
            <th>${views.report_auto['收款账号']}</th>
            <th style="padding-left: 35px;">${views.report['fund.list.transactionNo']}</th>
            <soul:orderColumn poType="${poType}" property="transactionMoney" column="${views.report['fund.list.money']}"/>
            <soul:orderColumn poType="${poType}" property="balance" column="${views.report['fund.list.balance']}"/>
            <th>API余额</th>
            <th>
                <gb:select name="search.status" value="${command.search.status}" cssClass="btn-group chosen-select-no-single" prompt="${views.common['all']}" list="${dictCommonStatus}" listKey="key" listValue="${dicts.common.status[key]}" callback="query"/>
            </th>
            <c:if test="${isActive && easyPaymentStatus eq 'true'}">
                <th>
                    <gb:select name="search.checkStatus" value="${command.search.checkStatus}" cssClass="btn-group chosen-select-no-single" prompt="${views.common['all']}"
                               list="${withdrawCkeckStatus}" listKey="key" listValue="value" callback="query"/>
                </th>
            </c:if>
            <th>${views.report_auto['操作']}</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="pt" varStatus="status">
            <c:set value="" var="_symbol"></c:set>
            <c:set value="" var="_desc"></c:set>
            <c:set value="" var="view_url"></c:set>
            <c:choose>
                <c:when test="${pt.transactionType eq 'favorable'}">
                    <%--优惠--%>
                    <c:set value="+" var="_symbol"></c:set>
                    <c:set value="/report/vPlayerFundsRecord/view.html?search.id=${pt.id}" var="view_url"></c:set>
                    <c:set value="${dicts.common.fund_type[pt.fundType]}" var="_desc"></c:set>
                    <c:if test="${!empty pt.transactionWay && pt.transactionWay!='refund_fee'}">
                        <c:set value="${_desc}-${dicts.common.transaction_way[pt.transactionWay]}" var="_desc"/>
                    </c:if>
                    <c:if test="${pt.fundType eq 'artificial_deposit'}">
                        <%--手动存款--%>
                        <c:set value="${_desc}-${dicts.common.activity_type[pt._describe['activityType'].toString()]}" var="_desc"/>
                        <c:set value="/fund/manual/depositView.html?search.id=${pt.id}" var="view_url"></c:set>
                    </c:if>
                </c:when>
                <c:when test="${pt.transactionType eq 'deposit'}">
                    <%--存款--%>
                    <c:set value="+" var="_symbol"></c:set>
                    <c:set value="${dicts.common.fund_type[pt.fundType]}" var="_desc"></c:set>
                    <c:if test="${pt.fundType=='atm_counter'||pt.fundType=='artificial_deposit'}">
                        <c:set value="${_desc}-${dicts.common.transaction_way[pt.transactionWay]}" var="_desc"/>
                    </c:if>
                    <c:choose>
                        <c:when test="${pt.fundType eq 'online_deposit' || pt.fundType eq 'qqwallet_scan' || pt.fundType eq 'wechatpay_scan' || pt.fundType eq 'alipay_scan' || pt.fundType eq 'digiccy_scan' || pt.fundType eq 'jdpay_scan' || pt.fundType eq 'bdwallet_san' || pt.fundType eq 'union_pay_scan' || pt.fundType eq 'easy_pay'}">
                            <c:set value="false" var="showSubType"></c:set>
                            <%--在线--%>
                            <c:set value="/fund/deposit/online/view.html?search.id=${pt.sourceId}" var="view_url"></c:set>
                        </c:when>
                        <c:when test="${pt.fundType eq 'online_bank' || pt.fundType eq 'wechatpay_fast' || pt.fundType eq 'alipay_fast' || pt.fundType eq 'atm_money'|| pt.fundType eq 'atm_recharge'|| pt.fundType eq 'atm_counter' || pt.fundType eq 'bitcoin_fast' || pt.fundType eq 'onecodepay_fast' || pt.fundType eq 'qqwallet_fast' || pt.fundType eq 'jdwallet_fast' || pt.fundType eq 'bdwallet_fast' || pt.fundType eq 'other_fast'}">
                            <%-- 公司入款 --%>
                            <c:set value="/fund/deposit/company/view.html?search.id=${pt.sourceId}" var="view_url"></c:set>
                        </c:when>
                        <c:when test="${pt.fundType eq 'artificial_deposit'}">
                            <%--手动存款--%>
                            <c:set value="/fund/manual/depositView.html?search.id=${pt.id}" var="view_url"></c:set>
                        </c:when>
                    </c:choose>
                </c:when>
                <c:when test="${pt.transactionType eq 'withdrawals'}">
                    <%--取款--%>
                    <c:set value="/fund/withdraw/withdrawAuditView.html?search.id=${pt.sourceId}&pageType=detail" var="view_url"></c:set>
                    <c:set value="${dicts.common.fund_type[pt.fundType]}${empty pt.transactionWay?'':'-'}${dicts.common.transaction_way[pt.transactionWay]}" var="_desc"></c:set>
                    <c:if test="${pt.fundType eq 'artificial_withdraw'}">
                        <%--手动取款--%>
                        <c:set value="/fund/manual/withdrawView.html?search.id=${pt.sourceId}" var="view_url"></c:set>
                    </c:if>
                </c:when>
                <c:when test="${pt.transactionType eq 'transfers'}">
                    <%--转账:转入 转出 --%>
                    <c:set value="/report/fundsTrans/view.html?id=${pt.id}" var="view_url"></c:set>
                    <c:choose>
                        <c:when test="${pt.fundType eq 'transfer_into'}">
                            <c:set value="+" var="_symbol"></c:set>
                            <c:set value="${gbFn:getSiteApiName(pt._describe['API'].toString())}-${views.report['fund.list.wallect']}" var="_desc"></c:set>
                            <%--转入--%>
                        </c:when>
                        <c:when test="${pt.fundType eq 'transfer_out'}">
                            <c:set value="${views.report['fund.list.wallect']}-${views.fund['transaction.list.to']} ${gbFn:getSiteApiName(pt._describe['API'].toString())}" var="_desc"></c:set>
                            <%--转出--%>
                        </c:when>
                    </c:choose>
                </c:when>
                <c:when test="${pt.transactionType eq 'recommend'}">
                    <%--推荐--%>
                    <c:set value="+" var="_symbol"></c:set>
                    <c:set value="${dicts.common.fund_type[pt.fundType]}-${dicts.common.transaction_way[pt.transactionWay]}" var="_desc"></c:set>
                </c:when>
                <c:when test="${pt.transactionType eq 'backwater'}">
                    <%--返水--%>
                    <c:set value="+" var="_symbol"></c:set>
                    <c:set value="${dicts.common.fund_type[pt.fundType]}" var="_desc"></c:set>
                </c:when>
            </c:choose>

            <tr class="tab-detail">
                <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                <td class="co-blue">
                    <shiro:hasPermission name="role:player_detail"><a href="/player/playerView.html?search.id=${pt.playerId}" nav-target="mainFrame"></shiro:hasPermission>
                    ${pt.username}
                    <shiro:hasPermission name="role:player_detail"></a></shiro:hasPermission>
                    ${gbFn:riskImgByName(pt.username)}
                </td>
                <td>
                    <c:set value="${soulFn:formatDateTz(pt.completionTime, DateFormat.DAY_SECOND,timeZone)}" var="completionTime"></c:set>
                    <c:set value="${soulFn:formatDateTz(pt.createTime, DateFormat.DAY_SECOND,timeZone)}" var="createTime"></c:set>
                    <c:if test="${empty completionTime}">
                        --
                    </c:if>
                        ${completionTime}
                </td>
                    <%--类别名称--%>
                <td>
                        ${_desc}
                </td>
                <td>
                    <c:choose>
                        <c:when test="${!empty pt.payName && pt.transactionType eq 'deposit'}">
                            ${pt.payName}
                        </c:when>
                        <c:otherwise>
                            ---
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${pt.origin eq 'MOBILE'}">
                            <span class="fa fa-mobile mobile" title="${views.report_auto['手机订单']}" data-content="${views.report_auto['手机订单']}" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span style="width:8px; display: inline-block"></span>
                        </c:otherwise>
                    </c:choose>&nbsp;
                    <c:if test="${empty pt.transactionNo}">
                        ---
                    </c:if>
                    <c:if test="${!empty pt.transactionNo}">
                        <c:choose>
                            <c:when test="${not empty view_url}">
                                <a href="${view_url}" nav-target="mainFrame">${pt.transactionNo}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="/report/vPlayerFundsRecord/view.html?search.id=${pt.id}" nav-target="mainFrame">${pt.transactionNo}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </td>
                    <%-- 金额 --%>
                <td
                        <c:choose>
                            <c:when test="${pt.status eq 'failure' || pt.status eq 'reject'}">class="co-grayc2"</c:when>
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
                <td>
                    ${empty pt.apiMoney ? '---' : soulFn:formatCurrency(pt.apiMoney)}
                </td>
                <td>
                    <c:set value="" var="status_class"></c:set>
                    <c:choose>
                        <c:when test='${pt.status eq "pending" || pt.status eq "pending_pay" || pt.status eq "deal_audit_fail" || pt.status eq "tosubmit"}'> 	<%--状态：待处理/待支付 --%> <c:set var="status_class" value="label label-orange"></c:set></c:when>
                        <c:when test='${pt.status eq "process"}'> 	<%--状态：处理中 --%> <c:set var="status_class" value="label label-info"></c:set></c:when>
                        <c:when test='${pt.status eq "success"}'> 	<%--状态：成功 --%> <c:set var="status_class" value="label label-success"></c:set></c:when>
                        <c:when test='${pt.status eq "failure" || pt.status eq "cancel"}'> 	<%--状态：失败 --%> <c:set var="status_class" value="label"></c:set></c:when>
                        <c:when test='${pt.status eq "reject"||pt.status eq "over_time"}'> 	<%--状态：拒绝 --%> <c:set var="status_class" value="label label-danger"></c:set></c:when>
                        <c:when test='${pt.status eq "lssuing"}'> 	<%--状态：已发放 --%> <c:set var="status_class" value="label label-success"></c:set></c:when>
                    </c:choose>
                    <span class="${status_class}" title="${dicts.common.status[pt.status]}">${dicts.common.status[pt.status]}</span>
                </td>
                <c:if test="${isActive && easyPaymentStatus eq 'true'}">
                    <td>
                        <c:set value="" var="status_class"></c:set>
                        <c:choose>
                            <c:when test='${pt.checkStatus eq "payment_processing"}'> <%--状态：处理中 --%> <c:set var="status_class" value="label label-info"></c:set></c:when>
                            <c:when test='${pt.checkStatus eq "payment_success"}'> <%--状态：成功 --%> <c:set var="status_class" value="label label-success"></c:set></c:when>
                            <c:when test='${pt.checkStatus eq "payment_fail"}'> <%--状态：失败 --%> <c:set var="status_class" value="label"></c:set></c:when>
                            <c:otherwise>--</c:otherwise>
                        </c:choose>
                        <span class="${status_class}" title="${dicts.fund.withdraw_check_status[pt.checkStatus]}">${dicts.fund.withdraw_check_status[pt.checkStatus]}</span>
                    </td>
                </c:if>
                <td>
                    <c:choose>
                        <c:when test="${not empty view_url}">
                            <a href="${view_url}" nav-target="mainFrame">${views.common['detail']}</a>
                        </c:when>
                        <c:otherwise>
                            <a href="/report/vPlayerFundsRecord/view.html?search.id=${pt.id}" nav-target="mainFrame">${views.common['detail']}</a>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<soul:pagination/>
<!--//endregion your codes 1-->
