<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VUserPlayerListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form:form>

    <div id="validateRule" style="display: none">${validateRule}</div>
<div class="modal-body">
    <div class="form-group clearfix line-hi34 m-b-xxs">
        <label class="col-xs-3 al-right">
            <span class="co-red3 m-r-xs">*</span>
                代理体系
        </label>
        <div class="col-xs-8 p-x">
            <span class="bg-gray input-group-addon bdn">
                <gb:select name="search.agentRanks" prompt="${views.common['pleaseSelect']}" cssClass="btn-group chosen-select-no-single"
                            relSelect="result.agentId"/>
            </span>
            <span class="bg-gray input-group-addon bdn">
                <gb:select name="result.agentId" prompt="${views.common['pleaseSelect']}" cssClass="btn-group chosen-select-no-single" callback="queryAgentLine"
                       relSelectPath="${root}/player/getRank/#search.agentRanks#.html"  listKey="id" listValue="username" />
            </span>
        </div>
    </div>
    <div class="clearfix line-hi34 hide" id="agent-line-div">
        <label class="col-xs-3 al-right">
            代理线
        </label>
        <div class="col-xs-8 p-x" id="agentLine">

        </div>
    </div>

    <div class="clearfix line-hi34">
        <label class="col-xs-3 al-right">
            <span class="co-red3 m-r-xs">*</span>
            账号
        </label>
        <div class="col-xs-8 p-x">
            <input type="text" name="result.username" class="form-control m-b">
        </div>
    </div>

    <div class="form-group clearfix line-hi34 m-b-xxs">
        <label class="col-xs-3 al-right">
            <span class="co-red3 m-r-xs">*</span>
                密码
        </label>
        <div class="col-xs-8 p-x">
            <input type="text" name="result.password" class="form-control m-b">
        </div>
    </div>

    <div class="form-group clearfix line-hi34 m-b-xxs" style="margin-bottom: 15px;">
        <label class="col-xs-3 al-right">
            <span class="co-red3 m-r-xs">*</span>
                层级
        </label>
        <div class="col-xs-8 p-x">
            <gb:select name="result.rankId" cssClass="btn-group chosen-select-no-single" prompt="${views.common['pleaseSelect']}"
                      callback="queryRank" list="${playerRanks}" listKey="id" listValue="rankName"/>
        </div>
    </div>
    <div class="clearfix line-hi34 hide" id="rakeback-div">
        <label class="col-xs-3 al-right">
            返水方案
        </label>
        <div class="col-xs-8 p-x" id="rakebackName-div">

        </div>
    </div>
    <div class="form-group clearfix line-hi34 m-b-xxs">
        <label class="col-xs-3 al-right">
                备注
        </label>
        <div class="col-xs-8 p-x">
            <textarea name="search.memo" id="result.memo" class="form-control m-b" data-value=""></textarea>
        </div>
    </div>
</div>
    <div class="modal-footer">
        <soul:button target="${root}/player/saveNewPlayer.html" text="" cssClass="btn btn-filter"
                     precall="validateForm" opType="ajax" post="getCurrentFormData" callback="closePage">${views.common['OK']}</soul:button>
        <soul:button target="closePage" text="${views.common['cancel']}" opType="function" cssClass="btn btn-outline btn-filter"></soul:button>
    </div>
    </form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/vuserplayer/addNewPlayer"/>
</html>
