<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-10-14
  Time: 下午8:02
--%>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.VReportFundVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<div class="col-lg-12 m-t">
    <div class="wrapper white-bg shadow clearfix">
        <div class="sys_tab_wrap"><div class="m-sm"><b>${views.report['fund.detail.backwater']}</b></div></div>
        <div class="p-sm p-b-xxs">${views.report['fund.detail.playerAccount']}<span class="co-blue">${command.result.username}</span>
            <a class="btn btn-filter btn-outline btn-sm m-l-sm" href="/report/fundsLog/list.html?search.username=${command.result.username}&search.fundTypes=backwater" nav-target="mainFrame">${views.operation['backwater.settlement.view.queryAllBill']}</a>
        </div>
        <div class="dataTables_wrapper p-x" role="grid">


            <div class="panel-body">

                <div class="table-responsive">
                    <table class="table border m-b-none">
                        <thead>
                        <tr class="bg-gray">
                            <th colspan="5"><div class="al-left">${views.report['fund.detail.orderInfo']}</div></th>
                        </tr>
                        <tr>
                            <th>${views.report['fund.detail.transactionNo']}</th>
                            <th>${views.report['fund.detail.transactionInfo']}</th>
                            <th>${views.report['fund.detail.backwaterTotal']}</th>
                            <th>${views.report['fund.detail.backwaterActual']}</th>
                            <th>${views.report['fund.detail.balance']}</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>${empty command.result.transactionNo ? '---':command.result.transactionNo}</td>
                            <td>${_desc}</td>
                            <td class="co-green">+${command.result.backwaterTotal}</td>
                            <td class="co-green">+${command.result.backwaterActual}</td>
                            <td>${command.result.balance}</td>
                        </tr>
                        <%--<tr class="bg-gray">
                            <td colspan="5" class="al-left"><b>${views.report['fund.detail.reasonContent']}</b> ${command.result.reasonContent}</td>
                        </tr>--%>
                        <tr class="bg-gray">
                            <td colspan="5" class="al-left"><b>${views.report['fund.detail.remark']}</b> ${command.result.remark}</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="dataTables_wrapper p-x" role="grid">
            <div class="panel-body">
                <div class="table-responsive">
                    <table class="table border m-b-none">
                        <tr>
                            <th>${views.report['fund.detail.createTime']}</th>
                            <th>${views.report['fund.detail.operateUser']}</th>
                            <th>${views.report['fund.detail.completionTime']}</th>
                            <th>${views.report['fund.detail.status']}</th>
                        </tr>
                        <tr>
                            <td>
                                <c:if test="${empty command.result.createTime}">
                                    ---
                                </c:if>
                                ${soulFn:formatDateTz(command.result.createTime, DateFormat.DAY_SECOND,timeZone)}</td>
                            <td>
                               <%-- <c:if test="${empty command.result.operateName}">
                                    ---
                                </c:if>
                                ${command.result.operateName}--%></td>
                            <td>
                                <c:if test="${empty command.result.completionTime}">
                                    ---
                                </c:if>
                                ${soulFn:formatDateTz(command.result.completionTime, DateFormat.DAY_SECOND,timeZone)}</td>
                            <td>${dicts.common.status[command.result.status]}</td>
                        </tr>
                    </table>
                </div></div></div>

    </div>
</div>