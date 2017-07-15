<%@ page import="so.wwb.gamebox.model.master.player.po.UserPlayerTransfer" %>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div id="editable_wrapper" class="dataTables_wrapper" role="grid">
    <div class="table-responsive table-min-h">
        <table class="table table-striped table-hover dataTable" aria-describedby="editable_info">
        <c:set var="poType" value="<%= UserPlayerTransfer.class %>"></c:set>
        <thead>
        <tr role="row" class="bg-gray">
            <th>${views.common['number']}</th><!--所属总代	所属代理	玩家账号（必填）	账户余额（必填）	真实姓名	手机号码	邮箱地址	收款银行卡号	开户行-->
            <th>${views.column['UserPlayerTransfer.topagent']}</th>
            <th>${views.column['UserPlayerTransfer.agent']}</th>
            <th>${views.setting_auto['层级']}</th>
            <th>${views.column['UserPlayerTransfer.playerAccount']}</th>
            <th>${views.column['UserPlayerTransfer.accountBalance']}</th>
            <th>${views.column['UserPlayerTransfer.realName']}</th>
            <th>${views.column['UserPlayerTransfer.mobilePhone']}</th>
            <th>${views.column['UserPlayerTransfer.email']}</th>
            <th>${views.column['UserPlayerTransfer.bankCode']}</th>
            <th>${views.column['UserPlayerTransfer.bankcardNumber']}</th>
            <th>${views.column['UserPlayerTransfer.bankDeposit']}</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${empty command.result}">
            <td colspan="4" class="no-content_wrap">
                <div>
                    <i class="fa fa-exclamation-circle"></i> ${views.common['noResult']}
                </div>
            </td>
        </c:if>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <tr class="tab-detail">
                <td>${(command.paging.pageNumber-1)*command.paging.pageSize+status.index+1}</td>
                <td>
                    ${p.topagent}
                </td>
                <td>
                    ${p.agent}
                </td>
                <td>${p.playerRank}</td>
                <td>
                    ${p.playerAccount}
                </td>
                <td>
                    ${soulFn:formatCurrency(p.accountBalance)}
                </td>
                <td>
                    ${p.realName}
                </td>
                <td>
                    ${p.mobilePhone}
                </td>
                <td>
                    ${p.email}
                </td>
                <td>${dicts.common.bankname[p.bankCode]}</td>
                <td>
                    ${p.bankcardNumber}
                </td>
                <td>
                    ${p.bankDeposit}
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
