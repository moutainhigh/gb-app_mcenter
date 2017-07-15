<%--@elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.VNoticeEmailRankVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<html lang="zh-CN">
<head>
    <title>${views.common['edit']}</title>
    <%@ include file="/include/include.head.jsp" %>
    <!--//region your codes 2-->

    <!--//endregion your codes 2-->
</head>

<body>

<form:form id="editForm" action="${root}/vNoticeEmailInterface/edit.html" method="post">
    <input id="rankCount" type="hidden" value="${command.rankList.size()}"/>
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <input name="original" type="hidden" value="${command.result.emailAccount}"/>
    <input name="result.original" type="hidden" value="${command.result.emailAccount}"/>
    <!--//region your codes 3-->
    <div class="modal-body">
        <div class="form-group clearfix line-hi34 m-b-xxs">
            <label class="col-xs-3 al-right"><span
                    class="co-red3 m-r-xs">*</span>${views.setting['mail.Edit.name']}：</label>

            <div class="col-xs-8 p-x">
                <c:if test="${command.result.builtIn}">
                    ${command.result.name}
                    <input name="result.name" value="${command.result.name}" type="hidden"/>
                </c:if>
                <c:if test="${!command.result.builtIn}">
                    <form:input path="result.name" cssClass="form-control m-b"/>
                </c:if>
            </div>
        </div>
        <div class="form-group clearfix line-hi34 m-b-xxs">
            <label class="col-xs-3 al-right"><span class="co-red3 m-r-xs">*</span>${views.setting['mail.Edit.rankName']}：</label>

            <div class="col-xs-8 p-x m-b rankStatus">
                <c:if test="${command.result.builtIn}">
                    ${views.setting['mail.Index.allRank']}
                    <input name="result.userGroupId" value="0" type="hidden"/>
                </c:if>
                <c:if test="${!command.result.builtIn}">
                    <%--<gb:select name="result.userGroupId" ajaxListPath="${root}/vNoticeEmailInterface/queryUsableList.html" value="${command.result.userGroupId}" listKey="id" listValue="rankName" cssClass="btn-primary"/>--%>
                    <label class="m-r-sm"><input type="checkbox" class="i-checks all_rank" ${command.rankList.size()==fn:length(fn:split(command.result.rankids,',' ))?'checked':''}>${views.setting['mail.Index.allRank']}</label>
                    </label><br>
                    <%--player rank--%>
                    <c:forEach items="${command.rankList}" var="playerRanks">
                        <label class="m-r-sm">
                        <input type="checkbox" class="i-checks rank" name="rank"
                            <c:forEach items="${fn:split(command.result.rankids,',')}" var="rank">
                                 ${rank==playerRanks.id?'checked':''}

                            </c:forEach>
                               value="${playerRanks.id}">${playerRanks.rankName}</label>

                    </c:forEach>
                    <form:hidden path="rankIds" id="rankIds"/>
                </c:if>
            </div>
        </div>
        <div class="form-group clearfix  m-b-xxs">
            <label class="col-xs-3 al-right"><span
                    class="co-red3 m-r-xs">*</span>${views.setting['mail.Edit.smtp']}：</label>

            <div class="col-xs-8 p-x"><form:input path="result.serverAddress" cssClass="form-control m-b"/></div>
        </div>
        <div class="form-group clearfix line-hi34 m-b-xxs">
            <label class="col-xs-3 al-right"><span
                    class="co-red3 m-r-xs">*</span>${views.setting['mail.Edit.port']}：</label>

            <div class="col-xs-8 p-x"><form:input path="result.serverPort" cssClass="form-control m-b"/></div>
        </div>
        <div class="form-group clearfix line-hi34 m-b-xxs">
            <label class="col-xs-3 al-right"><span class="co-red3 m-r-xs">*</span>${views.setting['mail.Edit.userName']}：</label>

            <div class="col-xs-8 p-x"><form:input path="result.emailAccount" cssClass="form-control m-b"/></div>
        </div>
        <div class="form-group clearfix line-hi34 m-b-xxs">
            <label class="col-xs-3 al-right"><span class="co-red3 m-r-xs">*</span>${views.setting['mail.Edit.password']}：</label>

            <div class="col-xs-8 p-x">
                <input style="display: none"><input type="password" name="result.accountPassword" class="form-control m-b" value="${command.result.accountPassword}"/>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <soul:button cssClass="btn btn-filter" text="${views.setting['common.ok']}" opType="ajax" dataType="json"
                     target="${root}/vNoticeEmailInterface/save.html" precall="saveValid" post="getCurrentFormData"
                     callback="saveCallbak"/>
        <soul:button target="closePage" text="${views.setting['common.cancel']}" cssClass="btn btn-outline btn-filter"
                     opType="function"/>
    </div>
    <!--//endregion your codes 3-->

</form:form>

</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import res="site/setting/interface/email/Edit"/>
<!--//endregion your codes 4-->
</html>