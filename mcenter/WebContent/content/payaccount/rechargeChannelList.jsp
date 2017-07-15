<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html lang="zh-CN">
<head>
    <title>${views.common['edit']}</title>
    <%@ include file="/include/include.head.jsp" %>
    <!-- Gritter -->
    <link href="${resComRoot}/themes/${curTheme}/style.css" rel="stylesheet">
    <link href="${resComRoot}/themes/${curTheme}/content.css" rel="stylesheet">
</head>
<body>
<!--编辑弹窗-->
<form:form id="editForm" action="${root}/player/updateUserPlayerAndPlayerTag.html" method="post">
    <div class="li-tag clearfix">
        <C:forEach var="p" items="${rechargeChannelList}">
            <soul:button target="payChannelCode" opType="function" post="${p.code}" cssClass="code" text="${dicts.common.channel[p.code]}" ></soul:button>
        </C:forEach>
    </div>
    <!--标签选择弹窗-->
</form:form>

</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/content/payaccount/rechargeChannelList"/>
</html>
