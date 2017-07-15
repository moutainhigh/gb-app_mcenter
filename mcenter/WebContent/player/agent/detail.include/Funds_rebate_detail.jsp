<%--@elvariable id="listVo" type="so.wwb.gamebox.model.master.player.vo.RemarkListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form id="agentDetail">
<div class="row">
    <div class="position-wrap clearfix">
        <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
        <span>${views.sysResource['角色']}</span>
        <span>/</span><span>${views.sysResource['代理管理']}</span>
        <soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
            <em class="fa fa-caret-left"></em>${views.common['return']}
        </soul:button>
    </div>
    <div class="col-lg-12">
        <div class="wrapper white-bg clearfix shadow">
            <div class="sys_tab_wrap clearfix line-hi34 p-sm">
                <div class="pull-left">
                    <h3 class="pull-left m-b-none">${views.column['userAgent.funds.type.rebateDetail']}</h3>
                </div>
            </div>
            <div class="table-responsive">
                <div class="panel blank-panel">
                    <div class="panel-body">
                        <div class="tab-content">
                            <div id="tab-1" class="tab-pane active">
                                <input type="hidden" name="search.agentId" value="${command.search.agentId}">
                                <div class="al-left">
                                    <label class=""><b>${views.column['userAgent.funds.type.rebateDetail.account']}：</b> <span class="co-blue">${username}</span></label>
                                    <%--<label class=""><a href="/userAgent/agent/detail.html?search.id=${agentId}&extendedLinks=yes" nav-target="mainFrame">${views.player_auto['查询所有订单']}</a></label>--%>
                                </div>
                                <div class="det-title"><b>${views.column['userAgent.funds.type.rebateDetail.order.info']}</b></div>
                                <table class="table table-bordered dataTable">
                                    <thead>
                                    <tr>
                                        <th>${views.column['userAgent.funds.tradeNo']}</th>
                                        <th>${views.column['userAgent.funds.type.rebateDetail.order.description']}</th>
                                        <th>${views.column['userAgent.funds.type.rebateDetail.order.should']}</th>
                                        <th>${views.column['userAgent.funds.type.rebateDetail.order.actual']}</th>
                                        <th>${views.column['userAgent.funds.type.rebateDetail.order.amount']}</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>${orderVo.result.transactionNo}</td>
                                        <td>
                                            <div>${orderVo.result.settlementName}&nbsp;${views.role['Agent.detail.rebateDetail']}</div>
                                            <div>${soulFn:formatDateTz(orderVo.result.startTime, DateFormat.DAY,timeZone)} ~ ${soulFn:formatDateTz(orderVo.result.endTime, DateFormat.DAY,timeZone)}</div>
                                        </td>
                                        <td class="co-green">
                                            <c:if test="${orderVo.result.rebateAmount gt 0}">+</c:if>
                                            ${soulFn:formatCurrency(orderVo.result.rebateAmount)}
                                        </td>
                                        <td class="co-green">
                                            <c:if test="${orderVo.result.actualAmount gt 0}">+</c:if>
                                            ${soulFn:formatCurrency(orderVo.result.actualAmount)}
                                        </td>
                                        <td>${soulFn:formatCurrency(billVo.result.balance)}</td>
                                    </tr>
                                    <tr>
                                    <tr>
                                        <td colspan="5" class="al-left"><b>${views.column['userAgent.funds.type.rebateDetail.order.remark']}：</b>${orderVo.result.remark}</td>
                                    </tr>
                                        <c:if test="${orderVo.result.settlementState == 'reject_lssuing'}">
                                            <td colspan="5" class="al-left"><b>${views.column['userAgent.funds.type.rebateDetail.order.rejectReason']}：</b>${orderVo.result.reasonContent}</td>
                                        </c:if>
                                    </tr>
                                    </tbody>
                                </table>

                                <table class="table table-bordered dataTable">
                                    <thead>
                                    <tr>
                                        <th>${views.column['userAgent.funds.type.rebateDetail.order.createTime']}</th>
                                        <th>${views.column['userAgent.funds.type.rebateDetail.order.operator']}</th>
                                        <th>${views.column['userAgent.funds.type.rebateDetail.order.completeTime']}</th>
                                        <th>${views.column['userAgent.funds.type.rebateDetail.order.status']}</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>${soulFn:formatDateTz(orderVo.result.billCreateTime, DateFormat.DAY_SECOND,timeZone)}</td>
                                        <td>${orderVo.result.username}</td>
                                        <td>${soulFn:formatDateTz(orderVo.result.createTime, DateFormat.DAY_SECOND,timeZone)}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${orderVo.result.settlementState == 'lssuing'}"><span class="label label-success">${dicts.operation.settlement_state[orderVo.result.settlementState]}</span></c:when>
                                                <c:when test="${orderVo.result.settlementState == 'pending_lssuing'}"><span class="label">${dicts.operation.settlement_state[orderVo.result.settlementState]}</span></c:when>
                                                <c:when test="${orderVo.result.settlementState == 'reject_lssuing'}"><span class="label label-danger">${dicts.operation.settlement_state[orderVo.result.settlementState]}</span></c:when>
                                            </c:choose>
                                        </td>
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
<soul:import res="site/player/agent/Detail"/>