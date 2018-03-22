<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VUserPlayerListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
    <form:form>
        <input type="hidden" name="search.id" value="${command.result.id}"/>
        <input type="hidden" name="sysUser.username" value="${command.result.username}"/>
        <div id="validateRule" style="display: none">${validateRule}</div>
        <div class="modal-body">
            <div class="form-group over clearfix">
                <label class="col-xs-3 al-right"><span class="co-red m-r-sm">*</span>${views.player_auto['账号']}：</label>
                <div class="col-xs-9 p-x">
                    <span>${command.result.username}</span>
                </div>
            </div>
            <%--<div class="form-group over clearfix">
                <label class="col-xs-3 al-right"><span class="co-red m-r-sm">*</span>${views.player_auto['额度']}：</label>
                <div class="col-xs-9 p-x">
                    <input type="text" name="result.walletBalance" class="form-control" value="${command.result.walletBalance}"/>
                </div>
            </div>--%>
            <div class="form-group over clearfix">
                <label class="col-xs-3 al-right">${views.player_auto['有效时间截止']}：</label>
                <div class="col-xs-9 p-x">
                    <gb:dateRange format="${DateFormat.DAY_SECOND}" style="width:45%"
                                  useRange="false"
                                  opens="right" position="down"
                                  name="sysUser.freezeStartTime" value="${command.result.freezeStartTime}"/>
                    <div><span>${views.player_auto['若未设置']}</span></div>
                </div>
            </div>

            <div class="form-group clearfix">
                <label class="col-xs-3 al-right line-hi34">${views.player_auto['备注']}：</label>
                <div class="col-xs-9 p-x">
                    <textarea class="form-control" name="sysUser.memo">${command.result.memo}</textarea>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <soul:button precall="validateForm" cssClass="btn btn-filter _enter_submit" callback="saveCallbak" text="${views.common['OK']}" opType="ajax" dataType="json" target="${root}/simulationAccount/updatePlayer.html" post="getCurrentFormData"/>
            <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
        </div>
    </form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import type="edit"/>
</html>
