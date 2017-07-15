<%--@elvariable id="listVo" type="so.wwb.gamebox.model.master.player.vo.PlayerGameOrderListVo"--%>
<%--@elvariable id="playerApiOrders" type="java.util.List<so.wwb.gamebox.model.master.player.po.PlayerApiOrder>"--%>
<%--@elvariable id="player" type="so.wwb.gamebox.model.master.player.po.VUserPlayer"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--下单记录列表-->
<div id="editable_wrapper" class="dataTables_wrapper" role="grid">
    <div class="table-responsive" id="tab-1">
    <table class="table table-striped table-bordered table-hover  dataTable" aria-describedby="editable_info">
    <thead>
    <tr>
        <th>${views.common['number']}</th>
        <th>${views.column['PlayerApiOrder.apiName']}</th>
        <th>${views.column['PlayerApiOrder.count']}</th>
        <th>${views.column['PlayerApiOrder.effective']}/${views.column['PlayerApiOrder.tranaction']}</th>
        <th>${views.column['PlayerApiOrder.breakeven']}</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${playerApiOrders}" var="i" varStatus="status">
        <tr>
            <td>${status.index+1}</td>
            <td>
                <shiro:hasPermission name="report:betorder">
                    <a href="/report/gameTransaction/list.html?search.orderState=${listVo.search.orderState}&search.apiList=${i.apiId}&search.username=${player.username}&search.searchCondition=true&isLink=true&search.createStart=${startTime}&search.createEnd=${endTime}" nav-target="mainFrame">${gbFn:getSiteApiName(i.apiId.toString())}</a>
                </shiro:hasPermission>
                <shiro:lacksPermission name="report:betorder">${gbFn:getSiteApiName(i.apiId.toString())}</shiro:lacksPermission>

            </td>
            <td>
                <shiro:hasPermission name="report:betorder">
                    <a href="/report/gameTransaction/list.html?search.orderState=${listVo.search.orderState}&search.apiList=${i.apiId}&search.username=${player.username}&search.searchCondition=true&isLink=true&search.createStart=${startTime}&search.createEnd=${endTime}" nav-target="mainFrame">${i.count}</a>
                </shiro:hasPermission>
                <shiro:lacksPermission name="report:betorder">${i.count}</shiro:lacksPermission>
            </td>
            <td><span class="co-blue">${soulFn:formatCurrency(i.effective)}</span> / ${soulFn:formatCurrency(i.tranaction)}</td>
            <td class="<c:if test="${i.breakeven>=0}">co-green</c:if>
                <c:if test="${i.breakeven<0}">co-red</c:if>">${i.breakeven>=0?'+':''}${soulFn:formatCurrency(i.breakeven)}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
        </div></div>
<div class="clearfix remark-wrap">
    <div class="pull-left">
        <span class="m-r-md">${fn:replace(views.role['player.view.singleRecord.currentTotal'],'{0}',soulFn:formatNumber(total.count))}</span>
        <c:if test="${listVo.search.orderState!='pending_settle'}">
             <span class="m-r-md"><i class="icon iconfont"></i>&nbsp;&nbsp;${views.role['player.view.singleRecord.effectiveTransaction']}：
                ${player.defaultCurrency}&nbsp;<b class="co-blue">${soulFn:formatCurrency(total.effective)}</b>
            </span>
            <span>
            <i class="fa fa-gamepad"></i>&nbsp;&nbsp;${views.role['player.view.singleRecord.gameBreakeven']}：
                ${player.defaultCurrency}&nbsp;<b class="co-red2">${soulFn:formatCurrency(total.transaction)}</b>
            </span>
        </c:if>
    </div>
    <c:if test="${listVo.paging.totalCount>10}">
        <a href="/report/gameTransaction/list.html?search.orderState=${listVo.search.orderState}&search.username=${player.username}&search.searchCondition=true" nav-target="mainFrame" class="pull-right">${views.role['player.view.singleRecord.viewMore']} &gt;&gt;</a>
    </c:if>
</div>

