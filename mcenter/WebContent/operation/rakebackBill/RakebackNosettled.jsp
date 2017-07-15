<%--@elvariable id="rakebackBillNosettled" type="so.wwb.gamebox.model.master.operation.po.RakebackBillNosettled"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form action="${root}/operation/rakebackBill/rakebackNosettled.html" method="post">
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
    <div class="col-lg-12 m-t">
        <div class="wrapper white-bg shadow clearfix">
            <div class="present_wrap clearfix">
                <b>${views.operation['Rakeback.list.nosettled']}</b>
                <span class="co-grayc2 m-l-sm">${views.operation['Rakeback.list.updateTime']}：${soulFn:formatDateTz(rakebackBillNosettled.createTime,DateFormat.DAY_SECOND,timeZone)}</span>
                <b class="pull-right">${views.operation['Rakeback.list.formula']}<span tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top" data-content="${views.operation['Rakeback.list.formula.detail']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span></b>
            </div>
            <div class="form-group clearfix m-t-sm line-hi25">
                <label class="ft-bold al-right m-l">${views.operation['Rakeback.list.preSettlementPeriod']}：</label>${soulFn:formatDateTz(rakebackBillNosettled.startTime,DateFormat.DAY,timeZone)} ~ ${soulFn:formatDateTz(rakebackBillNosettled.endTime,DateFormat.DAY,timeZone)}
            </div>
            <div class="form-group clearfix m-t-sm line-hi25">
                <label class="ft-bold al-right m-l">${views.operation['Rakeback.list.totalAmount']}：</label>${soulFn:formatCurrency(rakebackBillNosettled.rakebackTotal)}
            </div>
            <hr class="m-t-sm m-b-sm">
            <div class="clearfix line-hi34">
                <div class="input-group content-width-limit-250 m-l pull-left">
                    <input type="text" class="form-control" name="search.username" placeholder="${views.operation['Rakeback.list.playerAccount']}"/>
                    <span class="input-group-btn p-l-sm">
                        <soul:button target="query" text="" opType="function" cssClass="btn btn-filter">
                            <i class="fa fa-search"></i><span class="hd">&nbsp;${views.common['search']}</span>
                        </soul:button>
                    </span>
                </div>
                <c:if test="${!empty rakebackBillNosettled}">
                    <soul:button target="${root}/operation/rakebackBill/nosettledChoose.html?search.rakebackBillNosettledId=${rakebackBillNosettled.id}" text="${views.operation['Rakeback.list.chooseDisplayField']}" opType="dialog" cssClass="co-blue3 pull-right m-r" callback="back"/>
                </c:if>
            </div>
            <div class="search-list-container" role="grid">
                <%@ include file="RakebackNosettledPartial.jsp" %>
            </div>
        </div>
    </div>
</div>
</form:form>
<soul:import res="site/operation/rakebackBill/RakebackNosettled"/>