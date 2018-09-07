<%--@elvariable id="command" type="so.wwb.gamebox.model.gamebox.vo.WithdrawAccountListVo"--%>
<%@ page import="so.wwb.gamebox.model.master.content.po.WithdrawAccount" %>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="poType" value="<%= WithdrawAccount.class %>"></c:set>

<!--//region your codes 1-->
<div id="editable_wrapper" class="dataTables_wrapper" role="grid">
    <div class="table-responsive table-min-h">
        <table class="table table-striped table-hover dataTable m-b-sm" aria-describedby="editable_info">
            <thead>
            <tr role="row" class="bg-gray">
                <th>
                    方案名称
                </th>
                <th>创建时间</th>
                <th>
                    方案类型
                </th>
                <th>
                    收费类型
                </th>
                <th>
                    费用标准
                </th>
                <th>
                    最高上限
                </th>
                <th>
                    受控账号
                </th>
                <th>${views.common['operate']}</th>
            </tr>
            <tr class="bd-none hide">
                <th colspan="13">
                    <div class="select-records"><i class="fa fa-exclamation-circle"></i>${views.role['player.cancelSelectAll.prefix']}&nbsp;<span id="page_selected_total_record"></span>${views.role['player.cancelSelectAll.middlefix']}
                        <soul:button target="cancelSelectAll" opType="function" text="${views.role['player.cancelSelectAll']}"/>${views.role['player.cancelSelectAll.suffix']}
                    </div>
                </th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${command.result}" var="p" varStatus="stat">
                <tr class="tab-detail">
                    <td>${p.schemaName}</td>
                    <td>${p.createTime}</td>

                    <td>
                            ${p.isFee} --${p.isReturnFee}
                    </td>
                    <td>${p.feeType}</td>
                    <td>
                        存满￥10返10.0%,上限￥10
                    </td>
                    <td>${p.maxFee}</td>

                    <td>账号</td>
                    <td>
                        <shiro:hasPermission name="content:withdraw_account_edit">
                            <a href="/rechargeFeeSchema/edit.html?search.id=${p.id}" nav-target="mainFrame">${views.common['edit']}</a>
                        </shiro:hasPermission>
                        <span class="dividing-line m-r-xs m-l-xs">|</span>
                        <a href="/rechargeFeeSchema/view.html?search.id=${p.id}" nav-target="mainFrame">${views.common['detail']}</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${fn:length(command.result)<1}">
                <tr>
                    <td colspan="13" class="no-content_wrap">
                        <div>
                            <i class="fa fa-exclamation-circle"></i>
                            暂无代付出款账户信息
                        </div>
                    </td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
    <soul:pagination/>
</div>


<!--//endregion your codes 1-->
