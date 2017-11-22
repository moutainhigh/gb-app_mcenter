<%--@elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.RebateSetVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form>
	<div id="validateRule" style="display: none">${command.validateRule}</div>
	<div class="row">
		<div class="position-wrap clearfix">
			<h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
			<span>${views.sysResource['运营']}</span><span>/</span><span>${views.sysResource['返佣设置']}</span>
			<a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
			<soul:button tag="a" target="goToLastPage" text="" opType="function" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn">
				<em class="fa fa-caret-left"></em>${views.common['return']}
			</soul:button>
		</div>
		<div class="col-lg-12">
			<div class="wrapper white-bg shadow">
				<div class="present_wrap">
					<b>${views.setting['rebate.edit.view']}</b>
					<a href="/rebateSet/copyRebateSet.html?search.id=${command.result.id}" nav-target="mainFrame">复制本方案</a>
				</div>
				<div class="form-group clearfix m-t-sm m-b-sm line-hi25">
					<label class="ft-bold al-right content-width-limit-10">${views.setting['rebate.view.scheduleName']}：</label>${command.result.name}
				</div>
				<div class="form-group clearfix m-t-sm m-b-sm line-hi25">
					<label class="ft-bold al-right content-width-limit-10">${views.setting['rebate.view.effetivePlayerTransactionAmount']}：</label>${command.result.validValue}
				</div>
				<div class="form-group clearfix m-t-sm m-b-sm line-hi25">
					<label class="ft-bold al-right content-width-limit-10">${views.setting['rebate.view.amountOfAgentTOUseSchedule']}：</label>
					<c:choose>
						<c:when test="${command.result.userAgentNum>0}">
							<a href="/vUserAgentManage/list.html?search.rebateId=${command.result.id}" nav-target="mainFrame" class="co-blue">${command.result.userAgentNum}</a>${views.setting['rebate.view.person']}
						</c:when>
						<c:otherwise>
							${command.result.userAgentNum}${views.setting['rebate.view.person']}
						</c:otherwise>
					</c:choose>
				</div>
				<div class="clearfix m">
					<div class="table-responsive">
						<table class="table table-striped table-bordered table-hover dataTable m-b-none">
							<tr role="row" class="bg-color">
								<td rowspan="2"><h3>${views.setting['rebate.edit.totalProfit']}</h3></td>
								<td rowspan="2"><h3>${views.setting['rebate.edit.validPlayerNum']}</h3></td>
								<td rowspan="2"><h3>${views.setting['rebate.edit.max']}</h3></td>
								<td colspan="${command.apiIds.size()}"><h3>${views.setting['rebate.edit.ratio']}</h3></td>
							</tr>
							<tr class="bg-color">
								<c:forEach items="${command.apiIds}" var="api">
									<td class="bg-gray"><b>${gbFn:getSiteApiName(api.toString())}</b></td>
								</c:forEach>
							</tr>
							<c:forEach items="${command.rebateGrads}" var="rebateGrad" varStatus="status">
							<tr class="bg-color">
								<td height="36">${rebateGrad.totalProfit}</td>
								<td>${rebateGrad.validPlayerNum}</td>
								<td>${soulFn:formatNumber(rebateGrad.maxRebate)}</td>
								<c:forEach items="${command.apiIds}" var="api">
									<td>
										<c:forEach items="${command.someGames}" var="game" varStatus="game_status">
											<c:if test="${game['apiId'] eq api}">
												<c:forEach items="${rebateGrad.rebateGradsApis}" var="rga" varStatus="apiStatus">
													<c:if test="${game['apiId'] eq rga.apiId && game['gameType'] eq rga.gameType}">
														<div class="input-group date" title="${gbFn:getGameTypeName(game['gameType'])}">
																${dicts.game.game_type[game['gameType']]}:${empty rga.ratio?0:rga.ratio}%
														</div>
													</c:if>
												</c:forEach>
											</c:if>
										</c:forEach>
									</td>
								</c:forEach>
							</tr>
							</c:forEach>
						</table>
					</div>
				</div>
				<div class="form-group clearfix m-t-sm m-b-sm line-hi25">
					<label class="ft-bold al-right col-sm-2">${views.setting['rebate.edit.remark']}:</label>
					<div class="col-sm-9">${command.result.remark}</div>
				</div>
			</div>
		</div>
	</div>
</form:form>
<soul:import res="site/setting/rebate/Edit"/>
