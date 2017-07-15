<%--@elvariable id="command" type="so.wwb.gamebox.model.site.report.vo.VPlayerGameOrderListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="so.wwb.gamebox.model.site.report.po.VPlayerGameOrder" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="poType" value="<%= VPlayerGameOrder.class %>"/>
<%--用于导出--%>
<input type="hidden" id="conditionJson" value="${params}">
<div class="search-params-div hide"></div>
<input type="hidden" name="search.searchCondition" value="${command.search.searchCondition}"/>
<input type="hidden" name="search.beginWinningAmount" value="${command.search.beginWinningAmount}"/>
<input type="hidden" name="search.beginContributionAmount" value="${command.search.beginContributionAmount}"/>
<input type="hidden" name="outer" value="${command.outer}">
<div class="tesponsive table-min-h">
    <c:choose>
        <%--真人--%>
        <c:when test="${apiType=='1'}">
            <%@ include file="/report/betting/LiveDealer.jsp" %>
        </c:when>
        <%--体育--%>
        <c:when test="${apiType=='3'}">
            <%@ include file="/report/betting/Sportsbook.jsp" %>
        </c:when>
        <c:otherwise>
            <%@ include file="/report/betting/AllType.jsp" %>
        </c:otherwise>
    </c:choose>
</div>
