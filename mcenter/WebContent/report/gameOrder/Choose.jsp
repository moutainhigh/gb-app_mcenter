<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VPlayerGameOrderListVo"--%>
<%--@elvariable id="game" type="so.wwb.gamebox.model.company.po.Game"--%>
<%--@elvariable id="api" type="so.wwb.gamebox.model.company.setting.po.Api"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
    <!--选择字段-->
    <form:form method="post">
        <div class="modal-body">
            <div>
                <soul:button target="checkAll" text="${views.operation['backwater.settlement.choose.allChoose']}" opType="function" tag="button" cssClass="btn btn-filter btn-xs"/>
                <soul:button target="clearAll" text="${views.operation['backwater.settlement.choose.clear']}" opType="function" tag="button" cssClass="btn btn-outline btn-filter btn-xs  m-l-xs m-r"/>
                <c:forEach items="${allApis}" var="i">
                    <c:set value="${gbFn:getApiName(i.apiId.toString())}" var="apiName"/>
                    <c:set value="${gbFn:getSiteApiName(i.apiId.toString())}" var="siteApiName"/>
                    <soul:button target="choseApi" text="${empty siteApiName?apiName:siteApiName}" opType="function" data="${i.apiId}" cssClass="btn btn-outline  m-t-xs btn-filter btn-xs"/>
                </c:forEach>
                <span class="dividing-line m-r-xs m-l-xs">|</span>
                <c:forEach items="${apiTypes}" var="i">
                    <soul:button target="choseGameType" text="${i.apiTypeName}" opType="function" data="${i.apiTypeId}" gameTypes="${i.gameTypes}" cssClass="btn btn-outline  m-t-xs btn-filter btn-xs"/>
                </c:forEach>
            </div>
            <div class="table-responsive m-t">
                <table class="table table-bordered m-b-xxs">
                    <tbody>
                    <c:forEach var="apis" items="${apiList}">
                        <c:forEach var="api" items="${apis}">
                            <c:set value="${gbFn:getApiName(api.key.toString())}" var="apiName"/>
                            <c:set value="${gbFn:getSiteApiName(api.key.toString())}" var="siteApiName"/>
                            <tr>
                                <td class="bg-gray al-left" name="api_td" data-id="${api.key}">
                                    <label>
                                        <input type="checkbox" class="i-checks" name="apicheck" value="true">
                                    <span class="m-l-xs">
                                        <b>${empty siteApiName?apiName:siteApiName}</b>
                                    </span>
                                    </label>
                                </td>
                                <td class="al-left"  data-id="${api.key}">
                                    <c:forEach items="${api.value}" var="game">
                                        <label class="fwn m-r-sm">
                                            <input name="gamecheck" type="checkbox" class="i-checks" value="${game.gameType}">
                                                ${gbFn:getGameTypeName(game.gameType)}
                                        </label>
                                    </c:forEach>
                                </td>
                            </tr>
                        </c:forEach>

                    </c:forEach>
                    <%--<c:forEach items="${allApis}" var="api">
                        <c:set value="${gbFn:getApiName(api.apiId.toString())}" var="apiName"/>
                        <c:set value="${gbFn:getSiteApiName(api.apiId.toString())}" var="siteApiName"/>
                        <tr>
                            <td class="bg-gray al-left" name="api_td" data-id="${api.apiId}">
                                <label>
                                    <input type="checkbox" class="i-checks" name="apicheck" value="true">
                                    <span class="m-l-xs">
                                        <b>${empty siteApiName?apiName:siteApiName}</b>
                                    </span>
                                   </label>
                            </td>
                            <td class="al-left"  data-id="${api.apiId}">
                                <c:forEach items="${allGames}" var="game">
                                    <c:if test="${game.apiId == api.apiId}">
                                        <label class="fwn m-r-sm"><input name="gamecheck" type="checkbox" class="i-checks" data-parent="${game.apiTypeId}" value="${game.gameType}">${gbFn:getGameTypeName(game.gameType)}</label>
                                    </c:if>
                                </c:forEach>
                            </td>
                        </tr>
                    </c:forEach>--%>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="modal-footer">
            <soul:button cssClass="btn btn-filter" text="${views.common['OK']}" opType="function" target="choose" tag="button"/>
            <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter" opType="function" tag="button"/>
        </div>
    </form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/gameOrder/Choose"/>
</html>