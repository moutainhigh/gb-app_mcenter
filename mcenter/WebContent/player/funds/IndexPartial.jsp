<%@ page import="so.wwb.gamebox.model.master.player.po.PlayerTransaction" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.PlayerTransactionListVo"--%>
<%--@elvariable id="player" type="so.wwb.gamebox.model.master.player.po.VUserPlayer"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="poType" value="<%= PlayerTransaction.class %>"></c:set>
<form:input path="command.search.playerId" value="${command.search.playerId}" type="hidden"/>
<div class="table-responsive  table-min-h">
    <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
        <div id="tab-1">
            <table class="table table-striped table-bordered table-hover dataTable" aria-describedby="editable_info">
                <thead>
                <tr>
                    <th>${views.common['number']}</th>
                    <th>${views.column['PlayerTransaction.transactionNo']}</th>
                    <soul:orderColumn poType="${poType}" property="createTime"
                                      column="${views.column['PlayerTransaction.createTime']}"/>
                    <th class="inline">
                        <form:select callback="funds.query" path="command.search.transactionType"
                                     data-placeholder="${views.column['PlayerTransaction.transactionType']}"
                                     class="btn-group chosen-select-no-single">
                            <option value="">${views.column['PlayerTransaction.transactionType']}</option>
                            <c:forEach items="${command.dictCommonTransactionType}" var="i">
                                <c:if test="${i.key!='rebate'}">
                                    <option value="${i.key}"
                                            <c:if test="${i.key==command.search.transactionType}">selected</c:if>>${dicts.common.transaction_type[i.key]}</option>
                                </c:if>
                            </c:forEach>
                        </form:select>
                    </th>
                    <soul:orderColumn poType="${poType}" property="transactionMoney"
                                      column="${views.column['PlayerTransaction.transactionMoney']}"/>
                    <th class="inline">
                        <%--<gb:select name="transaction.search.status" cssClass="btn-group chosen-select-no-single" prompt="${views.role['player.view.funds.allStatus']}" list="${dicts.common.status}" listKey="key" listValue="value" callback="searchTransaction"/>--%>
                        <form:select callback="funds.query" path="command.search.status"
                                     data-placeholder="${views.role['player.view.funds.allStatus']}"
                                     class="btn-group chosen-select-no-single" tabindex="9">
                            <option value="">${views.role['player.view.funds.allStatus']}</option>
                            <c:forEach items="${command.dictCommonStatus}" var="i">
                                <option value="${i.key}"
                                        <c:if test="${command.search.status == i.key}">selected</c:if>>${dicts.common.status[i.key]}</option>
                            </c:forEach>
                        </form:select>
                    </th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${command.result}" var="pt" varStatus="status" begin="0" end="9">
                    <%--

                         交易记录表:player_transaction 字段 transaction_data, 各个交易方式需要保存的数据

                         存款:{"bankCode":"","username":"player","favorable":"1","poundage":"","bankOrder":""}
                         存款:{"银行代码":"","用户名":"","优惠":"","手续费":"","银行订单号":""}

                         取款:{"bankCode":"","bankNo":"","withdrawStatus":""}
                         取款:{"bankCode":"","银行卡号":"","稽核状态":""}


                         transfers 转账(转入,转出): API id    {"API":2}

                         backwater 返水:时间+期数; {"period":"1","date":"2015-05-09"}

                         favorable 优惠:优惠活动名称; {"favorableType":""}

                         recommend 推荐:被推荐人 {"username":""}

                         --银行代码为 字典 module = common and dict_type = bankname

                     --%>
                    <c:set value="" var="_symbol"></c:set>
                    <c:set value="" var="_desc"></c:set>
                    <c:choose>
                        <c:when test="${pt.transactionType eq 'favorable'}">
                            <%--优惠--%>
                            <c:set value="+" var="_symbol"></c:set>
                            <%--<c:set value="${dicts.common.transaction_way[pt._describe['favorableType']]}"
                                   var="_desc"></c:set>--%>
                            <c:choose>
                                <c:when test="${pt.transactionWay != null}">
                                    <c:set value="${dicts.common.fund_type[pt.fundType]}-${dicts.common.transaction_way[pt.transactionWay]}" var="_desc"></c:set>
                                </c:when>
                                <c:otherwise>
                                    <c:set value="${dicts.common.fund_type[pt.fundType]}" var="_desc"></c:set>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:when test="${pt.transactionType eq 'deposit'}">
                            <%--存款--%>
                            <c:set value="+" var="_symbol"></c:set>
                            <c:if test="${not empty pt.transactionWay && not empty dicts.common.transaction_way[pt.transactionWay]}">
                                <c:if test="${pt.fundType=='artificial_deposit'}">
                                    <c:set value="${views.fund['despoit.check.companyDespoit.administratorManualDeposit']}" var="_desc"></c:set>
                                </c:if>
                                <c:if test="${pt.fundType!='artificial_deposit'}">
                                    <c:set value="${dicts.common.transaction_way[pt.transactionWay]}" var="_desc"></c:set>
                                </c:if>
                            </c:if>
                            <c:if test="${empty pt.transactionWay || empty dicts.common.transaction_way[pt.transactionWay]}">
                                <c:set value="${dicts.common.fund_type[pt.fundType]}" var="_desc"></c:set>
                            </c:if>
                        </c:when>
                        <c:when test="${pt.transactionType eq 'withdrawals'}">
                            <%--取款--%>
                            <c:set value="${dicts.common.bankname[pt._describe['bankCode']]} ${views.fund['transaction.list.bankNoAfter']}${fn:substring(pt._describe['bankNo'],pt._describe['bankNo'].length()-4,pt._describe['bankNo'].length())}"
                                   var="_desc"></c:set>
                        </c:when>
                        <c:when test="${pt.transactionType eq 'transfers'}">
                            <%--转账:转入 转出 相对于钱包来说--%>
                            <c:choose>
                                <c:when test="${pt.fundType eq 'transfer_into'}">
                                    <c:set value="+" var="_symbol"></c:set>
                                    <c:set value="${gbFn:getSiteApiName(pt._describe['API'].toString())} ${dicts.common.transaction_type[pt.transactionType]}${views.fund['transaction.list.to']} ${views.fund['transaction.list.wallet']}"
                                           var="_desc"></c:set>
                                    <%--转入--%>
                                </c:when>
                                <c:when test="${pt.fundType eq 'transfer_out'}">
                                    <c:set value="${views.fund['transaction.list.wallet']} ${dicts.common.transaction_type[pt.transactionType]}${views.fund['transaction.list.to']} ${gbFn:getSiteApiName(pt._describe['API'].toString())}"
                                           var="_desc"></c:set>
                                    <%--转出--%>
                                </c:when>
                            </c:choose>
                        </c:when>
                        <c:when test="${pt.transactionType eq 'backwater'}">
                            <%--返水--%>
                            <c:set value="+" var="_symbol"></c:set>
                            <c:set value="${pt._describe['date']} ${pt._describe['period']}${views.fund['transaction.list.period']}"
                                   var="_desc"></c:set>
                        </c:when>
                        <c:when test="${pt.transactionType eq 'recommend'}">
                            <%--推荐--%>
                            <c:set value="+" var="_symbol"></c:set>
                            <c:set value="${views.fund['transaction.list.friend']} ${pt._describe['username']}"
                                   var="_desc"></c:set>
                        </c:when>
                    </c:choose>
                    <tr>
                        <td>${status.index+1}</td>
                        <td>${pt.transactionNo}</td>
                        <td>${soulFn:formatDateTz(pt.createTime, DateFormat.DAY_SECOND,timeZone)}</td>
                        <td>
                            <div>${dicts.common.transaction_type[pt.transactionType]}${pt.isFirstRecharge?'-'.concat(views.fund['despoit.index.firstRecharge']):''}</div>
                            <span class="co-gray9">${_desc}</span>
                        </td>
                        <td class="${pt.transactionMoney lt 0 ?'co-red':'co-green'}">${_symbol}${soulFn:formatCurrency(pt.transactionMoney)}
                        </td>
                        <td>
                            <c:if test="${pt.status=='failure'}">
                                <div class="co-red" title='${gbFn:unescapeXml(pt.failureReason)}'>${dicts.common.status[pt.status]}</div>
                            </c:if>
                            <c:if test="${pt.status=='success'}">
                                <div class="co-green">${dicts.common.status[pt.status]}</div>
                             </c:if>
                            <c:if  test="${pt.status!='failure'&&pt.status!='success'}">
                                ${dicts.common.status[pt.status]}
                            </c:if>
                        </td>
                        <%--<td  <c:if
                                test="${pt.status=='failure'}"> class="co-red" data-toggle="tooltip" data-placement="left" title="${pt.failureReason}"</c:if>
                                <c:if test="${pt.status=='success'}"> class="co-green"</c:if>>
                                ${dicts.common.status[pt.status]}
                        </td>--%>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<div class="clearfix remark-wrap">
    <div class="pull-left">
        <span class="m-r-md">${fn:replace(views.role['player.view.funds.currentTotal'],'{0}',transactionTotal['count'])}</span>
        <span class="m-r-md">
            <i class="icon iconfont"></i>&nbsp;&nbsp;${views.role['player.view.funds.depositTotal']}：
            <b class="co-blue">
                ${player.defaultCurrency}&nbsp;${soulFn:formatCurrency(transactionTotal['deposit'])}
            </b>
        </span>
        <span>
            <i class="fa fa-gamepad"></i>&nbsp;&nbsp;${views.role['player.view.funds.withdrawalsTotal']}：
            <b class="co-red2">
                ${player.defaultCurrency}&nbsp;${soulFn:formatCurrency(transactionTotal['withdrawals'])}
            </b>
        </span>
    </div>
    <c:if test="${command.paging.totalCount>10}">
        <a href="/report/vPlayerFundsRecord/fundsLog.html?search.userTypes=username&search.usernames=${sysUserVo.result.username}&search.outer=-1" nav-target="mainFrame"
           class="pull-right">${views.role['player.view.funds.viewMore']} &gt;&gt;</a>
    </c:if>
</div>
