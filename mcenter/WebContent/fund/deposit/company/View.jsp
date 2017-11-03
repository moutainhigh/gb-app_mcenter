<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.vo.VPlayerDepositVo"--%>
<%@ page import="so.wwb.gamebox.model.master.fund.enums.RechargeStatusEnum" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<c:set var="r" value="${command.result}" />
<c:set var="rs" value="${r.rechargeStatus}" />

<c:set var="fail" value='<%=RechargeStatusEnum.FAIL.getCode() %>' />
<c:set var="deal" value='<%=RechargeStatusEnum.DEAL.getCode() %>' />
<c:set var="exchange" value='<%=RechargeStatusEnum.EXCHANGE.getCode() %>' />

<form:form>
	<input type="hidden" value="${r.id}" name="search.id"/>
	<div class="row">
		<div class="position-wrap clearfix">
			<h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont"></i> </a></h2>
			<span>${views.sysResource['资金']}</span>
			<span>/</span>
			<span>${views.sysResource['公司入款审核']}</span>
			<soul:button target="goToLastPage" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
				<em class="fa fa-caret-left"></em>${views.common['return']}
			</soul:button>
			<a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
		</div>

		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="co-gray6">${views.fund['despoit.index.despoitView']}</h3>
				</div>
				<div class="panel-body p-sm">
					<table class="table no-border table-desc-list">
						<tbody>
						<tr>
							<td colspan="2" class="text-right">
									${views.fund['交易号：']}
								<span id="transaction">${r.transactionNo}</span>
								<a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-target="transaction" data-clipboard-text="Default clipboard text from attribute" name="copy">
									<i class="fa fa-copy" title="${views.common['copy']}"></i>
								</a>
							</td>
						</tr>
						<tr>
							<th scope="row" class="text-right">${views.fund['despoit.index.playerAccount']}</th>
							<td>
								<a class="btn btn-link co-blue" href="/player/playerView.html?search.id=${r.playerId}" nav-Target="mainFrame">
										${r.username}
								</a>
								<a class="btn btn-link" nav-Target="mainFrame" href="/fund/deposit/company/list.html?search.fundTypes=company_deposit&search.userNameEqual=true&search.username=${r.username}">
									<i class="iconfont icon-wanjiaguanli"></i>${views.fund['despoit.index.viewPlayerAllDespoit']}
								</a>
							</td>
						</tr>

						<tr>
							<th scope="row" class="text-right vtop">${views.fund['交易描述：']}</th>
							<td>
								<table class="table table-bordered width-response">
									<tbody>
									<tr>
										<th scope="row" class="text-right active">${views.fund['存款方式：']}</th>
										<td><span class="co-black">${dicts.fund.recharge_type[r.rechargeType]}</span></td>
									</tr>
									<!--存款人姓名-->
									<c:if test="${!empty r.payerName}">
										<tr>
											<th scope="row" class="text-right">${views.fund['存款人姓名']}</th>
											<td>
												<span>${r.payerName}</span>
											</td>
										</tr>
									</c:if>
									<!--柜台现金-展示交易地点-->
									<c:if test="${r.rechargeType=='atm_money'}">
										<tr>
											<th scope="row" class="text-right">${views.fund['交易地点:']}</th>
											<td>
												<span id="rechargeAddress">${empty r.rechargeAddress?'--':r.rechargeAddress}</span>
												<c:if test="${!empty r.rechargeAddress}">
													<a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-target="rechargeAddress" data-clipboard-text="Default clipboard text from attribute" name="copy">
														<i class="fa fa-copy" title="${views.common['copy']}"></i>
													</a>
												</c:if>
											</td>
										</tr>
									</c:if>
									<!--电子支付-展示支付账号、尾号-->
									<c:if test="${r.rechargeType=='wechatpay_fast'||r.rechargeType=='alipay_fast'||r.rechargeType=='qqwallet_fast'||r.rechargeType=='jdwallet_fast'||r.rechargeType=='bdwallet_fast'||r.rechargeType=='onecodepay_fast'||r.rechargeType=='other_fast'}">
										<tr>
											<c:if test="${r.rechargeType=='wechatpay_fast'}">
												<c:set var="data" value="${views.fund_auto['微信账号']}："/>
											</c:if>
											<c:if test="${r.rechargeType=='alipay_fast'}">
												<c:set var="data" value="${views.fund_auto['支付宝账号']}："/>
											</c:if>
											<c:if test="${r.rechargeType=='qqwallet_fast'}">
												<c:set var="data" value="${views.fund_auto['QQ钱包账号']}："/>
											</c:if>
											<c:if test="${r.rechargeType=='jdwallet_fast'}">
												<c:set var="data" value="${views.fund_auto['京东钱包账号']}："/>
											</c:if>
											<c:if test="${r.rechargeType=='bdwallet_fast'}">
												<c:set var="data" value="${views.fund_auto['百度钱包账号']}："/>
											</c:if>
											<c:if test="${r.rechargeType=='onecodepay_fast'}">
												<c:set var="data" value="${views.fund_auto['一码付账号']}："/>
											</c:if>
											<c:if test="${r.rechargeType=='other_fast'}">
												<c:set var="data" value="${views.fund_auto['其他电子账号']}："/>
											</c:if>
											<th scope="row" class="text-right active">${data}</th>
											<td>
												<span id="wechatBankcard">${empty r.payerBankcard?'--':r.payerBankcard}</span>
												<a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-target="wechatBankcard" data-clipboard-text="Default clipboard text from attribute" name="copy"><i class="fa fa-copy" title="${views.common['copy']}"></i></a>
											</td>
										</tr>
										<tr>
											<th scope="row" class="text-right active">${views.fund['订单尾号：']}</th>
											<td>
												<span class="co-green" id="bankOrder">${r.bankOrder}</span>
												<c:if test="${!empty r.bankOrder}">
													<a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-target="bankOrder" data-clipboard-text="${r.bankOrder}" name="copy"><i class="fa fa-copy" title="${views.common['copy']}"></i></a>
												</c:if>
											</td>
										</tr>
									</c:if>
									<c:if test="${r.rechargeType=='bitcoin_fast'}">
										<tr>
											<th scope="row" class="text-right active">${views.fund_auto['收款比特币钱包地址']}：</th>
											<td>
												<span class="co-green">${r.account}</span>
												<c:if test="${!empty r.account}">
													<a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-text="${r.account}" name="copy"><i class="fa fa-copy" title="${views.common['copy']}"></i></a>
												</c:if>
											</td>
										</tr>
										<tr>
											<th scope="row" class="text-right active">${views.fund_auto['玩家比特币钱包地址']}：</th>
											<td>
												<span class="co-green">${r.payerBankcard}</span>
												<c:if test="${!empty r.payerBankcard}">
													<a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-text="${r.payerBankcard}" name="copy"><i class="fa fa-copy" title="${views.common['copy']}"></i></a>
												</c:if>
											</td>
										</tr>
										<tr>
											<th scope="row" class="text-right active">txId：</th>
											<td>
												<span class="co-green">${r.bankOrder}</span>
												<c:if test="${!empty r.bankOrder}">
													<a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-text="${r.bankOrder}" name="copy"><i class="fa fa-copy" title="${views.common['copy']}"></i></a>
												</c:if>
											</td>
										</tr>
										<tr>
											<th scope="row" class="text-right active">${views.fund_auto['交易时间']}：</th>
											<td>
												<span class="co-green">${soulFn:formatDateTz(r.returnTime,DateFormat.DAY_SECOND,timeZone)}</span>
												<c:if test="${!empty r.bankOrder}">
													<a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-text="${soulFn:formatDateTz(r.returnTime,DateFormat.DAY_SECOND,timeZone)}" name="copy"><i class="fa fa-copy" title="${views.common['copy']}"></i></a>
												</c:if>
											</td>
										</tr>
									</c:if>
									<tr>
										<th scope="row" class="text-right active">${views.fund['创建时间：']}</th>
										<td>${soulFn:formatDateTz(r.createTime, DateFormat.DAY_SECOND,timeZone)} - <span class="co-grayc2">${soulFn:formatTimeMemo(r.createTime,locale)}</span></td>
									</tr>
									</tbody>
								</table>
							</td>
						</tr>
						<tr>
							<th scope="row" class="text-right">${views.column['VPlayerRecharge.masterBankcard']}</th>
							<td>
								<a href="/vPayAccount/detail.html?result.id=${r.payAccountId}&search.type=1" nav-target="mainFrame" class="btn btn-link co-blue">${dicts.common.bankname[r.bankCode]}-${r.fullName}</a>
                                <c:if test="${r.rechargeStatus=='1'}">
									<c:set var="paStatus" value="${r.payAccountStatus}" />
									<span class="btn btn-sm
                                        ${paStatus == '1' ? 'btn-info' : ''}
                                        ${paStatus == '2' ? 'btn-danger' : ''}
                                        ${paStatus == '3' ? 'btn-warning' : ''} btn-stroke m-l-sm">
										${dicts.content.pay_account_status[paStatus]}
									</span>
								</c:if>
							</td>
						</tr>
						<c:if test="${r.rechargeType eq 'bitcoin_fast'}">
							<tr>
								<th scope="row" class="text-right">${views.fund_auto['比特币']}：</th>
								<td class="money">
									Ƀ<fmt:formatNumber value="${r.bitAmount}" pattern="#.########"/>
									<c:if test="${exchange eq r.rechargeStatus}">
										<soul:button permission="fund:companydeposit_check" target="${root}/fund/deposit/company/exchange.html?search.id=${r.id}" text="${views.fund_auto['兑换']}" opType="dialog"
													 cssClass="btn btn-success-hide p-x-sm m-l-sm" tag="button" callback="refreshBack">
											<i class="fa fa-check"></i>${views.fund_auto['兑现']}
										</soul:button>
										<soul:button permission="fund:companydeposit_check" target="checkFailure" data="${r.id}" opType="function" text="${views.common['checkFailure']}" cssClass="btn btn-danger p-x-sm m-l-sm" tag="button"/>
									</c:if>
								</td>
							</tr>
							<c:if test="${!empty poloniexResult.total}">
								<tr>
									<th scope="row" class="text-right">${views.fund_auto['兑换美元']}：</th>
									<td class="money"><fmt:formatNumber value="${poloniexResult.total}" pattern="#.########"/></td>
								</tr>
							</c:if>
							<c:if test="${!empty rate.askRate}">
								<tr>
									<th scope="row" class="text-right">${fn:replace(views.fund_auto['USD兑汇率'], '{0}', r.defaultCurrency)}</th>
									<td class="money">${rate.askRate}</td>
								</tr>
							</c:if>
						</c:if>
						<tr>
							<th scope="row" class="text-right">${views.fund['实际到账：']}</th>
							<td class="money">
								<c:set var="rechargeTotalAmount" value="${r.rechargeAmount+r.counterFee}"/>
									${r.currencySign}${soulFn:formatInteger(rechargeTotalAmount)}<i>${soulFn:formatDecimals(rechargeTotalAmount)}</i>
								<c:if test="${r.isFirstRecharge}">
									<span class="co-gray9 m-l-md">${views.fund['首次存款']}</span>
								</c:if>
								<c:if test="${!r.isFirstRecharge}">
									<span class="co-gray9 m-l-md">${views.fund['已成功存款']}<span class="co-yellow">${empty r.rechargeCount?0:r.rechargeCount}</span>${views.fund['次']}</span>
								</c:if>
							</td>
						</tr>
						<tr>
							<th scope="row" class="text-right">${r.counterFee>0? views.fund['返还手续费'] : views.fund['手续费']}</th>
							<c:if test="${r.counterFee==0}">
								<td class="money">--</td>
							</c:if>
							<c:if test="${r.counterFee!=0}">
								<td class="money  ${r.counterFee>0?'positive':'negative'}">${r.currencySign} ${r.counterFee>0?'+':''}${soulFn:formatInteger(r.counterFee)}<i>${soulFn:formatDecimals(r.counterFee)}</i></td>
							</c:if>
						</tr>
						<tr>
							<th scope="row" class="text-right">${views.fund['优惠金额：']}</th>
							<td class="money">
								<c:if test="${empty r.favorableTotalAmount||r.favorableTotalAmount==0}">
									--
									<%---只有满足无申请优惠且订单成功才能补优惠--%>
									<c:if test="${r.rechargeStatus eq '2' && empty command.activityId}">
										<shiro:hasPermission name="fund:artificial">
											<a href="/fund/manual/index.html?transactionNo=${r.transactionNo}&username=${r.username}&hasReturn=true" nav-target="mainFrame" class="btn btn-filter p-x-sm m-l-sm">${views.fund_auto['补优惠']}</a>
										</shiro:hasPermission>
									</c:if>
								</c:if>
								<c:if test="${r.favorableTotalAmount>0}">
									${r.currencySign}${soulFn:formatInteger(r.favorableTotalAmount)}<i>${soulFn:formatDecimals(r.favorableTotalAmount)}</i>
									<c:choose>
										<c:when test="${r.rechargeStatus=='1'}">
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
										<c:when test="${r.rechargeStatus=='2'}">
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
						<tr class="${r.rechargeStatus=='1'?'warning':''}${r.rechargeStatus=='2'?'success':''}${r.rechargeStatus=='3'?'danger':''} major">
							<th scope="row" class="text-right">${views.fund['存款金额：']}</th>
							<td class="money">
								<c:if test="${r.rechargeAmount>0}">
									<strong>${r.currencySign} ${soulFn:formatInteger(r.rechargeAmount)}<i>${soulFn:formatDecimals(r.rechargeAmount)}</i></strong>
								</c:if>
								<c:if test="${empty r.rechargeAmount || r.rechargeAmount<=0}">--</c:if>
								<span class="${rs == '2' ? 'co-green' : ''}${rs == '1' ? 'co-orange' : ''}${rs == '3' ? 'co-red' : ''}">[${dicts.fund.recharge_status[rs]}]</span>
								<c:if test="${r.origin eq 'MOBILE'}">
									<span class="fa fa-mobile mobile" data-content="${views.fund_auto['手机存款']}" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
									</span>
								</c:if>
							</td>
						</tr>
						<c:if test="${rs != deal}">
							<tr>
								<th scope="row" class="text-right">${views.fund['审核人：']}</th>
								<td>${r.checkUsername}</td>
							</tr>
							<tr>
								<th scope="row" class="text-right">${views.fund['审核时间：']}</th>
								<td>${soulFn:formatDateTz(r.checkTime, DateFormat.DAY_SECOND, timeZone)} - <span class="co-grayc2">${soulFn:formatTimeMemo(r.checkTime, locale)}</span></td>
							</tr>
						</c:if>
						<c:if test="${rs == fail&&!empty r.failureTitle}">
							<tr>
								<th scope="row" class="text-right">${views.fund['失败原因：']}</th>
								<td>${r.failureTitle}</td>
							</tr>
						</c:if>
						<tr>
							<th scope="row" class="text-right" style="vertical-align: top;" for="result.checkRemark">${views.fund['备注：']}</th>
							<td>
								<textarea class="form-control width-response" readonly maxlength="200" rows="4" id="result.checkRemark" name="result.checkRemark">${r.checkRemark}</textarea>
								<div id="validateRule" style="display: none">${validateRule}</div>
								<div class="btn-groups p-t-xs width-response pull-left">
									<soul:button target="editRemark" text="${views.fund_auto['编辑']}" opType="function" cssClass="btn btn-link co-blue">
										<span class="fa fa-edit"></span>${views.fund['编辑']}
									</soul:button>
									<div style="display: none" id="editRemark">
										<soul:button target="${root}/fund/deposit/check/updateRemark.html?result.id=${r.id}" text="" callback="afterUpdateRemark" opType="ajax" cssClass="btn btn-link co-blue" post="getCurrentFormData">
											<span class="fa fa-save"></span> ${views.fund['保存']}
										</soul:button>
										<soul:button target="cancelEdit" text="" opType="function" cssClass="btn btn-link co-blue">
											<span class="fa fa-undo"></span> ${views.common_report['取消']}
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
									<a class="btn btn-primary-hide p-x-lg" type="button" nav-Target="mainFrame" href="/report/vPlayerFundsRecord/fundsLog.html?search.fundType=favourable&search.usernames=${r.username}&search.userTypes=username&search.outer=-1"><span class="fa fa-gift"></span> ${views.fund_auto['查看优惠订单']}</a>
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
<soul:import res="site/fund/deposit/company/View"/>