<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--咨询-->
    <form:form id="advisory" action="${root}/player/view/news.html?search.playerId=${command.search.playerId}" method="post">
        <div class="search-list-container dataTables_wrapper" role="grid">
            <%@include file="NewsPartial.jsp"%>
        </div>
    </form:form>

<script>
    curl(["site/player/advisory/LoadAdvisory"], function (LoadAdvisory) {
        page.loadAdvisory = new LoadAdvisory();
    });
</script>