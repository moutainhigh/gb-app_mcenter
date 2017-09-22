<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.UserBankcardVo"--%>
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
<c:if test="${bankcard==null}">
    <div class="no-content_wrap">
        <i class="fa fa-exclamation-circle"></i> ${views.role['Player.detail.bankcard.noresult']}
    </div>
</c:if>
<c:if test="${bankcard!=null}">
    <form:form method="post" name="addBankForm">
        <gb:token></gb:token>
        <div id="validateRule" style="display: none">${validate}</div>
        <form:input path="search.id" type="hidden" value="${bankcard.id}"/>
        <form:input path="result.id" type="hidden" value="${bankcard.id}"/>
        <form:input path="result.bankcardMasterName" type="hidden"
                    value="${not empty bankcard.bankcardMasterName?bankcard.bankcardMasterName:sysUser.realName}"/>
        <c:choose>
            <c:when test="${!empty bankcard.bankName}">
                <input id="result.bankName" name="result.bankName" type="hidden" value="${bankcard.bankName}"/>
            </c:when>
            <c:when test="${fn:length(bankListVo.result)>0}">
                <input id="result.bankName" name="result.bankName" type="hidden" value="${bankListVo.result.get(0).bankName}"/>
            </c:when>
            <c:otherwise>
                <input id="result.bankName" name="result.bankName" type="hidden" value=""/>
            </c:otherwise>
        </c:choose>

        <form:input path="result.userId" type="hidden" value="${bankcard.userId}"/>
        <div class="modal-body">
            <div class="form-group over clearfix">
                <label class="col-xs-2 al-right">${views.role['Player.detail.bank.realName']}</label>
                <div class="col-xs-9 p-x">${sysUser.realName}</div>
            </div>
            <div class="form-group over clearfix">
                <label class="col-xs-2 al-right">${views.role['Player.detail.bank.bank']}</label>
                <div class="col-xs-9 p-x">
                        <div class="bank-deposit clearfix">

                            <div class="bank-total">
                                <c:forEach items="${bankListVo.result}" var="bank" varStatus="vs" end="14">
                                    <label class="bank pay-bank-label ${bankcard.bankName eq bank.bankName ? 'select' : empty bankcard.bankName && vs.index==0?'select':''}" bankcode="${bank.bankName}">
                                        <span class="radio">
                                            <input name="bankName" type="radio"value="${bank.bankName}"
                                            ${bankcard.bankName eq bank.bankName ? 'checked':empty bankcard.bankName && vs.index==0?'checked':''} class="ignore"/>
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
                                    <label class="bank ${bankcard.bankName eq bank.bankName ? 'select':empty bankcard.bankName && vs.index==0?'select':''}" bankcode="${bank.bankName}">
                                    <span class="radio">
                                        <input name="bankName" type="radio"
                                               value="${bank.bankName}" ${bankcard.bankName eq bank.bankName ? 'checked':empty bankcard.bankName && vs.index==0?'checked':''} class="ignore"/>
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
                <label class="col-xs-2 al-right" for="result.bankcardNumber">${views.role['Player.detail.bank.cardNumber']}</label>
                <div class="col-xs-9 p-x">
                    <form:input type="text" class="form-control" path="result.bankcardNumber" value="${bankcard.bankcardNumber}"/>
                </div>
            </div>
            <div class="form-group over clearfix">
                <label class="col-xs-2 al-right" for="result.bankDeposit">${views.player_auto['开户行']}：</label>
                <div class="col-xs-9 p-x">
                    <form:input type="text" class="form-control" placeholder="${views.player_auto['选择“其它”银行时必填']}" path="result.bankDeposit" value="${bankcard.bankDeposit}"/>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <soul:button precall="validateForm" cssClass="btn btn-filter" callback="saveCallbak" text="${views.common['OK']}" opType="ajax" dataType="json" target="${root}/player/view/bankCardSave.html" post="getCurrentFormData"/>
            <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
        </div>
    </form:form>
</c:if>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/agent/BankCardEdit"/>
</html>