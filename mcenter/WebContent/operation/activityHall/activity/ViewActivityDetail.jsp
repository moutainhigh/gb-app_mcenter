<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.ActivityMessageVo"--%>
<%--@elvariable id="rulesListVo" type="so.wwb.gamebox.model.master.operation.vo.ActivityMoneyAwardsRulesListVo"--%>
<%@ include file="/include/include.inc.jsp" %>

<form:form>
<div class="row">
    <div class="position-wrap clearfix">
        <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
        <span>${views.sysResource['运营']}&nbsp;&nbsp;/</span><span>${views.sysResource['活动大厅']}</span>
        <soul:button target="goToLastPage" refresh="false" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
            <em class="fa fa-caret-left"></em>${views.common['return']}
        </soul:button>
        <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
    </div>
    <div class="col-lg-12 m-b">
        <div class="wrapper">
            <div class="wrapper shadow  white-bg" role="grid">
                <c:set value="${command.result}" var="p"></c:set>
                <input type="hidden" id="activityMessageId" value="${p.id}">
                <div class="m-sm">
                    <div class="clearfix">
                        <div class="clearfix m-l-lg line-hi34">
                            <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.type']}：</label>
                            <div class="col-sm-5 ">
                                ${dicts.common.activity_type[p.activityTypeCode]}
                            </div>
                        </div>
                        <div class="clearfix m-l-lg line-hi34">
                            <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.isDisplay']}：</label>
                            <div class="col-sm-5">
                                <c:choose>
                                    <c:when test="${p.isDisplay}">
                                        ${views.operation['Activity.step.isDisplay.true']}
                                    </c:when>
                                    <c:otherwise>
                                        ${views.operation['Activity.step.isDisplay.false']}
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="clearfix m-l-lg line-hi34">
                            <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.activityClass']}：</label>
                            <div class="col-sm-5">
                                    ${siteI18nMap[p.activityClassifyKey].value}
                            </div>
                        </div>
                        <div class="clearfix m-l-lg line-hi34" >
                            <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.activityTime']}：</label>
                            <div class="col-sm-5">
                                    ${soulFn:formatDateTz(p.startTime, DateFormat.DAY_SECOND,timeZone)}
                                -
                                    ${soulFn:formatDateTz(p.endTime, DateFormat.DAY_SECOND,timeZone)}
                            </div>
                        </div>

                        <%--<div class="clearfix m-l-lg line-hi34">--%>
                            <%--<label class="ft-bold col-sm-3 al-right">${views.operation['有效条件']}：</label>--%>
                            <%--<div class="col-sm-5 ">--%>
                                <%--<c:forEach items="${registeEffectiveList}" var="effective" >--%>
                                    <%--${views.operation[effective.preferentialCode]} &nbsp;&nbsp;--%>
                                <%--</c:forEach>--%>
                            <%--</div>--%>
                        <%--</div>--%>

                        <c:if test="${p.activityTypeCode ne 'content'}">
                            <div class="clearfix m-l-lg line-hi34">
                                <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.conditions']}：</label>
                                <!--    返水优惠-->
                                <c:if test="${p.activityTypeCode eq 'back_water'}">
                                    <div class="col-sm-5">
                                        <div class="tab-content">
                                            <table class="table border">
                                                <tr>
                                                    <th class="bg-gray">${views.operation['Activity.step.rakebackOffersName']}</th>
                                                    <th class="bg-gray">${views.operation['Activity.step.create']}</th>
                                                    <th class="bg-gray">${views.common['status']}</th>
                                                </tr>
                                                <c:forEach items="${rakebackSets}" var="r">
                                                    <tr>
                                                        <td>${r.name}</td>
                                                        <td>${soulFn:formatDateTz(r.createTime,DateFormat.DAY_SECOND,timeZone)}</td>
                                                        <td>
                                                            <c:if test="${r.status eq 0}">
                                                                <span class="label">
                                                                        ${views.common['disabled']}
                                                                </span>
                                                            </c:if>
                                                            <c:if test="${r.status eq 1}">
                                                                <span class="label label-success">
                                                                    ${views.common['normal']}
                                                                </span>
                                                            </c:if>
                                                            <c:if test="${r.status eq 2}">
                                                                <span class="label label-danger">
                                                                        ${views.common['delete']}
                                                                </span>
                                                            </c:if>
                                                            <%--<span class="label label-label-success">
                                                                <c:if test="${r.status eq 0}">${views.common['disabled']}</c:if>
                                                                <c:if test="${r.status eq 1}">${views.common['normal']}</c:if>
                                                                <c:if test="${r.status eq 2}">${views.common['delete']}</c:if>
                                                            </span>--%>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </table>
                                        </div>
                                    </div>
                                </c:if>
                                <div class="col-sm-8">
                                    <!--    盈亏送-->
                                    <c:if test="${p.activityTypeCode eq 'profit_loss'}">
                                        <table class="table table-bordered">
                                            <tr>
                                                <th>${views.operation['Activity.rule']}</th>
                                                <th colspan="2">${views.operation['Activity.step.offerForm']}</th>
                                            </tr>
                                            <tr>
                                                <td>${views.operation['Activity.step.profit']}</td>
                                                <td>${views.operation['Activity.step.caijin']}<%=SessionManager.getUser().getDefaultCurrency()%></td>
                                                <td>${views.operation['Activity.step.audit']}</td>
                                            </tr>
                                            <c:forEach items="${preferentialWayRelation[p.id]}" var="item">
                                                <c:forEach items="${item.child}" var="child">
                                                        <c:if test="${child.preferentialCode eq 'profit_ge' && item.orderColumn eq child.orderColumn}">
                                                            <tr>
                                                                <td>${views.operation['Activity.step.full']}${child.preferentialValue}${views.operation['Activity.step.more']}</td>
                                                                <td>${views.operation['Activity.step.send']}${child.wayPreferentialValue}</td>
                                                                <td>
                                                                    <c:choose>
                                                                        <c:when test="${child.wayPreferentialAudit==''}">
                                                                            ---
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            ${child.wayPreferentialAudit}
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                            </tr>
                                                        </c:if>
                                                </c:forEach>
                                            </c:forEach>
                                        </table>
                                        <hr/>
                                        <table class="table table-bordered">
                                            <tr>
                                                <th>${views.operation['Activity.rule']}</th>
                                                <th colspan="2">${views.operation['Activity.step.offerForm']}</th>
                                            </tr>
                                            <tr>
                                                <td>${views.operation['Activity.step.loss']}</td>
                                                <td>${views.operation['Activity.step.caijin']}<%=SessionManager.getUser().getDefaultCurrency()%></td>
                                                <td>${views.operation['Activity.step.audit']}</td>
                                            </tr>

                                            <c:forEach items="${preferentialWayRelation[p.id]}" var="item">
                                                <c:forEach items="${item.child}" var="child">

                                                    <c:if test="${child.preferentialCode eq 'loss_ge' && item.orderColumn eq child.orderColumn}">
                                                        <tr>
                                                            <td>${views.operation['Activity.step.full']}${child.preferentialValue}${views.operation['Activity.step.more']}</td>
                                                            <td>${views.operation['Activity.step.send']}${child.wayPreferentialValue}</td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${child.wayPreferentialAudit==''}">
                                                                        ---
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        ${child.wayPreferentialAudit}
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                    </c:if>
                                                </c:forEach>
                                            </c:forEach>
                                        </table>
                                    </c:if>
                                    <!--    首存送 存就送-->
                                    <c:if test="${ is123Deposit || p.activityTypeCode eq 'deposit_send'}">
                                        <table class="table  table-bordered">
                                            <tr>
                                                <th>${views.operation['Activity.rule']}</th>
                                                <th colspan="2">${views.operation['Activity.step.offerForm']}</th>
                                            </tr>

                                            <tr>
                                                <td>
                                                        ${views.operation['Activity.step.depositAmount']}<%=SessionManager.getUser().getDefaultCurrency()%>
                                                </td>
                                                    <c:if test="${preferentialWayRelation[p.id][0].wayPreferentialForm eq 'percentage_handsel'}">
                                                    <td>${views.operation['Activity.step.proportion']}</td>
                                                    </c:if>
                                                    <c:if test="${preferentialWayRelation[p.id][0].wayPreferentialForm eq 'regular_handsel'}">
                                                        <td>${views.operation['fixProfit']}${siteCurrency}</td>
                                                    </c:if>
                                                <td>
                                                        ${views.operation['Activity.step.audit']}
                                                </td>
                                            </tr>
                                            <c:forEach items="${preferentialWayRelation[p.id]}" var="a">
                                                <tr>
                                                    <td>${views.operation['Activity.step.isFull']}${a.preferentialValue}${views.operation['Activity.step.more']}</td>
                                                    <c:if test="${a.wayPreferentialForm eq 'percentage_handsel'}">
                                                        <td>${a.wayPreferentialValue}%</td>
                                                    </c:if>
                                                    <c:if test="${a.wayPreferentialForm eq 'regular_handsel'}">
                                                        <td>${views.operation['Activity.step.send']}${a.wayPreferentialValue}</td>
                                                    </c:if>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${a.wayPreferentialAudit ==''}">
                                                                ---
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${a.wayPreferentialAudit}${views.operation['Activity.step.times']}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>

                                        </table>
                                    </c:if>
                                    <!--    救济金-->
                                    <c:if test="${p.activityTypeCode eq 'relief_fund'}">
                                        <table class="table table-bordered">
                                            <tr>
                                                <th colspan="2">${views.operation['Activity.rule']}</th>
                                                <th colspan="2">${views.operation['Activity.step.offerForm']}</th>
                                            </tr>
                                            <tr>
                                                <td>${views.operation['Activity.step.totalAssets']}</td>
                                                <td>${views.operation['Activity.step.lossAmount']}</td>
                                                <td>${views.operation['Activity.step.caijin']}${siteCurrency}</td>
                                                <td>${views.operation['Activity.step.audit']}</td>
                                            </tr>
                                            <c:forEach items="${preferentialWayRelation[p.id]}" var="item">
                                                <tr>

                                                    <c:forEach items="${item.child}" var="child">
                                                        <c:if test="${item.orderColumn eq child.orderColumn && child.preferentialCode eq 'total_assets_le'}">
                                                            <td>${views.operation['Activity.step.surplus']}${child.preferentialValue}${views.operation['Activity.step.less']}</td>
                                                        </c:if>
                                                    </c:forEach>

                                                    <c:forEach items="${item.child}" var="child">
                                                        <c:if test="${item.orderColumn eq child.orderColumn && child.preferentialCode eq 'loss_ge'}">
                                                            <td>${views.operation['Activity.step.reach']}${child.preferentialValue}${views.operation['Activity.step.more']}</td>
                                                        </c:if>
                                                    </c:forEach>

                                                    <td>${views.operation['Activity.step.send']}${item.wayPreferentialValue}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${item.wayPreferentialAudit ==''}">
                                                                ---
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${item.wayPreferentialAudit}${views.operation['Activity.step.times']}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>

                                        </table>
                                    </c:if>
                                    <!--    注册送-->
                                    <c:if test="${p.activityTypeCode eq 'regist_send'}">
                                        <table class="table table-bordered">
                                            <tr>
                                                <th colspan="2">${views.operation['Activity.step.offerForm']}</th>
                                            </tr>
                                            <tr>
                                                <td>${views.operation['Activity.step.caijin']}${siteCurrency}</td>
                                                <td>${views.operation['Activity.step.audit']}</td>
                                            </tr>

                                                <c:forEach items="${preferentialWayRelation[p.id]}" var="r">
                                                <tr>
                                                    <td>${views.operation['Activity.step.send']}${r.wayPreferentialValue}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${r.wayPreferentialAudit ==''}">
                                                                ---
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${r.wayPreferentialAudit}${views.operation['Activity.step.times']}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                                </c:forEach>

                                        </table>
                                    </c:if>
                                    <!--    有效交易量-->
                                    <c:if test="${p.activityTypeCode eq 'effective_transaction'}">
                                        <table class="table table-bordered">
                                            <tr>
                                                <th>${views.operation['Activity.rule']}</th>
                                                <th colspan="2">${views.operation['Activity.step.offerForm']}</th>
                                            </tr>
                                            <tr>
                                                <td>${views.operation['Activity.step.totalTransaction']}</td>
                                                <td>${views.operation['Activity.step.caijin']}${siteCurrency}</td>
                                                <td>${views.operation['Activity.step.audit']}</td>
                                            </tr>
                                            <c:forEach items="${preferentialWayRelation[p.id]}" var="b">
                                                <tr>
                                                    <td>${views.operation['Activity.step.full']}${b.preferentialValue}${views.operation['Activity.step.more']}</td>
                                                    <td>${views.operation['Activity.step.send']}${b.wayPreferentialValue}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${b.wayPreferentialAudit ==''}">
                                                                ---
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${b.wayPreferentialAudit}${views.operation['Activity.step.times']}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </table>
                                    </c:if>
                                    <c:if test="${p.activityTypeCode=='money'}">
                                        <div class="clearfix m-t-md">
                                            <div class="col-sm-9">
                                                <label class="ft-bold al-right line-hi34">${views.operation_auto['每天开放时段']}：</label>
                                                <div class="tab-content table-responsive">
                                                    <table class="table border" id="preview_open_period">
                                                        <tr>
                                                            <td class="bg-gray ft-bold">${views.operation_auto['时段']}</td>
                                                            <td class="bg-gray ft-bold" >${views.operation_auto['开始时间']}</td>
                                                            <td class="bg-gray ft-bold">${views.operation_auto['结束时间']}</td>
                                                        </tr>
                                                        <c:if test="${empty periodListVo.result}">
                                                            <tr class="fd">
                                                                <td>

                                                                </td>
                                                                <td>
                                                                </td>
                                                                <td>
                                                                </td>
                                                            </tr>
                                                        </c:if>
                                                        <c:if test="${not empty periodListVo.result}">
                                                            <c:forEach var="period" items="${periodListVo.result}" varStatus="vs">
                                                                <tr class="fd">
                                                                    <td>
                                                                            ${views.operation_auto['时段']}${vs.index+1}
                                                                    </td>
                                                                    <td>
                                                                        ${period.startTimeHour<10?'0'.concat(period.startTimeHour):period.startTimeHour}
                                                                            :
                                                                            ${period.startTimeMinute<10?'0'.concat(period.startTimeMinute):period.startTimeMinute}
                                                                    </td>
                                                                    <td>
                                                                        ${period.endTimeHour<10?'0'.concat(period.endTimeHour):period.endTimeHour}
                                                                            :
                                                                        ${period.endTimeMinute<10?'0'.concat(period.endTimeMinute):period.endTimeMinute}
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>

                                                        </c:if>
                                                    </table>
                                                </div>

                                            </div>
                                        </div>
                                        <c:if test="${activityRuleVo.result.conditionType!='3'}">
                                        <div class="clearfix m-t-md">
                                            <div class="col-sm-9">
                                                <label class="ft-bold al-right line-hi34">${views.operation_auto['优惠条件']}：</label>
                                                <div class="tab-content table-responsive">
                                                    <table class="table border" id="preview_money_condition">
                                                        <tr>
                                                            <td class="bg-gray ft-bold">
                                                                <c:if test="${activityRuleVo.result.conditionType=='1'}">${views.operation_auto['单次存款金额']}</c:if>
                                                                <c:if test="${activityRuleVo.result.conditionType=='2'}">${views.content_auto['累计存款金额']}</c:if>
                                                            </td>
                                                            <td class="bg-gray ft-bold" >${views.operation_auto['时段累计有效投注额']}</td>
                                                            <td class="bg-gray ft-bold">${views.operation_auto['抽奖次数']}</td>
                                                        </tr>
                                                        <c:if test="${not empty conditionListVo.result}">
                                                            <c:forEach var="con" items="${conditionListVo.result}" varStatus="vs">
                                                                <tr>
                                                                    <td>${fn:replace(views.operation_auto['满以上'],"[0]",con.singleDepositAmount)}</td>
                                                                    <td>${views.operation_auto['达']}${con.effectiveAmount}</td>
                                                                    <td>${con.betCount}${views.operation_auto['次']}</td>
                                                                </tr>
                                                            </c:forEach>
                                                        </c:if>
                                                        <c:if test="${empty conditionListVo.result}">
                                                            <tr>
                                                                <td></td>
                                                                <td></td>
                                                                <td></td>
                                                            </tr>
                                                        </c:if>

                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                        </c:if>
                                        <c:if test="${activityRuleVo.result.conditionType=='3'}">
                                        <div class="clearfix m-t-md">
                                            <div class="col-sm-9">
                                                <div class="tab-content table-responsive">
                                                        ${views.operation_auto['每次开放抽奖']}
                                                    <span style="width: 50px;border: 1px solid #e6e6e6;padding: 0 8px;" id="preview_bet_count">${activityRuleVo.result.betCountMaxLimit}</span>
                                                    ${views.operation_auto['次']}
                                                </div>
                                            </div>
                                        </div>
                                        </c:if>
                                        <div class="clearfix m-t-md">
                                            <div class="col-sm-9">
                                                <label class="ft-bold al-right line-hi34">
                                                    ${views.operation_auto['奖项设置']}：</label>
                                                <br>
                                                    ${views.operation_auto['剩余总时段数']}：${command.totalPeriods}
                                                <div class="tab-content table-responsive">
                                                    <table class="table border" id="preview_awards_rules">
                                                        <tr>
                                                            <td class="bg-gray ft-bold">${views.operation_auto['金额']}</td>
                                                            <td class="bg-gray ft-bold">${views.operation_auto['名额']}</td>
                                                            <td class="bg-gray ft-bold">${views.operation_auto['总名额']}</td>
                                                            <td class="bg-gray ft-bold" style="width: 150px;">${views.operation_auto['红包总金额']}</td>
                                                            <td class="bg-gray ft-bold" >${views.operation_auto['优惠稽核']}</td>
                                                            <td class="bg-gray ft-bold">${views.operation_auto['中奖概率']}</td>
                                                            <td class="bg-gray ft-bold">${views.operation_auto['时段剩余名额']}</td>
                                                        </tr>
                                                        <c:if test="${not empty rulesListVo.result}">
                                                            <c:set var="totalAmount" value="${0}"></c:set>
                                                            <c:set var="totalCount" value="${0}"></c:set>
                                                            <c:set var="allTotalAmount" value="${0}"></c:set>
                                                            <c:set var="allTotalCount" value="${0}"></c:set>
                                                            <c:set var="totalRemain" value="${0}"></c:set>
                                                            <c:forEach var="rule" items="${rulesListVo.result}" varStatus="vs">
                                                                <tr>
                                                                    <c:set var="totalAmount" value="${totalAmount + rule.amount}"></c:set>
                                                                    <c:set var="totalCount" value="${totalCount + rule.quantity}"></c:set>
                                                                    <c:set var="allTotalAmount" value="${allTotalAmount + rule.quantity * command.totalPeriods * rule.amount}"></c:set>
                                                                    <c:set var="allTotalCount" value="${allTotalCount + rule.quantity * command.totalPeriods}"></c:set>
                                                                    <c:set var="totalRemain" value="${totalRemain + rule.quantity}"></c:set>
                                                                    <td>${siteCurrencySign}${rule.amount}</td>
                                                                    <td>${rule.quantity}${views.operation_auto['个']}</td>
                                                                    <td>${rule.quantity * command.totalPeriods}${views.operation_auto['个']}</td>
                                                                    <td>${siteCurrencySign}${rule.quantity * command.totalPeriods * rule.amount}</td>
                                                                    <td>${rule.audit}${views.operation_auto['倍']}</td>
                                                                    <td>${rule.probability}%</td>
                                                                    <td><span id="award_remain_count_${rule.id}">${rule.quantity}</span>${views.operation_auto['个']}</td>
                                                                </tr>
                                                            </c:forEach>
                                                            <tr>
                                                                <td style="width: 150px;">
                                                                    ${views.report_auto['总计']}：${siteCurrencySign}<span>${totalAmount}</span>
                                                                </td>
                                                                <td style="width: 120px;">
                                                                        ${views.report_auto['总计']}：<span>${totalCount}</span>${views.operation_auto['个']}
                                                                </td>

                                                                <td style="width: 120px;">
                                                                        ${views.report_auto['总计']}：<span>${allTotalCount}</span>${views.operation_auto['个']}
                                                                </td>
                                                                <td style="width: 150px;">
                                                                        ${views.report_auto['总计']}：${siteCurrencySign}<span>${allTotalAmount}</span>
                                                                </td>
                                                                <td style="width: 120px;"></td>
                                                                <td style="width: 120px;"></td>
                                                                <td style="width: 120px;"><span id="allRemainCount">${totalRemain}</span>${views.operation_auto['个']}</td>
                                                            </tr>
                                                        </c:if>
                                                        <c:if test="${empty rulesListVo.result}">
                                                            <tr>
                                                                <td></td>
                                                                <td></td>
                                                                <td></td>
                                                                <td></td>
                                                                <td></td>
                                                                <td></td>
                                                                <td></td>
                                                            </tr>
                                                        </c:if>


                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>

                                </div>
                            </div>
                        </c:if>

                        <c:if test="${( is123Deposit || p.activityTypeCode eq 'deposit_send') && not empty activityRuleVo.result.preferentialAmountLimit}">
                            <div class="clearfix m-l-lg line-hi34">
                                <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.preferentialAmountLimit']}：</label>
                                <div class="col-sm-5">${activityRuleVo.result.preferentialAmountLimit}</div>
                            </div>
                        </c:if>
                        <c:if test="${p.activityTypeCode eq 'back_water'}">
                            <div class="clearfix m-l-lg line-hi34">
                                <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.rakebackBillingCycle']}：</label>
                                <div class="col-sm-5">
                                    <c:choose>
                                        <c:when test="${rakebackSetting eq 0}">
                                            ${views.operation['Activity.step.dayBack']}
                                        </c:when>
                                        <c:otherwise>
                                            ${rakebackSetting}${views.operation['siteManage.detailView.activity.times']}
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:if>


                        <c:if test="${is123Deposit || p.activityTypeCode eq 'deposit_send'}">
                            <div class="clearfix m-l-lg line-hi34">
                                <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.depositWay']}</label>
                                <div class="col-sm-5">
                                    <c:forEach items='${fn:split(activityRuleVo.result.depositWay, ",")}' var="dw">
                                        ${views.operation['Activity.step.depositWay.'.concat(dw)]},
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>

                        <c:if test="${p.activityTypeCode ne 'back_water'}">
                            <div class="clearfix m-l-lg line-hi34">
                                <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.rank']}：</label>
                                <div class="col-sm-5">
                                    <c:choose>
                                        <c:when test="${activityRuleVo.result.isAllRank}">
                                            ${views.operation['Activity.step.allRank']}
                                        </c:when>
                                        <c:otherwise>
                                            ${activityRuleVo.ranks}
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${(p.activityTypeCode eq 'regist_send' || is123Deposit) && p.activityTypeCode ne 'everyday_first_deposit' }">
                            <div class="clearfix m-l-lg line-hi34">
                                <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.effectiveTime']}：</label>
                                <div class="col-sm-5">
                                        ${views.operation[activityRuleVo.result.effectiveTime]}
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${p.activityTypeCode eq 'relief_fund' || p.activityTypeCode eq 'effective_transaction' || p.activityTypeCode eq 'profit_loss' }">
                            <div class="clearfix m-l-lg line-hi34">
                                <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.claimPeriod']}：</label>
                                <div class="col-sm-5">
                                        ${views.operation[activityRuleVo.result.claimPeriod]}
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${activityType.result.code eq 'relief_fund'}">
                            <div class="clearfix m-l-lg line-hi34">
                                <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.placesNumber']}：</label>
                                <div class="col-sm-5">${activityRuleVo.result.placesNumber}
                                        ${p.placesNumber gt 0 ?p.placesNumber:views.operation['Activity.step.unlimited']}
                                </div>
                            </div>
                        </c:if>
                        <c:set var="length" value="${languageList.size()}"></c:set>
                        <c:if test="${activityType.result.code ne 'content'}">
                            <div class="clearfix m-l-lg line-hi34">
                                <label class="ft-bold col-sm-3 al-right">${views.operation['领取方式']}：</label>
                                <div class="col-sm-5">
                                    <c:choose>
                                        <c:when test="${activityRuleVo.result.isAudit}">
                                            ${views.operation['前端申领（审核）']}
                                        </c:when>
                                        <c:otherwise>
                                            ${views.operation['前端申领（免审）']}
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:if>
                        <div class="clearfix m-l-lg line-hi34 m-b">
                            <label class="ft-bold col-sm-3 al-right"></label>
                            <div class="col-sm-5">
                                <c:forEach var="lang" items="${languageList}" varStatus="status">
                                        <span>
                                            <a href="javascript:void(0)" id="${lang.language}" name="${status.index}"
                                               class="btn <c:if test="${status.index!=0}">btn-outline</c:if> btn-filter btn-sm activityTag" >
                                                    ${dicts.common.local[lang.language]}PC
                                            </a>
                                        </span>
                                </c:forEach>
                                <c:if test="${activityMessageI18nListVo.result.size() > languageList.size()}">
                                    <c:forEach var="lang" items="${languageList}" varStatus="status">
                                        <span>
                                            <a href="javascript:void(0)" id="" name="${status.index+length}"
                                               class="btn btn-outline btn-filter btn-sm activityTag" >
                                                    ${dicts.common.local[lang.language]}mobile
                                            </a>
                                        </span>
                                    </c:forEach>
                                </c:if>
                            </div>
                        </div>
                        <c:forEach var="lang" items="${languageList}" varStatus="status">
                            <c:forEach var="i18n" items="${activityMessageI18nListVo.result}">
                                <c:if test="${empty i18n.activityTerminalType || i18n.activityTerminalType == '1'}">
                                    <c:if test="${lang.language eq i18n.activityVersion}">
                                        <div class="${status.index==0?'':'hide'} contentDiv" id="content${status.index}">
                                            <div class="clearfix m-l-lg line-hi34">
                                                <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.affiliated']}：</label>
                                                <div class="col-sm-5">
                                                    <img data-src="${soulFn:getImagePath(domain,i18n.activityAffiliated)}"
                                                         src="${soulFn:getThumbPath(domain,i18n.activityAffiliated,630,350)}" alt="${i18n.activityName}">
                                                </div>
                                            </div>
                                            <div class="clearfix m-l-lg line-hi34">
                                                <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.name']}：</label>
                                                <div class="col-sm-5">${i18n.activityName}</div>
                                            </div>
                                            <div class="clearfix m-l-lg line-hi34">
                                                <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.content']}：</label>
                                                <div class="col-sm-5">
                                                    <p>
                                                    ${gbFn:unescapeXml(i18n.activityDescription)}
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:if>
                            </c:forEach>
                        </c:forEach>
                        <c:forEach var="lang" items="${languageList}" varStatus="status">
                            <c:forEach var="i18n" items="${activityMessageI18nListVo.result}">
                                <c:if test="${i18n.activityTerminalType == '2'}">
                                    <c:if test="${lang.language eq i18n.activityVersion}">
                                        <div class="hide contentDiv" id="content${status.index+length}">
                                            <div class="clearfix m-l-lg line-hi34">
                                                <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.affiliated']}：</label>
                                                <div class="col-sm-5">
                                                    <img data-src="${soulFn:getImagePath(domain,i18n.activityAffiliated)}"
                                                         src="${soulFn:getThumbPath(domain,i18n.activityAffiliated,630,350)}" alt="${i18n.activityName}">
                                                </div>
                                            </div>
                                            <div class="clearfix m-l-lg line-hi34">
                                                <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.name']}：</label>
                                                <div class="col-sm-5">${i18n.activityName}</div>
                                            </div>
                                            <div class="clearfix m-l-lg line-hi34">
                                                <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.content']}：</label>
                                                <div class="col-sm-5">
                                                    <p>
                                                            ${gbFn:unescapeXml(i18n.activityDescription)}
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:if>
                            </c:forEach>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</form:form>
<soul:import res="site/operation/activityHall/ViewActivityDetail"/>