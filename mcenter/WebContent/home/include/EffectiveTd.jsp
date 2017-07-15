<%@ page import="so.wwb.gamebox.model.master.fund.enums.TransactionWayEnum" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:forEach var="r" items="${effectiveTd}" varStatus="vs">

        <c:set var="effective" value="${r.value}"/>
        <c:choose>
            <c:when test="${effective == 0.0}">
                0&nbsp;
            </c:when>
            <c:otherwise>
                <c:set var="effe" value="${effective / 10000}"/>
                <c:if test="${vs.index==0}">
                    <c:choose>
                        <c:when test="${effective lt 0}">
                            <strong class="co-tomato">${soulFn:formatInteger(effective)}<i>${soulFn:formatDecimals(effe)}</i></strong>
                        </c:when>
                        <c:otherwise>
                            <span tabindex="0" class="help-popover m-r-xs" role="button"
                                  data-container="body" data-toggle="popover" data-trigger="focus"
                                  data-placement="top" data-html="true"
                                  data-content="${soulFn:formatInteger(effective)}${soulFn:formatDecimals(effective)}"
                                  data-original-title="" title="">
                                ${soulFn:formatInteger(effe)}<i>${soulFn:formatDecimals(effe)}</i>
                            </span>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </c:otherwise>
        </c:choose>

</c:forEach>