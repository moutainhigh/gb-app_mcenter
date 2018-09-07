<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<head>
    <title></title>
    <%@ include file="/include/include.head.jsp" %>
</head>

<body id="mainFrame">
<form action="">
    <div class="modal-body">
        <div class="search-list-container">
            <div class="table-responsive table-min-h">
                <div class="search-params-div hide"></div>
                <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
                    <thead>
                    <tr role="row" class="bg-gray">
                        <th>${views.fund['时间']}</th>
                        <th>${views.fund['调用接口']}</th>
                        <th>${views.fund['错误信息']}</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${command.result}" var="p" varStatus="status">
                        <%--errorLog为空不展示--%>
                        <c:if test="${!empty p.errorLog}" >
                            <tr>
                                <td>${soulFn:formatDateTz(p.operateTime, DateFormat.DAY_SECOND,timeZone)}</td>
                                <td>${p.description}</td>
                                <td>${p.errorLog==null?"--":p.errorLog}</td>
                            </tr>
                        </c:if>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/fund/deposit/online/ViewPayLog"/>
</html>
