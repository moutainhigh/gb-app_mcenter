<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.VActivityMessageListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<!--//region your codes 3-->
<div id="steps">
    <form>
        <div id="validateRule" style="display: none">${validateRule}</div>
        <input id="code" type="hidden" name="result.code" value="${activityType.result.code}">
        <input id="name" type="hidden" name="result.name" value="${activityType.result.name}">
        <input type="hidden" id="introduce" name="result.introduce" value="${activityType.result.introduce}">
        <input type="hidden" name="result.logo" value="${activityType.result.logo}">
        <input id="activityMessageId" type="hidden" name="activityMessageId" value="${activityMessageVo.result.id}">
        <input id="states" type="hidden" name="states" value="${activityMessageVo.states}">
        <gb:token/>

        <jsp:include page="ActivityContent.jsp"/>
        <c:if test="${activityType.result.code ne 'content'}">
            <jsp:include page="ActivityRule.jsp"/>
        </c:if>
        <jsp:include page="ActivityPreview.jsp"/>
        <jsp:include page="ActivityRelease.jsp"/>
    </form>
    <table id="hidden_open_period" style="display: none;">
        <tr class="fd">
            <td>

            </td>
            <td>
                <gb:select name="moneyOpenPeriods[{n}].startTimeHour" list="${hourList}" callback="validateOpenPeriod"  />
                ：
                <gb:select name="moneyOpenPeriods[{n}].startTimeMinute" list="${minutesList}" callback="validateOpenPeriod" />
            </td>
            <td>
                <gb:select name="moneyOpenPeriods[{n}].endTimeHour" list="${hourList}" callback="validateOpenPeriod" />
                ：
                <gb:select name="moneyOpenPeriods[{n}].endTimeMinute" list="${minutesList}" callback="validateOpenPeriod" />
            </td>
            <td>
                <soul:button target="deleteTableRow" text="" opType="function" cssClass="btn pull-left">
                    <span class="hd">${views.common['delete']}</span>
                </soul:button>
            </td>
        </tr>
    </table>
    <table id="hidden_money_condition" style="display: none;">
        <tr>
            <td>${views.operation_auto['满']}<input type="number" class="input-text condition-input-txt" name="moneyConditions[{n}].singleDepositAmount" style="width: 80px">${views.operation_auto['以上']}</td>
            <td>${views.operation_auto['达']}<input type="number" class="input-text condition-input-txt" name="moneyConditions[{n}].effectiveAmount" style="width: 80px"></td>
            <td><input type="number" class="input-text condition-input-txt" name="moneyConditions[{n}].betCount" style="width: 80px">${views.operation_auto['次']}</td>
            <td>
                <soul:button target="deleteTableRow" text="" opType="function" cssClass="btn pull-left">
                    <span class="hd">${views.common['delete']}</span>
                </soul:button>
            </td>
        </tr>
    </table>
    <table id="hidden_awards_rules" style="display: none;">
        <tr>
            <td>
                ${siteCurrencySign}<input type="number" class="input-text award_rule_amount" name="moneyAwardsRules[{n}].amount" style="width: 80px">
            </td>
            <td><input type="number" class="input-text" name="moneyAwardsRules[{n}].audit" style="width: 80px">${views.operation_auto['倍']}</td>
            <td><input type="number" class="input-text" name="moneyAwardsRules[{n}].quantity" style="width: 80px">${views.operation_auto['个']}</td>

            <td><input type="number" class="input-text awards-rules-input-pro" name="moneyAwardsRules[{n}].probability" style="width: 80px">%</td>
            <c:if test="${not empty rulesListVo.result}">
                <td></td>
            </c:if>
            <td>
                <soul:button target="deleteTableRow" text="" opType="function" cssClass="btn pull-left">
                    <span class="hd">${views.common['delete']}</span>
                </soul:button>
            </td>
        </tr>
    </table>
</div>
<soul:import res="site/operation/activity/ActivityContent"/>
<!--//endregion your codes 4-->
