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
<form:hidden path="result.id" id="resultId" />

    <%--<input type="hidden" value="${command.creditId}" name="creditId" id="creditId">--%>
    <%--<div id="validateRule" style="display: none">${validateRule}</div>--%>
    <div class="modal-body">


        <c:set value="${paramValueMap}" var="p"></c:set>
        <div class="form-group over clearfix">
            <label class="col-xs-3 al-right"><span class="co-red m-r-sm">*</span>${views.fund_auto['出款渠道']}：</label>
            <div class="col-xs-8 p-x">
                <input type="hidden" id="middleValue" name="middleValue" value="" />
                <input type="hidden" id="lastSavedChannel" value="${paramValueMap.withdrawChannel}" />
                <select  id="withdrawChannel" name="result.paramValue" class="chosen-select-no-single" callback="bankChannel">
                        <option value="">${views.common['pleaseSelect']}</option>
                    <c:if test="${command.result != null}">
                        <c:forEach items="${bankList}" var="b">
                            <option value="${b.bankName}" ${p.get("withdrawChannel")==b.bankName?'selected':''}>${(dicts.common.bankname[b.bankName]==null)?b.bankShortName:dicts.common.bankname[b.bankName]}</option>
                        </c:forEach>
                    </c:if>
                </select>
            </div>
        </div>

    <div class="modal-footer">
        <soul:button precall="" cssClass="btn btn-filter" opType="ajax" dataType="json" text="${views.common['OK']}"
                     target="${root}/fund/withdraw/payment.html?search.transactionNo=${xx}" post="getCurrentFormData" callback="saveCallbak"/>

        <soul:button precall="" cssClass="btn btn-filter" opType="ajax" dataType="json" text="${views.common['OK']}"
                     target="${root}/fund/withdraw/saveWithdrawAccount.html" post="getCurrentFormData" callback="saveCallbak"/>

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