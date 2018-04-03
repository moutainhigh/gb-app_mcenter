<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VPlayerOnlineListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->
    <div class="table-responsive table-min-h">
        <table class="table table-striped table-hover dataTable" aria-describedby="editable_info">
            <thead>
            <tr class="bg-gray">
                <th>${views.common['number']}</th>
                <th>${views.common['提交时间']}</th>
                <th>${views.common['数据类型']}</th>
                <th>${views.common['银行名称']}</th>
                <th>${views.common['银行卡号']}</th>
                <th>${views.common['真实姓名']}</th>
                <th>${views.common['手机号码']}</th>
                <th>${views.common['IP地址']}</th>
                <th>${views.common['状态']}</th>
                <th class="inline">${views.common['operate']}</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${command.result}" var="p" varStatus="status">
                <tr class="tab-detail">
                    <td>${status.index+1}</td>
                    <td>${soulFn:formatDateTz(p.createTime, DateFormat.DAY_SECOND,timeZone)}</td>
                    <td>${gbFn:getRiskString(p.dataType)}</td>
                    <td>${dicts.common.bankname[p.bankName]}</td>
                    <td>${p.bankcardNumber}</td>
                    <td>${p.realName}</td>
                    <td>${p.mobilePhone}</td>
                    <td>
                            ${soulFn:formatIp(p.ipAddress)}
                            ${gbFn:getShortIpRegion(p.ipAddress)}
                    </td>
                    <td>
                        <c:if test="${p.checkStatus eq 0}">
                            ${views.common['待审核']}
                        </c:if>
                        <c:if test="${p.checkStatus eq 1}">
                            ${views.common['通过']}
                        </c:if>
                        <c:if test="${p.checkStatus eq 2}">
                            ${views.common['失败']}
                        </c:if>
                    </td>
                    <td>

                        <c:if test="${p.checkStatus eq 0 }">
                            <soul:button target="${root}/riskManagementSite/delete.html?id=${p.id}" text="删除" opType="ajax" dataType="json" confirm="您确定要删除该条记录吗？" callback="query" /></td>
                        </c:if>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

<soul:pagination/>
<!--//endregion your codes 1-->
