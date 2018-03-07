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
            <label class="">${views.fund_auto['启用提示信息1']}<br>
                    ${views.fund_auto['启用提示信息2']}</label>
        </div>

        <div class="form-group over clearfix">
            <label class="col-xs-3 al-right">${views.fund_auto['是否启用']}：</label>
            <div class="col-xs-8 p-x">
                <input type="checkbox" name="my-checkbox" data-size="mini" ${command.result.active?'checked':''}>
                <input type="hidden" name="result.active" value="${not empty command.result.active && command.result.active?'true':'false'}">
            </div>
        </div>

        <c:set value="${paramValueMap}" var="p"></c:set>
        <div class="form-group over clearfix">
            <label class="col-xs-3 al-right"><span class="co-red m-r-sm">*</span>${views.fund_auto['出款渠道']}：</label>
            <div class="col-xs-8 p-x">
                <select  id="withdrawChannel" name="result.paramValue" class="btn btn-group btn-default dropdown-toggle" style="height: 35px">
                        <option value="">${views.common['pleaseSelect']}</option>
                        <c:forEach items="${bankList}" var="b">
                            <option value="${b.bankName}" ${p.get("withdrawChannel")==b.bankName?'selected':''}>${(dicts.common.bankname[b.bankName]==null)?b.bankShortName:dicts.common.bankname[b.bankName]}</option>
                        </c:forEach>
                </select>
            </div>
        </div>
        <div class="form-group over clearfix">
            <label class="col-xs-3 al-right"><span class="co-red m-r-sm">*</span>${views.fund_auto['商户号']}：</label>
            <div class="col-xs-8 p-x">
                <input id="merchantCode" type="text" name="result.paramValue" class="form-control" value="${p.get("merchantCode")}"/>
            </div>
        </div>
        <div class="form-group over clearfix">
            <label class="col-xs-3 al-right"><span class="co-red m-r-sm"></span>${views.fund_auto['平台号']}：</label>
            <div class="col-xs-8 p-x">
                <input id="platformId" type="text" name="result.paramValue" class="form-control" value="${p.get("platformId")}"/>
            </div>
        </div>
        <div class="form-group over clearfix">
            <label class="col-xs-3 al-right"><span class="co-red m-r-sm">*</span>${views.fund_auto['秘钥']}：</label>
            <div class="col-xs-8 p-x">
                <input id="key" type="text" name="result.paramValue" class="form-control" value="${p.get("key")}"/>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <soul:button precall="accountValidateForm" cssClass="btn btn-filter" opType="ajax" dataType="json" text="${views.common['OK']}" target="${root}/fund/withdraw/saveWithdrawAccount.html" post="getCurrentFormData" callback="saveCallbak"/>
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