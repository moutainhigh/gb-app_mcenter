<%--@elvariable id="objectVo" type="so.wwb.gamebox.model.master.operation.vo.RebateBillVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

	<!--//region your codes 3-->
<form:form action="${root}/operation/rebate/clearing.html?id=${objectVo.result.id}">
<div class="row">
	<div class="position-wrap clearfix">
		<h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
		<span>${views.sysResource['资金']}</span>
		<span>/</span><span>${views.sysResource['返佣结算']}</span>
		<soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
			<em class="fa fa-caret-left"></em>${views.common['return']}
		</soul:button>
		<a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
		<input type="hidden" name="search.id" value="${objectVo.result.id}">
	</div>
	<div class="col-lg-12">
		<div class="wrapper white-bg shadow clearfix">
			<div class="present_wrap">
				<b>${views.operation['Rebate.view.commissionSettlement']}</b>
				<span class="co-grayc2 m-l-sm">
					${objectVo.result.settlementName}
				</span>
				<b class="pull-right">${views.operation['Rebate.view.rebateFormula']}<span tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top" data-content="${views.operation['Rebate.view.formula.desc']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span></b>
			</div>
			<div id="" class="dataTables_wrapper m-sm" role="grid">
			<div class="table-responsive">
				<table class="table table-bordered">
					<tr class="tab-title">
						<th class="bg-tbcolor">${views.operation['Rebate.view.rebatePeriod']}</th>
						<td>${soulFn:formatDateTz(objectVo.result.startTime,DateFormat.DAY , timeZone)} ~ ${soulFn:formatDateTz(objectVo.result.endTime,DateFormat.DAY , timeZone)}</td>
						<th class="bg-tbcolor">${views.operation['Rebate.view.agentCount']}</th>
						<td>${objectVo.result.agentCount}${views.operation_auto['人']}</td>
						<th class="bg-tbcolor">${views.operation['Rebate.view.agentLssuingCount']}</th>
						<td>${objectVo.result.agentLssuingCount}${views.operation['Rebate.pop.people']}</td>
						<th class="bg-tbcolor">${views.operation['Rebate.view.agentRejectCount']}</th>
						<td>${objectVo.result.agentRejectCount}${views.operation['Rebate.pop.people']}</td>
					</tr>
					<tr class="tab-title">
						<th class="bg-tbcolor">${views.operation['Rebate.view.rebatePayable']}</th>
						<td>${soulFn:formatCurrency(objectVo.result.rebateTotal)}</td>
						<th class="bg-tbcolor">${views.operation['Rebate.view.rebateAactuallyPaid']}</th>
						<td>${soulFn:formatCurrency(objectVo.result.rebateActual)}</td>
						<th class="bg-tbcolor">${views.operation['Rebate.view.lastOperator']}</th>
						<td colspan="3" class="al-left">
							<span class="co-blue m-r-sm">
								<%--<a href="/userAgent/topagent/detail.html?search.id=${objectVo.result.userId}" nav-target="mainFrame" title="${views.operation_auto['账号详情页']}">--%>
								<c:choose>
									<c:when test="${empty objectVo.result.username}">
										---
									</c:when>
									<c:otherwise>
										${objectVo.result.username}
									</c:otherwise>
								</c:choose>
								<%--</a>--%>
							</span>
							<span>${soulFn:formatDateTz(objectVo.result.lastOperateTime,DateFormat.DAY_SECOND ,timeZone )}</span>
							<a href="/report/log/logList.html?search.operator=${objectVo.result.username}" nav-target="mainFrame">${views.operation['Rebate.view.checkOperationalRecords']}</a>
							<%--<a href="javascript:void(0)" class="m-l-sm">${views.operation_auto['查看操作记录']}</a>--%>
						</td>
					</tr>
				</table>
			</div>
				</div>
			<hr class="m-t-sm m-b-sm">
			<div class="clearfix line-hi34">
				<div class="input-group content-width-limit-250 m-l pull-left">
					<form:input class="form-control" path="search.agentName" placeholder="${views.operation['Rebate.agentName']}"/>
					<span class="input-group-btn p-l-sm"><soul:button target="query" opType="function" text="" cssClass="btn btn-filter"><i class="fa fa-search"></i><span class="hd">&nbsp;${views.common['search']}</span></soul:button></span>
				</div>
			</div>

			<div class="search-list-container dataTables_wrapper m-t-md" role="grid" id="editable_wrapper">
				<%@include file="clearingPartial.jsp"%>
			</div>
			<div class="clearfix filter-wraper border-b-1 operate-btn">
				<div class="function-menu" id="asd" style="border-left: none">
					<soul:button callback="allQuery" target="${root}/operation/rebate/toConfirmSettlement.html?ids={ids}&search.id=${objectVo.result.id}"
								 precall="getIds" text="${views.operation['Rebate.confirmSettlement']}"
								 title="${views.operation['Rebate.view.confirmCommissionSettlement']}"
								 opType="dialog" tag="button"
								 cssClass="btn btn-filter btn-lg m-r ui-button-disable disabled">
						<span class="">${views.operation['Rebate.confirmSettlement']}</span>
					</soul:button>
					<soul:button callback="allQuery" target="${root}/operation/rebate/toRefuseSettlement.html?ids={ids}&search.id=${objectVo.result.id}"
								 precall="hasReason" text="${views.operation['Rebate.refuseSettlement']}"
								 title="${views.operation['Rebate.view.rejectReason']}"
								 opType="dialog"
								 tag="button"
								 cssClass="btn btn-filter btn-lg m-r ui-button-disable disabled">
						<span class="">${views.operation['Rebate.refuseSettlement']}</span>
					</soul:button>
					<a nav-target="mainFrame" style="display: none" name="editTmpl" href="/noticeTmpl/tmpIndex.html?lastPage=t"><span></span></a>
				</div>
			</div>
		</div>
	</div>
</div>
</form:form>
	<!--//endregion your codes 3-->

<!--//region your codes 4-->
<soul:import res="site/operation/rebate/Rebate"/>
<!--//endregion your codes 4-->