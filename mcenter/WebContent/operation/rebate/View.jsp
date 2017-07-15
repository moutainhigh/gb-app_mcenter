<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.RebateBillVo"--%>
<%--@elvariable id="objectVo" type="so.wwb.gamebox.model.master.operation.vo.RebateBillVo"--%>
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
		<span>/</span><span>${views.sysResource['返佣结算']}</span>
		<soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
			<em class="fa fa-caret-left"></em>${views.common['return']}
		</soul:button>
		<a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
	</div>
	<c:set value="${objectVo.result}" var="c"></c:set>
	<div class="col-lg-12">
		<div class="wrapper white-bg shadow clearfix">
			<div class="present_wrap clearfix">
				<b>${views.operation['Rebate.view.commissionDetail']}</b>
				<span class="co-grayc2 m-l-sm">
					${c.settlementName}
				</span>
				<b class="pull-right">${views.operation['Rebate.view.rebateFormula']}<span tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top" data-content="${views.operation['Rebate.view.formula.desc']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span></b>
			</div>
			<div id="" class="dataTables_wrapper m-sm" role="grid">
			<div class="table-responsive">
				<table class="table table-bordered">
					<tr class="tab-title">
						<th class="bg-tbcolor">${views.operation['Rebate.commissionCycle']}</th>
						<td>${soulFn:formatDateTz(c.startTime, DateFormat.DAY_SECOND,timeZone)} ~ ${soulFn:formatDateTz(c.endTime, DateFormat.DAY_SECOND,timeZone)}</td>
						<th class="bg-tbcolor">${views.operation['Rebate.view.agentCount']}</th>
						<td>${c.agentCount}${views.operation_auto['人']}</td>
						<th class="bg-tbcolor">${views.operation['Rebate.view.agentLssuingCount']}</th>
						<td>${c.agentLssuingCount}${views.operation['Rebate.pop.people']}</td>
						<th class="bg-tbcolor">${views.operation['Rebate.view.agentRejectCount']}</th>
						<td>${c.agentRejectCount}${views.operation['Rebate.pop.people']}</td>
					</tr>
					<tr class="tab-title">
						<th class="bg-tbcolor">${views.operation['Rebate.view.rebatePayable']}</th>
						<td>${soulFn:formatCurrency(c.rebateTotal)}</td>
						<th class="bg-tbcolor">${views.operation['Rebate.view.rebateAactuallyPaid']}</th>
						<td>${soulFn:formatCurrency(c.rebateActual)}</td>
						<th class="bg-tbcolor">${views.operation['Rebate.view.lastOperator']}</th>
						<td colspan="3" class="al-left">
							<span class="co-blue m-r-sm">
								<%--<a href="/userAgent/topagent/detail.html?search.id=${c.userId}" nav-target="mainFrame" title="${views.operation_auto['账号详情页']}">--%>
								<c:choose>
									<c:when test="${empty c.username}">
										---
									</c:when>
									<c:otherwise>
										${c.username}
									</c:otherwise>
								</c:choose>
								<%--</a>--%>
							</span>
							<span>${soulFn:formatDateTz(c.lastOperateTime, DateFormat.DAY_SECOND,timeZone)}</span>
                            <a href="/report/log/logList.html?search.operator=${c.username}" nav-target="mainFrame">${views.operation['Rebate.view.checkOperationalRecords']}</a>
							<%--<soul:button target="${root}/report/log/logList.html?search.moduleType=13" text="${views.operation_auto['查看操作记录']}" opType="ajax" post="getCurrentFormData" />--%>
						</td>
					</tr>
				</table>
			</div>
				</div>
			<hr class="m-t-sm m-b-sm">
			<div class="clearfix line-hi34">
				<div class="input-group content-width-limit-250 m-l pull-left">
					<form:input class="form-control" path="search.agentName" placeholder="${views.operation['Rebate.agentName']}"/>
					<span class="input-group-btn p-l-sm"> <soul:button target="query" text="${views.common['search']}" opType="function" cssClass="btn btn-filter"><i class="fa fa-search"></i><span class="hd">&nbsp;${views.common['search']}</span></soul:button></span>
				</div>
			</div>
			<div id="editable_wrapper" class="dataTables_wrapper search-list-container m-t-md" role="grid">
				<%@ include file="ViewPartial.jsp" %>
			</div>
			<div class="operate-btn">
				<c:if test="${c.lssuingState ne 'all_pay'}">
					<shiro:hasPermission name="operate:rebate_settle">
					<a href="/operation/rebate/clearing.html?id=${c.id}" nav-target="mainFrame" class="btn btn-filter btn-lg m-r">${views.operation['Rebate.view.settlementCommission']}</a>
					</shiro:hasPermission>
				</c:if>
			</div>
		</div>
	</div>
</div>
</form:form>
	<!--//endregion your codes 3-->

<!--//region your codes 4-->
<soul:import type="list"/>
<!--//endregion your codes 4-->