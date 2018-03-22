<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.RebateAgentVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<html lang="zh-CN">
<head>
    <title>${views.fund_auto['可获返佣金额结算']}</title>
    <%@ include file="/include/include.head.jsp" %>
    <!--//region your codes 2-->

    <!--//endregion your codes 2-->
</head>

<body>

<form:form id="editForm" action="" method="post">
    <gb:token/>
    <input type="hidden" name="result.id" value="${command.result.id}">
    <div id="validateRule" style="display: none">${validateRule}</div>

    <!--//region your codes 3-->

    <div class="modal-body">
        <div class="line-hi34 col-sm-12 bg-gray m-b-sm">
            <span class="co-yellow"><i class="fa fa-exclamation-circle"></i></span>
                ${views.fund_auto['进行结算的时候']}
        </div>

        <div class="form-group clearfix line-hi34 m-b-sm col-xs-12">
            <label class="col-xs-3 al-right">${views.fund_auto['可获得返佣金额']}：</label>
            <div class="col-xs-8 p-x">
                <span class="co-orange">${soulFn:formatCurrency(command.result.rebateTotal)}</span>
                <input type="hidden" name="result.rebateTotal" value="${command.result.rebateTotal}">
            </div>
        </div>

        <div class="form-group clearfix line-hi34 m-b-sm col-xs-12">
            <label class="col-xs-3 al-right">${views.fund_auto['返佣金额']}：</label>
            <div class="col-xs-8 p-x">
                <input type="number" class="form-control" name="result.rebateActual">
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <soul:button target="${root}/rebateAgent/settled.html" text="${views.common['OK']}" opType="ajax" cssClass="btn btn-filter _enter_submit"
                     post="getCurrentFormData" callback="saveCallbak" precall="myValidateForm" tag="button">${views.common['OK']}</soul:button>
        <soul:button target="closePage" text="${views.common['cancel']}" opType="function" cssClass="btn btn-outline btn-filter"/>
    </div>
    <!--//endregion your codes 3-->
</form:form>

</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import res="site/operation/rebate/Settle"/>
<!--//endregion your codes 4-->
</html>