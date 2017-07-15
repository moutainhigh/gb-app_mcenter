<%@ page import="so.wwb.gamebox.model.master.fund.enums.TransactionWayEnum" %><%--@elvariable id="rakebackPlayer" type="so.wwb.gamebox.model.master.operation.po.RakebackPlayer"--%>
<%--@elvariable id="playerTransaction" type="so.wwb.gamebox.model.master.player.po.PlayerTransaction"--%>
<%--@elvariable id="rakebackBillVo" type="so.wwb.gamebox.model.master.operation.vo.RakebackBillVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--返水详细-->
<form>
<div class="row">
    <div class="position-wrap clearfix">
        <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont"></i> </a></h2>
        <span>${views.sysResource['资金']}</span>
        <span>/</span>
        <span>${views.sysResource['返水结算']}</span>
        <soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
            <em class="fa fa-caret-left"></em>${views.common['return']}
        </soul:button>
    </div>
    <div class="col-lg-12">
        <div class="wrapper white-bg clearfix shadow">
            <div class="sys_tab_wrap clearfix">
                <div class="m-sm">
                    <b class="fs16">${views.operation['backwater.view.title']}</b>
                </div>
            </div>
            <div class="table-responsive">
                <div class="panel blank-panel">
                    <div class="panel-body">
                        <div class="tab-content">
                            <div id="tab-1" class="tab-pane active">
                                <div class="al-left">
                                    <label class="">
                                        <b>${views.operation['backwater.settlement.view.playerUsername']}：</b>
                                        <a  href="/player/playerView.html?search.id=${rakebackPlayer.playerId}" nav-Target="mainFrame">
                                            ${rakebackPlayer.username}
                                        </a>
                                    </label>
                                    <a class="btn btn-filter btn-outline btn-sm m-l-sm" href="/report/vPlayerFundsRecord/fundsLog.html?search.outer=-1&search.userTypes=username&search.usernames=${rakebackPlayer.username}&search.transactionWays=<%=TransactionWayEnum.BACK_WATER.getCode()%>&search.hasReturn=true" nav-target="mainFrame">${views.operation['backwater.settlement.view.queryAllBill']}</a>
                                </div>
                                <div class="det-title"><b>${views.operation['backwater.settlement.view.orderInfo']}</b></div>
                                <table class="table table-bordered dataTable">
                                    <thead>
                                    <tr>
                                        <th>${views.column['PlayerTransaction.transactionNo']}</th>
                                        <th>${views.operation['backwater.settlement.view.transactionDescription']}</th>
                                        <th>${views.column['SettlementBackwater.backwaterTotal']}</th>
                                        <th>${views.column['SettlementBackwater.backwaterActual']}</th>
                                        <th>${views.column['PlayerTransaction.balance']}</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>${playerTransaction.transactionNo}</td>
                                        <td>
                                            <div>${views.operation['backwater.settlement.view.backwater']}&nbsp;&nbsp;${playerTransaction.remark}</div>
                                            <div>${soulFn:formatDateTz(rakebackBillVo.result.startTime, DateFormat.DAY, timeZone)} ~ ${soulFn:formatDateTz(rakebackBillVo.result.endTime, DateFormat.DAY, timeZone)}</div>
                                        </td>
                                        <td class="co-green">+${soulFn:formatCurrency(rakebackPlayer.rakebackTotal)}</td>
                                        <td class="co-green">+${soulFn:formatCurrency(rakebackPlayer.rakebackActual)}</td>
                                        <td>${soulFn:formatCurrency(playerTransaction.balance)}</td>
                                    </tr>
                                    <tr>
                                        <td colspan="5" class="al-left">
                                            <b>${views.operation['backwater.settlement.remark']}：</b> ${rakebackPlayer.remark}
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                                <table class="table table-bordered dataTable">
                                    <thead>
                                    <tr>
                                        <th>${views.operation['backwater.settlement.view.createTime']}</th>
                                        <th>${views.operation['backwater.settlement.view.operator']}</th>
                                        <th>${views.operation['backwater.settlement.view.finishTime']}</th>
                                        <th>${views.common['status']}</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>${soulFn:formatDateTz(rakebackBillVo.result.createTime,DateFormat.DAY_SECOND,timeZone)}</td>
                                        <td>${rakebackPlayer.operateUsername}</td>
                                        <td>${soulFn:formatDateTz(rakebackPlayer.settlementTime,DateFormat.DAY_SECOND,timeZone)}</td>
                                        <td><span class="label label-success">${dicts.operation.settlement_state[rakebackPlayer.settlementState]}</span></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</form>
<soul:import type="view"/>