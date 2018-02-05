<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VPlayerRankStatisticsVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<form:form>
<div class="row">
	<div class="position-wrap clearfix">
		<h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
		<span>${views.sysResource['角色']}</span><span>/</span>
		<span>${views.sysResource['层级设置']}</span>
		<%--<a href="/vPlayerRankStatistics/list.html" class="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" nav-target="mainFrame"><em class="fa fa-caret-left"></em>${views.common['return']}</a>--%>
		<soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
			<em class="fa fa-caret-left"></em>${views.common['return']}
		</soul:button>
	</div>
	<div class="col-lg-12">
		<div class="wrapper white-bg shadow clearfix">
			<div class="sys_tab_wrap clearfix line-hi34 p-xs m-b-sm">
				<h3 class="pull-left">${views.role['PlayerRank.view.cjxxzl']}</h3>
			</div>
			<div class="panel blank-panel">
				<div class="tab-content p-sm">
					<table class="table dataTable">
						<tbody>
						<c:set value="${command.result}" var="p"/>
						<tr class="tab-title">
							<%--层级名称--%>
							<th class="bg-tbcolor">${views.role['PlayerRank.view.rankName']}：</th>
							<td>${p.rankName}
								<c:if test="${p.riskMarker}">
									<span href="javascript:void(0)" class="ico-lock co-red3"><i class="fa fa-warning"></i></span>
								</c:if>
							</td>
							<th>${views.player_auto['返水方案']}：</th>
							<td>
								<a href="/setting/vRakebackSet/view.html?id=${p.rakebackId}" nav-target="mainFrame">${p.rakebackName}</a>
							</td>
								<%--玩家数--%>
							<th class="bg-tbcolor">${views.role['PlayerRank.view.playerNum']}：</th>
							<td><a href="/player/list.html?search.rankId=${p.id}" nav-target="mainFrame">${p.playerNum}</a></td>
								<%--公司入款限额--%>
							<th class="bg-tbcolor">${views.role['PlayerRank.view.gsrkxe']}：</th>
							<td>${p.onlinePayMin}~${p.onlinePayMax}</td>

						</tr>
						<tr class="tab-title">
								<%--单次取款限额--%>
							<th class="bg-tbcolor">${views.role['PlayerRank.view.dcqkxe']}：</th>
							<td>${p.withdrawMinNum}~${p.withdrawMaxNum}</td>
							<%--存款手续费--%>
							<th class="bg-tbcolor">${views.role['PlayerRank.view.cksxf']}：</th>
							<td>
								<c:if test="${not empty p.isFee&&empty p.isReturnFee}">
									<c:if test="${p.isFee}">
										<%--${p.feeMoney}${p.feeType=='1'?'%':''}--%>
										<c:if test="${p.feeType=='1'}">
											<c:set var="maxFee" value="${siteCurrencySign}${soulFn:formatInteger(p.maxFee)}${soulFn:formatDecimals(p.maxFee)}"></c:set>
											${views.player_auto['收取']}${p.feeMoney}%,&nbsp;${views.player_auto['上限']}${maxFee}
										</c:if>
										<c:if test="${p.feeType!='1'}">
											${views.player_auto['收取']}${siteCurrencySign}${p.feeMoney}
										</c:if>
									</c:if>
									<c:if test="${!p.isFee}">
										${views.role['PlayerRank.list.none']}
									</c:if>
								</c:if>
								<c:if test="${empty p.isFee&&not empty p.isReturnFee}">
									<c:if test="${p.isReturnFee}">
										<c:set var="restr" value="${views.player_auto['存满']}"></c:set>
										<c:set var="reachMoney" value="${siteCurrencySign}${soulFn:formatInteger(p.reachMoney)}${soulFn:formatDecimals(p.reachMoney)}"></c:set>
										<c:if test="${p.returnType=='1'}">
											<c:set var="returnMoney" value="${p.returnMoney}%"></c:set>
										</c:if>
										<c:if test="${p.returnType!='1'}">
											<c:set var="returnMoney" value="${siteCurrencySign}${soulFn:formatInteger(p.returnMoney)}${soulFn:formatDecimals(p.returnMoney)}"></c:set>
										</c:if>
										<c:set var="maxReturnFee" value="${siteCurrencySign}${soulFn:formatInteger(p.maxReturnFee)}${soulFn:formatDecimals(p.maxReturnFee)}"></c:set>
										<c:set var="depositFee" value='${fn:replace(fn:replace(fn:replace(restr,"{0}", reachMoney),"{1}",returnMoney),"{2}",maxReturnFee)}'/>
										<c:if test="${p.returnType=='1'}">
											${depositFee}
										</c:if>
										<c:if test="${p.returnType!='1'}">
											${fn:substringBefore(depositFee,"," )}
										</c:if>

										<%--${fn:replace(fn:replace(fn:replace(restr,"{0}", reachMoney),"{1}",returnMoney),"{2}",maxReturnFee)}--%>


										<%--<span class="co-red">-${p.returnMoney}${p.returnType=='1'?'%':''}</span>--%>
									</c:if>
									<c:if test="${!p.isReturnFee}">${views.role['PlayerRank.list.none']}</c:if>
								</c:if>
							</td>
								<%--存款手续费收取方式--%>
							<th class="bg-tbcolor">${views.role['PlayerRank.view.cksxfsqfs']}：</th>
							<td>
								<c:if test="${not empty p.isFee}">
									<c:if test="${p.isFee}">
										<c:if test="${not empty p.feeTime&&not empty p.freeCount}">
											${fn:replace(fn:replace(views.role['playerRank.view.cksxf'], "{hour}", p.feeTime), "{count}", p.freeCount)}
										</c:if>
										<c:if test="${empty p.feeTime&&empty p.freeCount}">
											${views.role['PlayerRank.view.wmf']}
										</c:if>
									</c:if>
									<c:if test="${!p.isFee}">
										${views.role['PlayerRank.list.none']}
									</c:if>
								</c:if>
								<c:if test="${not empty p.isReturnFee}">
									<c:if test="${p.isReturnFee}">
										<c:if test="${not empty p.returnTime&&not empty p.returnFeeCount}">
											${fn:replace(fn:replace(views.role['playerRank.view.ckfsxf'], "{hour}", p.returnTime), "{count}", p.returnFeeCount)}
										</c:if>
										<c:if test="${empty p.returnTime&&empty p.returnFeeCount}">
											${views.role['PlayerRank.list.none']}
										</c:if>
									</c:if>
									<c:if test="${!p.isReturnFee}">
										${views.role['PlayerRank.list.none']}
									</c:if>
								</c:if>
							</td>
								<%--取款手续费--%>
							<th class="bg-tbcolor">${views.role['PlayerRank.view.qksxf']}：</th>
							<td>

								<c:if test="${p.withdrawFeeType=='1'}">
									${views.player_auto['收取']}${p.withdrawFeeNum}%,&nbsp;${views.player_auto['上限']}${siteCurrencySign}${p.withdrawMaxFee}
								</c:if>
								<c:if test="${p.withdrawFeeType!='1'}">
									${views.player_auto['收取']}${siteCurrencySign}${p.withdrawFeeNum}
								</c:if>

							<%--${views.player_auto['收取']}${p.withdrawFeeType!='1'?siteCurrencySign:''}${p.withdrawFeeNum}${p.withdrawFeeType=='1'?'%':''}--%>

							</td>

						</tr>
						<tr class="tab-title">
								<%--取款手续费收取方式--%>
							<th class="bg-tbcolor">${views.role['PlayerRank.view.qksxfsqfs']}：</th>
							<td>
								<c:if test="${not empty p.withdrawTimeLimit}">
									<c:set value="${views.player_auto['小时内免']}" var="limit"></c:set>
									${fn:replace(fn:replace(limit,"{0}" , p.withdrawTimeLimit),"{1}",p.withdrawFreeCount)}
									<%--${p.withdrawTimeLimit}${views.role['PlayerRank.view.xsn']}
									<span class="co-grayc2">
										${views.role['PlayerRank.view.m']}${p.withdrawFreeCount}${views.role['PlayerRank.view.c']}
									</span>--%>
								</c:if>
								<c:if test="${p.isWithdrawFeeZeroReset}">
									<c:set value="${views.player_auto['0000重置：免']}" var="limit"></c:set>
									${fn:replace(limit,"{0}" ,p.withdrawFreeCount)}
									<%--${p.withdrawTimeLimit}${views.role['PlayerRank.view.xsn']}
									<span class="co-grayc2">
										${views.role['PlayerRank.view.m']}${p.withdrawFreeCount}${views.role['PlayerRank.view.c']}
									</span>--%>
								</c:if>

								<c:if test="${not empty p.withdrawMaxFee}">
									${views.player_auto['上限']}${siteCurrencySign}${soulFn:formatInteger(p.withdrawMaxFee)}${soulFn:formatDecimals(p.withdrawMaxFee)}
								</c:if>
							</td>
							<th class="bg-tbcolor">${views.player_auto['存款稽核']}：</th><td>${empty p.withdrawNormalAudit ?'':soulFn:formatNumber(p.withdrawNormalAudit)}</td>
							<th class="bg-tbcolor">${views.player_auto['行政费']}：</th><td>${empty p.withdrawAdminCost ?'':soulFn:formatInteger(p.withdrawAdminCost).concat(soulFn:formatDecimals(p.withdrawAdminCost))}</td>
							<th class="bg-tbcolor">${views.player_auto['放宽额度']}：</th><td>${empty p.withdrawRelaxCredit ?'':soulFn:formatInteger(p.withdrawRelaxCredit).concat(soulFn:formatDecimals(p.withdrawRelaxCredit))}</td>

						</tr>
						<tr class="tab-title">

							<%--24小时允许取款次数--%>
							<th class="bg-tbcolor">${views.role['PlayerRank.view.24xsnyxqkcs']}：</th>
							<td>
								<c:choose>
									<c:when test="${p.withdrawCount>0}">
										${p.withdrawCount}${views.role['PlayerRank.view.c']}
									</c:when>

									<c:otherwise>${views.role['PlayerRank.view.wxz']}</c:otherwise>
								</c:choose>
							</td>
								<%--取款审核--%>
							<th class="bg-tbcolor">${views.role['PlayerRank.view.qksh']}：</th>
							<td>
								<c:choose>
									<%--普通和超额都开启--%>
									<c:when test="${p.withdrawCheckStatus&&p.withdrawExcessCheckStatus}">
										${views.role['PlayerRank.view.pt']}${p.withdrawCheckTime}${views.role['PlayerRank.view.fz']}, &nbsp;${views.role['PlayerRank.view.ce']}(${siteCurrencySign}${p.withdrawExcessCheckNum})&nbsp${p.withdrawExcessCheckTime}${views.role['PlayerRank.view.fz']}
									</c:when>
									<c:when test="${p.withdrawCheckStatus}">
										${views.role['PlayerRank.view.pt']}${p.withdrawCheckTime}${views.role['PlayerRank.view.fz']}
									</c:when>
									<c:when test="${p.withdrawExcessCheckStatus}">
										${views.role['PlayerRank.view.ce']}(${siteCurrencySign}${p.withdrawExcessCheckNum})&nbsp${p.withdrawExcessCheckTime}${views.role['PlayerRank.view.fz']}
									</c:when>
									<c:otherwise>
										${views.role['PlayerRank.view.wqy']}
									</c:otherwise>
								</c:choose>
							</td>
							<th class="bg-tbcolor">${views.player_auto['余额稽核']}：</th>
							<td>${empty p.withdrawDiscountAudit ?'':soulFn:formatInteger(p.withdrawDiscountAudit).concat(soulFn:formatDecimals(p.withdrawDiscountAudit))}</td>
							<th class="bg-tbcolor">${views.player_auto['优惠稽核']}：</th>
							<td>${p.favorableAudit}</td>


						</tr>
						<tr class="tab-title">
								<%--备注--%>
							<th class="bg-tbcolor">${views.role['PlayerRank.view.remark']}：</th>
							<td colspan="7">${p.remark}</td>
						</tr>
						</tbody>
					</table>
					<div class="det-title"><b>${views.role['PlayerRank.view.ckaccount']}</b></div>
					<table class="table table-bordered dataTable">
						<tbody>
						<c:forEach items="${command.detailResult}" var="detail">
							<c:set var="maplist" value="${detail.value}"/>
							<c:forEach var="ml" items="${maplist}" varStatus="status">
								<tr>
									<c:if test="${status.index==0}">
										<td rowspan="${fn:length(maplist)}"><b>${views.role[detail.key]}</b></td>
									</c:if>
									<td ${status.index>0?'rowspan=""':""}>
										<b>
											<%--<img src="${resComRoot}${banks[ml.value[0].bankCode].bankIcon}">--%>
											<span class="${banks[ml.value[0].bankCode].type=='1'?'pay-bank ':'pay-third '} ${banks[ml.value[0].bankCode].bankName}"></span>
											<div>${dicts.common.bankname[ml.value[0].bankCode]}</div>
										</b>
									</td>
									<td rowspan="" class="al-left">
										<c:forEach items="${ml.value}" var="pa">
											<a href="javascript:void(0)" class="m-r-sm co-gray6">${pa.payName}&nbsp;&nbsp;${pa.account}&nbsp;;</a>
										</c:forEach>
									</td>
								</tr>
							</c:forEach>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
</form:form>
<soul:import res="site/player/playerrank/View"/>