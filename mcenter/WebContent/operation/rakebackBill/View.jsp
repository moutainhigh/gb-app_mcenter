<%--@elvariable id="rakebackBillVo" type="so.wwb.gamebox.model.master.operation.vo.RakebackBillVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form action="${root}/operation/rakebackBill/backwaterView.html?search.rakebackBillId=${rakebackBillVo.result.id}&search.settlementState=${rakebackBillVo.search.settlementState}">
<div class="row">
    <div class="position-wrap clearfix">
        <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont"></i> </a></h2>
        <span>${views.sysResource['资金']}</span>
        <span>/</span>
        <span>${views.sysResource['返水结算']}</span>
        <a  href="/operation/rakebackBill/list.html" nav-target="mainFrame" class="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn">
            <em class="fa fa-caret-left"></em>${views.common['return']}
        </a>
        <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
    </div>
    <div class="col-lg-12">
        <div class="wrapper white-bg shadow clearfix">
            <div class="present_wrap clearfix">
                <b>${views.operation['backwater.view.title']}</b>
                <span class="co-grayc2 m-l-sm">${soulFn:formatDateTz(rakebackBillVo.result.endTime, DateFormat.YEAR,timeZone)}${views.common['year']}${soulFn:formatDateTz(rakebackBillVo.result.endTime, DateFormat.MONTH,timeZone)}${views.common['month']}${rakebackBillVo.result.period}${views.common['qi']}</span>
                <b class="pull-right">
                    ${views.operation['backwater.settlement.backwaterFormula']}
                    <span tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top" data-content="${views.operation['Rakeback.list.formula.detail']}" data-original-title="" title="">
                        <i class="fa fa-question-circle"></i>
                    </span>
                </b>
            </div>
            <div id="editable_wrapper" class="dataTables_wrapper m-sm" role="grid">
            <div class="table-responsive">
                <table class="table table-bordered">
                    <tbody>
                    <tr class="tab-title">
                        <th class="bg-tbcolor">${views.column['SettlementBackwater.startTime']}</th>
                        <td>${soulFn:formatDateTz(rakebackBillVo.result.startTime, DateFormat.DAY,timeZone)} ~ ${soulFn:formatDateTz(rakebackBillVo.result.endTime, DateFormat.DAY,timeZone)}</td>
                        <th class="bg-tbcolor">${views.column['SettlementBackwater.playerPendingCount']}</th>
                        <td>${rakebackBillVo.result.playerCount-rakebackBillVo.result.playerLssuingCount-rakebackBillVo.result.playerRejectCount}${views.operation['backwater.settlement.people']}</td>
                        <th class="bg-tbcolor">${views.column['SettlementBackwater.playerLssuingCount']}</th>
                        <td>${rakebackBillVo.result.playerLssuingCount}${views.operation['backwater.settlement.people']}</td>
                        <th class="bg-tbcolor">${views.column['SettlementBackwater.playerRejectCount']}</th>
                        <td>${rakebackBillVo.result.playerRejectCount}${views.operation['backwater.settlement.people']}</td>
                    </tr>
                    <tr class="tab-title">
                        <th class="bg-tbcolor">${views.operation['backwater.settlement.backwaterTotal']}</th>
                        <td>${soulFn:formatCurrency(rakebackBillVo.result.rakebackTotal)}</td>
                        <th class="bg-tbcolor">${views.operation['backwater.settlement.backwaterActual']}</th>
                        <td>${soulFn:formatCurrency(rakebackBillVo.result.rakebackActual)}</td>
                        <th class="bg-tbcolor">${views.operation['backwater.settlement.lasterOperator']}</th>
                        <td colspan="3" class="al-left">
                            <span class="co-blue m-r-sm">
                                ${empty rakebackBillVo.result.username?'---':rakebackBillVo.result.username}
                            </span>
                            ${soulFn:formatDateTz(rakebackBillVo.result.lastOperateTime, DateFormat.DAY_SECOND,timeZone)}
                            <a href="/report/log/logList.html?search.operator=${rakebackBillVo.result.username}" nav-target="mainFrame">${views.operation['backwater.settlement.viewOperationalRecord']}</a>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div></div>
            <hr class="m-t-sm m-b-sm">
            <div class="clearfix line-hi34">
                <div class="input-group col-md-3 m-l pull-left">
                    <input type="text" class="form-control" name="search.username" placeholder="${views.player_auto['多个账号，用半角逗号隔开']}" value="${command.search.username}">
                    <span class="input-group-btn p-l-sm">
                        <soul:button target="query" text="" opType="function" cssClass="btn btn-filter" tag="button" >
                            <i class="fa fa-search"></i>
                            <span class="hd">&nbsp;${views.common['search']}</span>
                        </soul:button>
                    </span>
                </div>
                <soul:button target="${root}/operation/rakebackBill/choose.html?search.rakebackBillId=${command.search.rakebackBillId}" text="${views.operation['backwater.settlement.chooseDisplayerField']}" opType="dialog" cssClass="co-blue3 pull-right m-r" callback="back"/>
            </div>
            <div class="dataTables_wrapper m-t-sm search-list-container table-min-h" role="grid">
                <%@ include file="ViewPartial.jsp" %>
            </div>
            <c:if test="${rakebackBillVo.result.lssuingState!='all_pay'}">
                <div class="operate-btn">
                    <shiro:hasPermission name="operate:rakeback_settle">
                        <a  href="/operation/rakebackBill/settlement.html?search.rakebackBillId=${rakebackBillVo.result.id}" nav-target="mainFrame" class="btn btn-filter btn-lg m-r">
                           ${views.operation['backwater.view.rakebackBill']}
                        </a>
                    </shiro:hasPermission>
                </div>
            </c:if>
        </div>
    </div>
</div>
</form:form>
<soul:import res="site/operation/rakebackBill/View"/>