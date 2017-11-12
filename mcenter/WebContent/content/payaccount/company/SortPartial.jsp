<%--@elvariable id="bankAccounts" type="java.util.List<so.wwb.gamebox.model.master.content.po.VPayAccountCashOrder>"--%>
<%--@elvariable id="thirdAccounts" type="java.util.List<so.wwb.gamebox.model.master.content.po.VPayAccountCashOrder>"--%>
<%--@elvariable id="rank" type="so.wwb.gamebox.model.master.player.po.PlayerRank"--%>

<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="line-hi34 col-sm-12 bg-gray m-b">
    ${views.content_auto['展示所有账户']}：
    <input type="checkbox" name="openMoreAccount" data-rank="${rank.id}" ${rank.displayCompanyAccount ?'checked':''} value="true"/>&nbsp;${views.content_auto['启用后']}。
    <span tabindex="0" class="m-l m-r help-popover" role="button" data-container="body" data-toggle="popover"  data-trigger="focus" data-placement="right" data-content=${views.content_auto['启用后']}>
        <i class="fa fa-question-circle"></i>
    </span>
</div>
<div class="line-hi34 col-sm-12 bg-gray m-b">
    <span class="co-yellow m-r-sm"><i class="fa fa-exclamation-circle"></i></span>
    ${views.content['payAccount.drag.tip']}
</div>
<div class="clearfix m-b limit_title_wrap">
    <h3 name="type" class="limit_title cur" data="bank">${views.content_auto['网银存款']}</h3>
    <h3 name="type" class="limit_title" data="third">${views.content_auto['电子支付']}</h3>
    <h3 name="type" class="limit_title" data="bitcoin">bitcoin</h3>
</div>
<hr class="m-t m-b-sm">
<%--银行账户--%>
<div id="bank" class="table-responsive">
    <table class="table table-striped table-hover dataTable m-b-sm dragdd">
        <tbody class="dd-list1">
        <c:forEach items="${bankAccounts}" var="i" varStatus="status">
            <tr class="dd-item1 tab-detail">
                <input type="hidden" name="playerRankId" value="${i.playerRankId}" />
                <input type="hidden" name="payAccountId" value="${i.payAccountId}" />
                <td class="td-handle1" width="80"><i class="fa fa-arrows"></i></td>
                <td  width="50">${status.index+1}</td>
                <td  width="80" style="text-align: left" class="td-handle1">
                    <span>${dicts.common.bankname[i.bankCode]}</span>
                </td>
                <td  width="80" style="text-align: left">${i.accountName}</td>
                <td  width="80" style="text-align: left">${empty i.aliasName?'--':i.aliasName}</td>
                <td class="co-yellow"  width="250" style="text-align: left">${i.account}</td>
                <td  width="180" style="text-align: left">${views.column['VPayAccount.disableAmount']}：${soulFn:formatCurrency(i.disableAmount)}</td>
                <td  width="80">
                    <c:choose>
                        <c:when test="${i.status=='1'}">
                            <span class="label label-success">${views.content['payAccount.status.1']}</span>
                        </c:when>
                        <c:when test="${i.status=='2'}">
                            <span class="label label-danger">${views.content['payAccount.status.2']}</span>
                        </c:when>
                        <c:when test="${i.status == '3'}">
                            <span class="label label-info">${views.content['payAccount.status.3']}</span>
                        </c:when>
                    </c:choose>
                </td>
                <td>&nbsp;</td>
            </tr>
        </c:forEach>
        <c:if test="${fn:length(bankAccounts)<1}">
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
<%--第三方账户--%>
<div id="third" class="table-responsive" style="display: none">
    <table class="table table-striped table-hover dataTable m-b-sm dragdd">
        <tbody class="dd-list1">
        <c:forEach items="${thirdAccounts}" var="i" varStatus="status">
            <tr class="dd-item1 tab-detail">
                <input type="hidden" name="playerRankId" value="${i.playerRankId}" />
                <input type="hidden" name="payAccountId" value="${i.payAccountId}" />
                <td class="td-handle1" width="80"><i class="fa fa-arrows"></i></td>
                <td  width="50" >${status.index+1}</td>
                <td  width="80" style="text-align: left" class="td-handle1">
                    <span>${dicts.common.bankname[i.bankCode]}</span>
                </td>

                <td  width="80" style="text-align: left">${i.accountName}</td>
                <td  width="80" style="text-align: left">${empty i.aliasName?'--':i.aliasName}</td>
                <td class="co-yellow"  width="250" style="text-align: left">${i.account}</td>
                <td  width="180" style="text-align: left">${views.column['VPayAccount.disableAmount']}：<fmt:formatNumber value="${empty order.disableAmount?0:order.disableAmount}" pattern="#,####.##"/></td>
                <td  width="80">
                    <c:choose>
                        <c:when test="${i.status=='1'}">
                            <span class="label label-success">${views.content['payAccount.status.1']}</span>
                        </c:when>
                        <c:when test="${i.status=='2'}">
                            <span class="label label-danger">${views.content['payAccount.status.2']}</span>
                        </c:when>
                        <c:when test="${i.status == '3'}">
                            <span class="label label-info">${views.content['payAccount.status.3']}</span>
                        </c:when>
                    </c:choose>
                </td>
                <td>&nbsp;</td>
            </tr>
        </c:forEach>
        <c:if test="${fn:length(thirdAccounts)<1}">
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
<%--比特币--%>
<div id="bitcoin" class="table-responsive" style="display: none">
    <table class="table table-striped table-hover dataTable m-b-sm dragdd">
        <tbody class="dd-list1">
        <c:forEach items="${bitAccounts}" var="i" varStatus="status">
            <tr class="dd-item1 tab-detail">
                <input type="hidden" name="playerRankId" value="${i.playerRankId}" />
                <input type="hidden" name="payAccountId" value="${i.payAccountId}" />
                <td class="td-handle1" width="80"><i class="fa fa-arrows"></i></td>
                <td  width="50" >${status.index+1}</td>
                <td  width="80" style="text-align: left" class="td-handle1">
                    <span>${dicts.common.bankname[i.bankCode]}</span>
                </td>

                <td  width="80" style="text-align: left">${i.accountName}</td>
                <td  width="80" style="text-align: left">${empty i.aliasName?'--':i.aliasName}</td>
                <td class="co-yellow"  width="250" style="text-align: left">${i.account}</td>
                <td  width="180" style="text-align: left">${views.column['VPayAccount.disableAmount']}：<fmt:formatNumber value="${empty order.disableAmount?0:order.disableAmount}" pattern="#,####.##"/></td>
                <td  width="80">
                    <c:choose>
                        <c:when test="${i.status=='1'}">
                            <span class="label label-success">${views.content['payAccount.status.1']}</span>
                        </c:when>
                        <c:when test="${i.status=='2'}">
                            <span class="label label-danger">${views.content['payAccount.status.2']}</span>
                        </c:when>
                        <c:when test="${i.status == '3'}">
                            <span class="label label-info">${views.content['payAccount.status.3']}</span>
                        </c:when>
                    </c:choose>
                </td>
                <td>&nbsp;</td>
            </tr>
        </c:forEach>
        <c:if test="${fn:length(bitAccounts)<1}">
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
    <soul:button target="save" text="${views.common['save']}" opType="function" cssClass="btn btn-filter btn-lg m-r">${views.common['save']}</soul:button>
</div>
