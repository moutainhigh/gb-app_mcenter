<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.VActivityMessageListListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<style type="text/css">
    .input-text{
        height: 30px;
        padding: 5px 12px;
        font-size: 14px;
    }
</style>
<div class="clearfix m-t-md">
    <label class="ft-bold col-sm-3 al-right line-hi34">${views.operation_auto['每天开放时段']}：</label>
    <div class="col-sm-9">
        <div class="tab-content" id="open-period-div" style="width: 820px">
            <table class="table border" id="open_period" style="width: 820px">
                <tr>
                    <td class="bg-gray ft-bold" style="width: 80px">${views.operation_auto['时段']}</td>
                    <td class="bg-gray ft-bold" style="width: 330px;">${views.operation_auto['开始时间']}</td>
                    <td class="bg-gray ft-bold" style="width: 330px">${views.operation_auto['结束时间']}</td>
                    <td class="bg-gray ft-bold">${views.common['operate']}</td>
                </tr>
                <c:if test="${not empty periodListVo.result}">
                    <c:forEach var="period" items="${periodListVo.result}" varStatus="vs">
                        <tr class="fd">
                            <td>
                                    ${views.operation_auto['时段']}${vs.index+1}
                            </td>
                            <td>
                                <gb:select name="moneyOpenPeriods[${vs.index}].startTimeHour" list="${hourList}" value="${period.startTimeHour}" callback="validateOpenPeriod"  />
                                ：
                                <gb:select name="moneyOpenPeriods[${vs.index}].startTimeMinute" list="${minutesList}" value="${period.startTimeMinute}" callback="validateOpenPeriod"  />
                            </td>
                            <td>
                                <gb:select name="moneyOpenPeriods[${vs.index}].endTimeHour" list="${hourList}" value="${period.endTimeHour}" callback="validateOpenPeriod"  />
                                ：
                                <gb:select name="moneyOpenPeriods[${vs.index}].endTimeMinute" list="${minutesList}" value="${period.endTimeMinute}" callback="validateOpenPeriod"  />

                            </td>
                            <td>
                                <soul:button target="deleteTableRow" text="" opType="function" cssClass="btn pull-left">
                                    <span class="hd">${views.common['delete']}</span>
                                </soul:button>
                            </td>
                        </tr>
                    </c:forEach>

                </c:if>
                <c:if test="${empty periodListVo.result}">
                    <tr class="fd">
                        <td>
                                ${views.operation_auto['时段']}1
                        </td>
                        <td>
                            <gb:select name="moneyOpenPeriods[0].startTimeHour" list="${hourList}" callback="validateOpenPeriod"  />
                            ：
                            <gb:select name="moneyOpenPeriods[0].startTimeMinute" list="${minutesList}" callback="validateOpenPeriod"  />
                        </td>
                        <td>
                            <gb:select name="moneyOpenPeriods[0].endTimeHour" list="${hourList}" callback="validateOpenPeriod"  />
                            ：
                            <gb:select name="moneyOpenPeriods[0].endTimeMinute" list="${minutesList}" callback="validateOpenPeriod"  />
                        </td>
                        <td>
                            <soul:button target="deleteTableRow" text="" opType="function" cssClass="btn pull-left">
                                <span class="hd">${views.common['delete']}</span>
                            </soul:button>
                        </td>
                    </tr>
                </c:if>
            </table>
            <table style="width: 820px">
                <tr><td style="width: 100%;">
                    <soul:button target="addOpenPeriod" text="" opType="function" cssClass="btn btn-info btn-addon pull-right">
                        <span class="hd">${views.common['create']}</span>
                    </soul:button>
                </td></tr>
            </table>
        </div>

    </div>
