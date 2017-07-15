<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<tr class="bg-color">
	<td colspan="13" class="p-x">
		<div class="panel blank-panel m-b">
			<div class="">
				<div class="panel-options">
					<ul class="nav nav-tabs">
						<li class="active"><a data-toggle="tab" href="../#tab-1" aria-expanded="true">${views.role['rankDetail']}</a></li>
					</ul>
				</div>
			</div>
			<div class="panel-body">
				<div class="tab-content">
					<div id="tab-1" class="tab-pane active">
						<table class="table table-striped table-bordered table-hover dataTable">
							<tbody>
							<tr>
								<th>${views.column['PlayerRank.rankName']}</th>
								<th>${views.column['VplayerRecharge.registerTime']}</th>
								<th>${views.column['VPlayerRankStatistics.playerNum']}</th>
								<th>${views.column['VPlayerRankStatistics.payAccountNum']}</th>
								<th>${views.column['VPlayerRankStatistics.czCount']}</th>
								<th>${views.column['VPlayerRankStatistics.czMaxNum']}</th>
								<th>${views.column['VPlayerRankStatistics.czTotal']}</th>
								<th>${views.column['VPlayerRankStatistics.txCount']}</th>
								<th>${views.column['VPlayerRankStatistics.txTotal']}</th>
								<th>${views.column['PlayerRank.remark']}</th>
							</tr>
							<tr>
								<td>${p.rankName}</td>
								<td>${soulFn:formatDateTz(p.registerStartTime, DateFormat.DAY_SECOND,timeZone)}&nbsp;${views.common['TO']}&nbsp;${soulFn:formatDateTz(p.registerEndTime, DateFormat.DAY_SECOND,timeZone)}</td>
								<td>${empty p.playerNum?0:p.playerNum}</td>
								<td>${p.payAccountNum} <a href="/playerRank/addPayLimit.html?rankId=${p.id}" nav-target="mainFrame">${views.role['setting']}</a></td>
								<td>${empty p.czCount?0:p.czCount}</td>
								<td>${empty p.czMaxNum?0:p.czMaxNum}</td>
								<td>${empty p.txTotal?0:p.txTotal}</td>
								<td>${empty p.txCount?0:p.txCount}</td>
								<td>${empty p.txTotal?0:p.txTotal}</td>
								<td title="${p.remark}">
									<c:choose>
										<c:when test="${fn:length(p.remark)>5}">${fn:substring(p.remark, 0, 5)}</c:when>
										<c:otherwise>${p.remark}</c:otherwise>
									</c:choose>
								</td>
							</tr>
							</tbody>
						</table>
						<div class="det-title"><b>${views.role['draw.limit']}</b></div>
						<dl class="col-sm-4 al-left tixian">
							<dt>${views.role['draw.charge']}</dt>
							<dd class="table-bordered">
								<div><b>${views.role['limit.time']}/${views.role['hour']}：</b><c:if test="${!empty p.txTimeLimit}">${p.txTimeLimit}${views.role['hour']}</c:if></div>
								<div><b>${views.role['free.num']}：</b>${p.txFreeCount}</div>
								<div><b>${views.role['max.money']}：</b>${empty p.txMaxFee?'':currency}&nbsp;<fmt:formatNumber value="${p.txMaxFee}" pattern="#,###.00#"/></div>
								<div><b>${views.role['charge.percent']}：</b>${p.txFeeNum}${p.txFeeType eq '1'?'%':''}</div>
							</dd>
						</dl>
						<dl class="col-sm-4 al-left tixian">
							<dt>${views.role['draw.setting']}</dt>
							<dd class="table-bordered">
								<div><b>${views.role['draw.audit']}：</b><c:if test="${!empty p.txCheckTime}">${views.role['deal.time']}${p.txCheckTime}${views.role['hour']}</c:if></div>
								<div><b>${views.role['ex.drawaudit']}：</b><c:if test="${!empty p.txExcessCheckNum}">${views.role['ex.money']}<%=SessionManager.getUser().getDefaultCurrency()%>${p.txExcessCheckNum} ${views.role['deal.time']}${p.txExcessCheckTime}${views.role['hour']}</c:if></div>
							</dd>
						</dl>
						<dl class="col-sm-4 al-left tixian">
							<dt>${views.role['draw.check']}</dt>
							<dd class="table-bordered">
								<div><b>${views.role['one.maxlimit']}：</b>${empty p.txMaxNum?'':currency}&nbsp;${p.txMaxNum}</div>
								<div><b>${views.role['one.minlimit']}：</b>${empty p.txMinNum?'':currency}&nbsp;${p.txMinNum}</div>
								<div><b>${views.role['normal.check']}：</b><c:if test="${!empty p.txNormalAudit}">${p.txNormalAudit}%</c:if></div>
								<div><b>${views.role['admin.free']}：</b><c:if test="${!empty p.txAdminCost}">${p.txAdminCost}%</c:if></div>
								<div><b>${views.role['range.money']}：</b><c:if test="${!empty p.txRelaxCredit}">${currency}&nbsp;${p.txRelaxCredit}</c:if></div>
								<div><b>${views.role['sale.balancecheck']}：</b><c:if test="${!empty p.txDiscountAudit}">${p.txDiscountAudit}%</c:if></div>
							</dd>
						</dl>
					</div>
				</div>
			</div>
		</div>
	</td>
</tr>