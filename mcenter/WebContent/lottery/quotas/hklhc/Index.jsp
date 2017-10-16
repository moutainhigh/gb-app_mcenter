<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div  class="dataTables_wrapper" role="grid">
    <div class="panel-body">
        <div class="tab-content">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover dataTable m-b-none text-center" aria-describedby="editable_info">
                    <thead>
                    <tr class="bg-gray">

                        <th>香港六合彩</th>
                        <th>单项（号）限额</th>
                        <th>单注限额</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${playMap}" var="playWay" varStatus="status">
                        <tr>
                            <td>${playWay.key}</td>
                            <input type="hidden" value="${command[playWay.value].id}" name="quotaList[${status.index}].id">
                            <input type="hidden" value="${command[playWay.value].siteId}" name="quotaList[${status.index}].siteId">
                            <input type="hidden" value="${command[playWay.value].code}" name="quotaList[${status.index}].code">
                            <input type="hidden" value="${command[playWay.value].playCode}" name="quotaList[${status.index}].playCode">
                            <td>
                                <div class="input-group content-width-limit-10">
                                    <input type="text" class="form-control input-sm" value="${command[playWay.value].numQuota}" data-value="${command[playWay.value].numQuota}" name="quotaList[${status.index}].numQuota">

                                </div>
                            </td>
                            <td>
                                <div class="input-group content-width-limit-10">
                                    <input type="text" class="form-control input-sm" value="${command[playWay.value].betQuota}" data-value="${command[playWay.value].betQuota}" name="quotaList[${status.index}].betQuota">
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

