<%--@elvariable id="listVo" type="so.wwb.gamebox.model.master.player.vo.PlayerGameOrderListVo"--%>
<%--@elvariable id="apiList" type="java.util.List<java.lang.Integer>"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--玩家详情-投注-->
<form name="single_partial_form" action="${root}/playerSingleRecord/singleRecord.html?playerId=${listVo.search.playerId}&search.orderState=${listVo.search.orderState}">
    <div class="clearfix history-wrap">
    <span class="pull-left">
        <soul:button target="singleRecord" action="${root}/playerSingleRecord/singleRecord.html?playerId=${listVo.search.playerId}" text="${views.role['player.view.singleRecord.historyRecord']}" opType="function" cssClass="${listVo.search.orderState=='settle'?'current':''}"/>|
        <soul:button target="singleRecord" action="${root}/playerSingleRecord/singleRecord.html?playerId=${listVo.search.playerId}&search.orderState=pending_settle" text="${views.role['player.view.singleRecord.RecordUnsettled']}" opType="function" cssClass="${listVo.search.orderState=='pending_settle'?'current':''}"/>
    </span>
    <span class="pull-right co-gray9">
        <soul:button target="recordRefresh" text="" data="${listVo.search.orderState}" playerId="${listVo.search.playerId}" opType="function" cssClass="co-gray9"><i class="fa fa-refresh"></i></soul:button>
        ${views.role['player.view.singleRecord.synchronizationTime']}：${soulFn:formatDateTz(synTime, DateFormat.DAY_SECOND,timeZone)}
    </span>
    </div>
    <div name="singleRecordList">
        <%@include file="../singleRecord/SingleRecordList.jsp" %>
    </div>
</form>
<script>
    curl(["site/player/singleRecord/SingleRecord"], function (SingleRecord) {
        page.singleRecord = new SingleRecord();
        page.singleRecord.bindButtonEvents();
    });
</script>
