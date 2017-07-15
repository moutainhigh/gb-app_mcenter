<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${views.role['player.view.funds.viewMore']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<!--咨询查看更多-->
<div class="modal-body">
    <form:form action="${root}/player/moreAdvisoryReply.html?search.playerAdvisoryId=${command.search.playerAdvisoryId}" method="post">
        <div class="search-list-container">
            <%@include file="MoreAdvisoryReplyPartial.jsp" %>
        </div>
    </form:form>
</div>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/advisory/LoadAdvisory"/>
</html>
