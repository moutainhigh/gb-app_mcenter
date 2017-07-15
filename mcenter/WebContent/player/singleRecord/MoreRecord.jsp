<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${views.role['player.view.singleRecord.viewMore']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<!--交易查看更多-->
<div class="modal-body">
    <form action="${root}/playerSingleRecord/moreRecord.html" method="post">
        <div class="search-list-container">
            <%@include file="MoreRecordPartial.jsp"%>
        </div>
    </form>
</div>
</body>
<%@ include file="/include/include.js.jsp" %>
<script type="text/javascript">
    curl(['common/BaseListPage'], function(Page) {
        page = new Page(null, "form");
    });
</script>
</html>