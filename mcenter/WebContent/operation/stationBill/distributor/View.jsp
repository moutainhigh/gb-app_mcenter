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
		<div class="col-lg-12 m-b">
			<div class="wrapper white-bg shadow clearfix">
				<div class="present_wrap clearfix"><b>${objectVo.result.billName}</b></div>
				<div class="m line-hi25">
					<h3>${views.operation['Bill.distributor.view.topAgent']}：<a href="javascript:void(0)">${objectVo.result.topagentName}</a></h3>
					<p><b>${views.operation['Bill.period']}：</b>${soulFn:formatDateTz(objectVo.result.firstDateOfMonth,DateFormat.DAY,timeZone)}~${soulFn:formatDateTz(objectVo.result.lastDateOfMonth,DateFormat.DAY,timeZone)}</p>
				</div>
				<hr class="m-t-sm m-b-sm">
				<div><b class="line-hi34 m-l">
					${objectVo.result.payMonthMoney}<%=SessionManager.getUser().getDefaultCurrency()%>：<span class="${objectVo.result.cssClass}">${soulFn:formatCurrency(objectVo.result.amountPayable)}</span>
				</b></div>

				<div class="m">
					<div class="dataTables_wrapper">
						<div class="table-responsive tab-content">
							<table class="table border">
								<thead>
									<tr class="bg-gray">
										<th colspan="4"><div class="al-left">${views.operation['Bill.station.view.title3']}</div></th>
									</tr>
									<tr>
										<th>${views.column['StationProfitLoss.apiId']}</th>
										<th>${views.column['StationProfitLoss.gameType']}</th>
										<th>${views.column['StationProfitLoss.occupyProportion.topAgent']}</th>
										<th>${views.column['StationProfitLoss.amountPayable']}</th>
									</tr>
								</thead>
								<tbody>
								<c:set var="total" value="${0}"></c:set>
								<c:forEach var="a" items="${listtomap}">
									<c:forEach var="s" items="${a.value}"  varStatus="status">
										<c:set value="${total+s.amountPayable}" var="total"></c:set>
										<tr>
											<c:if test="${status.index == 0}">
												<td rowspan="${a.value.size()}" class="api-name-b-r"><b>${gbFn:getSiteApiName(a.key.toString())}</b></td>
											</c:if>
											<td>${gameTypeMap[s.gameType].value}</td>
											<td>
												${soulFn:formatCurrency(s.occupyProportion)}%
											</td>
											<td class="${s.cssClass}">
												<c:if test="${s.amountPayable gt 0}">+</c:if>
													${soulFn:formatCurrency(s.amountPayable)}
											</td>
										</tr>
									</c:forEach>
								</c:forEach>
								</tbody>
								<tr class="bg-gray">
									<td class="al-right" colspan="4" style="text-align: right;"><b>${views.common['subtotal']}：</b>${soulFn:formatCurrency(total)}</td>
								</tr>
							</table>
						</div>
					</div>
					<div class="dataTables_wrapper">
						<div class="table-responsive tab-content">
							<table class="table border">
								<thead>
								<tr class="bg-gray">
									<th colspan="3"><div class="al-left">${views.operation['Bill.distributor.view.cost']}</div></th>
								</tr>
								<tr>
									<th>${views.column['StationBillOther.projectCode']}</th>
									<th>${views.column['StationBillOther.apportionProportion']}</th>
									<th>${views.column['StationBillOther.amountPayable_1']}</th>
								</tr>
								</thead>
								<tbody>
									<c:set var="sum" value="${0}"></c:set>
									<c:forEach items="${stationBillOtherListVo.result}" var="p">
										<c:set var="sum" value="${sum+p.amountPayable}"></c:set>
										<tr>
											<td>${dicts.operation.project_code[p.projectCode]}</td>
											<td>
												${soulFn:formatCurrency(p.apportionProportion)}%
											</td>
											<td class="${p.cssClass2}">
												<c:if test="${p.amountPayable gt 0}">+</c:if>
												${soulFn:formatCurrency(p.amountPayable)}
											</td>
										</tr>
									</c:forEach>
								</tbody>
								<tr class="bg-gray">
									<td class="al-right" colspan="3" style="text-align: right;"><b>${views.common['subtotal']}：</b>${soulFn:formatCurrency(sum)}</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</form:form>
<!--//endregion your codes 3-->
<!--//region your codes 4-->
<soul:import type="list"/>
<!--//endregion your codes 4-->