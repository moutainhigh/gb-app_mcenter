<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="dataTables_wrapper" role="grid">
    <a href="javascript:void(0)" play="two" betCode="ten_thousand_thousand" page="num">${views.lottery_auto['万仟']}</a>
    <a href="javascript:void(0)" play="two" betCode="ten_thousand_hundred" page="num">${views.lottery_auto['万佰']}</a>
    <a href="javascript:void(0)" play="two" betCode="ten_thousand_ten" page="num">${views.lottery_auto['万拾']}</a>
    <a href="javascript:void(0)" play="two" betCode="ten_thousand_one" page="num">${views.lottery_auto['万个']}</a>
    <a href="javascript:void(0)" play="two" betCode="thousand_hundred" page="num">${views.lottery_auto['仟佰']}</a>
    <a href="javascript:void(0)" play="two" betCode="thousand_ten" page="num">${views.lottery_auto['仟拾']}</a>
    <a href="javascript:void(0)" play="two" betCode="thousand_one" page="num">${views.lottery_auto['仟个']}</a>
    <a href="javascript:void(0)" play="two" betCode="hundred_ten" page="num">${views.lottery_auto['佰拾']}</a>
    <a href="javascript:void(0)" play="two" betCode="hundred_one" page="num">${views.lottery_auto['佰个']}</a>
    <a href="javascript:void(0)" play="two" betCode="ten_one" page="num">${views.lottery_auto['拾个']}</a>
  <%--  <a href="javascript:void(0)" play="two" betCode="two_first_three" page="num">${views.lottery_auto['前三二字组合']}</a>
    <a href="javascript:void(0)" play="two" betCode="two_in_three" page="num">${views.lottery_auto['中三二字组合']}</a>
    <a href="javascript:void(0)" play="two" betCode="two_after_three" page="num">${views.lottery_auto['后三二字组合']}</a>--%>
</div>
<script src="${resRoot}/js/lottery/odds/getSubPage.js?v=${rcVersion}"></script>