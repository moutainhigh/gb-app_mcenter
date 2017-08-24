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

<script src="${resRoot}/js/lottery/odds/getSubPage.js?v=${rcVersion}"></script>