<%@ page import="so.wwb.gamebox.model.company.credit.po.VCreditRecord" %><%--@elvariable id="command" type="so.wwb.gamebox.model.company.credit.vo.VCreditRecordListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="poType" value="<%= VCreditRecord.class %>" />
<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray tab-detail">
            <th>${views.setting_auto['订单号']}</th>
            <th>${views.setting_auto['操作人']}</th>
            <th>${views.setting_auto['充值金额']}</th>
            <th>
                <gb:select name="search.payType" value="${command.search.payType}" cssClass="btn-group chosen-select-no-single" prompt="${views.common['all']}"
                           list="${payType}" listKey="key" listValue="value" callback="query"/>
            </th>
            <th>
                <gb:select name="search.status" value="${command.search.status}" cssClass="btn-group chosen-select-no-single" prompt="${views.common['all']}"
                           list="${status}" listKey="key" listValue="value" callback="query"/>
            </th>
            <th>${views.setting_auto['存款渠道']}</th>
            <th>${views.setting_auto['支付时间']}</th>
            <th>${views.setting_auto['IP']}</th>
            <th>${views.setting['credit.creditRecord.receipt']}</th>
            <th>${views.common['operate']}</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <tr class="tab-detail">
                <td>${empty p.transactionNo?"---":p.transactionNo}</td>
                <td>
                    <c:choose>
                        <c:when test="${p.backgroundAdded == true}">
                            ${views.setting['credit.creditRecord.boss']}
                        </c:when>
                        <c:otherwise>
                            ${p.payUserName}
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>${soulFn:formatInteger(p.payAmount)}${soulFn:formatDecimals(p.payAmount)}</td>
                <td>${dicts.credit.pay_type[p.payType]}</td>
                <td>
                    <c:set value="" var="status_class"></c:set>
                    <c:choose>
                        <c:when test='${p.status eq 1}'> 	<%--状态：处理中 --%> <c:set var="status_class" value="label label-info"></c:set></c:when>
                        <c:when test='${p.status eq 2}'> 	<%--状态：成功 --%> <c:set var="status_class" value="label label-success"></c:set></c:when>
                        <c:when test='${p.status eq 3}'> 	<%--状态：失败 --%> <c:set var="status_class" value="label"></c:set></c:when>
                    </c:choose>
                    <span class="${status_class}">${dicts.credit.credit_status[p.status]}</span>
                </td>
                <td>${empty dicts.common.bankname[p.bankName]?"---":dicts.common.bankname[p.bankName]}</td>
                <td>${soulFn:formatDateTz(p.createTime, DateFormat.DAY_SECOND,timeZone)}</td>
                <td>${soulFn:formatIp(p.ip)}</td>
                <td>
                    <c:if test="${not empty p.path}">
                        <a href="javascript:void(0)"><img data-src="${soulFn:getImagePath(domain,p.path)}" src="${soulFn:getThumbPath(domain,p.path,66,24)}"></a>
                    </c:if>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${!p.backgroundAdded}">
                            <soul:button target="${root}/creditRecord/uploadReceipt.html?search.id=${p.id}"
                                         text="${views.setting['credit.creditRecord.uploadReceipt']}" opType="dialog"
                                         callback="query">${views.setting['credit.creditRecord.uploadReceipt']}</soul:button>
                        </c:when>
                        <c:otherwise>
                            ---
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

