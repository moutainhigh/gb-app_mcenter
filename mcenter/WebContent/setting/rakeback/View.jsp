<%--@elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.VRakebackSetVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form>
	<div class="row">
		<div class="position-wrap clearfix">
			<h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
			<span>${views.sysResource['运营']}</span><span>/</span><span>${views.setting['rakeback.edit.title']}</span>
			<a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
			<soul:button tag="a" target="goToLastPage" text="" opType="function" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn">
				<em class="fa fa-caret-left"></em>${views.common['return']}
			</soul:button>
		</div>
		<div class="col-lg-12">
			<div class="wrapper white-bg shadow">

				<div class="present_wrap"><b>${views.setting['rakeback.view.planDetail']}</b></div>
				<div class="form-group clearfix m-t-sm m-b-sm line-hi25">
					<label class="ft-bold al-right content-width-limit-10">${views.setting['rakeback.edit.planName']}</label>
					<c:out value="${command.result.name}"></c:out>
					<%--0停用，1正常 TODO　颜色--%>
					<c:choose>
						<c:when test="${command.result.status eq '0'}">
							<span class="co-green m-l-xs fs12">${dicts.setting.program_settings[r.status]}</span>
						</c:when>
						<c:otherwise>
							<span>${dicts.setting.program_settings[r.status]}</span>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="form-group clearfix m-t-sm m-b-sm line-hi25">
					<label class="ft-bold al-right content-width-limit-10">
						<span title="" data-original-title="" data-content="1、${views.setting_auto['优惠稽核倍数为空']}<br>2、${views.setting_auto['玩家在取款时']}<br>3、${views.setting_auto['当没有通过存款申请获得优惠']}" data-html="true" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover m-l-sm" tabindex="0"><i class="fa fa-question-circle"></i></span>
					${views.setting['rakeback.edit.auditNum']}
					</label>
					<span class="co-red m-r-xs fs12">${command.result.auditNum}</span>${views.setting['rakeback.edit.times']}
				</div>
				<div class="form-group clearfix m-t-sm m-b-sm line-hi25">
					<label class="ft-bold al-right content-width-limit-10">${views.setting['rakeback.view.amountOfRank']}：</label>
					<c:choose>
						<c:when test="${command.result.rankCount>0}">
							<td class="co-blue"><a nav-target="mainFrame" href="/vPlayerRankStatistics/list.html?search.rakebackId=${command.result.id}&hasReturn=true">${command.result.rankCount}</a></td>
						</c:when>
						<c:otherwise>
							<td> ${command.result.rankCount}</td>
						</c:otherwise>
					</c:choose>
					${views.setting_auto['个']}
				</div>
				<div class="form-group clearfix m-t-sm m-b-sm line-hi25">
					<label class="ft-bold al-right content-width-limit-10">${views.setting['rakeback.view.playerAmountOfSchedule']}：</label>
					<c:choose>
						<c:when test="${command.result.playerCount gt 0}">
							<a nav-target="mainFrame" href="/player/list.html?search.rakebackId=${command.result.id}&search.hasReturn=true">${command.result.playerCount}</a>
						</c:when>
						<c:otherwise>
							${command.result.playerCount}
						</c:otherwise>
					</c:choose>
						${views.setting['rakeback.view.person']}
				</div>
				<div class="clearfix m">
					<div class="table-responsive">
						<table class="table table-striped table-bordered table-hover dataTable m-b-none">
							<tr role="row" class="bg-color">
								<td rowspan="2"><h3>${views.setting['rakeback.edit.validValue']}</h3></td>
								<td rowspan="2"><h3>${views.setting['rakeback.edit.maxRakeback']}</h3></td>
								<td colspan="${command.apiIds.size()}"><h3>${views.setting['rakeback.edit.grads']}</h3></td>

							</tr>
							<tr class="bg-color">
								<c:forEach items="${command.apiIds}" var="api">
									<td class="bg-gray"><b>${gbFn:getSiteApiName(api.toString())}</b></td>
								</c:forEach>
							</tr>
							<c:forEach items="${command.rakebackGrads}" varStatus="status" var="rake">
								<tr class="bg-color">
									<td height="36">${rake.validValue}</td>
									<td>${rake.maxRakeback}</td>
									<c:forEach items="${command.apiIds}" var="api">
										<td>
											<c:forEach items="${command.someGames}" var="game">
												<c:if test="${game['apiId'] eq api}">
													<c:forEach items="${rake.rakebackGradsApis}" var="rga" varStatus="apiStatus">
														<c:if test="${game['apiId'] eq rga.apiId && game['gameType'] eq rga.gameType}">
															<div class="input-group date" title="${gbFn:getGameTypeName(game['gameType'])}">
																${gbFn:getGameTypeName(game['gameType'])}: ${rga.ratio}%
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
					<label class="ft-bold al-right col-sm-2">${views.setting['rakeback.edit.remark']}</label>
					<div class="col-sm-9">${command.result.remark}</div>
				</div>

				<div class="operate-btn">
					<soul:button refresh="true" tag="button" target="goToLastPage" text="" opType="function" cssClass="btn btn-filter btn-lg m-r">
						${views.common['return']}
					</soul:button>
				</div>
			</div>
		</div>
	</div>
</form:form>
<soul:import type="view"/>