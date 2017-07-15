<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.reply.vo.PlayerAdvisoryReplyListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<html lang="zh-CN">
<head>
    <%@ include file="/include/include.head.jsp" %>
    <!--//region your codes 2-->

    <!--//endregion your codes 2-->
</head>
<body>

<form:form action="${root}${controller}/list.html" method="post">
    <div class="panel panel-default">
        <div class="panel-body">
            <!--//region your codes 3-->
            <div class="row">

                <div class="col-md-1">
                    <soul:button target="query" opType="function" text="${views.common['search']}" cssClass="btn btn-default" />
                </div>
                <div class="col-md-1">
                    <soul:button target="${root}${controller}/create.html" opType="dialog" text="${views.common['create']}" cssClass="btn btn-default" />
                </div>
            </div>

            <br/>
            <div class="search-list-container">
                <%@ include file="IndexPartial.jsp" %>
            </div>
            <!--//endregion your codes 3-->
        </div>
    </div>
</form:form>

</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import type="list"/>
<!--//endregion your codes 4-->
</html>