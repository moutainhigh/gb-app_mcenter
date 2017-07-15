<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="detect-title m-l-n m-r-n">${views.fund['playerDetect.view.transationRecord']}</div>
<ul>
    <li><b>${views.fund['playerDetect.view.accumulateTransation']}：</b><span
            class="pull-right">${gameOrderMap.transction}</span></li>
    <li><b>${views.fund['playerDetect.view.accumulateEffectiveTransation']}：</b><span
            class="pull-right">${gameOrderMap.effective}</span></li>
    <li><b>${views.fund['playerDetect.view.profitAndLossAmount']}：</b><span
            class="pull-right co-green">${gameOrderMap.profit}</span></li>
    <%--<li><b>${views.fund['playerDetect.view.profitAndLossRanking']}：</b><span
            class="pull-right co-green">${gameOrderMap.rank}</span></li>--%>
</ul>
