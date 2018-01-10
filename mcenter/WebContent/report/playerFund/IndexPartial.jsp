<%@ page import="so.wwb.gamebox.model.master.report.vo.UserPlayerFund" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.VPlayerFundsRecordListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set value="<%=UserPlayerFund.class%>" var="poType"></c:set>
<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
        <thead>
            <tr role="row" class="bg-gray">
                <th>${views.common['number']}</th>
                <th>账号</th>
                <th>注册时间</th>
                <th>存款次数</th>
                <th>存款金额</th>
                <th>取款次数</th>
                <soul:orderColumn poType="${poType}" property="withdrawAmount" column="取款金额"></soul:orderColumn>
                <%--<th>取款金额</th>--%>
                <%--<th>优惠优惠</th>--%>
                <soul:orderColumn poType="${poType}" property="favorableAmount" column="优惠金额"></soul:orderColumn>
                <th>返水金额</th>
                <th>有效投注额</th>
                <th>损益</th>
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
