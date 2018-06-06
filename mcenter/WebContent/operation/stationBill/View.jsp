<%--@elvariable id="command" type="so.wwb.gamebox.model.report.operation.vo.StationBillVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<!--//region your codes 3-->
<form:form>
	<div class="row">
		<div class="position-wrap clearfix">
			<h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
			<span>${views.sysResource['资金']}</span>
			<span>/</span><span>${views.sysResource['结算账单']}</span>
			<soul:button target="goToLastPage" refresh="false" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
				<em class="fa fa-caret-left"></em>${views.common['return']}
			</soul:button>
			<a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
		</div>
		<div class="col-lg-12">
			<div class="wrapper white-bg shadow clearfix">
				<div class="present_wrap clearfix"><b>${objectVo.result.billName}</b></div>
				<div class="m line-hi25">
					<h3>${views.operation['Bill.station.view.dear']} ${siteName}${views.operation['Bill.station.view.hello']}</h3>
					<p>
						${views.operation['Bill.station.view.message4']}${objectVo.result.billName}
					</p>
					<p><b>${views.operation['Bill.period']}：</b>
							${soulFn:formatDateTz(objectVo.result.firstDateOfMonth,DateFormat.DAY,timeZone)}~${soulFn:formatDateTz(objectVo.result.lastDateOfMonth,DateFormat.DAY,timeZone)}
					</p>
				</div>
				<hr class="m-t-sm m-b-sm">
				<div>
					<b class="line-hi34 m-l">
							${fn:replace(views.operation['Bill.station.pop.message4'],'{billMonth}',objectVo.result.billMonth)}：<span class="${objectVo.result.cssClass}">${soulFn:formatCurrency(objectVo.result.amountPayable)}</span>
								<c:if test="${objectVo.result.amountPayable lt 0 && objectVo.result.allowModify}">
									<soul:button permission="operate:bill_modify" callback="allQuery" target="${root}/operation/stationbill/toUpdateAmountPayable.html?search.id=${objectVo.result.id}" text="${views.operation['Bill.station.view.update']}" opType="dialog" cssClass="btn btn-warning btn-xs m-l">${views.common['Bill.station.view.update']}</soul:button>
						</c:if>
					</b>
				</div>
				<c:if test="${objectVo.result.amountActual ne objectVo.result.amountPayable}">
					<div>
						<b class="line-hi34 m-l">
								${views.operation['Bill.station.pop.message5']}：<span class="${objectVo.result.cssClass2}">${soulFn:formatCurrency(objectVo.result.amountActual)}</span>
						</b>
					</div>
				</c:if>
				<div class="clearfix bg-gray p-t-xs p-l-sm p-r-sm">
                    <span class="co-orange line-hi25 pull-left m-r-sm">
                        <i class="fa fa-exclamation-circle m-t-n-sm"></i>
                    </span>
					<div class="line-hi25 pull-left m-b-sm">${views.operation['Bill.station.view.message1']}
					</div>
				</div>
				<div class="m">
					<div class="dataTables_wrapper">
						<div class="table-responsive tab-content">
							<table class="table border">
								<thead>
								<tr class="bg-gray">
									<th colspan="5"><div class="al-left">${views.operation['Bill.station.view.title1']}</div></th>
								</tr>
								<tr>
									<th width="20%">${views.column['StationProfitLoss.profitAndLoss']}<span tabindex="0" class=" help-popover m-l-sm" role="button" data-container="body" data-toggle="popover" data-html="ture" data-trigger="focus" data-placement="top" data-content="${views.operation['Bill.station.view.message']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span></th>
									<th width="20%">${views.column['StationProfitLoss.gameType']}</th>
										<%--<th>${views.column['StationProfitLoss.occupyProportion']}</th>--%>
									<th width="20%">${views.column['StationProfitLoss.profitLoss']}</th>
									<th>${views.column['StationProfitLoss.amountPayable']}</th>
								</tr>
								</thead>
								<tbody>
								<c:set var="total" value="${0}"></c:set>
								<c:forEach var="a" items="${listtomap}">
									<c:forEach var="s" items="${a.value}"  varStatus="status">
										<c:choose>
											<c:when test="${s.apiId == '10'|| s.gameType == 'LiveDealer'}">
												<c:set value="${total+s.amountPayable}" var="total"></c:set>
											</c:when>
											<c:otherwise>
												<c:if test="${s.amountPayable gt 0}">
													<c:set value="${total+s.amountPayable}" var="total"></c:set>
												</c:if>
											</c:otherwise>
										</c:choose>
										<tr>
											<c:if test="${status.index == 0}">
												<td rowspan="${a.value.size()}" class="api-name-b-r">
													<input type="checkbox" class="i-checks" disabled="" ${contractApiMap[a.key].isAssume?"checked":""}><b>${gbFn:getSiteApiName(a.key.toString())}</b>
												</td>
											</c:if>
											<td>${dicts.game.game_type[s.gameType]}</td>
											<td>
													${soulFn:formatCurrency(s.profitLoss)}
											</td>
											<td class="${s.cssClass}">
												<c:if test="${s.amountPayable gt 0}">+</c:if>
													${soulFn:formatCurrency(s.amountPayable)}
											</td>
										</tr>
									</c:forEach>
								</c:forEach>
								</tbody>
								<tr class="bg-gray" hd="${hdTotal}">
									<c:if test="${hdTotal>0}">
										<c:set value="${total+hdTotal}" var="total"></c:set>
									</c:if>
									<td class="al-right" colspan="5"><b>${views.common['subtotal']}：</b>${soulFn:formatCurrency(total)}</td>
								</tr>
							</table>
						</div>
					</div>
					<div class="dataTables_wrapper">
						<div class="table-responsive tab-content">
							<table class="table border">
								<thead>
								<tr class="bg-gray">
									<th colspan="4"><div class="al-left">${views.operation['Bill.station.view.title2']}</div></th>
								</tr>
								<tr>
									<th>${views.column['StationBillOther.projectCode']}</th>
									<th>${views.column['StationBillOther.amountPayable']}</th>
									<th>${views.column['StationBillOther.amountActual']}</th>
									<th>${views.column['StationBillOther.remark']}</th>
								</tr>
								</thead>
								<tbody>
								<c:set var="sum" value="${0}"></c:set>
								<c:forEach items="${stationBillOtherListVo}" var="p">
									<c:if test="${p.projectCode ne 'reduction_maintenance_fee'}">
										<tr>
											<td>${dicts.operation.project_code[p.projectCode]}</td>
											<td class="<c:choose>
														<c:when test="${p.projectCode eq 'return_profit'}">
															co-orange
														</c:when>
														<c:otherwise>
															${p.cssClass2}
														</c:otherwise>
													</c:choose>">
												<c:choose>
													<c:when test="${p.projectCode eq 'return_profit'}">
														${soulFn:formatCurrency(p.amountPayableAfter)}
													</c:when>
													<c:otherwise>
														${soulFn:formatCurrency(p.amountPayable)}
													</c:otherwise>
												</c:choose>
											</td>
											<td class="<c:choose>
														<c:when test="${p.projectCode eq 'return_profit'}">
															co-orange
														</c:when>
														<c:otherwise>
															${p.cssClass}
														</c:otherwise>
													</c:choose>">
												<c:if test="${p.amountActual gt 0 && p.projectCode ne 'return_profit'}">+</c:if>
												<c:choose>
													<c:when test="${p.projectCode eq 'return_profit'}">
														<c:set var="sum" value="${sum+p.amountActualAfter}"></c:set>
														${soulFn:formatCurrency(p.amountActualAfter)}
													</c:when>
													<c:otherwise>
														<c:set var="sum" value="${sum+p.amountActual}"></c:set>
														${soulFn:formatCurrency(p.amountActual)}
													</c:otherwise>
												</c:choose>
											</td>
											<td>${p.remark}</td>
										</tr>
									</c:if>
								</c:forEach>
								</tbody>
								<tr class="bg-gray">
									<td class="al-right" colspan="4"><b>${views.common['subtotal']}：</b>${soulFn:formatCurrency(sum)}</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--//endregion your codes 3-->
	<!--//region your codes 4-->
</form:form>
<soul:import res="site/operation/stationbill/View"/>
<!--//endregion your codes 4-->