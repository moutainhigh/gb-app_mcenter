<%--@elvariable id="command" type="so.wwb.gamebox.model.company.sys.vo.VDomainCheckResultStatisticsListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable m-b-sm" aria-describedby="editable_info" id="editable">
        <thead>
        <tr role="row" class="bg-gray">
            <th>序号</th>
            <th>域名</th>
            <th>状态</th>
            <th>区域</th>
            <th>运营商</th>
            <%--<c:if test="${ command.search.isSecondSearch!='0' } ">--%>
                <th width="70px">详情</th>
            <%--</c:if>--%>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <tr>
                <td>${status.index+1}</td>
                <td>${p.domain}</td>
                <td>${p.status}</td>
                <td>${p.area}</td>
                <td>${p.isp}</td>
                <td>
                    <%--<c:if test="${ command.search.isSecondSearch!='0' } ">--%>
                        <div class="joy-list-row-operations">
                            <a class="btn btn-link co-blue"
                               href="/operation/domainCheckResult/list.html?search.domain=${p.domain}&search.isSecondSearch=0"
                               nav-target="mainFrame">详情
                        </div>
                    <%--</c:if>--%>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${fn:length(command.result)<1}">
            <tr>
　　　　　　　　　　　　正常
            </tr>
        </c:if>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
