<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.PlayerRankVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<html lang="zh-CN">
<head>
    <title>${views.role['add.rank']}</title>
    <%@ include file="/include/include.head.jsp" %>
    <!--//region your codes 2-->

    <!--//endregion your codes 2-->
</head>

<body>

<form:form id="editForm" action="${root}/playerRank/edit.html" method="post">
    <gb:token></gb:token>
    <div id="validateRule" style="display: none">${command.validateRule}</div>
        <div class="modal-body">
            <!--                  <div class="add-players">-->
            <div class="form-group clearfix m-b-sm line-hi34">
                <label class="col-xs-3 al-right">${views.column['PlayerRank.rankCode']}</label>
                <div class="col-xs-9">${command.result.rankCode}</div>
            </div>
            <div class="form-group clearfix m-b-xxs">
                <label class="col-xs-3 al-right line-hi34"><span
                        class="co-red m-r-sm">*</span>${views.column['PlayerRank.rankName']}</label>
                <div class="col-xs-9 input-group">
                    <form:input path="result.rankName" cssClass="form-control m-b"/>
                </div>
            </div>
            <div class="form-group clearfix m-b-xs line-hi34">
                <label class="col-xs-3 al-right">${views.column['PlayerRank.riskMarker']}</label>
                <div class="col-xs-9">
                    <input name="result.riskMarker" type="checkbox" class="i-checks" value="true">${views.column['PlayerRank.Marker']}
                </div>
            </div>
            <div class="form-group clearfix m-b-xs line-hi34">
                <label class="col-xs-3 al-right"><span
                        class="co-red m-r-sm">*</span>${views.role['Player.addplayer.fsyhfa']}</label>

                <div>
                    <div class="col-xs-9 input-group date">
                        <gb:select name="result.rakebackId" list="${command.rakebackSetList}"
                                   prompt="${views.role['player.addplayer.wfsfa']}"
                                   value="${command.result.rakebackId}" listValue="name"
                                   cssClass="btn-group chosen-select-no-single input-sm" listKey="id"></gb:select>
                    </div>
                </div>
            </div>
            <div class="form-group clearfix m-b-xxs">
                <label class="col-xs-3 al-right line-hi34">${views.column['PlayerRank.remark']}</label>
                <div class="col-xs-9">
                    <form:textarea path="result.remark" cssClass="form-control"/>
                </div>
            </div>
            <!--                  </div>-->
        </div>
        <div class="modal-footer">
            <soul:button cssClass="btn btn-default" text="${views.common['commit']}" opType="ajax" dataType="json" target="${root}/playerRank/addPlayerRank.html" precall="validateForm" post="getCurrentFormData" callback="saveCallbak" />
            <soul:button cssClass="btn btn-filter" text="${views.role['add.submitandsetup']}" opType="function" dataType="json" precall="validateForm" post="getCurrentFormData"
                         target="saveGetVo" />
        </div>
    <!--//endregion your codes 3-->

</form:form>

</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import res="site/player/playerrank/Add"/>
<!--//endregion your codes 4-->
</html>