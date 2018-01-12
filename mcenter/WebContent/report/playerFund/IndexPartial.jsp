<%@ page import="so.wwb.gamebox.model.master.report.vo.UserPlayerFund" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.VPlayerFundsRecordListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set value="<%=UserPlayerFund.class%>" var="poType"></c:set>
<!--//region your codes 1-->
<div class="dataTables_wrapper white-bg" role="grid">
    <div class="tab-content">
        <div class="table-responsive">
            <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
                <thead>
                <tr class="bg-gray">
                    <th colspan="9">
                        <span class="pull-left">${views.fund['资金汇总']}</span>
                    </th>
                </tr>
                <tr>
                    <th>${views.player_auto['存款金额']}</th>
                    <th>${views.player_auto['取款金额']}</th>
                    <th>${views.player_auto['优惠金额']}</th>
                    <th>${views.player_auto['返水金额']}</th>
                    <th>${views.player_auto['有效投注额']}</th>
                    <th>${views.player_auto['损益']}</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <c:set var="m" value="${command.fundTotalMap}"/>
                    <td>${m.get('depositamounttotal')}</td>
                    <td>${m.get('withdrawamounttotal')}</td>
                    <td>${m.get('favorableamounttotal')}</td>
                    <td>${m.get('rakebackamounttotal')}</td>
                    <td>${m.get('effectivetransactiontotal')}</td>
                    <td>${m.get('profitlosstotal')}</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
        <thead>
            <tr role="row" class="bg-gray">
                <th>${views.common['number']}</th>
                <th>${views.fund['账号']}</th>
                <soul:orderColumn poType="${poType}" property="createTime" column="${views.player_auto['注册时间']}"></soul:orderColumn>
                <soul:orderColumn poType="${poType}" property="depositCount" column="${views.player_auto['存款次数']}"></soul:orderColumn>
                <soul:orderColumn poType="${poType}" property="depositAmount" column="${views.player_auto['存款金额']}"></soul:orderColumn>
                <soul:orderColumn poType="${poType}" property="withdrawCount" column="${views.player_auto['取款次数']}"></soul:orderColumn>
                <soul:orderColumn poType="${poType}" property="withdrawAmount" column="${views.player_auto['取款金额']}"></soul:orderColumn>
                <soul:orderColumn poType="${poType}" property="favorableAmount" column="${views.player_auto['优惠金额']}"></soul:orderColumn>
                <soul:orderColumn poType="${poType}" property="rakebackAmount" column="${views.player_auto['返水金额']}"></soul:orderColumn>
                <soul:orderColumn poType="${poType}" property="effectiveTransaction" column="${views.player_auto['有效投注额']}"></soul:orderColumn>
                <soul:orderColumn poType="${poType}" property="profitLoss" column="${views.player_auto['损益']}"></soul:orderColumn>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${command.fundList}" var="p" varStatus="status">
                <tr class="tab-detail">
                    <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                    <td>${p.playerName}</td>
                    <td>${soulFn:formatDateTz(p.createTime, DateFormat.DAY_SECOND, timeZone)}</td>
                    <th>${p.depositCount}</th>
                    <th>${soulFn:formatCurrency(p.depositAmount)}</th>
                    <th>${p.withdrawCount}</th>
                    <th>${soulFn:formatCurrency(p.withdrawAmount)}</th>
                    <th>${soulFn:formatCurrency(p.favorableAmount)}</th>
                    <th>${soulFn:formatCurrency(p.rakebackAmount)}</th>
                    <th>${soulFn:formatCurrency(p.effectiveTransaction)}</th>
                    <th>${soulFn:formatCurrency(p.profitLoss)}</th>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
