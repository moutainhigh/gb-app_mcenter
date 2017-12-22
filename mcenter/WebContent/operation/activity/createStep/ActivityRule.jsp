<%@ page import="org.soul.commons.dict.DictTool" %>
<%@ page import="so.wwb.gamebox.model.DictEnum" %>
<%--@elvariable id="vo" type="so.wwb.gamebox.model.master.operation.vo.VActivityMessageListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->

<!--//endregion your codes 1-->
<!--//region your codes 3-->
<div class="row" style="display: none" id="step2">
    <div class="position-wrap clearfix">
        <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
        <span>${views.sysResource['运营']}</span>
        <span>/</span>
        <span>${views.sysResource['活动管理']}</span>
        <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        <soul:button target="goToLastPage" refresh="false" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
            <em class="fa fa-caret-left"></em>${views.common['return']}
        </soul:button>
    </div>
    <div class="col-lg-12">
        <div class="wrapper white-bg shadow">
            <ul class="artificial-tab clearfix">
                <li class="col-sm-3 col-xs-12 p-x"><a class="no" href="javascript:void(0)"><span class="no">1</span><span class="con">${views.operation['Activity.content']}</span></a></li>
                <li class="col-sm-3 col-xs-12 p-x"><a href="javascript:void(0)" class="current"><span class="no">2</span><span class="con">${views.operation['Activity.rule']}</span></a></li>
                <li class="col-sm-3 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">3</span><span class="con">${views.operation['Activity.preview']}</span></a></li>
                <li class="col-sm-3 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">4</span><span class="con">${views.operation['Activity.finish']}</span></a></li>
            </ul>
            <%@include file="rule.include/ActivityType.jsp" %>
            <c:if test="${activityType.result.code eq 'effective_transaction' || activityType.result.code eq 'profit_loss'}">
                <div class="clearfix m-t-md line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.claimPeriod']}：</label>
                    <div class="col-sm-5">
                        <span class="input-group pull-left line-hi25 m-r">
                            <gb:select name="activityRule.claimPeriod" list="<%=DictTool.get(DictEnum.CLAIM_PERIOD)%>" prompt="${views.common['pleaseSelect']}" value="${activityRule.claimPeriod}"/>
                        </span>
                        <span class="m-l co-grayc2">${views.operation['Activity.step.message4']}</span>

                    </div>
                </div>
            </c:if>
            <c:if test="${activityType.result.code eq 'relief_fund'}">
                <div class="clearfix m-t-md line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.claimPeriod']}：</label>
                    <div class="col-sm-5">
                        <span class="input-group pull-left line-hi25 m-r">
                            <gb:select name="activityRule.claimPeriod" list="<%=DictTool.get(DictEnum.CLAIM_PERIOD)%>" prompt="${views.common['pleaseSelect']}" value="${activityRule.claimPeriod}"/>
                        </span>
                        <span class="m-l co-grayc2">${views.operation['Activity.step.message5']}</span>

                    </div>
                </div>
            </c:if>
            <c:if test="${activityType.result.code eq 'regist_send'}">
                <div class="clearfix m-t-md line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.effectiveTime']}：</label>
                    <div class="col-sm-5">
                    <span class="input-group pull-left line-hi25 m-r">
                        <gb:select name="activityRule.effectiveTime" list="<%=DictTool.get(DictEnum.EFFECTIVE_TIME)%>" value="${activityRule.effectiveTime}"  prompt="${views.operation_auto['请选择']}"/>
                    </span>
                        <span class="m-l co-grayc2">${views.operation['Activity.step.message6']}</span>
                    </div>
                </div>
            </c:if>

            <%--<c:if test="${activityType.result.code eq 'effective_transaction' || activityType.result.code eq 'profit_loss'}">--%>
                <%--<div class="clearfix m-t-md line-hi34">--%>
                    <%--<label class="ft-bold col-sm-3 al-right">${views.operation_auto['申领周期']}：</label>--%>
                    <%--<div class="col-sm-5">--%>
                        <%--<span class="input-group pull-left line-hi25 m-r">--%>
                            <%--<gb:select name="activityRule.claimPeriod" prompt="${views.operation_auto['请选择']}" value="${activityRule.claimPeriod}" listValue="remark" listKey="dictCode"--%>
                                       <%--relSelect="activityRule.effectiveTime" ajaxListPath="${root}/operation/activity/getClaimPeriod.html"/>--%>
                        <%--</span>--%>
                        <%--<span class="m-l co-grayc2">每个周期内，每人默认只能申请一次。</span>--%>

                    <%--</div>--%>
                <%--</div>--%>

                <%--<div class="clearfix m-t-md line-hi34">--%>
                    <%--<label class="ft-bold col-sm-3 al-right">${views.operation_auto['有效时间']}：</label>--%>
                    <%--<div class="col-sm-5">--%>
                    <%--<span class="input-group pull-left line-hi25 m-r">--%>
                        <%--<gb:select name="activityRule.effectiveTime" value="${activityRule.effectiveTime}" prompt="${views.operation_auto['请选择']}"--%>
                                <%--relSelectPath="${root}/operation/activity/getEffectiveTime/#value#.html" listValue="remark" listKey="dictCode"/>--%>
                    <%--</span>--%>
                        <%--<span class="m-l co-grayc2">指在每个申领周期结束后有效时间内玩家未申领，则视为放弃本优惠，无法再申请。</span>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</c:if>--%>


            <%--优惠条件--%>
            <c:if test="${activityType.result.code eq 'back_water'}">
                <%@ include file="rule.include/BackWater.jsp" %>
            </c:if>
            <c:if test="${activityType.result.code eq 'first_deposit'|| activityType.result.code eq 'deposit_send'}">
                <%@ include file="rule.include/FirstDeposit.jsp" %>
            </c:if>
            <c:if test="${activityType.result.code eq 'regist_send'}">
                <%@ include file="rule.include/RegistSend.jsp" %>
            </c:if>
            <c:if test="${activityType.result.code eq 'relief_fund'}">
                <%@ include file="rule.include/ReliefFund.jsp" %>
            </c:if>
            <c:if test="${activityType.result.code eq 'effective_transaction'}">
                <%@ include file="rule.include/EffectiveTransaction.jsp" %>
            </c:if>
            <c:if test="${activityType.result.code eq 'profit_loss'}">
                <%@ include file="rule.include/ProfitLoss.jsp" %>
            </c:if>
            <c:if test="${activityType.result.code eq 'money'}">
                <%@ include file="rule.include/Money.jsp" %>
            </c:if>

            <c:if test="${activityType.result.code eq 'first_deposit' || activityType.result.code eq 'deposit_send'}">
                <div class="clearfix m-t-md" id="preferentialAmountLimit">
                    <label class="ft-bold col-sm-3 al-right line-hi34">${views.operation['Activity.step.preferentialAmountLimit']}${siteCurrency}：</label>
                    <div class="col-sm-5 input-group">
                        <input type="text" class="form-control" name="activityRule.preferentialAmountLimit" id="rulePAL" value="<fmt:formatNumber value='${activityRule.preferentialAmountLimit}' type="number" groupingUsed="false"/>">
                        <span class="input-group-addon adjust">
                            <soul:button tag="a" target="changeRatio" post="add" text="" cssClass="adjust up" opType="function">
                            <i class="fa fa-angle-up"></i></soul:button>
                            <soul:button tag="a" target="changeRatio" post="sub" text="" cssClass="adjust down" opType="function">
                                <i class="fa fa-angle-down"></i>
                            </soul:button>
                        </span>
                    </div>
                </div>
            </c:if>
            <c:if test="${activityType.result.code eq 'first_deposit' || activityType.result.code eq 'deposit_send'}">

                <div class="clearfix m-t-md line-hi34" id="depositWay">
                    <label class="ft-bold col-sm-3 al-right line-hi34">
                    <span tabindex="0" class=" help-popover m-l-sm"
                          role="button" data-container="body"
                          data-toggle="popover" data-trigger="focus"
                          data-placement="top" data-html="true" data-content="${views.operation['Activity.step.depositWay.tips']}"
                          data-original-title="" title=""><i
                            class="fa fa-question-circle"></i></span> ${views.operation['Activity.step.depositWay']}</label>
                    <div class="col-sm-5 input-group">
                        <c:forEach items="${activityDepositWays}" var="dw">
                            <%--<label class="m-r-sm">--%>
                                <input type="checkbox" class="i-checks" name="activityRule.depositWay" value="${dw.code}" ${fn:contains(activityRule.depositWay,dw.code) ? "checked":""}/>${views.operation['Activity.step.depositWay.'.concat(dw.code)]}
                            <%--</label>--%>
                        </c:forEach>
                    </div>
                </div>

            </c:if>
            <c:if test="${activityType.result.code ne 'back_water'}">
                <input type="hidden" name="isAllRank" value="${isAllRank}">
                <input type="hidden" name="rank" id="prank" value="${(!isAllRank and type eq 'edit')?"":activityRule.rank}"/>
                <c:set value="${activityRule.rank}," var="bb"></c:set>
                <div class="clearfix m-t-md line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.rank']}：</label>
                    <label class="col-sm-5">
                        <input type="checkbox" class="i-checks" id="levels" name="activityRule.isAllRank" ${activityRule.isAllRank?"checked":""} ${type eq 'edit' ? " disabled":""}/>
                        ${views.operation['Activity.step.allRank']}
                    </label>
                    <div class="col-sm-5 col-sm-offset-3" id="playerRank">
                        <c:forEach items="${playerRanks}" var="a">
                            <c:set value="${a.id}," var="b"></c:set>
                            <label class="m-r-sm">
                                <input type="checkbox" class="i-checks" name="activityRule.rank" value="${a.id}" ${empty isAllRank and isAllRank ? "" : (fn:contains(playerRank,b) || fn:contains(bb,b))?"checked":""} ${!(activityType.result.code eq 'first_deposit' || activityType.result.code eq 'regist_send') ? "":fn:contains(playerRank,b)?" disabled":""}>
                                ${a.rankName}
                            </label>
                        </c:forEach>

                            <%--<c:forEach items="${playerRanks}" var="a">
                                &lt;%&ndash;<c:forEach items="${fn:split(activityRule.rank,',')}" var="b">&ndash;%&gt;
                                <c:set value="${a.id}," var="b"></c:set>
                                <span class="m-r-sm"><input type="checkbox" class="i-checks" name="activityRule.rank" value="${a.id}" ${fn:contains(playerRank,b)?"checked":""}>${a.rankName}</span>
                                &lt;%&ndash;</c:forEach>&ndash;%&gt;
                            </c:forEach>--%>

                        <c:if test="${activityType.result.code eq 'first_deposit' || activityType.result.code eq 'regist_send'}">
                            <div id="getRankActivityMessage">
                                <%@include file="rule.include/GetRankActivityMessage.jsp"%>
                            </div>
                        </c:if>
                    </div>
                </div>
            </c:if>
            <c:if test="${activityType.result.code eq 'relief_fund'}">
                <div class="clearfix m-t-md line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.placesNumber']}：</label>
                    <div class="col-sm-5">
                        <span class="input-group pull-left line-hi25">
                            <gb:select callback="placesNumberChange" cssClass="btn-group chosen-select-no-single" name="placesNumber" value="${activityRule.placesNumber gt 0?'false':'true'}" list="{'true':'${views.operation['Activity.step.unlimited']}','false':'${views.operation['Activity.step.quantitativeRestrictions']}'}"/>
                        </span>
                        <div class="content-width-limit-10 pull-left input-group m-l" style="${activityRule.placesNumber gt 0?'':'display:none'}" id="placesNumbers">
                            <input type="text" class="form-control" placeholder="" name="activityRule.placesNumber" value="${activityRule.placesNumber}">
                            <span class="input-group-addon">${views.operation['Activity.step.name']}</span>
                        </div>
                        <span class="m-l co-grayc2" id="placesNumber_tips" style="${activityRule.placesNumber gt 0?'':'display:none'}">${views.operation['Activity.step.message8']}</span>
                    </div>
                </div>
            </c:if>
            <c:if test="${activityType.result.code ne 'back_water'}">
                <div class="clearfix m-t-md">
                    <label class="ft-bold col-sm-3 al-right line-hi34">
                    <span tabindex="0" class=" help-popover m-l-sm"
                          role="button" data-container="body"
                          data-toggle="popover" data-trigger="focus"
                          data-placement="top" data-html="true" data-content="${views.operation['Activity.step.isAudit.tip']}"
                          data-original-title="" title=""><i
                            class="fa fa-question-circle"></i></span> ${views.operation['Activity.step.isAudit']}：</label>

                    <div class="col-sm-3 input-group">
                        <gb:select name="activityRule.isAudit" value="${activityRule.isAudit}" list="{'true':'${views.operation['Activity.step.true']}','false':'${views.operation['Activity.step.false']}'}" prompt="${views.common['pleaseSelect']}"/>
                    </div>

                    <%--<div class="clearfix m-t-md">
                        <label class="ft-bold col-sm-3 al-right line-hi34">
                            <span tabindex="0" class=" help-popover m-l-sm" role="button" data-container="body" data-toggle="popover" data-trigger="focus"
                              data-placement="top" data-html="true" data-content="否：玩家注册后，视为默认参与；<br/>是：玩家注册后，需手动申请参与；"
                              data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
                            ${views.operation_auto['是否需要申请']}：</label>

                        <div class="col-sm-3 input-group">
                            <gb:select name="activityRule.isNeedApply" value="${activityRule.isNeedApply}" list="{'true':'${views.operation['Activity.step.true']}','false':'${views.operation['Activity.step.false']}'}" prompt="${views.common['pleaseSelect']}"/>
                        </div>
                    </div>--%>
                </div>
            </c:if>
            <div class="operate-btn">
                <c:if test="${!(activityMessageVo.result.checkStatus eq '1' && (activityMessageVo.states eq 'processing' || activityMessageVo.states eq 'notStarted')) || activityMessageVo.result.checkStatus eq '2'}">
                    <soul:button callback="getActivityMessageId" precall="uploadFile" target="${root}/operation/activity/activityRuleDraft.html?activityState=draft" text="${views.operation['Activity.step.saveAndDraft']}" opType="ajax" cssClass="btn btn-filter btn-lg" post="getCurrentFormData"/>
                </c:if>
                <soul:button opType="function" target="activityRulePre" cssClass="btn btn-filter btn-lg" text="${views.common['previous']}"/>
                <soul:button precall="activityRuleNextValidate" opType="function" target="activityRuleNext" code="${activityType.result.code}"
                             cssClass="btn btn-filter btn-lg" text="${views.common['next']}"/>
            </div>
        </div>
    </div>
</div>
<!--//endregion your codes 3-->