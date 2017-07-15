<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-6-30
  Time: 上午8:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body id="mainFrame">
    <form action="${root}/vPlayerTag/list.html">
        <div class="modal-body">
            <div class="search-list-container">
                <%@ include file="IndexPartial.jsp"%>
            </div>
        </div>
        <%--<div class="modal-footer">
            <soul:button target="closePage" cssClass="btn btn-filter" text="${views.common.OK}" opType="function"></soul:button>
            <soul:button target="closePage" cssClass="btn btn-outline btn-filter" text="${views.common.cancel}" opType="function"></soul:button>
        </div>--%>
    </form>
</body>
<%@ include file="/include/include.js.jsp" %>

<soul:import res="site/player/player/tag/PlayerTagManage"/>
</html>
