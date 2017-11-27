<%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.VPlayerApiTransactionVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->
<form:form action="" method="post">
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.report_auto['统计报表']}</span>
            <span>/</span><span>${views.report_auto['转账记录']}</span>
            <soul:button tag="a" target="goToLastPage" text="" opType="function"
                         cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>

        <c:set value="" var="_symbol"></c:set>
        <c:set value="" var="_desc"></c:set>

            <%--转账:转入 转出 --%>
        <c:choose>
            <c:when test="${command.result.fundType eq 'transfer_into'}">
                <c:set value="+" var="_symbol"></c:set>
                <c:set value="${gbFn:getSiteApiName(command.result.apiId.toString())} - ${views.report['fund.list.wallect']}"
                       var="_desc"></c:set>
                <%--转入--%>
            </c:when>
            <c:when test="${command.result.fundType eq 'transfer_out'}">
                <c:set value="${views.report['fund.list.wallect']} - ${gbFn:getSiteApiName(command.result.apiId.toString())}"
                       var="_desc"></c:set>
                <%--转出--%>
            </c:when>
        </c:choose>

        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="co-gray6">${views.report_auto['转账详细']}</h3>
                </div>

                <div class="panel-body p-sm">
                    <table class="table no-border table-desc-list">
                        <tbody>
                        <tr>
                            <td colspan="2" class="text-right">
                                    ${views.report_auto['交易号']}：${command.result.transactionNo}
                                <a type="button" class="btn btn-sm btn-info btn-stroke m-l-sm" name="copy"
                                   data-clipboard-text="${command.result.transactionNo}"><i class="fa fa-copy"
                                                                                            title="${views.report_auto['复制']}"></i></a>
                            </td>
                        </tr>

                        <tr>
                            <th scope="row" class="text-right">${views.report_auto['玩家账号']}：</th>
                            <td>
                                <shiro:hasPermission name="role:player_detail">
                                <a class="btn btn-link co-blue"
                                   href="/player/playerView.html?search.id=${command.result.playerId}"
                                   nav-target="mainFrame"></shiro:hasPermission>
                                   ${command.result.username}
                                <shiro:hasPermission name="role:player_detail"></a></shiro:hasPermission>
                                <a type="button" class="btn btn-link"
                                   href="/report/fundsTrans/apiTrans.html?search.username=${command.result.username}&search.fundTypes=transfer_into&search.fundTypes=transfer_out&search.type=playerDetail"
                                   nav-target="mainFrame"><i class="iconfont icon-wanjiaguanli"></i>${views.report_auto['查看所有订单']}</a>
                            </td>
                        </tr>

                        <tr>
                            <th scope="row" class="text-right">${views.report_auto['所属代理']}：</th>
                            <td>
                                <a class="btn btn-link co-blue"
                                   href="/userAgent/agent/detail.html?search.id=${command.result.agentid}"
                                   nav-target="mainFrame">${command.result.agentname}</a>

                            </td>
                        </tr>


                        <tr>
                            <th scope="row" class="text-right">${views.report_auto['钱包余额']}：</th>
                            <td class="money ">${siteCurrencySign}${command.result.balance}</td>
                        </tr>

                        <tr>
                            <th scope="row" class="text-right">${views.report_auto['API余额']}：</th>
                            <td class="money ">${siteCurrencySign}${command.result.apiMoney}</td>
                        </tr>

                        <tr>
                            <th scope="row" class="text-right">${views.report_auto['类型']}：</th>
                            <td>${_desc}</td>
                        </tr>

                        <tr>
                            <th scope="row" class="text-right">${views.report_auto['创建时间']}：</th>
                            <td>${soulFn:formatDateTz(command.result.createTime, DateFormat.DAY_SECOND,timeZone)} -
                                <span class="co-grayc2">${soulFn:formatTimeMemo(command.result.createTime, locale)}</span>
                            </td>
                        </tr>

                        <c:choose>
                            <c:when test='${command.result.status eq "success"}'>
                                <c:set var="status_class" value="co-green"></c:set>
                                <c:set var="tr_class" value="success major"></c:set>
                            </c:when>
                            <c:when test='${command.result.status eq "process"}'>
                                <c:set var="status_class" value="co-yellow"></c:set>
                                <c:set var="tr_class" value="warning major"></c:set>
                            </c:when>
                            <c:otherwise>
                                <c:set var="status_class" value="co-red"></c:set>
                                <c:set var="tr_class" value="danger major"></c:set>
                            </c:otherwise>
                        </c:choose>
                        <tr class="${tr_class}">
                            <th scope="row" class="text-right">${views.report_auto['转账金额']}：</th>
                            <td class="money"><strong>${siteCurrencySign}${command.result.transactionMoney}</strong> <span
                                    class="${status_class}">${dicts.common.status[command.result.status]}</span>
                                <c:if test="${command.result.origin eq 'MOBILE'}">
                                    <span class="fa fa-mobile mobile" data-content="${views.report_auto['手机订单']}" data-placement="top"
                                          data-trigger="focus" data-toggle="popover" data-container="body" role="button"
                                          class="help-popover" tabindex="0">
                                    </span>
                                </c:if>
                            </td>
                        </tr>

                        <tr>
                            <th scope="row" class="text-right">${views.report_auto['操作时间']}：</th>
                            <td>${soulFn:formatDateTz(command.result.completionTime, DateFormat.DAY_SECOND,timeZone)} -
                                <span class="co-grayc2">${soulFn:formatTimeMemo(command.result.completionTime, locale)}</span>
                            </td>
                        </tr>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</form:form>
<soul:import res="site/report/fund/views"/>
<!--//endregion your codes 1-->