<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.VPayAccountVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<form:form>
    <div style="display: none" id="validateRule">${command.validateRule}</div>
    <input type="hidden" value="${command.result.id}" name="result.id">
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['运营']}</span><span>/</span>
		<span>
			<c:if test="${command.search.type eq '1'}">
                ${views.sysResource['公司入款账户']}
            </c:if>
			<c:if test="${command.search.type eq '2'}">
                ${views.sysResource['线上支付账户']}
            </c:if>
		</span>
            <soul:button target="goToLastPage" refresh=""
                         cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text=""
                         opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
        </div>
        <c:set value="${command.result}" var="result"/>
        <c:set value="${command.playerRankList}" var="list"/>
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
                                <th class="bg-tbcolor">${views.column['VPayAccount.code']}：</th>
                                <td>${result.code}</td>
                                <th class="bg-tbcolor">${views.column['VPayAccount.payName']}：</th>
                                <td>${result.payName}</td>
                                <th class="bg-tbcolor">${views.column['PayAccount.account']}：</th>
                                <td><a href="javascript:void(0)">${result.account}</a></td>
                                <th class="bg-tbcolor">${views.column['VPlayerRecharge.rechargeType']}：</th>
                                <td>${dicts.common.bankname[result.bankCode]}</td>
                            </tr>
                            <%--<c:if test="${result.type=='1'}">--%>
                                <%--<tr class="tab-title">--%>
                                    <%--<th class="bg-tbcolor">${views.column['VPayAccount.fullName']}：</th>--%>
                                    <%--<td>${result.fullName}</td>--%>
                                    <%--&lt;%&ndash;<th class="bg-tbcolor">${views.column['PayAccount.disableAmount']}：</th>&ndash;%&gt;--%>
                                    <%--&lt;%&ndash;<td>${empty result.disableAmount?0:soulFn:formatCurrency(result.disableAmount)}</td>&ndash;%&gt;--%>
                                    <%--&lt;%&ndash;<th class="bg-tbcolor">&ndash;%&gt;--%>
                                        <%--&lt;%&ndash;${views.content['payAccount.view.ckcs']}<span title="" data-original-title="" data-content="指账户入款清零后，本周期内该账户收到的成功存款订单次数；<br>PS：账户入款清零时间，请在“预警设置”页面设置；" data-html="true" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover m-l-sm" tabindex="0"><i class="fa fa-question-circle"></i></span>：&ndash;%&gt;--%>
                                    <%--&lt;%&ndash;</th>&ndash;%&gt;--%>
                                    <%--&lt;%&ndash;<td>${empty result.depositCount?0:result.depositCount}${views.common['ci']}</td>&ndash;%&gt;--%>
                                    <%--&lt;%&ndash;<th class="bg-tbcolor">&ndash;%&gt;--%>
                                        <%--&lt;%&ndash;${views.column['VPlayerRecharge.rechargeAmount']}<span title="" data-original-title="" data-content="指账户入款清零后，本周期内该账户收到的成功存款订单金额；<br>PS：账户入款清零时间，请在“预警设置”页面设置；" data-html="true" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover m-l-sm" tabindex="0"><i class="fa fa-question-circle"></i></span>：&ndash;%&gt;--%>
                                    <%--&lt;%&ndash;</th>&ndash;%&gt;--%>
                                    <%--&lt;%&ndash;<td>${empty result.depositTotal?0:soulFn:formatCurrency(result.depositTotal)}</td>&ndash;%&gt;--%>

                                <%--</tr>--%>
                            <%--</c:if>--%>
                            <c:if test="${result.type=='2'}">
                                <tr class="tab-title">
                                    <c:set var="channelLength" value="${fn:length(command.channelJson)}"></c:set>
                                    <c:forEach items="${command.channelJson}" var="json" begin="1" end="4"
                                               varStatus="vs">
                                        <th>${messages.content['pay_channel.'.concat(json.get("view"))]}：</th>
                                        <td>
                                            <div style="width: 200px;cursor: pointer;display: -webkit-box;-webkit-box-orient: vertical;-webkit-line-clamp: 2;overflow: hidden;" title="${json.get("value")}">${json.get("value")}</div>
                                        </td>
                                    </c:forEach>
                                    <c:if test="${channelLength<4}">
                                        <c:forEach var="tr" begin="${channelLength}" end="4">
                                            <td></td>
                                        </c:forEach>
                                    </c:if>
                                </tr>
                                <tr class="tab-title">
                                    <th class="bg-tbcolor">${views.content['支持货币：']}</th>
                                    <td>
                                        <c:forEach var="cur" items="${command.payAccountCurrencyList}">
                                            ${dicts.common.currency[cur.currencyCode]}
                                        </c:forEach>
                                    </td>
                                    <th class="bg-tbcolor">${views.column['PayAccount.disableAmount']}：</th>
                                    <td>${command.result.disableAmount}</td>
                                    <th class="bg-tbcolor">${views.content['payAccount.view.ckcs']}：</th>
                                    <td>${command.result.depositCount}</td>
                                    <th class="bg-tbcolor">${views.column['VPlayerRecharge.rechargeAmount']}：</th>
                                    <td>${soulFn:formatCurrency(command.result.depositTotal)}</td>
                                </tr>
                            </c:if>
                            <tr class="tab-title">

                                <th class="bg-tbcolor">
                                    ${views.column['VPayAccount.ljckcs']}<span title="" data-original-title="" data-content="${views.content_auto['创建至今']}；" data-html="true" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover m-l-sm" tabindex="0"><i class="fa fa-question-circle"></i></span>：
                                </th>
                                <td id="depositDefaultCountTD">
                                    <span id="depositDefaultCountSPAN">${empty result.depositDefaultCount?0:result.depositDefaultCount}</span>${views.common['ci']}
                                    <span>
                                        <soul:button cssClass="m-l-sm" target="editDepositDefaultCount" text="${views.content_auto['编辑']}" opType="function"/>
                                        <soul:button cssClass="m-l-sm" target="recoveryData" url="${root}/payAccount/recoveryData/count.html"
                                                     text="${views.column['PayAccount.revert']}"
                                                     opType="function"/>
                                    </span>
                                </td>
                                <td class="hide" id="depositDefaultCountTD2">
                                    <input type="text" value="${result.depositDefaultCount}" id="depositDefaultCount" name="result.depositDefaultCount"/>
                                    ${views.common['ci']}
                                    <span>
                                        <soul:button cssClass="m-l-sm"
                                                     target="saveDepositDefault"
                                                     text="${views.content_auto['保存']}" opType="function"
                                                     url="${root}/payAccount/saveDepositDefaultCount.html"/>
                                        <soul:button cssClass="m-l-sm" target="cancleDepositDefaultCount"
                                                     text="${views.common_report['取消']}"
                                                     opType="function"/>
                                    </span>
                                </td>

                                <th class="bg-tbcolor">
                                    ${views.column['VPayAccount.ljckje']}<span title="" data-original-title="" data-content="${views.content_auto['创建至今该账户']}；" data-html="true" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover m-l-sm" tabindex="0"><i class="fa fa-question-circle"></i></span>：
                                </th>
                                <td id="depositDefaultTotalTD">
                                    <span>${empty result.depositDefaultTotal?0:soulFn:formatCurrency(result.depositDefaultTotal)}</span>
                                    <span>
                                        <soul:button cssClass="m-l-sm"
                                                     target="editDepositDefaultTotal"
                                                     text="${views.content_auto['编辑']}"
                                                     opType="function"/>
                                        <soul:button cssClass="m-l-sm" target="recoveryData" url="${root}/payAccount/recoveryData/total.html"
                                                     text="${views.column['PayAccount.revert']}"
                                                     opType="function"/>
                                    </span>
                                </td>
                                <td class="hide" id="depositDefaultTotalTD2">
                                    <input type="text" value="${empty result.depositDefaultTotal?0:result.depositDefaultTotal}" id="depositDefaultTotal" name="result.depositDefaultTotal"/>
                                    <span>
                                        <soul:button cssClass="m-l-sm"
                                                     target="saveDepositDefault" text="${views.content_auto['保存']}" opType="function"
                                                     url="${root}/payAccount/saveDepositDefaultTotal.html"/>
                                        <soul:button cssClass="m-l-sm" target="cancleDepositDefaultTotal"
                                                     text="${views.common_report['取消']}"
                                                     opType="function"/>
                                    </span>
                                </td>

                                <th class="bg-tbcolor">${views.column['VPayAccount.zhcksj']}：</th>
                                <td>${soulFn:formatDateTz(result.lastRecharge,DateFormat.DAY_SECOND,timeZone)}</td>
                                <th class="bg-tbcolor">${views.column['VPayAccount.status']}：</th>
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
                                    <span class="label ${color}">${dicts.content.pay_account_status[result.statusLabel]}</span>
                                </td>
                            </tr>
                            <c:if test="${result.type=='1'}">
                                <c:if test="${result.accountType=='1'}">
                                    <tr class="tab-title">
                                        <th class="bg-tbcolor">${views.content['开户行：']}</th>
                                        <td>${result.openAcountName}</td>
                                        <th>${views.content['支持货币：']}</th>
                                        <td>
                                            <c:set var="allCurrency"
                                                   value="${fn:length(command.payAccountCurrencyList)}"></c:set>
                                            <c:forEach var="cu" items="${command.payAccountCurrencyList}"
                                                       varStatus="vs">
                                                ${dicts.common.currency[cu.currencyCode]}
                                                <c:if test="${vs.index+1<allCurrency}">，</c:if>
                                            </c:forEach>
                                        </td>
                                        <th class="bg-tbcolor">${views.column['VPayAccount.payRankNum']}：</th>
                                        <td colspan="3" style="width:40%">
                                            <c:choose>
                                                <c:when test="${command.result.fullRank}">
                                                    ${views.content['payAccount.View.allRank']}
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach items="${list}" var="item">
                                                        ${item.rankName}&nbsp;&nbsp;
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:if>
                                <c:if test="${result.accountType!='1'}">
                                    <tr class="tab-title">
                                        <th class="bg-tbcolor">${views.content['payaccount.company.edit.qrcode']}</th>
                                        <td>
                                            <c:if test="${empty result.qrCodeUrl}">${views.content_auto['无']}</c:if>
                                            <c:if test="${not empty result.qrCodeUrl}">
                                                <soul:button target="previewImg" text="${views.content_auto['点击预览']}" opType="function">
                                                    <img style="height: 35px" data-src="${soulFn:getImagePath(domain,result.qrCodeUrl)}" src="${soulFn:getThumbPath(domain,result.qrCodeUrl,0,0)}" class="table-tdcode">
                                                    ${views.content['点击预览']}
                                                </soul:button>
                                            </c:if>
                                        </td>
                                        <th>${views.content['支持货币：']}</th>
                                        <td>
                                            <c:set var="allCurrency"
                                                   value="${fn:length(command.payAccountCurrencyList)}"></c:set>
                                            <c:forEach var="cu" items="${command.payAccountCurrencyList}" varStatus="vs">
                                                ${dicts.common.currency[cu.currencyCode]}
                                                <c:if test="${vs.index+1<allCurrency}">，</c:if>
                                            </c:forEach>
                                        </td>
                                        <th class="bg-tbcolor">${views.column['VPayAccount.payRankNum']}：</th>
                                        <td colspan="3" style="width:40%">
                                            <c:choose>
                                                <c:when test="${command.result.fullRank}">
                                                    ${views.content['payAccount.View.allRank']}
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach items="${list}" var="item">
                                                        ${item.rankName}&nbsp;&nbsp;
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:if>
                            <c:if test="${result.type=='1'}">
                                <tr class="tab-title">
                                    <th class="bg-tbcolor">${views.column['VPayAccount.fullName']}：</th>
                                    <td>${result.fullName}</td>
                                    <th class="bg-tbcolor">${views.content['前端备注：']}</th>
                                    <%--<td colspan="5" width="67.5%">${command.result.remark}</td>--%>
                                    <td >${command.result.remark}</td>
                                    <th class="bg-tbcolor">${views.content_auto['自定义别名']}</th>
                                    <td >${command.result.aliasName}</td>
                                    <th class="bg-tbcolor">${views.content_auto['柜员机/柜台存款']}</th>
                                    <c:choose>
                                        <c:when test="${command.result.supportAtmCounter}"><td >${views.content_auto['启用']}</td></c:when>
                                        <c:otherwise><td >${views.content_auto['禁用']}</td></c:otherwise>
                                    </c:choose>
                                </tr>
                            </c:if>
                            <c:if test="${result.type=='2'}">
                                <tr class="tab-title">
                                   <%-- <th class="bg-tbcolor">${views.content_auto['有效分钟数']}：</th>
                                    <td>${empty command.result.effectiveMinutes?0:command.result.effectiveMinutes}&nbsp;分钟</td>
                                    <th>${views.content_auto['单笔存款上下限']}：</th>
                                    <td>
                                            ${command.result.singleDepositMin}
                                        <c:if test="${not empty command.result.singleDepositMin}">
                                            ~
                                        </c:if>
                                            ${command.result.singleDepositMax}
                                    </td>--%>
                                    <th class="bg-tbcolor">${views.column['VPayAccount.payRankNum']}：</th>
                                    <td colspan="3"　style="width:40%" class="al-left">
                                        <c:choose>
                                            <c:when test="${command.result.fullRank}">
                                                ${views.content['payAccount.View.allRank']}
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach items="${list}" var="item">
                                                    ${item.rankName}&nbsp;&nbsp;
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form:form>
<soul:import res="site/content/payaccount/View"/>