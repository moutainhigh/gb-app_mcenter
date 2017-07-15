<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.UserAgentRebateListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div class="table-responsive">
    <table class="table table-condensed table-hover table-striped table-bordered">
        <thead>
        <tr>
            <th width="30px">#</th>
            <th width="70px">${views.common['operate']}</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <tr>
                <td>${status.index+1}</td>
                <td>
                    <div class="joy-list-row-operations">
                        <soul:button target="${root}/userAgentRebate/view.html?id=${p.id}" text="${views.common['view']}" opType="dialog" />
                        <soul:button target="${root}/userAgentRebate/edit.html?id=${p.id}" text="${views.common['edit']}" opType="dialog" />
                        <soul:button target="${root}/userAgentRebate/delete.html?id=${p.id}" text="${views.common['delete']}" opType="ajax" dataType="json" confirm="${views.common['confirm.delete']}？" callback="query" />
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
