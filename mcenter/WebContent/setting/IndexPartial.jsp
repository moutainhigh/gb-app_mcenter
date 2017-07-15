<%--@elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.VRakebackSetListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div class="table-responsive">
    <table class="table table-condensed table-hover table-striped table-bordered">
        <thead>
        <tr>
            <th width="30px">#</th>
            <th width="70px">${views.setting_auto['操作']}</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <tr>
                <td>${status.index+1}</td>
                <td>
                    <div class="joy-list-row-operations">
                        <soul:button target="${root}/rakebackGrads/view.html?id=${p.id}" text="${views.setting_auto['查看']}" opType="dialog" />
                        <soul:button target="${root}/rakebackGrads/edit.html?id=${p.id}" text="${views.setting_auto['编辑']}" opType="dialog" />
                        <soul:button target="${root}/rakebackGrads/delete.html?id=${p.id}" text="${views.setting_auto['删除']}" opType="ajax" dataType="json" confirm="${views.setting_auto['您确定要删除该条记录吗']}" callback="query" />
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
