<%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.OperatePlayerListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<div class="row">
    <form:form id="reportForm" action="${root}/report/operate/operateIndex.html" method="post">
        <div id="validateRule" style="display: none">${validateRule}</div>
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['统计']}</span><span>/</span><span>${views.sysResource['经营报表']}</span>
            ${command.outer}
            <%--<c:if test="${not empty outer}">--%>
                <soul:button target="goToLastPage" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                    <em class="fa fa-caret-left"></em>${views.common['return']}
                </soul:button>
            <%--</c:if>--%>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>

        <%-- 定义角色 --%>
        <input type="hidden" name="role.master" value="<%=SubSysCodeEnum.MCENTER.getCode() %>" />
        <input type="hidden" name="role.topAgent" value="<%=SubSysCodeEnum.MCENTER_TOP_AGENT.getCode() %>" />
        <input type="hidden" name="role.agent" value="<%=SubSysCodeEnum.MCENTER_AGENT.getCode() %>" />
        <input type="hidden" name="role.player" value="<%=SubSysCodeEnum.PCENTER.getCode() %>" />
        <input type="hidden" name="search.apiTypeList" value="" />

        <c:set var="ssCode" value="${command.subSysCode}" />
        <div class="col-lg-12 search-list-condition">
            <c:choose>
                <c:when test="${ssCode=='mcenter'}">
                    <%@ include file="site/header.jsp" %>
                </c:when>
                <c:when test="${ssCode=='mcenterTopAgent'}">
                    <%@ include file="topagent/header.jsp" %>
                </c:when>
                <c:when test="${ssCode=='mcenterAgent'}">
                    <%@ include file="agent/header.jsp" %>
                </c:when>
                <c:otherwise>
                    <%@ include file="player/header.jsp" %>
                </c:otherwise>
            </c:choose>
        </div>
        <c:set var="isLotterySite" value="<%=ParamTool.isLotterySite()%>"/>
        <c:if test="${!isLotterySite}">
            <%@ include file="middle.jsp" %>
        </c:if>
        <div class="search-list-container">
            <input type="hidden" name="outApiTypeId" value="${outApiTypeId}" />
            <c:choose>
                <c:when test="${ssCode=='mcenter'}">
                    <%@ include file="site/footer.jsp" %>
                </c:when>
                <c:when test="${ssCode=='mcenterTopAgent'}">
                    <%@ include file="topagent/footer.jsp" %>
                </c:when>
                <c:when test="${ssCode=='mcenterAgent'}">
                    <%@ include file="agent/footer.jsp" %>
                </c:when>
                <c:otherwise>
                    <%@ include file="player/footer.jsp" %>
                </c:otherwise>
            </c:choose>
        </div>

    </form:form>
</div>

<soul:import res="site/report/operate/index"/>