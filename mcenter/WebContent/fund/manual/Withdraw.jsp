<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<!--人工取出-->
<form>
<div class="panel-body p-sm">
    <div id="validateRule" style="display: none">${validateRule}</div>
    <gb:token></gb:token>
    <table class="table no-border table-desc-list">
        <tbody>
        <tr>
            <th scope="row" class="text-right">${views.fund['玩家账号：']}</th>
            <td>
                <div class="table-desc-right-t" style="display: block;width:25%;">
                    <input type="text" class="form-control nope" name="username" value="${username}" autocomplete="off"/>
                </div>
            </td>
        </tr>
        <tr>
            <th scope="row" class="text-right">${views.fund['钱包余额：']}</th>
            <td class="money">
                <span class="fs16"><span id="integerMoney"></span><i id="decimalsMoney"></i></span>
            </td>
        </tr>
        <tr>
            <th scope="row" class="text-right">${views.fund['取款金额：']}</th>
            <td>
                <input type="text" class="form-control" name="result.withdrawAmount" style="width:25%;">
            </td>
        </tr>
        <tr>
            <th scope="row" class="text-right">${views.fund['类型：']}</th>
            <td>
                <select name="result.withdrawType" class="btn-group chosen-select-no-single">
                    <c:forEach items="${withdrawType}" var="i">
                        <option value="${i.dictCode}">${dicts.fund.recharge_type[i.dictCode]}</option>
                    </c:forEach>
                </select>
                <span class="right-flo co-grayc2" style="display: none" id="spanTips">${views.fund['该笔资金记录不对玩家展示']}</span>
            </td>
        </tr>
        <tr>
            <th scope="row" class="text-right">${views.fund['稽核：']}</th>
            <td>
                <div class="line-hi34 min-w" style="width: 600px;">
                    <label><input type="checkbox" value="true" name="result.isClearAudit">${views.fund['清除稽核点']}</label>
                    <span tabindex="0" class=" help-popover" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top" data-html="true" data-content="${views.fund_auto['清除稽核点后']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
                </div>
            </td>
        </tr>
        <tr>
            <th scope="row" class="text-right" style="vertical-align: top;">${views.fund['备注：']}</th>
            <td>
                <textarea class="form-control width-response" maxlength="200" name="result.checkRemark" rows="4"></textarea>
            </td>
        </tr>
        <tr>
            <th></th>
            <td>
                <div class="btn-groups text-left">
                    <soul:button precall="validateForm" target="submit" callback="back" msg="${views.fund_auto['确认提交']}？" text="${views.fund_auto['确定']}" opType="function" cssClass="btn btn-filter p-x-lg m-r-md enter-submit"></soul:button>
                </div>
            </td>
        </tr>
        <a style="display: none;" id="withdraw" href="/fund/manual/index.html?type=withdraw"/>
        </tbody>
    </table>
</div>
</form>
<script type="text/javascript">
    curl(['site/fund/manual/Withdraw'], function(Withdraw) {
        page.withdraw = new Withdraw();
        page.withdraw.bindButtonEvents();
    });
</script>