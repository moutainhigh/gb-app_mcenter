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
    <input type="hidden" name="search.transactionNo" value="${withdrawVo.search.transactionNo}"/>

    <br/>
    <div class="">
            <%--<c:if test="${not empty accountListVo && accountListVo.result.size()==0}">--%>
            <%--<div class="form-group over clearfix">--%>
            <%--<label class="col-xs-3 al-right"><span class="co-red m-r-sm"></span></label>--%>
            <%--<div class="col-xs-4 p-x">--%>
            <%--</div>--%>
            <%--</c:if>--%>

        <c:if test="${not empty accountListVo}">

            <div class="form-group over clearfix">
                    <%--代付出款账户--%>
                <label class="col-xs-3 al-right"><span class="co-red m-r-sm">*</span>代付出款账户：</label>
                <div class="col-xs-4 p-x">
                    <c:if test="${accountListVo.result.size()>0}">
                        <gb:select name="withdrawAccount.id" list="${accountListVo.result}" listKey="id"
                                   listValue="withdrawName"
                                   prompt="${views.common['pleaseSelect']}" cssClass="">
                        </gb:select>
                    </c:if>
                    <c:if test="${accountListVo.result.size()==0}">
                        <span class="co-red m-r-sm">无可用的代付出款账户，请前往【运营-代付出款账户】设置出款账户</span>
                    </c:if>
                </div>
            </div>
        </c:if>


            <%--v2029前易收付参数--%>
        <c:if test="${empty accountListVo || not empty command.result}">
            <div class="form-group over clearfix">
                <label class="col-xs-3 al-right"><span class="co-red m-r-sm">*</span>${views.fund_auto['出款渠道']}：</label>
                <div class="col-xs-4 p-x">
                    <select name="withdrawChannel" class="chosen-select-no-single">
                        <c:if test="${command.result != null}">
                            <c:forEach items="${bankList}" var="b">
                                <option value="${b.bankName}" ${p.get("withdrawChannel")==b.bankName?'selected':''}>
                                        ${(dicts.common.bankname[b.bankName]==null)?b.bankShortName:dicts.common.bankname[b.bankName]}
                                </option>
                            </c:forEach>
                        </c:if>
                    </select>
                </div>
            </div>
            <div class="form-group over clearfix">
                <label class="col-xs-3 al-right"><span class="co-red m-r-sm"></span></label>
                <div class="col-xs-8 p-x">
                    <span class="co-red m-r-sm">玩家取款审核下的易收付出款设置为过度版本，后续将会取消，请尽快前往代付出款账户重新设置【运营-代付出款账户】</span>
                </div>
            </div>
        </c:if>
    </div>

    <div class="modal-footer">
        <c:if test="${ (not empty accountListVo && accountListVo.result.size()>0) || (not empty command.result ) }">
            <soul:button precall="checkSelectOption" cssClass="btn btn-filter" opType="ajax" dataType="json"
                         text="${views.common['OK']}"
                         target="${root}/fund/withdraw/payment.html" post="getCurrentFormData" callback="saveCallbak"/>
        </c:if>
        <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter"
                     opType="function"/>
    </div>
</form:form>
<!--//endregion your codes 3-->
</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import res="site/fund/withdraw/WithdrawAccount"/>
<!--//endregion your codes 4-->
</html>