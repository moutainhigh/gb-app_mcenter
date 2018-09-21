<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.PayAccountVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<body>
    <form:form id="editForm" action="${root}/payAccount/edit.html" method="post">
    <form:hidden path="result.id" id="resultId" />
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <div id="old-currency-div" class="hide">
        <c:forEach var="cu" items="${command.payAccountCurrencyList}">
            ${cu.currencyCode},
        </c:forEach>
    </div>
    <c:forEach items="${channelJson}" var="json">
        <c:if test="${json.get('view')=='payDomain'}">
            <c:set var="doamin" value="${json.get('value')}"></c:set>
        </c:if>

        <input type="hidden" name="${json.get('view')}" value="${json.get("value")}">
    </c:forEach>

    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a href="javascript:void(0)" class="navbar-minimalize"><i class="icon iconfont"></i></a></h2>
            <span>${views.sysResource['运营']}</span>
            <span>/</span>
            <span>${views.sysResource['线上支付账户']}</span>
            <soul:button target="goToLastPage" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
        </div>

        <div class="col-lg-12">
            <div class="wrapper white-bg shadow clearfix">
                <div class="present_wrap"><b>${empty command.result.id?views.common['create']:views.common['edit']}${views.sysResource['线上支付账户']}</b></div>
                <form class="m-t" action="">
                    <%-- 代号 --%>
                    <div class="form-group line-hi34 clearfix">
                        <label class="ft-bold col-sm-3 al-right">${views.column['PayAccount.code']}：</label>
                        <div class="col-sm-5">${command.result.code}</div>
                    </div>
                    <%-- 账户名称 --%>
                    <div class="form-group clearfix line-hi34">
                        <label for="result.payName" class="ft-bold col-sm-3 al-right line-hi34">
                            <span class="co-red m-r-sm">*</span>${views.column['PayAccount.payName']}：
                        </label>
                        <div class="col-sm-5">
                            <div class="input-group date">
                                <form:input disabled="${disabled}" id="payName" path="result.payName" cssClass="form-control"/>
                                <span class="input-group-addon bdn">&nbsp;&nbsp;</span>
                            </div>
                        </div>
                    </div>
                    <%-- 存款渠道 --%>
                    <div class="form-group clearfix third">
                        <div class="form-group clearfix">
                            <label class="ft-bold col-sm-3 al-right line-hi34">
                                <span class="co-red m-r-sm">*</span>${views.column['PayAccount.bankCode']}：
                            </label>
                            <div class="col-sm-5">
                                <div class="input-group date">
                                    <select name="payType" id="payType">
                                        <option value="0">${views.common['pleaseSelectPayment']}</option>
                                        <c:forEach items="${bankPayTypes}" var="p">
                                            <option value="${p.code}" ${currentBank.result.payType == p.code?'selected':''}>${dicts.common.paytype[p.name()]}</option>
                                        </c:forEach>
                                    </select>
                                    <span class="input-group-addon bg-gray">&emsp14;</span>
                                        <%--<span class="input-group-addon bdn">&nbsp;&nbsp;</span>--%>
                                    <select name="result.bankCode" id="bankCode">
                                        <option value="">${views.common['pleaseSelectDeposit']}</option>
                                        <c:if test="${command.result != null}">
                                            <c:forEach items="${command.bankList}" var="p">
                                                <c:if test="${currentBank.result.payType == p.payType}">
                                                    <option value="${p.bankName}" ${command.result.bankCode==p.bankName?'selected':''}>${(dicts.common.bankname[p.bankName]==null)?p.bankShortName:dicts.common.bankname[p.bankName]}</option>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%-- 支持终端 --%>
                    <div class="form-group clearfix line-hi34">
                        <label class="ft-bold col-sm-3 al-right">
                            <span class="co-red m-r-sm">*</span>${views.content['支持终端：']}
                        </label>
                        <div class="col-sm-5">
                            <div class="input-group date">
                                <c:set var="terminal" value="${command.result.terminal}"/>
                                <label class="m-r-sm">
                                    <input type="radio" value="0" name="result.terminal" ${empty terminal||terminal eq '0'?'checked':''}/>${views.content['全部']}
                                </label>
                                <label class="m-r-sm">
                                    <input type="radio" value="1" name="result.terminal" ${terminal eq '1'?'checked':''}/>${views.content['PC端']}
                                </label>
                                <label class="m-r-sm">
                                    <input type="radio" value="2" name="result.terminal" ${terminal eq '2'?'checked':''}/>${views.content['手机端']}
                                </label>
                            </div>
                        </div>
                    </div>
                    <%-- 随机额度 --%>
                    <%--<c:set var="accountType" value="${commond.result.accountType}"></c:set>--%>
                    <%--<c:choose>--%>
                        <%--<c:when test="${accountType=='2'}"></c:when>--%>
                        <%--<c:otherwise>--%>
                            <div class="form-group clearfix line-hi34">
                                <label class="ft-bold col-sm-3 al-right">
                                ${views.content_auto['随机额度']}：</label>
                                <div class="col-sm-5">
                                    <input type="checkbox" name="my-checkbox" data-size="mini" ${command.result.randomAmount?'checked':''}>
                                    <input type="hidden" name="result.randomAmount" value="${not empty command.result.randomAmount && command.result.randomAmount?'true':'false'}">
                                </div>
                            </div>
                        <%--</c:otherwise>--%>
                    <%--</c:choose>--%>
                    <%-- 支付域名 --%>
                    <div class="form-group clearfix hide payDomain">
                        <label class="ft-bold col-sm-3 al-right line-hi34">
                            <span class="co-red m-r-sm">*</span>${messages.content['pay_channel.payDomain']}：
                        </label>
                        <div class="col-sm-5" id="onLinePay">
                            <div class="input-group date">
                                <gb:select name="onLinePay" callback="onLinePay" cssClass="btn-group chosen-select-no-single" prompt="${views.common['pleaseSelect']}" list="${command.sysDomains}" listKey="domain" listValue="domain" value="${doamin}"/>
                               <%-- <select name="onLinePay" callback="onLinePay" class="btn-group chosen-select-no-single">
                                    <option value="">${views.common['pleaseSelect']}</option>
                                    <c:forEach items="${command.sysDomains}" var="p">
                                        <option value="${p.domain}" ${p.domain==doamin?'selected':''} >${p.domain}</option>
                                    </c:forEach>
                                </select>--%>
                                <span class="input-group-addon bdn">&nbsp;&nbsp;</span>
                            </div>
                        </div>
                    </div>
                    <%-- 提示 --%>
                    <div class="line-hi34 col-sm-12 bg-gray m-b">
                        <label class="ft-bold col-sm-3 al-right line-hi34"></label>
                        <span class="co-yellow m-r-sm m-l-sm"><i class="fa fa-exclamation-circle"></i></span>
                        ${views.content['payAccount.add.monetaryTips']}
                    </div>
                    <%-- 支持货币 --%>
                    <div class="form-group clearfix line-hi34">
                        <label class="ft-bold col-sm-3 al-right">
                            <span class="co-red m-r-sm">*</span>${views.content['payAccount.add.supportMoney']}：
                        </label>
                        <div class="col-sm-5">
                            <div class="input-group date">
                                <div class="col-sm-5 currency" id="currenct"></div>
                                <span class="input-group-addon bdn">&nbsp;&nbsp;</span>
                            </div>
                        </div>
                    </div>
                    <%-- 停用金额 --%>
                    <%--<div class="form-group clearfix">--%>
                        <%--<label for="result.disableAmount" class="ft-bold col-sm-3 al-right line-hi34"><span--%>
                                <%--class="co-red m-r-sm">*</span>${views.column['PayAccount.disableAmount']}${sessionSysUser.defaultCurrency}：</label>--%>
                        <%--<div class="col-sm-5">--%>
                            <%--<div class="input-group date">--%>
                                <%--<form:input id="disableAmount" path="result.disableAmount" cssClass="form-control"/>--%>
                                    <%--<span tabindex="0" class=" help-popover input-group-addon" role="button" data-container="body" data-toggle="popover"--%>
                                          <%--data-trigger="focus" data-placement="top" data-original-title="" title="" data-html="true"--%>
                                          <%--data-content="${views.content['payAccount.disableAmount']}">--%>
                                        <%--<i class="fa fa-question-circle"></i>--%>
                                    <%--</span>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                    <%-- 单笔存款 --%>
                    <div class="form-group clearfix">
                        <label class="ft-bold col-sm-3 al-right line-hi34">${views.column['PayAccount.singleDeposit']}${sessionSysUser.defaultCurrency}：</label>
                        <div class="col-sm-5">
                            <div class="input-group date">
                                <form:input placeholder="${views.content['payAccount.singleDepositMin']}" id="singleDepositMin" path="result.singleDepositMin" cssClass="form-control"/>
                                <span class="input-group-addon bg-gray">~</span>
                                <form:input placeholder="${views.content['payAccount.singleDepositMax']}" id="singleDepositMax" path="result.singleDepositMax" cssClass="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group clearfix">
                        <label class="ft-bold col-sm-3 al-right line-hi34">手续费方案：</label>
                        <div class="col-sm-5">
                            <div class="input-group date">
                                <gb:select name="result.feeSchemaId"  cssClass="btn-group chosen-select-no-single" prompt="${views.common['pleaseSelect']}" list="${schemaListVo.result}" listKey="id" listValue="schemaName" value="${feeAccountRelation.feeSchemaId}"/>
                            </div>
                        </div>
                    </div>
                    <%-- 有效分钟数--%>
                   <%-- <div class="form-group clearfix">
                        <label class="ft-bold col-sm-3 al-right line-hi34">${views.column['PayAccount.effectiveMinutes']}：</label>
                        <div class="col-sm-5">
                            <div class="input-group date">
                                <form:input placeholder="${views.common['pleaseEnter']}" id="effectiveMinutes" path="result.effectiveMinutes" cssClass="form-control"/>
                                <span class="input-group-addon bg-gray">${views.content['minutes']}</span>
                                    <span tabindex="0" class=" help-popover input-group-addon" role="button" data-container="body" data-toggle="popover"
                                          data-trigger="focus" data-placement="top" data-original-title="" title="" data-html="true"
                                          data-content="${views.content['payAccount.prompt']}">
                                        <i class="fa fa-question-circle"></i>
                                    </span>
                            </div>
                        </div>
                    </div>--%>
                    <%--<div class="form-group clearfix line-hi34" style="display:${command.result.id>0?"":"none"}">
                        <label class="ft-bold col-sm-3 al-right">${views.column['PayAccount.depositCount']}：</label>
                        <div class="col-sm-5">
                            <div class="input-group">
                                <input id="depositCount" name="result.depositCount" class="form-control" value="<fmt:formatNumber value="${command.result.depositCount}" pattern="0"/>">
                                <span class="input-group-addon bdn">
                                    <soul:button cssClass="m-l-sm" target="revertDepositCount" text="${views.column['PayAccount.revert']}" opType="function"></soul:button>
                                </span>
                            </div>
                        </div>
                    </div>


                    <div class="form-group clearfix line-hi34" style="display:${command.result.id>0?"":"none"}">
                        <label class="ft-bold col-sm-3 al-right">${views.column['PayAccount.depositTotal']}：</label>
                        <div class="col-sm-5">
                            <div class="input-group">
                                <input id="depositTotal" name="result.depositTotal" class="form-control" value="<fmt:formatNumber value="${command.result.depositTotal}" pattern="0"/>">
                                <span class="input-group-addon bdn">
                                    <soul:button cssClass="m-l-sm" target="revertDepositTotal" text="${views.column['PayAccount.revert']}" opType="function"></soul:button>
                                </span>
                            </div>
                        </div>
                    </div>--%>
                    <%-- 使用层级--%>
                    <div class="form-group clearfix line-hi34">
                        <label class="ft-bold col-sm-3 al-right">
                            <span class="co-red m-r-sm">*</span>${views.content['payAccount.add.useRank']}：
                        </label>
                        <div class="col-sm-5 rank">
                            <div>
                                <label class="m-r-sm"><input type="checkbox" id="fullRank" ${command.result.fullRank?'checked':''} />${views.content['全部层级']}</label>
                                <span class="m-l co-grayc2">${views.content['勾选后，后续新增的层级同样适用！']}</span>
                            </div>
                            <div class="input-group date allRank ${command.result.fullRank?'hide':''}">
                                <c:forEach items="${command.playerRankList}" var="p">
                                    <label class="m-r-sm">
                                        <input name="rank" type="checkbox" class="i-checks"
                                       <c:if test="${command.result.fullRank}">checked</c:if>
                                        <c:if test="${!command.result.fullRank}">
                                            <c:forEach items="${command.payRankList}" var="payRank">${p.id==payRank.playerRankId?"checked":""}</c:forEach>
                                        </c:if>
                                               value="${p.id}"> ${p.rankName}</label>
                                </c:forEach>
                                <span class="input-group-addon bdn">&nbsp;&nbsp;</span>
                            </div>
                        </div>
                    </div>
                    <hr class="m-t-sm m-b">
                    <form:hidden path="currencyStr" id="currencyStr" />
                    <form:hidden path="rankStr" id="rankStr" />
                    <form:hidden path="result.channelJson" id="channelJson" />
                    <form:hidden path="result.accountType" id="accountType" />
                    <gb:token/>
                    <input type="hidden" value="2" name="result.type" />
                    <input name="result.fullRank" value="${empty command.result.fullRank?false:command.result.fullRank}" hidden="hidden" />
                    <input id="code" name="result.payChannelCode" hidden="hidden" />
                    <%-- 提交 --%>
                    <div class="operate-btn">
                        <soul:button cssClass="btn btn-outline btn-filter btn-lg m-r" text="${views.common['commit']}" opType="ajax" dataType="json"
                                     target="${root}/payAccount/saveOnLine.html" precall="savePlayer" post="getCurrentFormData" callback="goToLastPage" refresh="true"/>
                        <soul:button cssClass="btn btn-filter btn-lg" text="${views.content['payaccount.tjbsjjlsx']}" opType="ajax" dataType="json"
                                     target="${root}/payAccount/saveOnLine.html" precall="savePlayer" post="getCurrentFormData" callback="savePayAccountAndFlowOrder"/>
                        <a id="savePlsyer" href="/vPayAccount/cashFlowOrder.html" nav-target="mainFrame"></a>
                    </div>

                </form>
            </div>
        </div>
    </div>
</form:form>
</body>
<!--//region your codes 4-->

<soul:import res="site/content/payaccount/onLine/Add"/>
<!--//endregion your codes 4-->
</html>