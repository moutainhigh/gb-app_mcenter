<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.WithdrawAccountVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<form:form>
    <div style="display: none" id="validateRule">${command.validateRule}</div>
    <input type="hidden" value="${command.result.id}" name="result.id">
    <c:forEach items="${channelJson}" var="json">
        <c:if test="${json.get('view')=='payDomain'}">
            <c:set var="domain" value="${json.get('value')}"></c:set>
        </c:if>
    </c:forEach>
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['运营']}</span><span>/</span>
            <span>代付出款账户</span>
            <soul:button target="goToLastPage" refresh="true"
                         cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text=""
                         opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
        </div>
        <c:set value="${command.result}" var="result"/>
        <div class="col-lg-12">
            <div class="wrapper white-bg clearfix shadow">
                <div class="sys_tab_wrap clearfix line-hi34 p-xs m-b-sm">
                    <h3 class="pull-left">${views.content['payAccount.accountDetail']}</h3>
                </div>
                <div class="panel blank-panel">
                    <div class="tab-content p-sm">
                        <table class="table dataTable">
                            <tbody>
                            <tr class="tab-title">
                                <th class="bg-tbcolor">代号：</th>
                                <td>${result.code}</td>
                                <th class="bg-tbcolor">账户名称：</th>
                                <td>${result.withdrawName}</td>
                                <th class="bg-tbcolor">账号：</th>
                                <td><a href="javascript:void(0)">${result.account}</a></td>
                            </tr>
                            <tr class="tab-title">
                                <th class="bg-tbcolor">存款渠道：</th>
                                <td>${dicts.common.bankname[result.bankCode]}</td>
                                <th class="bg-tbcolor">域名：</th>
                                <td>${domain}</td>
                                <th class="bg-tbcolor">状态：</th>
                                <c:choose>
                                    <c:when test="${result.status eq '1'}">
                                        <c:set var="color" value="label-success"></c:set>
                                    </c:when>
                                    <c:when test="${result.status eq '2'}">
                                        <c:set var="color" value="label-danger"></c:set>
                                    </c:when>
                                    <c:when test="${result.status eq '3'}">
                                        <c:set var="color" value="label-info"></c:set>
                                    </c:when>
                                </c:choose>
                                <td>
                                    <span class="label ${color}">${dicts.content.pay_account_status[result.status]}</span>
                                </td>
                            </tr>
                            <tr class="tab-title">
                                <th class="bg-tbcolor">累计出款次数：</th>
                                <td>${result.withdrawCount}</td>
                                <th class="bg-tbcolor">累计出款金额：</th>
                                <td>${soulFn:formatCurrency(result.withdrawTotal)}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form:form>
<soul:import type="view"/>