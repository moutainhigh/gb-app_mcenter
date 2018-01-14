<%@ page import="java.util.Date" %><%--@elvariable id="command" type="so.wwb.gamebox.model.company.sys.vo.VDomainCheckResultStatisticsListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div class="table-responsive">
    <div class="operate-btn n-o-margin border-b-1 clearfix">
        <span class="co-yellow"><i class="fa fa-exclamation-circle"></i></span>
        检测时间：${soulFn:formatDateTz(checkTime, DateFormat.DAY_SECOND, timeZone )}
    </div>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <span style="border-right: 680px;"> 所有域名检测结果仅提供参考,不完全代表整个区域的实际解析情况，不具备故障证据之用！如有需要自行核实实际域名情况</span>
    <table class="table table-condensed table-hover table-striped table-bordered">
        <thead>
        <tr>
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
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <c:if test="${fn:length(command.result)<1}">
                <tr>
                    <td>当前域名均处于正常状态</td>
                </tr>
            </c:if>
        </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
