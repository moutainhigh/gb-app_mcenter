<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${views.role['player.view.funds.viewMore']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<!--资金查看更多-->
<div class="modal-body">
    <form:form action="${root}/playerFunds/moreFunds.html" method="post">
        <div class="search-list-container">
            <%@include file="MoreFundsPartial.jsp" %>
        </div>
    </form:form>
</div>
</body>
<%@ include file="/include/include.js.jsp" %>
<script type="text/javascript">
    curl(['common/BaseListPage'], function(Page) {
        page = new Page(null, "form");
    });
</script>
</html>