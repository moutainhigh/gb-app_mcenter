<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-11-12
  Time: 下午9:47
--%>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.VPlayerTransactionVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="col-lg-12">
    <div class="wrapper white-bg shadow clearfix">
        <div class="sys_tab_wrap"><div class="m-sm"><b>${views.report_auto['额度转换详细']}</b></div></div>
        <div class="p-sm p-b-xxs">${views.report_auto['玩家账号']}：<span class="co-blue">${command.result.username}</span>
            <a class="btn btn-filter btn-outline btn-sm m-l-sm" href="/report/fundsLog/list.html?search.username=${command.result.username}&search.fundTypes=transfer_into&search.fundTypes=transfer_out" nav-target="mainFrame">${views.operation['backwater.settlement.view.queryAllBill']}</a>
        </div>

        <div class="dataTables_wrapper p-x" role="grid">


            <div class="panel-body">

                <div class="table-responsive">
                    <table class="table border m-b-none">
                        <thead>
                        <tr class="bg-gray">
                            <th colspan="5"><div class="al-left">${views.report_auto['订单信息']}</div></th>
                        </tr>
                        <tr>
                            <th>${views.report_auto['交易号']}</th>
                            <th>${views.report_auto['交易描述']}</th>
                            <th>${views.report_auto['金额']}</th>
                            <th>${views.report_auto['钱包余额']}</th>
                            <th>${views.report_auto['API余额']}</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>
                                ${command.result.transactionNo}
                                <c:if test="${command.result.origin eq 'MOBILE'}">
                                    <span class="fa fa-mobile mobile" data-content="${views.report_auto['手机订单']}" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                                    </span>
                                </c:if>
                            </td>
                            <td>${_desc}</td>
                            <td class="co-red3">${soulFn:formatCurrency(command.result.transactionMoney)}</td>
                            <td>${soulFn:formatCurrency(command.result.balance)}</td>
                            <td>${command.result.apiMoney}</td>
                        </tr>
                        </tbody>
                    </table>
                </div></div></div>
        <div class="dataTables_wra pper p-x" role="grid">


            <div class="panel-body">
                <div class="table-responsive">
                    <table class="table border m-b-none">
                        <tbody><tr>
                            <th>${views.report_auto['创建时间']}</th>
                            <th>${views.report_auto['操作人']}</th>
                            <th>${views.report_auto['完成时间']}</th>
                            <th>${views.report_auto['状态']}</th>
                        </tr>
                        <tr>
                            <td>${soulFn:formatDateTz(command.result.createTime, DateFormat.DAY_SECOND,timeZone)}</td>
                            <td>${views.report_auto['线上转换']}</td>
                            <td>${soulFn:formatDateTz(command.result.completionTime, DateFormat.DAY_SECOND,timeZone)}</td>
                            <td>${dicts.common.status[command.result.status]}</td>
                        </tr>
                        </tbody></table>
                </div></div></div>

    </div>
</div>