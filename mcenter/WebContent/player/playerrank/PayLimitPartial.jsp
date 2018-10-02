<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.po.VActivityMessage"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<%--渠道分为银行账户,第三方两个大类:产品确认,银行直接显示成银行直连/账户,第三方显示出支付名称--%>

                            <div class="clearfix m-t m-b fzcs">
                                <b class="pull-left col-sm-3 al-right line-hi34">存款渠道</b>
                                <div class="col-sm-5">
                                    <div>
                                        <label class="m-r-sm">
                                            <input type="checkbox" class="i-checks" name="isDepositCompanyAll${feeOrReturn}"
                                            ${command.result.isDepositCompanyAll?'checked':''}>
                                                所有公司入款
                                        </label>
                                    </div>
                                    <div class="div_bank" style="display: ${command.result.isDepositCompanyAll?'none':'block'};">
                                        <input type="hidden" class="i-checks" name="depositCompanyBank${feeOrReturn}" value="${command.result.depositCompanyBank}">
                                        <label class="m-r-sm">
                                            <input type="checkbox" class="i-checks company_item" bank_item="company_item"
                                                   value="bank_pay"
                                                ${fn:contains(command.result.depositCompanyBank,'bank_pay')?'checked':''}>
                                                    银行直连
                                        </label>
                                        <c:forEach items="${command.thirdBankList}" var="bank">
                                            <label class="m-r-sm">
                                                <input type="checkbox" class="i-checks company_item" bank_item="company_item"
                                                     value="${bank.bankName}"
                                                    ${fn:contains(command.result.depositCompanyBank,bank.bankName)?'checked':''}>
                                                        ${dicts.common.bankname[bank.bankName]}
                                            </label>
                                        </c:forEach>
                                    </div>
                                </div>
                             </div>
                            <div class="clearfix m-t m-b fzcs">
                                <b class="pull-left col-sm-3 al-right line-hi34"></b>
                                <div class="col-sm-5">
                                    <div>
                                        <label class="m-r-sm">
                                            <input type="checkbox" class="i-checks" name="isDepositOnlineAll${feeOrReturn}"
                                            ${command.result.isDepositOnlineAll?'checked':''}>
                                                所有线上支付
                                        </label>
                                    </div>
                                    <div class="div_bank"  style="display: ${command.result.isDepositOnlineAll?'none':'block'};">
                                        <input type="hidden" class="i-checks" name="depositOnlineBank${feeOrReturn}" value="${command.result.depositOnlineBank}">
                                        <label class="m-r-sm">
                                            <input type="checkbox" class="i-checks online_item" bank_item="online_item"
                                                   value="bank_pay">
                                            银行账户
                                        </label>
                                        <c:forEach items="${command.thirdBankList}" var="bank">
                                            <label class="m-r-sm">
                                                <input type="checkbox" class="i-checks online_item" bank_item="online_item"
                                                       value="${bank.bankName}"
                                                    ${fn:contains(command.result.depositOnlineBank,bank.bankName)?'checked':''}>
                                                    ${dicts.common.bankname[bank.bankName]}
                                            </label>
                                        </c:forEach>
                                    </div>
                                </div>
                             </div>