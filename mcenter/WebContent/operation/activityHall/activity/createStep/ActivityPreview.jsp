<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.VActivityMessageListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<!--//region your codes 3-->

<!--活动预览-->
<div class="row" id="step3" style="display: none">
    <div class="position-wrap clearfix">
        <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
        <span>${views.sysResource['运营']}</span>
        <span>/</span><span>${views.sysResource['活动管理']}</span>
        <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
    </div>
    <div class="col-lg-12">
        <div class="wrapper white-bg shadow">
            <ul class="artificial-tab clearfix">
                <c:choose>
                    <c:when test="${activityType.result.code eq 'content'}">
                        <li class="col-sm-3 col-xs-12 p-x"><a class="no" href="javascript:void(0)"><span class="no">1</span><span class="con">${views.operation['Activity.content']}</span></a></li>
                        <li class="col-sm-3 col-xs-12 p-x"><a href="javascript:void(0)" class="current"><span class="no">2</span><span class="con">${views.operation['Activity.preview']}</span></a></li>
                        <li class="col-sm-3 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">3</span><span class="con">${views.operation['Activity.finish']}</span></a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="col-sm-3 col-xs-12 p-x"><a class="no" href="javascript:void(0)"><span class="no">1</span><span class="con">${views.operation['Activity.content']}</span></a></li>
                        <li class="col-sm-3 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">2</span><span class="con">${views.operation['Activity.rule']}</span></a></li>
                        <li class="col-sm-3 col-xs-12 p-x"><a href="javascript:void(0)" class="current"><span class="no">3</span><span class="con">${views.operation['Activity.preview']}</span></a></li>
                        <li class="col-sm-3 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">4</span><span class="con">${views.operation['Activity.finish']}</span></a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.type']}：</label>
                <div class="col-sm-5" id="previewCode"></div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.isDisplay']}：</label>
                <div class="col-sm-5" id="previewDisplay"></div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.activityClass']}：</label>
                <div class="col-sm-5" id="previewActivityClass"></div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.activityTime']}：</label>
                <div class="col-sm-5" id="previewActivityTime"></div>
            </div>
            <%--优惠条件--%>
            <c:if test="${activityType.result.code ne 'content'}">
                <div class="clearfix line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.conditions']}：</label>
                    <!--    返水优惠-->
                    <c:if test="${activityType.result.code eq 'back_water'}">
                        <div class="col-sm-5" id="activityBackWaterTable"></div>
                    </c:if>
                    <div class="col-sm-8" id="activityTable">
                        <%@include file="rule.include/PreviewTable.jsp"%>
                    </div>
                </div>
            </c:if>
            <c:if test="${activityType.result.code eq 'first_deposit' || activityType.result.code eq 'deposit_send' }">
                <div class="clearfix line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.preferentialAmountLimit']}：</label>
                    <div class="col-sm-5" id="previewPAL"></div>
                </div>
            </c:if>
            <c:if test="${activityType.result.code eq 'back_water'}">
                <div class="clearfix line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.rakebackBillingCycle']}：</label>
                    <div class="col-sm-5" id="previewRakeback"></div>
                </div>
            </c:if>
            <c:if test="${activityType.result.code eq 'first_deposit' || activityType.result.code eq 'deposit_send' }">
                <div class="clearfix line-hi34" id="preDepositWay">
                    <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.depositWay']}</label>
                    <div class="col-sm-5" id="previewDepositWay"></div>
                </div>
            </c:if>
            <c:if test="${activityType.result.code ne 'back_water'}">
                <div class="clearfix line-hi34" id="rank">
                    <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.rank']}：</label>
                    <div class="col-sm-5" id="previewRank"></div>
                </div>
            </c:if>
            <c:if test="${activityType.result.code eq 'regist_send'}">
                <div class="clearfix line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.effectiveTime']}：</label>
                    <div class="col-sm-5" id="previewEffectiveTime"></div>
                </div>
            </c:if>
            <c:if test="${activityType.result.code eq 'relief_fund' || activityType.result.code eq 'effective_transaction' || activityType.result.code eq 'profit_loss' }">
                <div class="clearfix line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.claimPeriod']}：</label>
                    <div class="col-sm-5" id="previewClaimPeriod"></div>
                </div>
            </c:if>
            <c:if test="${activityType.result.code eq 'relief_fund'}">
                <div class="clearfix line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.placesNumber']}：</label>
                    <div class="col-sm-5" id="previewPlacesNumber"></div>
                </div>
            </c:if>
            <c:if test="${activityType.result.code ne 'content'}">
                <div class="clearfix line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.isAudit']}：</label>
                    <div class="col-sm-5" id="previewIsAudit"></div>
                </div>
                <%--<div class="clearfix line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.operation_auto['是否需要申请']}：</label>
                    <div class="col-sm-5" id="previewisNeedApply"></div>
                </div>--%>
            </c:if>
            <%--<div class="">--%>
            <c:set var="length" value="${languageList.size()}"></c:set>
            <div class="form-group clearfix">
                <div class="clearfix save lgg-version lang_label">
                    <ul class="nav nav-tabs">
                        <span class="col-sm-3"></span>
                        <c:forEach var="siteLang" items="${languageList}" varStatus="index">
                            <li class=" ${index.index==0?'active':''}">
                                <a data-toggle="tab" href="#tabb${index.index}" aria-expanded="${index.index==0?'true':'false'}">${fn:substringBefore(dicts.common.language[siteLang.value.language], '#')}pc</a>
                            </li>
                        </c:forEach>
                        <c:forEach var="siteLang" items="${languageList}" varStatus="index">
                            <li class="">
                                <a data-toggle="tab" href="#tabb${index.index+length}" aria-expanded="false">${fn:substringBefore(dicts.common.language[siteLang.value.language], '#')}mb</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <div class="panel-body">
                <div class="tab-content">
                    <c:forEach var="siteLang" items="${languageList}" varStatus="index">
                        <div id="tabb${index.index}" class="tab-pane ${index.index==0?'active':''}">
                            <div class="clearfix m-t-md line-hi34">
                                <label class="ft-bold col-sm-3 al-right line-hi34">${views.operation['Activity.name']}：</label>
                                <div class="col-sm-5" id="previewActivityName${index.index}"></div>
                            </div>

                            <div class="clearfix m-t-md">
                                <label class="ft-bold col-sm-3 al-right line-hi34">${views.operation['Activity.step.activityCover']}：</label>
                                <div class="col-sm-5" id="previewActivityAffiliateImg${index.index}"></div>
                            </div>

                            <div class="clearfix m-t-md line-hi34">
                                <label class="ft-bold col-sm-3 al-right line-hi34">${views.operation['Activity.step.activityDescription']}：</label>
                                <div class="col-sm-5" id="previewActivityDesc${index.index}"></div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:forEach var="siteLang" items="${languageList}" varStatus="index">
                        <div id="tabb${index.index+length}" class="tab-pane ${index.index+length==0?'active':''}">
                            <div class="clearfix m-t-md line-hi34">
                                <label class="ft-bold col-sm-3 al-right line-hi34">${views.operation['Activity.name']}：</label>
                                <div class="col-sm-5" id="previewActivityName${index.index+length}"></div>
                            </div>

                            <div class="clearfix m-t-md">
                                <label class="ft-bold col-sm-3 al-right line-hi34">${views.operation['Activity.step.activityCover']}：</label>
                                <div class="col-sm-5" id="previewActivityAffiliateImg${index.index+length}"></div>
                            </div>

                            <div class="clearfix m-t-md line-hi34">
                                <label class="ft-bold col-sm-3 al-right line-hi34">${views.operation['Activity.step.activityDescription']}：</label>
                                <div class="col-sm-5" id="previewActivityDesc${index.index+length}"></div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <%--</div>--%>
            <div class="operate-btn">
                <c:choose>
                    <c:when test="${activityType.result.code eq 'content'}">
                        <soul:button opType="function" target="activityContentTypePreviewPre" cssClass="btn btn-filter btn-lg" text="${views.common['previous']}"/>
                    </c:when>
                    <c:otherwise>
                        <soul:button opType="function" target="activityPreviewPre" cssClass="btn btn-filter btn-lg" text="${views.common['previous']}"/>
                    </c:otherwise>
                </c:choose>
                <soul:button precall="queryDisplayMoneyActivity" code="${activityType.result.code}" target="activityRelease" text="${views.common['release']}" opType="function" callback="showLastStepPage" cssClass="btn btn-filter btn-lg m-l activityRelease">${views.common['release']}</soul:button>
            </div>
        </div>
    </div>
</div>
    <!--//endregion your codes 3-->