<%--@elvariable id="command" type="so.wwb.gamebox.model.company.sys.vo.VDomainCheckResultStatisticsListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div class="table-responsive">
    <table class="table table-condensed table-hover table-striped table-bordered">
        <thead>
        <tr>
            <th width="30px">序号</th>
            <th width="70px">域名</th>
            <th width="70px">被墙</th>
            <th width="70px">被劫持</th>
            <th width="70px">未解析</th>
            <th width="70px">服务器不通</th>
            <th width="70px">未知错误</th>
            <th width="70px">操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <tr>
                <td>${status.index+1}</td>
                <td>${p.domain}</td>
                    <%--被墙状态--%>
                <c:choose>
                        <c:when test="${!empty p.firewall }">
                            <td>  ${p.firewall } </td>
                        </c:when>
                        <c:otherwise>
                            <td> 0 </td>
                         </c:otherwise>
                </c:choose>

                <%--被劫持状态--%>
                <c:choose>
                        <c:when test="${!empty p.hijack }">
                            <td>  ${p.hijack} </td>
                        </c:when>
                        <c:otherwise>
                            <td>  0</td>
                        </c:otherwise>
                </c:choose>
                    <%--未解析状态--%>
                <c:choose>
                    <c:when test="${!empty p.unparsed}">
                        <td>  ${p.unparsed} </td>
                    </c:when>
                    <c:otherwise>
                        <td>0</td>
                    </c:otherwise>
                </c:choose>
                    <%--服务器不通--%>
                <c:choose>
                    <c:when test="${!empty p.unreach}">
                        <td>  ${p.unreach} </td>
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
                        <a href="/vDomainCheckResultStatistics/searchDetail.html?id=${p.id}" nav-target="mainFrame" class="co-blue">详情</a>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
