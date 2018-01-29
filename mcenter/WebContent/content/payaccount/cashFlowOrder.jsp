<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.VPayAccountListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html>
<form:form action="${root}/" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
        <div class="row">
            <div class="position-wrap clearfix">
                <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
                <span>支付</span><span>/</span>
                <span>${views.sysResource['线上支付账户']}</span>
                <a href="/vPayAccount/list.html?search.type=2" nav-target="mainFrame" class="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn"><em class="fa fa-caret-left"></em>${views.common['return']}</a>
                <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
            </div>
            <form:hidden path="search.id"/>
            <div class="col-lg-12">
                <div class="wrapper white-bg shadow clearfix">
                    <div class="present_wrap"><b>${views.content['payAccount.cash.order']}</b></div>
                    <div class="select-level clearfix">
                        <c:forEach items="${command.playerRanks}" var="pr" varStatus="status">
                            <c:if test="${pr.payAccountNum>0}">
                                <c:set var="url" value="/vPayAccount/cashFlowOrder.html?id=${pr.id}"/>
                            </c:if>
                            <c:if test="${pr.payAccountNum<=0}">
                                <c:set var="url" value="#"/>
                            </c:if>
                            <a href="${url}" nav-target="mainFrame" class="${pr.payAccountNum>0?'':'disabled'}
                                <c:choose>
                                    <c:when test="${(empty id)&&status.index==0}">
                                        current
                                    </c:when>
                                    <c:when test="${!empty id&&pr.id eq id}">
                                        current
                                    </c:when>
                                </c:choose> "
                            >${pr.rankName}</a>
                        </c:forEach>
                    </div>
                    <div class="form-group clearfix">
                        <label class="ft-bold pull-left m-r-sm">${views.content['payAccount.taketurn']}：</label>
                        <div class="pull-left">
                            <c:if test="${empty command.playerRank}">
                                <c:set value="${command.playerRanks[0]}" var="prank"/>
                            </c:if>
                            <c:if test="${!empty command.playerRank}">
                                <c:set value="${command.playerRank}" var="prank"/>
                            </c:if>
                            <input type="hidden" name="takeTurnsStatus" value="${empty prank.isTakeTurns?true:prank.isTakeTurns}"/>
                            <input type="checkbox" name="isTakeTurns" data-size="mini" ${(empty prank.isTakeTurns or prank.isTakeTurns)?'checked':''}>
                            <%--<span class="m-l m-r"><i class="fa fa-question-circle"></i></span>--%>
                            <span tabindex="0" class="m-l m-r help-popover" role="button" data-container="body" data-toggle="popover"  data-trigger="focus" data-placement="right" data-content="${views.content['当某支付方式']}">
                                <i class="fa fa-question-circle"></i>
                            </span>
                            <b class="co-yellow">${views.content['payAccount.suggest.enable']}</b>
                            <label class="m-l-sm"><input type="radio" class="i-checks" name="takeTurns" value="2" ${empty prank.takeTurns || prank.takeTurns eq '2'?'checked':''}>${views.content['payAccount.manual']}</label>
                            <label class="m-l-sm"><input type="radio" class="i-checks" name="takeTurns" value="1" ${prank.takeTurns eq '1'?'checked':''}>${views.content['payAccount.auto']}</label>
                        </div>
                    </div>
                    <div class="line-hi34 col-sm-12 bg-gray m-b">
                        <span class="co-yellow m-r-sm"><i class="fa fa-exclamation-circle"></i></span>
                         ${views.content['payAccount.drag.tip']}
                    </div>
                    <div class="clearfix m-b limit_title_wrap">
                        <h3 name="type" class="limit_title cur" data="online">${views.role['automatic']}</h3>
                        <h3 name="type" class="limit_title" data="scan">${views.content['扫码支付']}</h3>
                    </div>
                    <hr class="m-t m-b-sm">
                    <%--线上支付--%>
                    <div id="online" class="table-responsive">
                        <table class="table table-striped table-hover dataTable m-b-sm dragdd">
                            <tbody class="dd-list1">
                            <c:forEach items="${command.payAccountCashOrderList}" var="order" varStatus="status">
                                <tr data-id="${empty order.sort?status.index:order.sort}" class="dd-item1 tab-detail">
                                    <input type="hidden" name="payRankId" value="${order.id}" />
                                    <input type="hidden" name="payAccountId" value="${order.payAccountId}" />
                                    <td class="td-handle1" width="80"><i class="fa fa-arrows"></i></td>
                                    <td  width="50" >${order.sort}</td>
                                    <td  width="80" style="text-align: left" class="td-handle1">
                                        <span>${dicts.common.bankname[order.bankCode]}</span>
                                    </td>
                                    <td  width="80" style="text-align: left">${order.accountName}</td>
                                    <td class="co-yellow"  width="250" style="text-align: left">${order.account}</td>
                                    <td  width="180" style="text-align: left">${views.column['VPayAccount.disableAmount']}：<fmt:formatNumber value="${empty order.disableAmount?0:order.disableAmount}" pattern="#,####.##"/></td>
                                    <td  width="80">
                                        <c:choose>
                                            <c:when test="${order.status=='1'}">
                                                <span class="label label-success">${views.content['payAccount.status.1']}</span>
                                            </c:when>
                                            <c:when test="${order.status=='2'}">
                                                <span class="label label-danger">${views.content['payAccount.status.2']}</span>
                                            </c:when>
                                            <c:when test="${order.status == '3'}">
                                                <span class="label label-info">${views.content['payAccount.status.3']}</span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td>&nbsp;</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${fn:length(command.payAccountCashOrderList)<1}">
                                <tr>
                                    <td colspan="7" class="no-content_wrap">
                                        <div>
                                            <i class="fa fa-exclamation-circle"></i> ${views.content['payAccount.rankNotAccount']}
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                    <%--扫码支付--%>
                    <div id="scan" class="table-responsive" style="display: none">
                        <table class="table table-striped table-hover dataTable m-b-sm dragdd">
                            <tbody class="dd-list1">
                            <c:forEach items="${command.scanCashOrderList}" var="order" varStatus="status">
                                <tr data-id="${empty order.sort?status.index:order.sort}" class="dd-item1 tab-detail">
                                    <input type="hidden" name="payRankId" value="${order.id}" />
                                    <input type="hidden" name="payAccountId" value="${order.payAccountId}" />
                                    <td class="td-handle1" width="80"><i class="fa fa-arrows"></i></td>
                                    <td  width="50" >${order.sort}</td>
                                    <td  width="80" style="text-align: left" class="td-handle1">
                                        <span>${dicts.common.bankname[order.bankCode]}</span>
                                    </td>

                                    <td  width="80" style="text-align: left">${order.accountName}</td>
                                    <td class="co-yellow"  width="250" style="text-align: left">${order.account}</td>
                                    <td  width="180" style="text-align: left">${views.column['VPayAccount.disableAmount']}：<fmt:formatNumber value="${empty order.disableAmount?0:order.disableAmount}" pattern="#,####.##"/></td>
                                    <td  width="80">
                                        <c:choose>
                                            <c:when test="${order.status=='1'}">
                                                <span class="label label-success">${views.content['payAccount.status.1']}</span>
                                            </c:when>
                                            <c:when test="${order.status=='2'}">
                                                <span class="label label-danger">${views.content['payAccount.status.2']}</span>
                                            </c:when>
                                            <c:when test="${order.status == '3'}">
                                                <span class="label label-info">${views.content['payAccount.status.3']}</span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td>&nbsp;</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${fn:length(command.scanCashOrderList)<1}">
                                <tr>
                                    <td colspan="7" class="no-content_wrap">
                                        <div>
                                            <i class="fa fa-exclamation-circle"></i> ${views.content['payAccount.rankNotAccount']}
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                    <div class="operate-btn">
                        <soul:button target="${root}/vPayAccount/remDialog.html" text="" title="${views.content['payAccount.colseInMoney']}" opType="dialog" cssClass="hid" id="remDialog" callback="closeTurn"/>
                        <%--<button class="btn btn-filter btn-lg">${views.common['save']}</button>--%>
                        <soul:button target="applyCashFlowOrder" precall="validateCondition" text="${views.common['save']}" opType="function" cssClass="btn btn-filter btn-lg m-r" callback="requery">${views.common['save']}</soul:button>
                    </div>
                </div>
            </div>
        </div>
</form:form>
<soul:import res="site/content/payaccount/PayAccountEdit"/>
</html>