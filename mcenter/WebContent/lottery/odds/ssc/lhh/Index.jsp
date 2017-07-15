<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="dataTables_wrapper" role="grid">
    <a href="javascript:void(0)" play="lhh" betCode="five_sum" page="all">${views.lottery_auto['总和']}</a>
    <a href="javascript:void(0)" play="lhh" betCode="dragon_tiger_tie" page="lhh">${views.lottery_auto['龙虎和']}</a>
</div>

<script src="${resRoot}/js/lottery/odds/getSubPage.js?v=${rcVersion}"></script>