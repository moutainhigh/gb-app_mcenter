<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form:form action="${root}/fund/withdraw/submitRemind.html" method="post">
    <div id="validateRule" style="display: none;">${validateRule}</div>
    <div class="modal-body">
        <div class="clearfix m-b bg-gray p-t-xs">
                    <span class="co-orange fs36 line-hi25 col-xs-1 al-right">
                        <i class="fa fa-exclamation-circle m-t-n-sm"></i>
                    </span>
            <div class="line-hi25 pull-left col-xs-11 m-b-sm">${views.fund['withdraw.index.playerWithdraw.withdrawRemind']}</div>
        </div>
        <div class="form-group clearfix line-hi34 m-b-sm">
            <label class="col-xs-3 al-right">${views.fund['withdraw.index.playerWithdraw.enable']}：</label>
            <div class="col-xs-8">
                <input type="checkbox" name="active"  value="${sysParam.active}" data-size="mini" <c:if test="${sysParam.active==true}">checked</c:if> />
            </div>
        </div>
        <div class="form-group clearfix line-hi34 m-b-sm">
            <label class="col-xs-3 al-right">${views.fund['withdraw.index.playerWithdraw.remindMultiple']}：</label>
            <div class="col-xs-8">
                <div class="input-group">
                    <input type="text" class="form-control" name="paramValue" placeholder="1~100" maxlength="100" value="${sysParam.paramValue}"><span class="input-group-addon">${views.fund['withdraw.index.playerWithdraw.multiple']}</span>
                </div>
            </div>
        </div>
    </div>

    <div class="modal-footer">
        <soul:button cssClass="btn btn-filter" text="${views.common['OK']}" opType="function" target="submitRemind" precall="validateForm"/>
        <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/fund/withdraw/Remind"/>
</html>

