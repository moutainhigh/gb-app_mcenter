<%--@elvariable id="command" type="so.wwb.gamebox.model.company.sys.vo.VDomainCheckResultStatisticsListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable m-b-sm" aria-describedby="editable_info" id="editable">
        <thead>
        <tr role="row" class="bg-gray">
            <th>序号</th>
            <th>域名类型</th>
            <th>域名</th>
            <th class="inline">
                状态<%--<gb:select name="search.status" value="" prompt="状态" list="${domainStatus}"/>--%>
            </th>
            <th>地区</th>
            <th>
                <%--运营商<gb:select name="search.isp" value="" prompt="运营商" list="${isp}" callback="query"/>--%>
            </th>
            <th>备注</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <c:set var="CN" value="CN"></c:set>
            <c:set var="province" value='${CN.concat("_").concat(p.serverProvince)}'></c:set>
            <tr>
                <td>${status.index+1}</td>
                <td>${pageUrl[p.pageUrl]}</td>
                <td>${p.domain}</td>
                <td>${dicts.common.domain_check_result_status[p.status]}</td>
                <td>${dicts.state[CN][p.serverProvince]}<br>
                        ${dicts.city[province][p.serverCity]}
                </td>
                <td>${dicts.common.isp[p.isp]}</td>
                <td> ${p.detail}</td>
            </tr>
        </c:forEach>
        <c:if test="${fn:length(command.result)<1}">
            <tr>
                　　　　　　　　
                <td>正常</td>
                　　　
            </tr>
        </c:if>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