</div>
<div class="clearfix m-t-md">
    <label class="ft-bold col-sm-3 al-right line-hi34">${views.operation_auto['是否条件限制']}：</label>
    <div class="col-sm-9">
        <label class="ft-bold al-left line-hi34">
            <input type="radio" name="activityRule.conditionType" value="1" class="has-condition-radio"
                   <c:if test="${empty activityRule.conditionType || activityRule.conditionType=='1'}">checked</c:if> >单次存款金额
        </label>
        <label class="ft-bold al-left line-hi34">
            <input type="radio" name="activityRule.conditionType" value="2" class="has-condition-radio"
                   <c:if test="${activityRule.conditionType=='2'}">checked</c:if> >累计存款金额
        </label>
        <label class="ft-bold al-left line-hi34">
            <input type="radio" name="activityRule.conditionType" value="3" class="has-condition-radio"
                   <c:if test="${activityRule.conditionType=='3'}">checked</c:if>>${views.operation_auto['无条件限制']}
        </label>
        <div class="tab-content" id="money_condition-div" style="width: 553px">
            <table class="table border ${activityRule.conditionType=='3'?'hide':''}" style="width: 550px" id="money_condition">
                <tr>
                    <td class="bg-gray ft-bold" style="width: 150px">
                        <div id="deposit_type_title">
                            <c:if test="${activityRule.conditionType=='1'}">${views.operation_auto['单次存款金额']}</c:if>
                            <c:if test="${activityRule.conditionType=='2'}">累计存款金额</c:if>
                        </div>

                    </td>
                    <td class="bg-gray ft-bold" style="width: 160px;">
                        ${views.operation_auto['时段累计有效投注额']}
                    </td>
                    <td class="bg-gray ft-bold" style="width: 150px">
                        ${views.operation_auto['抽奖次数']}
                    </td>
                    <td class="bg-gray ft-bold">${views.common['operate']}</td>
                </tr>
                <c:if test="${not empty conditionListVo.result}">
                    <c:forEach var="con" items="${conditionListVo.result}" varStatus="vs">
                        <tr>

                            <td>${views.operation_auto['满']}<input type="number" onmousewheel="return false" class="input-text condition-input-txt" name="moneyConditions[${vs.index}].singleDepositAmount" value="<fmt:formatNumber value='${con.singleDepositAmount}' pattern='#.##' minFractionDigits='2'></fmt:formatNumber>" style="width: 80px;">${views.operation_auto['以上']}</td>
                            <td>${views.operation_auto['达']}<input type="number" onmousewheel="return false" class="input-text condition-input-txt" name="moneyConditions[${vs.index}].effectiveAmount" value="<fmt:formatNumber value='${con.effectiveAmount}' pattern='#.##' minFractionDigits='2'></fmt:formatNumber>" style="width: 80px"></td>
                            <td><input type="number" onmousewheel="return false" class="input-text condition-input-txt" name="moneyConditions[${vs.index}].betCount" value="${con.betCount}" style="width: 80px">${views.operation_auto['次']}</td>
                            <td>
                                <soul:button target="deleteTableRow" text="" opType="function" cssClass="btn pull-left">
                                    <span class="hd">${views.common['delete']}</span>
                                </soul:button>

                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
                <c:if test="${empty conditionListVo.result}">
                    <c:forEach begin="0" end="2" varStatus="vs">
                        <tr>
                            <td>${views.operation_auto['满']}<input type="number" onmousewheel="return false" class="input-text condition-input-txt" name="moneyConditions[${vs.index}].singleDepositAmount" style="width: 80px;">${views.operation_auto['以上']}</td>
                            <td>${views.operation_auto['达']}<input type="number" onmousewheel="return false" class="input-text condition-input-txt" name="moneyConditions[${vs.index}].effectiveAmount" style="width: 80px"></td>
                            <td><input type="number" onmousewheel="return false" class="input-text condition-input-txt" name="moneyConditions[${vs.index}].betCount" style="width: 80px">${views.operation_auto['次']}</td>
                            <td>
                                <soul:button target="deleteTableRow" text="" opType="function" cssClass="btn pull-left">
                                    <span class="hd">${views.common['delete']}</span>
                                </soul:button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
            </table>
            <table class="${activityRule.conditionType=='3'?'hide':''}" style="width: 550px" id="money_condition_add_btn"><tr><td>
                <soul:button target="addCondition" text="" opType="function" cssClass="btn btn-info btn-addon pull-right">
                    <span class="hd">${views.common['create']}</span>
                </soul:button>
            </td></tr></table>
        </div>
    </div>

</div>
<div class="clearfix m-t-md ${empty activityRule.conditionType||activityRule.conditionType!='3'?'hide':''}" id="betCountMaxLimit_div">
    <label class="ft-bold col-sm-3 al-right line-hi34"></label>
    <div class="col-sm-9">
        <div class="tab-content table-responsive">
            ${views.operation_auto['每次开放抽奖，单个玩家抽奖上限']}
            <input type="number" onmousewheel="return false" class="input-text" name="activityRule.betCountMaxLimit" style="width: 80px" maxlength="2" id="bet_count" value="${activityRule.betCountMaxLimit}" />
            ${views.operation_auto['次']}
        </div>
    </div>
