<%@ page import="so.wwb.gamebox.model.master.lottery.po.LotteryTransaction" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.lottery.vo.LotteryTransactionListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<%@taglib uri="http://soul/tags" prefix="soul" %>

<!--//region your codes 1-->
<div id="editable_wrapper" class="dataTables_wrapper" role="grid">
    <div class="table-responsive table-min-h">
        <table class="table table-striped table-hover dataTable m-b-sm" aria-describedby="editable_info">
            <c:set var="poType" value="<%= LotteryTransaction.class %>"></c:set>
            <thead>
            <tr role="row" class="bg-gray">
                <th style="width: 10%;">${views.lottery_auto['序号']}</th>
                <th style="width: 15%;">${views.fund['玩家账号']}</th>
                <th style="width: 15%;">${views.lottery_auto['金额']}</th>
                <th style="width: 15%;">${views.lottery_auto['余额']}</th>
                <th style="width: 15%;">${views.lottery_auto['时间']}</th>
                <th style="width: 15%;">${views.lottery_auto['备注']}</th>
                <th style="width: 15%;">
                    <gb:select name="search.transactionType" cssClass="btn-group chosen-select-no-single" prompt="${views.common['all']}"
                               list="${transactionTypes}" value="${command.search.transactionType}" callback="query"/>
                </th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${empty command.result}">
                <td colspan="6" class="no-content_wrap">
                    <div>
                        <i class="fa fa-exclamation-circle"></i> ${views.common['noResult']}
                    </div>
                </td>
            </c:if>
            <c:forEach items="${command.result}" var="p" varStatus="status">
                <tr class="tab-detail">
                    <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                    <td>${p.username}</td>
                    <c:choose>
                        <c:when test="${p.transactionType==1}">
                            <td>-${p.money}</td>
                        </c:when>
                        <c:otherwise>
                            <td>${p.money}</td>
                        </c:otherwise>
                    </c:choose>
                    <td>${p.balance}</td>
                    <td>${soulFn:formatDateTz(p.transactionTime,DateFormat.DAY_SECOND, timeZone)}</td>
                    <td>${p.memo}</td>
                    <td>${dicts.lottery.transaction_type[p.transactionType]}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<soul:pagination cssClass="bdtop3"/>
<!--//endregion your codes 1-->
