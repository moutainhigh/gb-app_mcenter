<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.UserAgentRebateListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/userAgentRebate/list.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <div class="panel panel-default">
        <div class="panel-body">
            <!--//region your codes 2-->
            <div class="row">

                <div class="col-md-1">
                    <soul:button target="query" opType="function" text="${views.common['search']}" cssClass="btn btn-default" />
                </div>
                <div class="col-md-1">
                    <soul:button target="${root}/userAgentRebate/create.html" opType="dialog" text="${views.common['create']}" cssClass="btn btn-default" />
                </div>
            </div>

            <br/>
            <div class="search-list-container">
                <%@ include file="IndexPartial.jsp" %>
            </div>
            <!--//endregion your codes 2-->
        </div>
    </div>
</form:form>

<!--//region your codes 3-->
<soul:import type="list"/>
<!--//endregion your codes 3-->