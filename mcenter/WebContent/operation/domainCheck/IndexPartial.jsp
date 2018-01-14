<%@ page import="java.util.Date" %><%--@elvariable id="command" type="so.wwb.gamebox.model.company.sys.vo.VDomainCheckResultStatisticsListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable m-b-sm" aria-describedby="editable_info" id="editable">
        <thead>
        <tr role="row" class="bg-gray">
            <th width="70px">序号</th>
            <td width="70px">域名类型</td>
            <th width="70px">${views.operation['域名']}</th>
            <th width="70px">${views.operation['被墙']}</th>
            <th width="70px">${views.operation['被劫持']}</th>
            <th width="70px">${views.operation['未解析']}</th>
            <th width="70px">${views.operation['服务器不通']}</th>
            <th width="70px">${views.operation['未知错误']}</th>
            <th width="70px">域名未授权</th>
            <th width="70px">被跳转</th>
            <th width="70px">操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <tr>
                <td>${status.index+1}</td>
                <td>${pageUrl[p.pageUrl]}</td>
                <td>${p.domain}</td>
                    <%--被墙状态--%>
                <c:choose>
                    <c:when test="${!empty p.wallOF }">
                        <td>  ${p.wallOF} </td>
                    </c:when>
                    <c:otherwise>
                        <td> 0 </td>
                    </c:otherwise>
                </c:choose>

                    <%--被劫持状态--%>
                <c:choose>
                    <c:when test="${!empty p.beHijached }">
                        <td>  ${p.beHijached} </td>
                    </c:when>
                    <c:otherwise>
                        <td>0</td>
                    </c:otherwise>
                </c:choose>
                    <%--未解析状态--%>
                <c:choose>
                    <c:when test="${!empty p.unResolved}">
                        <td>  ${p.unResolved} </td>
                    </c:when>
                    <c:otherwise>
                        <td>0</td>
                    </c:otherwise>
                </c:choose>
                    <%--服务器不通--%>
                <c:choose>
                    <c:when test="${!empty p.serverUnreachable}">
                        <td>${p.serverUnreachable} </td>
                    </c:when>
                    <c:otherwise>
                        <td>0</td>
                    </c:otherwise>
                </c:choose>
                    <%--未授权--%>
                <c:choose>
                    <c:when test="${!empty p.unAuthorized}">
                        <td>${p.serverUnreachable} </td>
                    </c:when>
                    <c:otherwise>
                        <td>0</td>
                    </c:otherwise>
                </c:choose>
                    <%--被跳转--%>
                <c:choose>
                    <c:when test="${!empty p.redirect}">
                        <td>  ${p.redirect} </td>
                    </c:when>
                    <c:otherwise>
                        <td>0</td>
                    </c:otherwise>
                </c:choose>
                    <%--未知错误--%>
                <c:choose>
                    <c:when test="${!empty p.unknown}">
                        <td>  ${p.unknown} </td>
                    </c:when>
                    <c:otherwise>
                        <td>0</td>
                    </c:otherwise>
                </c:choose>
                <td>
                    <div class="joy-list-row-operations">
                        <a href="/vDomainCheckResultStatistics/getCount.html?search.domain=${p.domain}" nav-target="mainFrame" class="co-blue">详情</a>
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
