<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form name="fundsForm">
    <input type="hidden" value="${command.search.playerId}" name="search.playerId"/>
    <!--资金-->
    <div class="apiScare">
        <%@include file="../funds/ApiScare.jsp"%>
       <%-- <p style="text-align:center"><img src="${resRoot}/images/022b.gif"></p>--%>
    </div>
    <hr class="m-b-sm m-t">
    <div class="transaction">
        <%@include file="../funds/IndexPartial.jsp" %>
    </div>
</form>
<script>
    curl(["site/player/funds/Funds"], function (Funds) {
        page.funds = new Funds();
        page.funds.bindButtonEvents();
    });
</script>