</div>
<div class="clearfix m-t-md">
    <label class="ft-bold col-sm-3 al-right line-hi34">
        ${views.operation_auto['奖项设置']}：</label>
    <div class="col-sm-9">
        <%--先到先得，抢完为止：
        <label class="ft-bold al-left line-hi34">
            <input type="radio" name="activityRule.awardsRulesType" value="1" class="has-condition-radio"
                   <c:if test="${activityRule.awardsRulesType=='1'}">checked</c:if> >是
        </label>
        <label class="ft-bold al-left line-hi34">
            <input type="radio" name="activityRule.awardsRulesType" value="0" class="has-condition-radio"
                   <c:if test="${empty activityRule.awardsRulesType || activityRule.awardsRulesType=='0'}">checked</c:if> >否
        </label>--%>
        <div class="tab-content table-responsive">
            <table class="table border" style="width: 720px" id="awards_rules">
                <tr>
                    <td class="bg-gray ft-bold" style="width: 150px">${views.operation_auto['金额']}</td>
                    <td class="bg-gray ft-bold" style="width: 160px;">${views.operation_auto['优惠稽核']}</td>
                    <td class="bg-gray ft-bold" style="width: 150px">${views.operation_auto['名额']}</td>
                    <td class="bg-gray ft-bold" style="width: 160px">${views.operation_auto['中奖概率']}</td>
                    <c:if test="${not empty rulesListVo.result}">
                        <td class="bg-gray ft-bold" style="width: 150px">${messages.operation_auto['剩余名额']}</td>
                    </c:if>
                    <td class="bg-gray ft-bold">${views.common['operate']}</td>
                </tr>
                <c:if test="${not empty rulesListVo.result}">
                    <c:forEach var="rule" items="${rulesListVo.result}" varStatus="vs">
                        <tr>

                            <td>${siteCurrencySign}<input type="number" onmousewheel="return false" class="input-text award_rule_amount" name="moneyAwardsRules[${vs.index}].amount" value="<fmt:formatNumber value='${rule.amount}' pattern='#.##' minFractionDigits='2'></fmt:formatNumber>" style="width: 80px"></td>
                            <td><input type="number" onmousewheel="return false" class="input-text" name="moneyAwardsRules[${vs.index}].audit" value="${rule.audit}" style="width: 80px">${views.operation_auto['倍']}</td>
                            <td>
                                <span name="moneyAwardsRules[${vs.index}].showQuantity">${rule.quantity}</span>
                                <input type="hidden" class="input-text readonly1" name="moneyAwardsRules[${vs.index}].quantity" value="${rule.quantity}" style="width: 80px;" readonly="true">${views.operation_auto['个']}
                                <input type="hidden" name="moneyAwardsRules[${vs.index}].oldQuantity" value="${rule.quantity}">
                                <input type="hidden" name="moneyAwardsRules[${vs.index}].id" value="${rule.id}">
                            </td>
                            <td><input type="number" onmousewheel="return false" class="input-text awards-rules-input-pro" name="moneyAwardsRules[${vs.index}].probability" value="${rule.probability}" style="width: 80px">%</td>
                            <td>
                                <input type="number" onmousewheel="return false" class="input-text remain-count-txt" name="moneyAwardsRules[${vs.index}].remainCount" value="${rule.remainCount}" style="width: 80px">
                                <input type="hidden" name="moneyAwardsRules[${vs.index}].oldRemainCount" value="${rule.remainCount}">
                            </td>
                            <td>
                                <soul:button target="deleteTableRow" text="" opType="function" cssClass="btn pull-left">
                                    <span class="hd">${views.common['delete']}</span>
                                </soul:button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
                <c:if test="${empty rulesListVo.result}">
                    <c:forEach var="rules" begin="0" end="2" varStatus="vs">
                        <tr>
                            <td>
                                    ${siteCurrencySign}<input type="number" onmousewheel="return false" class="input-text award_rule_amount" name="moneyAwardsRules[${vs.index}].amount" style="width: 80px">
                            </td>
                            <td><input type="number" onmousewheel="return false" class="input-text" name="moneyAwardsRules[${vs.index}].audit" style="width: 80px">${views.operation_auto['倍']}</td>
                            <td><input type="number" onmousewheel="return false" class="input-text" name="moneyAwardsRules[${vs.index}].quantity" style="width: 80px">${views.operation_auto['个']}</td>
                            <td><input type="number" onmousewheel="return false" class="input-text awards-rules-input-pro" name="moneyAwardsRules[${vs.index}].probability" style="width: 80px">%</td>
                            <td>
                                <soul:button target="deleteTableRow" text="" opType="function" cssClass="btn pull-left">
                                    <span class="hd">${views.common['delete']}</span>
                                </soul:button>

                            </td>
                        </tr>
                    </c:forEach>

                </c:if>
            </table>
            <table style="width: 720px"><tr><td>
                <soul:button target="addAwardsRule" text="" opType="function" cssClass="btn btn-info btn-addon pull-right">
                    <span class="hd">${views.common['create']}</span>
                </soul:button>
            </td></tr></table>
            <div style="width: 720px;"><span id="izjgl" class="pull-right" style="height: 34px;width: 250px;padding: 5px 2px;"></span></div>
        </div>
    </div>

</div>
