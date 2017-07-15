<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.vo.VPlayerDepositVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="org.soul.web.session.SessionManagerBase" %>
<%@ page import="so.wwb.gamebox.model.master.fund.enums.CheckStatusEnum" %>
<%@ page import="so.wwb.gamebox.model.master.fund.enums.RechargeStatusEnum" %>
<%@ include file="/include/include.inc.jsp" %>

<c:set var="r" value="${command.result}" />
<c:set var="rs" value="${r.rechargeStatus}" />

<c:set var="overTime" value="<%=RechargeStatusEnum.OVER_TIME.getCode() %>" />
<c:set var="success" value="<%=RechargeStatusEnum.ONLINE_SUCCESS.getCode() %>" />
<c:set var="fail" value="<%=RechargeStatusEnum.ONLINE_FAIL.getCode() %>" />
<c:set var="pendingPay" value="<%=RechargeStatusEnum.PENDING_PAY.getCode() %>" />
<c:set var="failure" value="<%=CheckStatusEnum.FAILURE.getCode() %>" />

<c:set var="locale" value="<%=SessionManagerBase.getLocale() %>" />

<form:form>
<div class="row">
	<div class="position-wrap clearfix">
		<h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i></a></h2>
		<span>${views.sysResource['资金']}</span>
		<span>/</span>
		<span>${views.sysResource['线上支付记录']}</span>
		<soul:button target="goToLastPage" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
			<em class="fa fa-caret-left"></em>${views.common['return']}
		</soul:button>
		<a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
	</div>
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="co-gray6">${views.fund['线上支付详细']}</h3>
			</div>
			<div class="panel-body p-sm">
				<table class="table no-border table-desc-list">
					<tbody>
					<tr>
						<td colspan="2" class="text-right">
								${views.fund['交易号：']}<span id="transactionNo">${r.transactionNo}</span>
							<a type="button" class="btn btn-sm btn-info btn-stroke m-l-sm" data-clipboard-target="transactionNo" name="copy"><i class="fa fa-copy" title="${views.fund_auto['复制']}"></i></a>
						</td>
					</tr>
					<tr>
						<th scope="row" class="text-right">${views.fund['玩家账号：']}</th>
						<td>
							<a class="btn btn-link co-blue" nav-target="mainFrame" href="/player/playerView.html?search.id=${r.playerId}">${r.username}</a>
							<a class="btn btn-link" nav-Target="mainFrame" href="/fund/deposit/online/list.html?search.fundTypes=online_deposit&search.userNameEqual=true&search.username=${r.username}"><i class="iconfont icon-wanjiaguanli"></i>${views.fund['despoit.index.viewPlayerAllDespoit']}</a>
						</td>
					</tr>
					<tr>
						<th scope="row" class="text-right">${views.fund['收款账户']}</th>
						<td>
							<a href="/vPayAccount/detail.html?result.id=${r.payAccountId}&search.type=2" nav-target="mainFrame" class="btn co-blue">
								${r.payName}
							</a>
							<c:if test="${rs eq overTime}">
								<span class="btn btn-sm ${r.payAccountStatusCss} btn-stroke m-l-sm">
										${dicts.content.pay_account_status[r.payAccountStatus]}
								</span>
							</c:if>
						</td>
					</tr>
					<tr>
						<th scope="row" class="text-right">${views.fund['实际到账：']}</th>
						<td class="money">
							<c:set var="rechargeTotalAmount" value="${r.rechargeAmount+r.counterFee}"/>
							${siteCurrencySign} ${soulFn:formatInteger(rechargeTotalAmount)}
							<i>${soulFn:formatDecimals(rechargeTotalAmount)}</i>
							<c:choose>
								<c:when test="${r.isFirstRecharge}">
									<span class="co-gray9 m-l-md">${views.fund['首次存款']}</span>
								</c:when>
								<c:otherwise>
									<span class="co-gray9 m-l-md">${views.fund['已成功存款']}<span class="co-yellow">${empty r.rechargeCount?0:r.rechargeCount}</span>${views.fund_auto['次']}</span>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th scope="row" class="text-right">${views.fund['手续费：']}</th>
						<td class="money
									<c:if test="${r.counterFee > 0 }">
										positive
									</c:if>
									<c:if test="${r.counterFee < 0 }">
										negative
									</c:if>
								">${siteCurrencySign}${r.counterFee>0?'+':''} ${soulFn:formatInteger(r.counterFee)}<i>${soulFn:formatDecimals(r.counterFee)}</i></td>
					</tr>
					<tr>
						<th scope="row" class="text-right">${views.fund['优惠金额：']}</th>
						<td class="money">
							<c:if test="${empty r.favorableTotalAmount||r.favorableTotalAmount==0}">
								--
							</c:if>
							<c:if test="${r.favorableTotalAmount>0}">
								${r.currencySign}${soulFn:formatInteger(r.favorableTotalAmount)}<i>${soulFn:formatDecimals(r.favorableTotalAmount)}</i>
								<c:choose>
									<c:when test="${r.rechargeStatus=='4'||r.rechargeStatus=='7'}">
									<span class="co-gray9 m-l-md">
										<c:if test="${command.activityAudit}">
											${views.fund['该活动需要审核，本笔存款审核通过后，需前往该活动审核页面手动发放']}
										</c:if>
										<c:if test="${empty command.activityAudit||!command.activityAudit}">
											${views.fund['该活动无需审核，本笔存款审核通过后，将自动发放优惠']}
										</c:if>
									</span>
										<a style="margin-left: 10px;" href="/operation/activityType/viewActivityDetail.html?search.id=${command.activityId}" title="${command.activityName}" nav-target="mainFrame">${views.fund['查看优惠活动']}</a>
									</c:when>
									<c:when test="${r.rechargeStatus=='5'}">
										<c:if test="${command.activityStatus=='2'}">
											<span class="co-green">[${views.common['checkPass']}]</span>
										</c:if>
										<c:if test="${command.activityStatus=='3'}">
											<span class="co-red">[${views.common['checkFailure']}]</span>
										</c:if>
									<span class="co-gray9 m-l-md">
										<a href="/operation/activityType/viewActivityDetail.html?search.id=${command.activityId}" nav-target="mainFrame">${command.activityName}</a>
										<c:if test="${command.activityStatus=='1'}">
											<a style="margin-left:10px" href="/operation/vActivityPlayerApply/activityPlayerApply.html?search.id=${command.activityId}&search.playerId=${r.playerId}&search.playerRechargeId=${r.id}" nav-target="mainFrame">${views.fund['去审核']}</a>
										</c:if>
										<c:if test="${command.activityStatus=='2'}">
											<a style="margin-left:10px" href="/report/vPlayerFundsRecord/view.html?search.id=${command.favorableTransactionId}" nav-target="mainFrame">${views.fund['查看优惠记录']}</a>
										</c:if>
									</span>
									</c:when>
								</c:choose>
							</c:if>
						</td>
					</tr>

					<tr class="${r.statusCssForView.css1} major">
						<th scope="row" class="text-right">${views.fund['存款金额：']}</th>
						<td class="money">
							<strong>
									${siteCurrencySign} ${soulFn:formatInteger(r.rechargeAmount)}
								<i>${soulFn:formatDecimals(r.rechargeAmount)}</i>
							</strong>
							<span class="${r.statusCssForView.css2}">[${dicts.fund.recharge_status[rs]}]</span>
							<c:if test="${rs eq overTime|| rs eq pendingPay}">
								<soul:button data="${r.id}" target="confirmCheckPass" text="${views.common['checkPass']}" opType="function" cssClass="btn btn-primary p-x-sm m-l-sm" callback="back" permission="fund:onlinedeposit_check">
									<span class="fa fa-check"></span>${views.common['checkPass']}
								</soul:button>
								<soul:button data="${r.id}" target="checkFailure" text="${views.common['checkFailure']}" opType="function" cssClass="btn btn-danger p-x-sm m-l-sm" callback="back" permission="fund:onlinedeposit_check">
									<span class="fa fa-close"></span>${views.common['checkFailure']}
								</soul:button>
								<a nav-target="mainFrame" style="display: none" name="editTmpl" href="/noticeTmpl/tmpIndex.html?lastPage=t">dddd</a>
							</c:if>
							<c:if test="${r.origin eq 'MOBILE'}">
									<span class="fa fa-mobile mobile" data-content="${views.fund_auto['手机存款']}" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
									</span>
							</c:if>
						</td>
					</tr>
					<c:if test="${r.checkStatus eq failure &&! empty r.failureTitle}">
						<tr>
							<th scope="row" class="text-right">${views.fund['失败原因：']}</th>
							<td>${r.failureTitle}</td>
						</tr>
					</c:if>
					<c:if test="${rs eq success || rs eq fail}">
						<tr>
							<th scope="row" class="text-right">${views.fund['审核时间：']}</th>
							<td>${soulFn:formatDateTz(r.checkTime,DateFormat.DAY_SECOND, timeZone)} - <span class="co-grayc2">${soulFn:formatTimeMemo(r.checkTime, locale)}</span></td>
						</tr>
						<tr>
							<th scope="row" class="text-right">${views.fund['审核人：']}</th>
							<td>${empty r.checkUsername ? "系统自动" : r.checkUsername}</td>
						</tr>
					</c:if>
					<c:if test="${rs eq overTime}">
						<tr>
							<th scope="row" class="text-right">${views.fund['状态更新时间：']}</th>
							<td>${soulFn:formatDateTz(r.checkTime, DateFormat.DAY_SECOND, timeZone)} - <span class="co-grayc2">${soulFn:formatTimeMemo(r.checkTime, locale)}</span></td>
						</tr>
					</c:if>
					<tr>
						<th scope="row" class="text-right" style="vertical-align: top;">${views.fund['备注：']}</th>
						<td>
							<textarea class="form-control width-response" readonly maxlength="200" rows="4" name="result.checkRemark">${r.checkRemark}</textarea>
							<div id="validateRule" style="display: none">${validateRule}</div>
							<div class="btn-groups p-t-xs width-response">
								<soul:button target="editRemark" text="${views.fund_auto['编辑']}" opType="function" cssClass="btn btn-link co-blue">
									<span class="fa fa-edit"></span>${views.fund['编辑']}
								</soul:button>
								<div style="display: none" id="editRemark">
									<soul:button target="${root}/fund/deposit/check/updateRemark.html?result.id=${r.id}" callback="afterUpdateRemark" text="" opType="ajax" cssClass="btn btn-link co-blue" post="getCurrentFormData">
										<span class="fa fa-save"></span> ${views.fund['保存']}
									</soul:button>
									<soul:button target="cancelEdit" text="" opType="function" cssClass="btn btn-link co-blue">
										<span class="fa fa-undo"></span> ${views.fund['取消']}
									</soul:button>
									<input name="checkRemark" value="${r.checkRemark}" type="hidden"/>
								</div>
							</div>
						</td>
					</tr>
					<%--<tr class="active">
						<th></th>
						<td>
							<div class="btn-groups text-left">
								<a class="btn btn-primary-hide p-x-lg" nav-target="mainFrame"
								   href="/report/vPlayerFundsRecord/fundsLog.html?search.fundType=favourable&search.usernames=${r.username}&search.userTypes=username&search.outer=-1"><span class="fa fa-gift"></span> ${views.fund_auto['查看优惠订单']}</a>
							</div>
						</td>
					</tr>--%>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
</form:form>

<soul:import res="site/fund/deposit/online/View"/>