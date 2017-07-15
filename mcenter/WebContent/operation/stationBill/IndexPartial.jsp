<%--@elvariable id="command" type="so.wwb.gamebox.model.report.operation.vo.StationBillListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div class="table-responsive">
    <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
        <thead>
            <tr role="row" class="bg-gray">
                <th>${views.common['number']}</th>
                <th>${views.column['StationBill.billNum']}</th>
                <th>${views.column['StationBill.billName']}</th>
                <th>${views.column['StationBill.amountPayable']}</th>
                <th>${views.common['operate']}</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <tr>
                <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                <td>${p.billNum}</td>
                <td>${p.billName}</td>
                <td>${soulFn:formatCurrency(p.amountPayable)}</td>
                <td>
                    <a href="/operation/stationbill/view.html?id=${p.id}" nav-target="mainFrame">${views.common['detail']}</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<soul:pagination/>
<!--//endregion your codes 1-->
