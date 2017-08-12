<%--@elvariable id="command" type="so.wwb.gamebox.model.company.credit.vo.CreditRecordListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray tab-detail">
            <th>${views.setting_auto['订单号']}</th>
            <th>${views.setting_auto['操作人']}</th>
            <th>${views.setting_auto['充值金额']}</th>
            <th>${views.setting_auto['类型']}</th>
            <th>
                ${views.setting_auto['类型']}
                <%--<gb:select name="search.fundType" value="${command.search.fundType}" cssClass="btn-group chosen-select-no-single" prompt="${views.common['all']}"
                           list="${command.dictFundType}" listKey="key" listValue="value" callback="query"/>--%>
            </th>
            <th>${views.setting_auto['存款渠道']}</th>
            <th>${views.setting_auto['支付时间']}</th>
            <th>${views.setting_auto['IP']}</th>
        </tr>
        </thead>



        <tbody>
        <c:forEach items="${command.result}" var="p" varStatus="status">

            <tr class="tab-detail">
                <td>${p.transactionNo}</td>
                <td>${p.checkName}</td>
                <td>${soulFn:formatCurrency(p.payAmount)}</td>
                <td>${dicts.credit.pay_type[p.payType]}</td>
                <td>${dicts.credit.credit_status[p.status]}</td>
                <td>${p.bankName}</td>
                <td>${p.createTime}</td>
                <td>${p.ip}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<soul:pagination/>
<!--//endregion your codes 1-->

