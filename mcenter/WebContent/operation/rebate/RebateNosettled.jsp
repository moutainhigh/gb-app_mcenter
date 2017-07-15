<%--@elvariable id="rebateBillNosettled" type="so.wwb.gamebox.model.master.operation.po.RebateBillNosettled"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
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
	<div class="col-lg-12">
		<div class="wrapper white-bg shadow clearfix">
			<div class="present_wrap clearfix">
				<b>${views.operation['Rebate.list.noRecord']}</b><span class="co-grayc2 m-l-sm">${views.operation['Rebate.list.updateTime']}：${soulFn:formatDateTz(rebateBillNosettled.createTime, DateFormat.DAY_SECOND, timeZone)}</span>
				<b class="pull-right">${views.operation['Rebate.list.commissionFormula']}<span tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top" data-content="${views.operation['Rebate.view.formula.desc']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span></b>
			</div>
			<div class="form-group clearfix m-t-sm line-hi25">
				<label class="ft-bold al-right m-l">${views.operation['Rebate.list.preSettlementPeriod']}：</label>${soulFn:formatDateTz(rebateBillNosettled.startTime, DateFormat.DAY, timeZone)} ~ ${soulFn:formatDateTz(rebateBillNosettled.endTime, DateFormat.DAY, timeZone)}
			</div>
			<div class="form-group clearfix m-t-sm line-hi25">
				<label class="ft-bold al-right m-l">${views.operation['Rebate.list.currentPayable']}：</label>${soulFn:formatCurrency(rebateBillNosettled.rebateTotal)}
			</div>
			<hr class="m-t-sm m-b-sm">
			<div class="clearfix line-hi34">
				<div class="input-group content-width-limit-250 m-l pull-left">
					<input type="text" class="form-control" name="search.agentName" placeholder="${views.operation['Rebate.agentName']}">
					<span class="input-group-btn p-l-sm">
						<soul:button target="query" text="" opType="function" tag="button" cssClass="btn btn-filter">
							<i class="fa fa-search"></i><span class="hd">&nbsp;${views.common['search']}</span>
						</soul:button>
					</span>
				</div>

			</div>
			<div class="dataTables_wrapper search-list-container">
				<%@include file="RebateNosettledPartial.jsp"%>
			</div>
		</div>
	</div>
</div>
</form:form>
<soul:import type="list"/>
