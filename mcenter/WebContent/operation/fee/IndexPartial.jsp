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
                    <td>${soulFn:formatDateTz(p.createTime, DateFormat.DAY_SECOND,timeZone)}</td>

                    <%--收取--%>
                    <c:if test="${p.isFee}">
                        <td>
                            收手续费
                        </td>
                        <c:if test="${p.feeType=='1'}">
                            <td>
                                按比例收取
                            </td>
                            <td>
                                <c:if test="${p.feeTime!=null}">
                                    ${p.feeTime}小时内
                                </c:if>
                                <c:if test="${p.freeCount!=null}">
                                    免手续费${p.freeCount}次,
                                </c:if>
                                <c:if test="${p.freeCount==null}">
                                    免手续费0次,
                                </c:if>
                                单笔存款收取${p.feeMoney}%
                            </td>
                            <td>
                                    ${p.maxFee}
                            </td>
                        </c:if>
                        <c:if test="${p.feeType=='2'}">
                            <td>
                                固定收取
                            </td>
                            <td>
                                <c:if test="${p.feeTime!=null}">
                                    ${p.feeTime}小时内
                                </c:if>
                                <c:if test="${p.freeCount!=null}">
                                    免手续费${p.freeCount}次,
                                </c:if>
                                <c:if test="${p.freeCount==null}">
                                    免手续费0次,
                                </c:if>
                                单笔存款收取${siteCurrencySign}${p.feeMoney}
                            </td>
                            <td>
                                    ${p.maxFee}
                            </td>
                        </c:if>
                    </c:if>

                    <%--返还--%>
                    <c:if test="${p.isReturnFee}">
                        <td>
                            返手续费
                        </td>
                        <c:if test="${p.returnType=='1'}">
                            <td>
                                按比例返还
                            </td>
                            <td>
                                存满${p.reachMoney},返${p.returnMoney}%
                                <c:if test="${p.returnTime!=null}">
                                    ${p.returnTime}小时内
                                </c:if>
                                <c:if test="${p.returnFeeCount!=null}">
                                    返手续费${p.returnFeeCount}次,
                                </c:if>
                                <c:if test="${p.returnFeeCount==null}">
                                    返手续费0次,
                                </c:if>
                            </td>

                        </c:if>
                        <c:if test="${p.returnType=='2'}">
                            <td>
                                固定返还
                            </td>
                            <td>
                                <c:if test="${p.returnTime!=null}">
                                    ${p.returnTime}小时内
                                </c:if>
                                <c:if test="${p.returnFeeCount!=null}">
                                    返手续费${p.returnFeeCount}次,
                                </c:if>
                                <c:if test="${p.returnFeeCount==null}">
                                    返手续费0次,
                                </c:if>
                                存满${p.reachMoney},返${siteCurrencySign}${p.returnMoney}
                            </td>
                        </c:if>
                        <td>
                                ${p.maxReturnFee}
                        </td>
                    </c:if>
                    <%--不收不返--%>
                    <c:if test="${(p.isReturnFee == null && p.isFee == null ) || (!p.isReturnFee && !p.isFee)}">
                        <td>
                            --
                        </td>
                        <td>
                            --
                        </td>
                        <td>
                            --
                        </td>
                        <td>
                            --
                        </td>
                    </c:if>

                    <td>${p.accountCount}</td>
                    <td>
                        <shiro:hasPermission name="content:withdraw_account_edit">
                            <a href="/rechargeFeeSchema/edit.html?search.id=${p.id}" nav-target="mainFrame">${views.common['edit']}</a>
                        </shiro:hasPermission>
                        &nbsp;&nbsp;
                        <soul:button permission="role:rank_delete" target="${root}/rechargeFeeSchema/delete.html?id=${p.id}&result.id=${p.id}" confirm="${views.player_auto['确认删除该手续费方案']}"
                                     callback="query" text="${views.common['delete']}" opType="ajax" cssClass="co-blue">${views.common['delete']}</soul:button>
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
