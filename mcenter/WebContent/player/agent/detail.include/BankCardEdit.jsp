<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.UserBankcardVo"--%>
<%--@elvariable id="bankListVo" type="so.wwb.gamebox.model.company.vo.BankListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${views.common['edit']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<c:set value="${command.result}" var="bankcard"></c:set>
    <form:form method="post" name="addBankForm">
        <div id="validateRule" style="display: none">${validate}</div>
        <form:input path="result.id" type="hidden"/>
        <form:input path="result.userId" type="hidden"/>
        <%--<form:input path="result.bankcardMasterName" type="hidden"/>--%>

        <form:input path="search.id" type="hidden" value="${bankcard.id}"/>
        <form:input path="result.id" type="hidden" value="${bankcard.id}"/>
        <form:input path="result.bankcardMasterName" type="hidden"
                    value="${not empty bankcard.bankcardMasterName?bankcard.bankcardMasterName:sysUser.realName}"/>
        <form:input path="result.bankName" type="hidden"
                    value="${empty bankcard.bankName?bankListVo.result.get(0).bankName:bankcard.bankName}"/>
        <input type="hidden" name="userType" value="23">

        <div class="modal-body">
            <div class="form-group over clearfix">
                <label class="col-xs-3 al-right">${views.column['userAgent.bankcard.name']}：</label>
                <div class="col-xs-9 p-x">${not empty sysUser.realName?sysUser.realName:command.result.bankcardMasterName}</div>
            </div>
            <div class="form-group over clearfix">
                <label class="col-xs-3 al-right">${views.column['UserBankcard.bankName']}：</label>
                <div class="col-xs-9 p-x">
                    <%--
                    <form:select class="chosen-select-no-single" path="result.bankName">
                        <c:forEach items="${bankListVo.data}" var="i">
                            <option value="${i.bankName}" ${command.result.bankName==i.bankName?'selected':''}>${dicts.common.bankname[i.bankName]}</option>
                        </c:forEach>
                    </form:select>
                    --%>
                    <%--<gb:select name="result.bankName" value="${command.result.bankName}" list="${bankListVo.data}"/>--%>

                        <div class="bank-deposit clearfix">

                            <div class="bank-total">
                                <c:forEach items="${bankListVo.result}" var="bank" varStatus="vs" end="14">
                                    <label class="bank pay-bank-label ${command.result.bankName eq bank.bankName ? 'select' : empty command.result.bankName && vs.index==0?'select':''}" bankcode="${bank.bankName}">
                                    <span class="radio">
                                    <input name="bankName" type="radio"
                                           value="${bank.bankName}" ${command.result.bankName eq bank.bankName ? 'checked':empty command.result.bankName && vs.index==0?'checked':''} class="ignore"/>
                                    </span>
                                    <span class="radio-bank" title="${dicts.common.bankname[bank.bankName]}">
                                    <i class="pay-bank ${bank.bankName}"></i>
                                    </span>
                                        <span class="bank-logo-name">${dicts.common.bankname[bank.bankName]}</span>
                                    </label>
                                </c:forEach>
                            </div>

                            <div name="hideBank" style="display: none;">
                                <c:forEach items="${bankListVo.result}" var="bank" varStatus="vs" begin="15">
                                    <label class="bank ${command.result.bankName eq bank.bankName ? 'select':empty command.result.bankName && vs.index==0?'select':''}" bankcode="${bank.bankName}">
                                    <span class="radio">
                                        <input name="bankName" type="radio"
                                               value="${bank.bankName}" ${command.result.bankName eq bank.bankName ? 'checked':empty command.result.bankName && vs.index==0?'checked':''} class="ignore"/>
                                    </span>
                                    <span class="radio-bank" title="${dicts.common.bankname[bank.bankName]}">
                                        <i class="pay-bank ${bank.bankName}"></i>
                                    </span>
                                        <span class="bank-logo-name">${dicts.common.bankname[bank.bankName]}</span>
                                    </label>
                                </c:forEach>
                            </div>

                            <div class="clear"></div>
                        </div>
                        <c:if test="${fn:length(bankListVo.result)>15}">
                            <div class="bank-spreadout set">
                            <span name="extendBank">
                                <soul:button target="showMoreBank" text="${views.player_auto['展开更多银行']}" opType="function"/>
                                <i class="bank-arrico down"></i>
                            </span>
                            <span style="display: none" name="collapseBank">
                                <soul:button target="showMoreBank" text="${views.player_auto['收起部分银行']}" opType="function"/>
                                <i class="bank-arrico up"></i>
                            </span>
                            </div>
                        </c:if>
                </div>
            </div>
            <div class="form-group over clearfix">
                <label class="col-xs-3 al-right" for="result.bankcardNumber">${views.column['UserBankcard.bankcardNumber']}：</label>
                <div class="col-xs-9 p-x">
                    <form:input type="text" class="form-control" path="result.bankcardNumber" value="${command.result.bankcardNumber}"/>
                </div>
            </div>

            <div class="form-group over clearfix">
                <label class="col-xs-3 al-right" for="result.bankDeposit">${views.player_auto['开户行']}：</label>
                <div class="col-xs-9 p-x">
                    <form:input type="text" class="form-control" path="result.bankDeposit" value="${bankcard.bankDeposit}"/>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <soul:button precall="validateForm" cssClass="btn btn-filter" callback="saveCallbak" text="${views.common['OK']}" opType="ajax" dataType="json" target="${root}/userAgent/agent/bankCardSave.html" post="getCurrentFormData"/>
            <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
        </div>
    </form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/agent/BankCardEdit"/>
</html>