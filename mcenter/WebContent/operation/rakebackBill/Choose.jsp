<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.RakebackPlayerListVo"--%>
<%--@elvariable id="gametypes" type="java.util.Map<java.lang.Integer, java.util.Map<so.wwb.gamebox.model.master.operation.po.RakebackApi>>"--%>
<%--@elvariable id="apiTypes" type="java.util.list<java.lang.string>"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<c:set var="apiTypeI18n" value="<%=Cache.getSiteApiTypeI18n()%>"/>
    <!--选择字段-->
    <form:form method="post">
        <input type="hidden" path="search.rakebackBillId" value="${command.search.rakebackBillId}"/>
        <div class="modal-body">
            <div>
                <soul:button target="checkAll" text="${views.operation['backwater.settlement.choose.allChoose']}" opType="function" tag="button" cssClass="btn btn-filter btn-xs"/>
                <soul:button target="clearAll" text="${views.operation['backwater.settlement.choose.clear']}" opType="function" tag="button" cssClass="btn btn-outline btn-filter btn-xs m-l-xs m-r"/>
                <c:forEach items="${command.tabTitles}" var="i">
                    <soul:button target="choseApi" text="${gbFn:getSiteApiName(i.id.toString())}" opType="function" data="${i.id}"/>
                </c:forEach>
                <span class="dividing-line m-r-xs m-l-xs">|</span>
                <c:forEach items="${apiTypes}" var="i">
                    <soul:button target="choseGameType" text="${apiTypeI18n[i.toString()].name}" opType="function" data="${i}"/>
                </c:forEach>
            </div>
            <div class="table-responsive m-t">
                <table class="table table-bordered m-b-xxs">
                    <tbody>
                    <c:set var="locale" value="<%=SessionManager.getLocale()%>"/>
                    <c:forEach items="${command.tabTitles}" var="i" varStatus="vs">
                        <tr>
                            <td class="bg-gray al-left" name="api_td" data-id="${i.id}">
                                <label>
                                    <input type="checkbox" class="i-checks" value="true">
                                    <span class="m-l-xs">
                                        <b>${gbFn:getSiteApiName(i.id.toString())}</b>
                                    </span>
                                </label>
                            </td>
                            <td class="al-left"  data-id="${i.id}">
                                <c:forEach items="${gametypes[i.id]}" var="j">
                                    <label class="fwn m-r-sm"><input type="checkbox" class="i-checks" data-parent="${j.value.apiTypeId}" value="${j.key}">${gbFn:getGameTypeName(j.key)}</label>
                                </c:forEach>
                            </td>
                        </tr>
                    </c:forEach>
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
<soul:import res="site/operation/rakebackBill/Choose"/>
</html>