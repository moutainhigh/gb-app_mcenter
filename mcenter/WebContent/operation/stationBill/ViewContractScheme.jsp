<%--@elvariable id="command" type="so.wwb.gamebox.model.report.operation.vo.StationBillVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
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
			<div class="wrapper white-bg shadow">
				<div class="present_wrap"><b>${views.operation_auto['方案详细']}</b></div>
				<div class="m-sm">
					<div class="clearfix m-b-sm">
						<dd class="pull-left p-xs text-oflow-m60">
							<b>${views.operation_auto['方案名称']}：</b>
							<span class="m-l-xs">${command.result.schemeName}</span>
						</dd>
						<dd class="pull-left p-xs text-oflow-m60">
							<b>${views.operation_auto['保底消费CNY']}${siteCurrency}:</b>
							<span class="m-l-xs">${soulFn:formatCurrency(command.result.ensureConsume)} <span tabindex="0" class=" help-popover" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top" data-html="true" data-content="${views.operation_auto['根据站点报表计算出的运营商占成费用高于保底']}" ><i class="fa fa-question-circle"></i></span></span>
						</dd>
						<dd class="pull-left p-xs text-oflow-m60">
							<b>${views.operation_auto['维护费/月']}:</b>
							<span class="m-l-xs">${soulFn:formatCurrency(command.result.maintenanceCharges)} <span tabindex="0" class=" help-popover" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top" data-html="true" data-content="${views.operation_auto['线路费用']}"><i class="fa fa-question-circle"></i></span></span>
						</dd>
						<%--<dd class="pull-left p-xs text-oflow-m60">--%>
							<%--<b>${views.operation_auto['使用运营商']}:</b>--%>
							<%--<span class="m-l-xs">${command.result.centerChooseNum}个</span>--%>
						<%--</dd>--%>
						<dd class="pull-left p-xs text-oflow-m60">
							<b>${views.operation_auto['使用站点']}:</b>
							<span class="m-l-xs">${command.result.siteChooseNum}</span>
						</dd>
					</div>

					<div class="gray-chunk clearfix">
						<div class="form-group clearfix">
							<label class="ft-bold col-sm-3 line-hi34 al-right">${views.operation_auto['运营商占成']}：</label>
							<div class="col-sm-8">
								<div class="dataTables_wrapper" role="grid">
									<div class="tab-content table-responsive">
										<table class="table table-striped border">
											<tbody>
											<tr>
												<td class="ft-bold al-centre" rowspan="2"><div class=" content-width-limit-5">${views.operation_auto['盈亏共担']} </div></td>
												<td class="bg-gray ft-bold" colspan="${2+fn:length(command.contractOccupyGradsList)}">${views.operation_auto['API盈利梯度/月']}</td>
											</tr>
											<tr>
												<td class="ft-bold al-centre"><div class=" content-width-limit-5">${views.operation_auto['API二级分类']}</div></td>
												<c:forEach items="${command.contractOccupyGradsList}" var="c">
													<td>
															${soulFn:formatCurrency(c.profitLower/10000)} ~
														<c:if test="${fn:contains(c.profitLimit, '+')}">
															${c.profitLimit/10000}
														</c:if>
														<c:if test="${!fn:contains(c.profitLimit, '+')}">
															${soulFn:formatCurrency(c.profitLimit/10000)}
														</c:if>
														${views.operation_auto['万']}
													</td>
												</c:forEach>
											</tr>
											<c:forEach items="${command.contractApiList}" var="p">
												<tr>
													<td><input type="checkbox" class="i-checks" disabled ${p.isAssume?'checked':''}> ${gbFn:getSiteApiName((p.apiId).toString())}</td>
													<td>
														<c:forEach items="${p.siteI18nList}" var="ps">
															<dd class="inline-ch">${ps.value}</dd>
														</c:forEach>
													</td>
													<c:forEach items="${command.contractOccupyGradsList}" varStatus="cc">
														<!--前台是在该API下，以梯度范围列，循环游戏类别下的相应索引的梯度值 -->
														<td>
															<c:forEach items="${p.siteI18nList}" var="ps">
																<dd class="inline-ch">
																		${empty ps.contractOccupyApis[cc.index].ratio?0:ps.contractOccupyApis[cc.index].ratio}%
																</dd>
															</c:forEach>
														</td>
													</c:forEach>
												</tr>
											</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>

						<div class="form-group clearfix">
							<label class="ft-bold col-sm-3 line-hi34 al-right">${views.operation_auto['优惠']}：</label>
							<div class="col-sm-8">
								<c:forEach items="${command.contractFavourableList}" var="p">
									<c:if test="${p.favourableType eq '1'}">
										<div class="m-b">
											<div class="clearfix m-t-sm m-b-sm">
												<span class="pull-left m-l-sm"><input type="checkbox" class="i-checks" disabled checked>${views.operation_auto['减免维护费']}</span>
												<span class="pull-left m-l-sm"><input type="radio" class="i-checks" name="a" disabled ${p.favourableWay eq '1'?'checked':''}> ${views.operation_auto['固定']}</span>
												<span class="pull-left m-l-sm"><input type="radio" class="i-checks" name="a" disabled ${p.favourableWay eq '2'?'checked':''}> ${views.operation_auto['按比例']}</span>
											</div>

											<div class="dataTables_wrapper">
												<div class="tab-content table-responsive">
													<table class="table table-striped border">
														<tbody>
														<c:if test="${fn:length(p.gradses)>0}">
															<tr>
																<c:forEach items="${p.gradses}" var="c">
																	<td>
																			${fn:replace(views.operation_auto['满万'],"[0]",soulFn:formatCurrency(c.profitLower/10000))}
																	</td>
																</c:forEach>
															</tr>
														</c:if>
														<tr>
															<c:forEach items="${p.gradses}" var="c">
																<td>
																		${views.operation_auto['减']}&nbsp;&nbsp;
																	<%--${empty c.favourableValue?0:(p.favourableWay eq '1'?c.favourableValue/10000:soulFn:formatCurrency(c.favourableValue))}&nbsp;&nbsp;
																		${p.favourableWay eq '1'?'万':'%'}--%>
																		${empty c.favourableValue?0:soulFn:formatCurrency(c.favourableValue)}&nbsp;&nbsp;
																		${p.favourableWay eq '2'?'%':''}
																</td>
															</c:forEach>
														</tr>
														</tbody>
													</table>
												</div>
											</div>
										</div>
									</c:if>
								</c:forEach>
								<c:forEach items="${command.contractFavourableList}" var="p">
									<c:if test="${p.favourableType eq '2'}">
										<div class="m-b">
											<div class="clearfix m-t-sm m-b-sm line-hi34">
												<span class="pull-left m-l-sm"><input type="checkbox" class="i-checks" value="1" disabled checked> ${views.operation_auto['返还盈利']}</span>
												<span class="pull-left m-l-sm"><input type="radio" class="i-checks" name="b" disabled ${p.favourableWay eq '1'?'checked':''}> ${views.operation_auto['固定']}</span>
												<span class="pull-left m-l-sm"><input type="radio" class="i-checks" name="b" disabled ${p.favourableWay eq '2'?'checked':''}> ${views.operation_auto['按比例']}</span>
												<span class="pull-left m-l-sm">
													<c:if test="${not empty p.favourableLimit}">
														${views.operation_auto['上限CNY']}${siteCurrency}：${soulFn:formatCurrency(p.favourableLimit)}
													</c:if>
												</span>
											</div>

											<div class="dataTables_wrapper">
												<div class="tab-content table-responsive">
													<table class="table table-striped border">
														<tbody>
														<c:if test="${fn:length(p.gradses)>0}">
															<tr>
																<c:forEach items="${p.gradses}" var="c">
																	<td>
																			${fn:replace(views.operation_auto['满万'],"[0]",soulFn:formatCurrency(c.profitLower/10000))}
																	</td>
																</c:forEach>
															</tr>
														</c:if>
														<tr>
															<c:forEach items="${p.gradses}" var="c">
																<td>
																		${views.operation_auto['返']} &nbsp;&nbsp;
																	<%--${empty c.favourableValue?0:(p.favourableWay eq '1'?c.favourableValue/10000:soulFn:formatCurrency(c.favourableValue))}&nbsp;&nbsp;
																		${p.favourableWay eq '1'?'万':'%'}--%>
																		${empty c.favourableValue?0:soulFn:formatCurrency(c.favourableValue)}&nbsp;&nbsp;
																		${p.favourableWay eq '2'?'%':''}
																</td>
															</c:forEach>
														</tr>
														</tbody>
													</table>
												</div>
											</div>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--//endregion your codes 3-->
<!--//region your codes 4-->
</form:form>
<soul:import type="list"/>
<!--//endregion your codes 4-->