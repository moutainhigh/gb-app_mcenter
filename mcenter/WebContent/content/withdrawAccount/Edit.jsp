<%--@elvariable id="command" type="so.wwb.gamebox.model.gamebox.vo.WithdrawAccountVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<body>
<form:form id="editForm" action="${root}/payAccount/edit.html" method="post">
    <form:hidden path="result.id" id="resultId" />
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <form:hidden path="result.channelJson" id="channelJson" />
    <gb:token/>
    <input type="hidden" value="2" name="result.type" />
    <input id="code" name="result.payChannelCode" hidden="hidden" />
    <c:forEach items="${channelJson}" var="json">
        <c:if test="${json.get('view')=='payDomain'}">
            <c:set var="domain" value="${json.get('value')}"></c:set>
        </c:if>

        <input type="hidden" name="${json.get('view')}" value="${json.get("value")}">
    </c:forEach>

    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a href="javascript:void(0)" class="navbar-minimalize"><i class="icon iconfont"></i></a></h2>
            <span>${views.sysResource['运营']}</span>
            <span>/</span>
            <span>代付出款账户</span>
            <soul:button target="goToLastPage" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
        </div>

        <div class="col-lg-12">
            <div class="wrapper white-bg shadow clearfix">
                <div class="present_wrap"><b>${empty command.result.id?views.common['create']:views.common['edit']}收款账号</b></div>
                <form class="m-t" action="">
                        <%-- 代号 --%>
                    <div class="form-group line-hi34 clearfix">
                        <label class="ft-bold col-sm-3 al-right">${views.column['PayAccount.code']}：</label>
                        <div class="col-sm-5">${command.result.code}</div>
                    </div>
                        <%-- 账户名称 --%>
                    <div class="form-group clearfix line-hi34 m-t">
                        <label class="ft-bold col-sm-3 al-right line-hi34">
                            <span class="co-red m-r-sm" for="result.payName">*</span>账户名称：
                        </label>
                        <div class="col-sm-5">
                            <div class="input-group date">
                                <form:input disabled="${disabled}" id="result.withdrawName" path="result.withdrawName" cssClass="form-control"/>
                                <span class="input-group-addon bdn">&nbsp;&nbsp;</span>
                            </div>
                        </div>
                    </div>
                        <%-- 存款渠道 --%>
                    <div class="form-group clearfix third">
                        <label class="ft-bold col-sm-3 al-right line-hi34">
                            <span class="co-red m-r-sm">*</span>出款渠道：
                        </label>
                        <div class="col-sm-5" id="thirdError">
                            <div class="input-group date">
                                <form:select path="result.bankCode" callback="bankChannel" cssClass="btn-group chosen-select-no-single">
                                    <option value="">${views.common['pleaseSelect']}</option>
                                    <c:forEach items="${bankList}" var="b">
                                        <option value="${b.bankName}" ${command.result.bankCode==b.bankName?'selected':''}>${(dicts.common.bankname[b.bankName]==null)?b.bankShortName:dicts.common.bankname[b.bankName]}</option>
                                    </c:forEach>
                                </form:select>
                                <span class="input-group-addon bdn">&nbsp;&nbsp;</span>
                            </div>
                        </div>
                    </div>
                        <%-- 域名 --%>
                    <div class="form-group clearfix payDomain">
                        <label class="ft-bold col-sm-3 al-right line-hi34">
                            <span class="co-red m-r-sm">*</span>域名：
                        </label>
                        <div class="col-sm-5" id="onLinePay">
                            <div class="input-group date">
                                <gb:select name="onLinePay" callback="onLinePay" cssClass="btn-group chosen-select-no-single"
                                           prompt="${views.common['pleaseSelect']}"
                                           list="${command.sysDomains}"
                                           listKey="domain"
                                           listValue="domain"
                                           value="${domain}"/>
                                <span class="input-group-addon bdn">&nbsp;&nbsp;</span>
                            </div>
                        </div>
                    </div>
                    <hr class="m-t-sm m-b">
                        <%-- 提交 --%>
                    <div class="operate-btn">
                        <soul:button cssClass="btn btn-outline btn-filter btn-lg m-r" text="${views.common['commit']}"
                                     opType="ajax" dataType="json" target="${root}/withdrawAccount/persist.html" precall="savePre"
                                     post="getCurrentFormData" callback="saveCallbak" refresh="true"/>
                    </div>
                </form>
            </div>
        </div>
    </div>
</form:form>
</body>
<!--//region your codes 4-->

<soul:import res="site/content/withdrawAccount/Edit"/>
<!--//endregion your codes 4-->
</html>