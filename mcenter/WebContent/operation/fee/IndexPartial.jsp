<%--@elvariable id="command" type="so.wwb.gamebox.model.gamebox.vo.WithdrawAccountListVo"--%>
<%@ page import="so.wwb.gamebox.model.master.content.po.WithdrawAccount" %>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="poType" value="<%= WithdrawAccount.class %>"></c:set>

<!--//region your codes 1-->
<div id="editable_wrapper" class="dataTables_wrapper" role="grid">
    <div class="table-responsive table-min-h">
        <table class="table table-striped table-hover dataTable m-b-sm" aria-describedby="editable_info">
            <thead>
            <tr role="row" class="bg-gray">
                <th><input type="checkbox" class="i-checks"></th>
                <th>${views.common['number']}</th>
                <th>
                    ${views.column['PlayerRank.rankCode']}
                </th>
                <soul:orderColumn poType="${poType}" property="withdrawName" column="${views.column['VPayAccount.accountName']}"/>
                <th>${views.column['VPayAccount.account']}</th>
                <th class="inline">出款渠道</th>
                <soul:orderColumn poType="${poType}" property="withdrawCount" column='
            <span
                        tabindex="0" class="m-l-sm help-popover" role="button" data-container="body"
                        data-toggle="popover" data-trigger="focus" data-placement="top"
                        data-content="统计创建至今，该账户累计成功出款订单的总次数；" data-original-title="" title=""><i
                        class="fa fa-question-circle"></i>
                </span>出款次数'/>
                <soul:orderColumn poType="${poType}" property="withdrawTotal" column='
            <span
                        tabindex="0" class="m-l-sm help-popover" role="button" data-container="body"
                        data-toggle="popover" data-trigger="focus" data-placement="top"
                        data-content="统计创建至今，该账户成功出款订单的累计金额；" data-original-title="" title=""><i
                        class="fa fa-question-circle"></i>
                </span>累计出款金额${siteCurrency}'/>
                <th class="inline">
                    <%--<gb:select name="search.status" value="${command.search.status}" cssClass="btn-group chosen-select-no-single" prompt="${views.common['all']}" list="${statusMap}" callback="query"/>--%>
                </th>
                <th>${views.content['isEnable']}</th>
                <th>${views.common['operate']}</th>
            </tr>
            <tr class="bd-none hide">
                <th colspan="13">
                    <div class="select-records"><i class="fa fa-exclamation-circle"></i>${views.role['player.cancelSelectAll.prefix']}&nbsp;<span id="page_selected_total_record"></span>${views.role['player.cancelSelectAll.middlefix']}
                        <soul:button target="cancelSelectAll" opType="function" text="${views.role['player.cancelSelectAll']}"/>${views.role['player.cancelSelectAll.suffix']}
                    </div>
                </th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${command.result}" var="p" varStatus="stat">
                <tr class="tab-detail">
                    <c:choose>
                        <c:when test="${p.status eq '1'}">
                            <c:set var="color" value="label-success"></c:set>
                        </c:when>
                        <c:when test="${p.status eq '2'}">
                            <c:set var="color" value="label-danger"></c:set>
                        </c:when>
                        <c:when test="${p.status eq '3'}">
                            <c:set var="color" value="label-info"></c:set>
                        </c:when>
                    </c:choose>
                    <td><label><input type="checkbox" class="i-checks" value="${p.id}"></label></td>
                    <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(stat.index+1)}</td>
                    <td>${p.code}</td>

                    <td>${p.withdrawName}</td>
                    <td>${p.account}</td>
                    <td>${dicts.common.bankname[p.bankCode]}</td>
                    <td>${empty p.withdrawCount?0:p.withdrawCount}${views.common['ci']}</td>
                    <td>${empty p.withdrawTotal?0:soulFn:formatInteger(p.withdrawTotal).concat(soulFn:formatDecimals(p.withdrawTotal))}&nbsp;${siteCurrency}</td>
                    <td><span class="label ${color}" id="status${stat.index}">${dicts.content.pay_account_status[p.status]}</span></td>
                    <td>
                        <c:choose>
                            <c:when test="${p.status eq '1'}">
                                <input type="checkbox" name="my-checkbox" tt="${stat.index}" withdrawAccountId="${p.id}" data-size="mini" checked>
                            </c:when>
                            <c:when test="${p.status eq '2'}">
                                <input type="checkbox" name="my-checkbox" tt="${stat.index}" withdrawAccountId="${p.id}" data-size="mini">
                            </c:when>
                        </c:choose>
                    </td>
                    <td>
                        <shiro:hasPermission name="content:withdraw_account_edit">
                            <a href="/withdrawAccount/edit.html?search.id=${p.id}" nav-target="mainFrame">${views.common['edit']}</a>
                        </shiro:hasPermission>
                        <span class="dividing-line m-r-xs m-l-xs">|</span>
                        <a href="/withdrawAccount/view.html?search.id=${p.id}" nav-target="mainFrame">${views.common['detail']}</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${fn:length(command.result)<1}">
                <tr>
                    <td colspan="13" class="no-content_wrap">
                        <div>
                            <i class="fa fa-exclamation-circle"></i>
                            暂无手续费设置信息
                        </div>
                    </td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
    <soul:pagination/>
</div>


<!--//endregion your codes 1-->
