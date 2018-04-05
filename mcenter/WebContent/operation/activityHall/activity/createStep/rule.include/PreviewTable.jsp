<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.VActivityMessageListListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<%--预览页面优惠条件表格--%>
<!--    盈亏送-->
<c:if test="${activityType.result.code eq 'profit_loss'}">
    <table class="table table-bordered" id="previewprofit">
        <tr>
            <th>${views.operation['Activity.rule']}</th>
            <th colspan="2">${views.operation['Activity.step.offerForm']}</th>
        </tr>
        <tr>
            <td>${views.operation['Activity.step.profit']}</td>
            <td>${views.operation['Activity.step.caijin']}${siteCurrency}</td>
            <td>${views.operation['Activity.step.audit']}</td>
        </tr>
    </table>
    <hr/>
    <table class="table table-bordered" id="previewloss">
        <tr>
            <th>${views.operation['Activity.rule']}</th>
            <th colspan="2">${views.operation['Activity.step.offerForm']}</th>
        </tr>
        <tr>
            <td>${views.operation['Activity.step.loss']}</td>
            <td>${views.operation['Activity.step.caijin']}${siteCurrency}</td>
            <td>${views.operation['Activity.step.audit']}</td>
        </tr>
    </table>
</c:if>
<!--    首存送 存就送-->
<c:if test="${ is123Deposit || activityType.result.code eq 'deposit_send'}">
    <table class="table  table-bordered" id="firstAndDeposit">
        <tr>
            <th>${views.operation['Activity.rule']}</th>
            <th colspan="2">${views.operation['Activity.step.offerForm']}</th>
        </tr>
    </table>
</c:if>
<!--    救济金-->
<c:if test="${activityType.result.code eq 'relief_fund'}">
    <table class="table table-bordered" id="reliefund">
        <tr>
            <th colspan="3">${views.operation['Activity.rule']}</th>
            <th colspan="2">${views.operation['Activity.step.offerForm']}</th>
        </tr>
        <tr>
            <td>${views.operation['Activity.step.effectiveVolume']}</td>
            <td>${views.operation['Activity.step.totalAssets']}</td>
            <td>${views.operation['Activity.step.lossAmount']}</td>
            <td>${views.operation['Activity.step.caijin']}${siteCurrency}</td>
            <td>${views.operation['Activity.step.audit']}</td>
        </tr>
    </table>
</c:if>
<!--    注册送-->
<c:if test="${activityType.result.code eq 'regist_send'}">
    <table class="table table-bordered">
        <tr>
            <th colspan="2">${views.operation['Activity.step.offerForm']}</th>
        </tr>
        <tr>
            <td>${views.operation['Activity.step.caijin']}${siteCurrency}</td>
            <td>${views.operation['Activity.step.audit']}</td>
        </tr>
        <tr>
            <td id="registSendCaijin"></td>
            <td id="registSendJihe"></td>
        </tr>
    </table>
</c:if>
<!--    有效交易量-->
<c:if test="${activityType.result.code eq 'effective_transaction'}">
<table class="table table-bordered" id="effectiveTr">
    <tr>
        <th>${views.operation['Activity.rule']}</th>
        <th colspan="2">${views.operation['Activity.step.offerForm']}</th>
    </tr>
    <tr>
        <td>${views.operation['Activity.step.totalTransaction']}</td>
        <td>${views.operation['Activity.step.caijin']}${siteCurrency}</td>
        <td>${views.operation['Activity.step.audit']}</td>
    </tr>
</table>
</c:if>
<c:if test="${activityType.result.code eq 'money'}">
    <div class="clearfix m-t-md">
        <div class="col-sm-9">
            <label class="ft-bold al-right line-hi34">${views.operation_auto['每天开放时段']}：</label>
            <div class="tab-content table-responsive">
                <table class="table border" id="preview_open_period">
                    <tr>
                        <td class="bg-gray ft-bold">${views.operation_auto['时段']}</td>
                        <td class="bg-gray ft-bold" >${views.operation_auto['开始时间']}</td>
                        <td class="bg-gray ft-bold">${views.operation_auto['结束时间']}</td>
                    </tr>
                    <c:if test="${empty profitPreferential}">
                        <tr class="fd">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                    </c:if>
                </table>
            </div>

        </div>
    </div>
    <div class="clearfix m-t-md">
        <div class="col-sm-9">
            <label class="ft-bold al-right line-hi34">${views.operation_auto['优惠条件']}：</label>
            <div class="tab-content table-responsive">
                <table class="table border" id="preview_money_condition">
                    <tr>
                        <td class="bg-gray ft-bold">
                            <span id="condition_type_1">${views.operation_auto['单次存款金额']}</span>
                            <span id="condition_type_2" style="display: none">${views.content_auto['累计存款金额']}</span>

                        </td>
                        <td class="bg-gray ft-bold" >${views.operation_auto['时段累计有效投注额']}</td>
                        <td class="bg-gray ft-bold">${views.operation_auto['抽奖次数']}</td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <div class="clearfix m-t-md">
        <div class="col-sm-9" id="preview_bet_count_div">
            <div class="tab-content table-responsive">
                    ${views.operation_auto['每次开放抽奖，单个玩家抽奖上限']}
                <span style="width: 50px;border: 1px solid #e6e6e6;padding: 0 8px;" id="preview_bet_count">  </span>
                ${views.operation_auto['次']}
            </div>
        </div>
    </div>
    <div class="clearfix m-t-md">
        <div class="col-sm-9">
            <label class="ft-bold al-right line-hi34">
                ${views.operation_auto['奖项设置']}：</label>
            <div class="tab-content table-responsive">
                <table class="table border" id="preview_awards_rules">
                    <tr>
                        <td class="bg-gray ft-bold">${views.operation_auto['金额']}</td>
                        <td class="bg-gray ft-bold">${views.operation_auto['名额']}</td>
                        <td class="bg-gray ft-bold">${views.operation_auto['总名额']}</td>
                        <td class="bg-gray ft-bold">${views.operation_auto['红包总金额']}</td>
                        <td class="bg-gray ft-bold" >${views.operation_auto['优惠稽核']}</td>
                        <td class="bg-gray ft-bold">${views.operation_auto['中奖概率']}</td>
                        <c:if test="${not empty activityMessageVo.result.id}">
                            <td class="bg-gray ft-bold">${views.operation_auto['时段剩余名额']}</td>
                        </c:if>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <c:if test="${not empty activityMessageVo.result.id}">
                            <td></td>
                        </c:if>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</c:if>
<!--//endregion your codes 1-->

