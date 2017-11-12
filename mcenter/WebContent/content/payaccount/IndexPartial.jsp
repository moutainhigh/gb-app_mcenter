<%@ page import="so.wwb.gamebox.model.master.content.po.VPayAccount" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.VPayAccountListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="poType" value="<%= VPayAccount.class %>"></c:set>

<!--//region your codes 1-->
<div id="editable_wrapper" class="dataTables_wrapper" role="grid">
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable m-b-sm" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th><input type="checkbox" class="i-checks"></th>
            <th>${views.common['number']}</th>
            <th>
                ${views.column['PlayerRank.rankCode']}
            </th>
            <th>${views.column['VPayAccount.accountName']}</th>
            <th>${views.column['VPayAccount.account']}</th>
            <th class="inline">${views.column['PayAccount.bankCode']}
                    <%--<select name="search.bankCode" data-placeholder="${views.column['PayAccount.bankCode']}" value="${command.search.bankCode}"  class="btn-group chosen-select-no-single" tabindex="-1" callback="query">
                        <option value="" selected>${views.column['PayAccount.bankCode']}</option>
                        <c:forEach  items="${filterDeposit}" var="item" varStatus="status">
                            <c:choose>
                                <c:when test="${command.search.type=='1'}">
                                    <c:if test="${item.type!='3'}">
                                        <option value="${item.bankName}" >${dicts.common.bankname[item.bankName]}</option>
                                    </c:if>
                                </c:when>
                                <c:otherwise>
                                    <c:if test="${item.type=='3'}">
                                        <option value="${item.bankName}" >${dicts.common.bankname[item.bankName]}</option>
                                    </c:if>
                                </c:otherwise>
                            </c:choose>

                        </c:forEach>
                    </select>--%>
            </th>
        <c:if test="${command.search.type=='1'}">
            <th>${views.content_auto['姓名']}</th>
            <th>${views.content_auto['别名']}</th>
        </c:if>
            <soul:orderColumn poType="${poType}" property="payRankNum" column="${views.column['VPayAccount.payRankNum']}"/>
            <soul:orderColumn poType="${poType}" property="depositDefaultCount" column='
            <span
                        tabindex="0" class="m-l-sm help-popover" role="button" data-container="body"
                        data-toggle="popover" data-trigger="focus" data-placement="top"
                        data-content="${views.content_auto[\'统计创建至今，该账户累计收到的成功存款订单总次数；\']}" data-original-title="" title=""><i
                        class="fa fa-question-circle"></i>
                </span>
            ${views.content_auto[\'存款次数\']}'/>
            <soul:orderColumn poType="${poType}" property="depositDefaultTotal" column='
            <span
                        tabindex="0" class="m-l-sm help-popover" role="button" data-container="body"
                        data-toggle="popover" data-trigger="focus" data-placement="top"
                        data-content="${views.content_auto[\'统计创建至今，该账户累计收到的成功存款订单累计金额；\']}" data-original-title="" title=""><i
                        class="fa fa-question-circle"></i>
                </span>
            ${views.content_auto[\'累计存款金额\']}${siteCurrency}'/>
            <th class="inline">
                <gb:select name="search.status" value="${command.search.status}" cssClass="btn-group chosen-select-no-single" prompt="${views.common['all']}" list="${statusMap}" callback="query"/>
            </th>
            <th>${views.content['isEnable']}</th>
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
                    <c:choose>
                        <c:when test="${p.status eq '1'}">
                            <c:set var="color" value="label-success"></c:set>
                        </c:when>
                        <c:when test="${p.status eq '2'}">
                            <c:set var="color" value="label-danger"></c:set>
                        </c:when>
                        <c:when test="${p.status eq '3'}">
                            <c:set var="color" value="label-info"></c:set>
                        </c:when>
                    </c:choose>
                    <td><label><input type="checkbox" class="i-checks" value="${p.id}"></label></td>
                    <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(stat.index+1)}</td>
                    <td>${p.code}</td>

                    <td>${p.payName}</td>
                    <td>${p.account}</td>
                    <td>${dicts.common.bankname[p.bankCode]}</td>
                    <c:if test="${command.search.type=='1'}">
                    <td>${p.fullName}</td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty p.aliasName}">
                                ${p.aliasName}
                            </c:when>
                            <c:otherwise>
                                ---
                            </c:otherwise>
                        </c:choose>
                    </td>
                    </c:if>
                    <td>
                        <div class="btn-group" ajaxId="${p.id}">
                            <c:choose>
                                <c:when test="${p.fullRank}">
                                    <span class="btn btn-warning dropdown-toggle btn-xs">${views.content['全部层级']}</span>
                                </c:when>
                                <c:otherwise>
                                    <button data-toggle="dropdown" class="btn btn-warning dropdown-toggle btn-xs">${empty p.payRankNum?0:p.payRankNum}${views.content['个']}<i class="fa fa-angle-down"></i></button>
                                </c:otherwise>
                            </c:choose>
                            <ul class="dropdown-menu lang">
                                <%--<c:forEach items="${p.payRankList}" var="payRank">
                                    <li>
                                        <a href="javascript:void(0)">${payRank.rankName}</a>
                                        <soul:button tag="a" target="${root}/vPayAccount/delpayrank.html?search.id=${payRank.payRankId}" text="" opType="ajax" cssClass="clo" confirm="${views.role['playerrank.delete']}" callback="query"><img src="${resComRoot}/images/cle.png"></soul:button>
                                        &lt;%&ndash;<a href="/playerRank/rank_delete.html?id=${payRank.payRankId}" nav-target='mainFrame' class="clo"><img src="${resComRoot}/images/cle.png"></a>&ndash;%&gt;
                                    </li>
                                </c:forEach>--%>
                            </ul>
                        </div>
                    </td>
                    <%--<td>${empty p.disableAmount?0:soulFn:formatInteger(p.disableAmount).concat(soulFn:formatDecimals(p.disableAmount))}${views.common['yuan']}</td>--%>
                    <td>${empty p.depositCount?0:p.depositDefaultCount}${views.common['ci']}</td>
                    <td>${empty p.depositTotal?0:soulFn:formatInteger(p.depositDefaultTotal).concat(soulFn:formatDecimals(p.depositDefaultTotal))}&nbsp;${siteCurrency}</td>
                    <td><span class="label ${color}" id="status${stat.index}">${dicts.content.pay_account_status[p.statusLabel]}</span></td>
                    <td>
                        <c:choose>
                            <c:when test="${p.status eq '1'}">
                                <input type="checkbox" name="my-checkbox" tt="${stat.index}" payRankId="${p.id}" data-size="mini" checked>
                            </c:when>
                            <c:when test="${p.status eq '2'}">
                                <input type="checkbox" name="my-checkbox" tt="${stat.index}" payRankId="${p.id}" data-size="mini">
                            </c:when>
                            <c:when test="${p.status eq '3'}">
                                <soul:button target="${root}/payAccount/thawInfo.html?search.id=${p.id}" text="${views.content['payAccount.unfreeze']}" opType="dialog" callback="callBackQuery" />
                            </c:when>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${command.search.type=='1'}">
                                <shiro:hasPermission name="content:payaccount_edit">
                                <a href="/payAccount/companyEdit.html?id=${p.id}" nav-target="mainFrame">${views.common['edit']}</a>
                                </shiro:hasPermission>
                            </c:when>
                            <c:otherwise>
                                <shiro:hasPermission name="content:onlineaccount_edit">
                                <a href="/payAccount/onLineEdit.html?id=${p.id}" nav-target="mainFrame">${views.common['edit']}</a>
                                </shiro:hasPermission>
                            </c:otherwise>

                        </c:choose>
                        <span class="dividing-line m-r-xs m-l-xs">|</span>
                        <a href="/vPayAccount/detail.html?result.id=${p.id}&search.type=${command.search.type}" nav-target="mainFrame">${views.common['detail']}</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${fn:length(command.result)<1}">
                <tr>
                    <td colspan="13" class="no-content_wrap">
                        <div>
                            <i class="fa fa-exclamation-circle"></i>
                            <c:if test="${command.search.type eq '1'}">
                                ${views.content['payAccount.notInMoneyMessage']}
                            </c:if>
                            <c:if test="${command.search.type eq '2'}">
                                ${views.content['payAccount.notPayMessage']}
                            </c:if>
                        </div>
                    </td>
                </tr>
            </c:if>
        </tbody>
    </table>
    <li style="display: none" id="rankTmpl">
        <a href="javascript:void(0)">{rankName}</a>
        <soul:button permission="content:payaccount_delete" tag="a" target="${root}/vPayAccount/delpayrank.html?search.id={payRankId}" text="" opType="ajax" cssClass="clo" confirm="${views.role['playerrank.delete']}" callback="query"><img src="${resRoot}/images/cle.png"></soul:button>
    </li>
</div>
<soul:pagination/>
</div>

