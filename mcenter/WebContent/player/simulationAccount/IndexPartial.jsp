<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.reply.vo.PlayerAdvisoryReplyListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div class="table-responsive">
    <table class="table table-condensed table-hover table-striped table-bordered">
        <thead>
        <tr>
            <th class="user_checkbox"><label><input type="checkbox" class="i-checks"></label></th>
            <th>序号</th>
            <th>模拟账号</th>
            <th>创建时间</th>
            <th>有效截止时间</th>
            <th>剩余额度</th>
            <th>状态</th>
            <th>操作</th>
            <th>备注</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${fn:length(command.result)==0}">
            <tr>
                <td colspan="9" style="text-align: center"><i class="fa fa-exclamation-circle">暂无内容！</i></td>
            </tr>
        </c:if>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <tr>
                <td><input type="checkbox" value="${p.id}" name="id"></td>
                <td>${status.index+1}</td>
                <td>${p.username}</td>
                <td>${soulFn:formatDateTz(p.createTime, DateFormat.DAY_SECOND,timeZone)}</td>
                <c:choose>
                    <c:when test="${p.freezeStartTime==foreverTime}">
                        <td>---</td>
                    </c:when>
                    <c:otherwise>
                        <td>${soulFn:formatDateTz(p.freezeStartTime, DateFormat.DAY_SECOND,timeZone)}</td>
                    </c:otherwise>
                </c:choose>
                <td>${soulFn:formatCurrency(p.walletBalance)}</td>
                <td>
                    <c:if test="${p.simulationPlayerStatus=='1'}">
                        <span class="label label-success">
                        正常
                            </span>
                    </c:if>
                    <c:if test="${p.simulationPlayerStatus=='5'}">
                    <span class="label label-warning">
                        过期
                    </span>
                    </c:if>
                    <c:if test="${p.simulationPlayerStatus=='2'}">
                    <span class="label label-danger">
                        已停用
                    </span>
                    </c:if>
                </td>
                <td>
                    <div class="joy-list-row-operations">
                        <c:if test="${p.simulationPlayerStatus!='2'}">
                            <soul:button target="${root}/simulationAccount/editaAccount.html?search.id=${p.id}" text="${views.common['edit']}" opType="dialog" callback="callBackQuery"/>
                            <soul:button target="unableAccount" searchId="${p.id}" opType="function" text="${views.player_auto['账号停用']}">
                                <span class="hd">${views.player_auto['停用']}</span></soul:button>
                            <soul:button target="${root}/simulationAccount/addQuota.html?search.id=${p.id}" text="额度" opType="dialog" callback="callBackQuery" title="增加额度"/>
                        </c:if>
                        <c:if test="${p.simulationPlayerStatus=='2'}">
                            <span CLASS="co-gray">${views.common['edit']}</span>
                            <span CLASS="co-gray">${views.player_auto['停用']}</span>
                            <span CLASS="co-gray">额度</span>
                        </c:if>
                    </div>
                </td>
                <td>${p.memo}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
