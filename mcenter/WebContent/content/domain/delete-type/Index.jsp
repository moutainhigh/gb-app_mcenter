<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-8-15
  Time: 下午1:26
--%>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.CttDomainTypeListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<%----%>
    <form:form action="${root}/content/cttDomain/type/list.html">
        <div id="editable_wrapper" class="search-list-container" role="grid">
            <%@ include file="IndexPartial.jsp" %>
        </div>
    </form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/content/domain/type/Index"/>
</html>
