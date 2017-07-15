<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VPlayerGameTipOrderListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="p-sm">
    <b>${views.report_auto['总计']}：</b>${command.paging.totalCount}笔
    <b class="m-l">${views.report_auto['小费金额']}：</b>
    <span id="tipSum"><i class="fa fa-refresh fa-spin"></i></span>
</div>
<div class="wrapper white-bg shadow">
    <div class="dataTables_wrapper" role="grid">
        <div class="table-responsive">
            <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
                <thead>
                <tr role="row" class="bg-gray">
                    <th>${views.report_auto['小费流水号']}</th>
                    <th>${views.report_auto['api名称']}</th>
                    <th>${views.report_auto['时间']}</th>
                    <th>${views.report_auto['会员']}</th>
                    <th>${views.report_auto['荷官']}</th>
                    <th>${views.report_auto['小费金额']}</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${command.result}" var="i">
                    <tr class="tab-detail">
                        <td>${i.billNo}</td>
                        <td>
                            ${gbFn:getSiteApiName(i.apiId)}
                            <br/>
                            <c:set var="gameName" value="${gbFn:getSiteGameName(i.gameId)}"/>
                            ${i.apiId==9?'${views.report_auto[\'游戏方未提供\']}':gameName}
                        </td>
                        <td>${soulFn:formatDateTz(i.tipTime, DateFormat.DAY_SECOND,timeZone)}</td>
                        <td><a href="/player/playerView.html?search.id=${i.playerId}" nav-target="mainFrame">${i.username}</a></td>
                        <td>${empty i.sandsName?'${views.report_auto[\'游戏方未提供\']}':i.sandsName}</td>
                        <td>${soulFn:formatCurrency(i.tipAmount)}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

    </div>
</div>
<soul:pagination/>
