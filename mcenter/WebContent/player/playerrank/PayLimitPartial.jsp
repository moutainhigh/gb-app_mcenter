<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.po.VActivityMessage"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<%--渠道分为银行账户,第三方两个大类:产品确认,银行直接显示成银行直连/账户,第三方显示出支付名称--%>

                            <div class="clearfix m-t m-b fzcs">
                                <b class="pull-left col-sm-3 al-right line-hi34">存款渠道</b>
                                <div class="col-sm-5">
                                    <div>
                                        <label class="m-r-sm">
                                            <input type="checkbox" class="i-checks" name="result.isDepositCompanyAll"
                                            ${command.result.isDepositCompanyAll?'checked':''}
                                                    &nbsp;
                                            ${command.otherDepositPlayerRank.isDepositCompanyAll?'checked disabled':''}
                                            ${not empty command.otherDepositPlayerRank.depositCompanyBank?'disabled':''}>
                                                所有公司入款
                                        </label>
                                    </div>
                                    <div id="div_company_bank" style="display: ${command.result.isDepositCompanyAll?'none':'block'};">
                                        <input type="hidden" class="i-checks" name="result.depositCompanyBank" value="${command.result.depositCompanyBank}">
                                        <label class="m-r-sm">
                                            <input type="checkbox" class="i-checks company_item" bank_item="company_item" name="" value="bank_pay"
                                                ${fn:contains(command.result.depositCompanyBank,'bank_pay')?'checked':''}
                                                    &nbsp;
                                                ${fn:contains(command.otherDepositPlayerRank.depositCompanyBank,'bank_pay')?'disabled checked':''}>
                                                    银行直连
                                        </label>
                                        <c:forEach items="${command.thirdBankList}" var="bank">
                                            <label class="m-r-sm">
                                                <input type="checkbox" class="i-checks company_item" bank_item="company_item" name="" value="${bank.bankName}"
                                                    ${fn:contains(command.result.depositCompanyBank,bank.bankName)?'checked':''}
                                                       &nbsp;
                                                    ${fn:contains(command.otherDepositPlayerRank.depositCompanyBank,bank.bankName)?'disabled checked':''}>
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
                                            <input type="checkbox" class="i-checks" name="result.isDepositOnlineAll"
                                            ${command.result.isDepositOnlineAll?'checked':''}
                                                   &nbsp;
                                            ${command.otherDepositPlayerRank.isDepositOnlineAll?'checked disabled':''}
                                            ${not empty command.otherDepositPlayerRank.depositOnlineBank?'disabled':''}>
                                                所有线上支付
                                        </label>
                                    </div>
                                    <div id="div_online_bank"  style="display: ${command.result.isDepositOnlineAll?'none':'block'};">
                                        <input type="hidden" class="i-checks" name="result.depositOnlineBank" value="${command.result.depositOnlineBank}">
                                        <label class="m-r-sm">
                                            <input type="checkbox" class="i-checks online_item" bank_item="online_item" name="" value="bank_pay">
                                            银行账户
                                        </label>
                                        <c:forEach items="${command.thirdBankList}" var="bank">
                                            <label class="m-r-sm">
                                                <input type="checkbox" class="i-checks online_item" bank_item="online_item" name="" value="${bank.bankName}"
                                                    ${fn:contains(command.result.depositOnlineBank,bank.bankName)?'checked':''}
                                                       &nbsp;
                                                    ${fn:contains(command.otherDepositPlayerRank.depositOnlineBank,bank.bankName)?'disabled checked':''}>
                                                    ${dicts.common.bankname[bank.bankName]}
                                            </label>
                                        </c:forEach>
                                    </div>
                                </div>
                             </div>