<%@ page import="java.util.Date" %><%--@elvariable id="command" type="so.wwb.gamebox.model.company.sys.vo.VDomainCheckResultStatisticsListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable m-b-sm" aria-describedby="editable_info" id="editable">
        <thead>
        <tr role="row" class="bg-gray">
            <th >${views.common['number']}</th>
            <td >${views.operation['域名类型']}</td>
            <th >${views.operation['域名']}</th>
            <th >${views.operation['被墙']}</th>
            <th >${views.operation['被劫持']}</th>
            <th >${views.operation['未解析']}</th>
            <th >${views.operation['服务器不通']}</th>
            <th >${views.operation['未知错误']}</th>
            <th >${views.operation['域名未授权']}</th>
            <th >${views.operation['被跳转']}</th>
            <th >${views.operation['操作']}</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <tr class="tab-detail">
                <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                <td>${views.content[command.domainCheckResultListVo.pageUrl[p.pageUrl]]}</td>
                <td>${p.domain}</td>
                    <%--被墙状态--%>
                <td>
                    <c:choose>
                        <c:when test="${!empty p.wallOF && p.wallOF>0 }">
                            <a href="/operation/domainCheckResult/list.html?search.domain=${p.domain}&search.status=WALLED_OFF" nav-target="mainFrame" class="co-blue">${p.wallOF}</a>
                        </c:when>
                        <c:otherwise>
                                0
                        </c:otherwise>
                    </c:choose>
                </td>

                    <%--被劫持状态--%>
                <td>
                    <c:choose>
                        <c:when test="${!empty p.beHijached && p.beHijached>0 }">
                            <a href="/operation/domainCheckResult/list.html?search.domain=${p.domain}&search.status=BE_HIJACKED" nav-target="mainFrame" class="co-blue">${p.beHijached}</a>
                        </c:when>
                        <c:otherwise>
                            0
                        </c:otherwise>
                    </c:choose>
                </td>

                <%--未解析--%>
                <td>
                    <c:choose>
                        <c:when test="${!empty p.unResolved && p.unResolved>0}">
                        <a href="/operation/domainCheckResult/list.html?search.domain=${p.domain}&search.status=UNRESOLVED" nav-target="mainFrame" class="co-blue">${p.unResolved}</a>
                        </c:when>
                        <c:otherwise>
                            0
                        </c:otherwise>
                    </c:choose>
                </td>


                    <%--服务器不通--%>
                <td>
                    <c:choose>
                        <c:when test="${!empty p.serverUnreachable && p.serverUnreachable>0}">
                        <a href="/operation/domainCheckResult/list.html?search.domain=${p.domain}&search.status=SERVER_UNREACHABLE" nav-target="mainFrame" class="co-blue">${p.serverUnreachable}</a>
                        </c:when>
                        <c:otherwise>
                            0
                        </c:otherwise>
                    </c:choose>
                </td>

                    <%--未知错误--%>
                <td>
                    <c:choose>
                        <c:when test="${!empty p.unknown && p.unknown>0}">
                        <a href="/operation/domainCheckResult/list.html?search.domain=${p.domain}&search.status=UNKNOWN_ERR" nav-target="mainFrame" class="co-blue">${p.unknown}</a>
                        </c:when>
                        <c:otherwise>
                            0
                        </c:otherwise>
                    </c:choose>
                </td>
                    <%--域名未授权--%>
                <td>
                    <c:choose>
                        <c:when test="${!empty p.unAuthorized && p.unAuthorized>0}">
                            <a href="/operation/domainCheckResult/list.html?search.domain=${p.domain}&search.status=UNAUTHORIZED" nav-target="mainFrame" class="co-blue">${p.unAuthorized}</a>
                        </c:when>
                        <c:otherwise>
                            0
                        </c:otherwise>
                    </c:choose>
                </td>

                    <%--被跳转--%>
                <td>
                    <c:choose>
                        <c:when test="${!empty p.redirect &&  p.redirect>0}">
                        <a href="/operation/domainCheckResult/list.html?search.domain=${p.domain}&search.status=REDIRECT" nav-target="mainFrame" class="co-blue">${p.redirect}</a>
                        </c:when>
                        <c:otherwise>
                            0
                        </c:otherwise>
                    </c:choose>
                </td>

                <td>
                    <div class="joy-list-row-operations">
                        <a href="/operation/domainCheckResult/list.html?search.domain=${p.domain}" nav-target="mainFrame" class="co-blue">详情</a>
                    </div>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${fn:length(command.result)<1}">
            <tr>　　　　
                <td class="no-content_wrap" colspan="6">
                    <div><i class="fa fa-exclamation-circle"></i> ${views.operation['当前所有域名均处于正常状态!']}</div>
                </td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
