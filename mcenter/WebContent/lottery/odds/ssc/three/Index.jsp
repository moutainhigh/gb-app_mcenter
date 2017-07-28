<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="dataTables_wrapper" role="grid">
    <a href="javascript:void(0)" play="three" betCode="ten_thousand_thousand_hundred" page="num">${views.lottery_auto['万仟佰']}</a>
    <a href="javascript:void(0)" play="three" betCode="ten_thousand_thousand_ten" page="num">${views.lottery_auto['万仟拾']}</a>
    <a href="javascript:void(0)" play="three" betCode="ten_thousand_thousand_one" page="num">${views.lottery_auto['万仟个']}</a>
    <a href="javascript:void(0)" play="three" betCode="ten_thousand_hundred_ten" page="num">${views.lottery_auto['万百十']}</a>
    <a href="javascript:void(0)" play="three" betCode="ten_thousand_ten_one" page="num">${views.lottery_auto['万十个']}</a>
    <a href="javascript:void(0)" play="three" betCode="thousand_hundred_ten" page="num">${views.lottery_auto['仟佰拾']}</a>
    <a href="javascript:void(0)" play="three" betCode="thousand_hundred_one" page="num">${views.lottery_auto['仟佰个']}</a>
    <a href="javascript:void(0)" play="three" betCode="thousand_ten_one" page="num">${views.lottery_auto['仟拾个']}</a>
    <a href="javascript:void(0)" play="three" betCode="hundred_ten_one" page="num">${views.lottery_auto['佰拾个']}</a>
    <%--<a href="javascript:void(0)" betCode="ten_thousand_hundred">${views.lottery_auto['前三三字组合']}</a>--%>
    <%--<a href="javascript:void(0)" betCode="ten_thousand_hundred">${views.lottery_auto['中三三字组合']}</a>--%>
    <%--<a href="javascript:void(0)" betCode="ten_thousand_hundred">${views.lottery_auto['后三三字组合']}</a>--%>

</div>
<div class="clearfix m-t-md">
    <div class="clearfix col-lg-10">
        <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm" style="padding-left: 0;">
            <div class="input-group date time-select-a">
                <span class="input-group-addon bg-gray">赔率</span>
                <input type="number" class="form-control" placeholder="" id="defaultValue">
                <span class="input-group-addon time-select-btn">
                    <soul:button cssClass="btn btn-filter btn-outline batch-update-value" target="batchUpdateValue" text="${views.lottery_auto['批量调整']}" opType="function" tag="button"></soul:button>
                    <%--<a type="button" class="btn btn-filter btn-outline"><span class="hd">批量调整</span></a>--%>
                </span>
            </div>
        </div>
    </div>
    <div class="col-lg-2"><div class="form-group clearfix m-b-none">
        <soul:button tag="button" cssClass="btn btn-filter pull-right" text="${views.lottery_auto['确认修改']}" opType="function" target="saveLotteryOdd"/>
    </div></div>
</div>
<script src="${resRoot}/js/lottery/odds/getSubPage.js?v=${rcVersion}"></script>