<%--@elvariable id="command" type="org.soul.model.sys.vo.SysParamVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<head>
    <title></title>
    <%@ include file="/include/include.head.jsp" %>
    <!--//region your codes 2-->

    <!--//endregion your codes 2-->
</head>

<body>
<!--//region your codes 3-->
<form:form action="${root}/fund/withdraw/WithdrawAccount">

    <%--<input type="hidden" value="${command.creditId}" name="creditId" id="creditId">--%>
    <%--<div id="validateRule" style="display: none">${validateRule}</div>--%>
    <div class="modal-body">
        <div class="form-group over clearfix">
            <label class="">启用后，出款审核列表将显示出款相关信息及选项；<br>
                玩家点击入口并进行存款行为，系统将自动判断存款是否成功；</label>
        </div>

        <div class="form-group over clearfix">
            <label class="col-xs-3 al-right">是否启用：</label>
            <div class="col-xs-8 p-x">
                <input type="checkbox" name="my-checkbox" data-size="mini" ${command.result.isSwitch?'checked':''}>
                <input type="hidden" name="result.isSwitch" value="${not empty command.result.isSwitch && command.result.isSwitch?'true':'false'}">
            </div>
        </div>

        <c:set value="${paramValueMap}" var="p"></c:set>
        <div class="form-group over clearfix">
            <label class="col-xs-3 al-right"><span class="co-red m-r-sm">*</span>出款渠道：</label>
            <div class="col-xs-8 p-x">
                <select name="result.paramValue" class="btn btn-group btn-default dropdown-toggle" style="height: 35px">
                        <option value="">${views.common['pleaseSelect']}</option>
                        <c:forEach items="${bankList}" var="b">
                            <option value="${b.bankName}" ${p.get("withdrawChannel")==b.bankName?'selected':''}>${(dicts.common.bankname[b.bankName]==null)?b.bankShortName:dicts.common.bankname[b.bankName]}</option>
                        </c:forEach>
                </select>
            </div>
        </div>
        <div class="form-group over clearfix">
            <label class="col-xs-3 al-right"><span class="co-red m-r-sm">*</span>商户号：</label>
            <div class="col-xs-8 p-x">
                <input type="text" name="result.paramValue" class="form-control" value="${p.get("merchantCode")}"/>
            </div>
        </div>
        <div class="form-group over clearfix">
            <label class="col-xs-3 al-right"><span class="co-red m-r-sm">*</span>平台号：</label>
            <div class="col-xs-8 p-x">
                <input type="text" name="result.paramValue" class="form-control" value="${p.get("platformId")}"/>
            </div>
        </div>
        <div class="form-group over clearfix">
            <label class="col-xs-3 al-right"><span class="co-red m-r-sm">*</span>秘钥：</label>
            <div class="col-xs-8 p-x">
                <input type="text" name="result.paramValue" class="form-control" value="${p.get("key")}"/>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <soul:button precall="" cssClass="btn btn-filter" opType="ajax" dataType="json" text="${views.common['OK']}" target="${root}/fund/withdraw/saveWithdrawAccount.html" post="getCurrentFormData" callback="saveCallbak"/>
        <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
    </div>
</form:form>
<!--//endregion your codes 3-->
</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import res="site/fund/withdraw/WithdrawAccount"/>
<!--//endregion your codes 4-->
</html>