<%@ page import="so.wwb.gamebox.model.master.fund.enums.TransactionWayEnum" %><%--@elvariable id="command" type="so.wwb.gamebox.model.company.site.vo.SiteConfineIpVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/param/basicSettingIndex.html" method="post" nav-target="mainFrame">
    <!--//region your codes 2-->
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <form:hidden path="audit.id"/>
    <form:hidden path="isReward.id"/>
    <form:hidden path="rewardTheWay.id"/>
    <form:hidden path="rewardMoney.id"/>
    <form:hidden path="bonusTrading.id"/>
    <form:hidden path="bonusBonusMax.id"/>
    <form:hidden path="bonus.id"/>
    <form:hidden path="bonusAudit.id"/>

    <form:hidden path="isReward.active"/>
    <form:hidden path="bonus.active"/>
    <form:hidden path="bonusJsonId"/>
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a href="javascript:void(0)" class="navbar-minimalize"><i class="icon iconfont"></i> </a></h2>
            <span>${views.sysResource['运营']}</span>
            <span>/</span><span>${messages.sysResource['推荐设置']}</span>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <div class="present_wrap"><b>${views.sysResource['推荐设置']}</b>
                    <a href="/report/vPlayerFundsRecord/fundsLog.html?search.hasReturn=true&search.outer=-1&search.transactionWays=<%=TransactionWayEnum.SINGLE_REWARD.getCode()%>,<%=TransactionWayEnum.BONUS_AWARDS.getCode()%>" class="pull-right" nav-target="mainFrame">${views.setting['recommended.tjjl']}</a></div>

                <!--            <b class="m-l">${views.setting_auto['最近登录记录']}</b>-->
                <div class="clearfix m-t-sm line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.setting['recommended.tjdcjl']}<%--推荐单次奖励--%>：</label>
                    <div class="col-sm-7">
                        <label><input id="isRewardActive" type="checkbox" class="i-checks" value="child2" ${command.isReward.active?'checked':''}> ${views.setting['recommended.use']}<%--使用--%></label>
                        <span title="" data-original-title="" data-content="${views.setting['recommended.tjdcjl.prompt']}" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover m-l-sm" tabindex="0"><i class="fa fa-question-circle"></i></span>
                        <div class="clearfix m-t-none line-hi34">
                            <label class=" al-right">${views.setting['recommended.tjjlfs']}<%--推荐奖励方式--%>：</label>
                            <label><input value="1" type="radio" checked="" class="i-checks" name="isReward.paramValue" active="${command.isReward.paramValue}"> ${views.setting['recommended.sfjl']}<%--双方奖励--%> </label>
                            <label><input value="2" type="radio" class="i-checks" name="isReward.paramValue" active="${command.isReward.paramValue}"> ${views.setting['recommended.tjrjl']}<%--推荐人奖励--%> </label>
                            <label><input value="3" type="radio" class="i-checks" name="isReward.paramValue" active="${command.isReward.paramValue}"> ${views.setting['recommended.btjrjl']}<%--被推荐人奖励--%> </label>
                        </div>




                        <div class="clearfix">
                            <div class="form-group clearfix pull-left content-width-limit-30 m-t-sm m-b-none m-l-n-sm">
                                <div class="input-group">
                                    <span class="input-group-addon abroder-no">${views.setting['recommended.cgwjtj']}：</span>
                                    <span class="input-group-addon ">${views.setting['recommended.ckjem']}</span>
                                    <form:input path="rewardTheWay.paramValue" cssClass="form-control"  maxlength="8"/>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix">
                            <div class="form-group clearfix pull-left content-width-limit-30 m-t-sm m-b-none m-l-n-sm">
                                <div class="input-group">
                                    <span class="input-group-addon abroder-no">${views.setting['recommended.tjjlje']}<%--推荐奖励金额--%>：</span>
                                    <form:input path="rewardMoney.paramValue" cssClass="form-control" maxlength="11"/>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix">
                            <div class="form-group clearfix pull-left content-width-limit-30 m-t-sm m-b-none m-l-n-sm">
                                <div class="input-group">
                                    <span class="input-group-addon abroder-no">
                                    <span title="" data-original-title="" data-content="1、${views.setting['优惠稽核倍数为空，视为不对该笔优惠进行稽核；']}<br>2、${views.setting['玩家在取款时，有效投注额需要达到（存款金额+优惠金额）*优惠稽核倍数，否则将被扣除该笔优惠；']}<br>3、${views.setting['当没有通过存款申请获得优惠，而是直接获得优惠时，则直接按优惠金额*优惠稽核倍数来算即可；']}" data-html="true" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover m-l-sm" tabindex="0"><i class="fa fa-question-circle"></i></span>
                                    ${views.setting['recommended.yhjh']}<%--优惠稽核--%>：</span>
                                    <form:input path="audit.paramValue" cssClass="form-control" maxlength="5"/><span class="input-group-addon">${views.setting['recommended.bei']}<%--倍--%></span>
                                </div>
                            </div>

                        </div>


                    </div>
                </div>
                <div class="clearfix m-t-sm line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.setting['recommended.tjhl']}<%--推荐红利--%>：</label>
                    <div class="col-sm-6">
                        <label><input id="bonusActive"  type="checkbox" class="i-checks" value="child2" ${command.bonus.active?'checked':''}> ${views.setting['recommended.use']}</label><span data-html="true" data-content="${views.setting['recommended.tjhl.prompt']}" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class=" help-popover m-l-sm" tabindex="0" data-original-title="" title=""><i class="fa fa-question-circle"></i></span>  <span class="m-l co-grayc2">${views.setting['recommended.jltjr']}</span>

                        <div class="clearfix">
                            <div class="form-group clearfix pull-left content-width-limit-250 m-t-sm m-b-none m-l-n-sm">
                                <div class="input-group">
                                    <span class="input-group-addon abroder-no">${views.setting['recommended.yxwjjyl']}<%--有效玩家交易量--%>：</span>
                                    <form:input path="bonusTrading.paramValue" cssClass="form-control" maxlength="11"/>
                                </div>
                            </div>
                            <div class="form-group clearfix pull-left content-width-limit-250 m-t-sm m-b-none">
                                <div class="input-group">
                                    <span class="input-group-addon abroder-no">${views.setting['recommended.tjhlsx']}<%--推荐红利上限--%>：</span>
                                    <form:input path="bonusBonusMax.paramValue" cssClass="form-control" maxlength="11"/>
                                </div>
                            </div>
                            <div class="form-group clearfix pull-left content-width-limit-250 m-t-sm m-b-none">
                                <div class="input-group">
                                    <span class="input-group-addon abroder-no">
                                        <span title="" data-original-title="" data-content="1、${views.setting['优惠稽核倍数为空，视为不对该笔优惠进行稽核；']}<br>2、${views.setting['玩家在取款时，有效投注额需要达到（存款金额+优惠金额）*优惠稽核倍数，否则将被扣除该笔优惠；']}<br>3、${views.setting['当没有通过存款申请获得优惠，而是直接获得优惠时，则直接按优惠金额*优惠稽核倍数来算即可；']}" data-html="true" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover m-l-sm" tabindex="0"><i class="fa fa-question-circle"></i></span>
                                        ${views.setting['recommended.yhjh']}<%--优惠稽核--%>：
                                    </span>
                                    <form:input path="bonusAudit.paramValue" cssClass="form-control" maxlength="5"/><span class="input-group-addon">${views.setting['recommended.bei']}<%--倍--%></span>
                                </div>
                            </div>

                        </div>

                        <div class="table-responsive m-t-md">
                            <table class="table table-striped table-bordered table-hover dataTable m-b-none">
                                <thead>
                                <tr class="bg-gray">
                                    <th>${views.setting['recommended.yxtzrs']}<%--有效玩家数--%></th>
                                    <th>${views.setting['recommended.tjhlbl']}<%--推荐红利比例--%><span data-content="${views.setting['recommended.tjhlbl.prompt']}" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class=" help-popover m-l-sm" tabindex="0" data-original-title="" title=""><i class="fa fa-question-circle"></i></span> </th>
                                    <th>${views.common['operate']}<%--操作--%></th>
                                </tr>
                                </thead>
                                <tbody id="gradient">




                                <c:forEach items="${command.gradientTempList}" var="p" varStatus="status">
                                <tr class="bg-color">
                                    <td><input name='gradientTempList[${status.index}].playerNum' tt="temp" class="form-control" type='text' value='${p.playerNum}'></td>
                                    <td><div class=" clearfix content-width-limit-30 m-b-none">
                                        <div class="input-group">
                                            <input tt="temp" name='gradientTempList[${status.index}].proportion' type="text" class="form-control" value="${p.proportion}"><span class="input-group-addon">%</span>
                                        </div>
                                    </div></td>
                                    <td class='${status.index==0?'':'delTd'}'><a href='javascript:void(0)'>${status.index==0?'':views.common['delete']}</a></td>
                                </tr>
                                </c:forEach>
                                <tr class="bg-gray add">
                                    <td class="al-left" colspan="3">
                                        <b id="addTr"><a class="co-gray6 m-r-sm pull-right" href="javascript:void(0)"><i class="fa fa-plus m-r-sm"></i>${views.common['create']}<%--新增--%></a></b>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>

                    </div>
                </div>
                <ul class="artificial-tab clearfix bg-gray m-t">
                    <li class="col-sm-3"></li>
                    <c:forEach items="${command.languageList}" var="p" varStatus="status">
                    <li class="m-l-lg"><a id="tag${status.index+1}" name="tag" class="${status.index=='0'?'current':''} a_${p.language}" tagIndex="${status.index+1}" siteSize="${command.languageList.size()}" href="javascript:void(0)" local="${p.language}">${dicts.common.local[p.language]}<span id="span${p.language}">${status.index eq 0?views.setting['switch.CloseReminder.editing']:command.siteI18nContentMap.get(p.language).value.length()>0?views.setting['switch.CloseReminder.edited']:views.setting['switch.CloseReminder.unedited']}</span></a></li>
                    </c:forEach>
                    <li class="m-t-sm">
                        <div class="btn-group">
                            <button data-toggle="dropdown" class="btn btn-link dropdown-toggle fzyx" aria-expanded="false">${views.setting['复制语系']}&nbsp;&nbsp;<span class="caret"></span></button>
                            <ul class="dropdown-menu pull-right">
                                <c:forEach items="${command.languageList}" var="p" varStatus="status">
                                    <li ${empty command.siteI18nContentMap.get(0)||status.index==0?"hidden":""} id="option${p.language}" class="temp"><a class="co-gray copy" href="javascript:void(0)" local="${p.language}">${dicts.common.local[p.language]}</a></li>
                                </c:forEach>
                            </ul>
                        </div>
                    </li>
                </ul>
                <div class="clearfix m-t-md">
                    <label class="ft-bold col-sm-3 al-right line-hi34">${views.setting['recommended.tjfsjnr']}<%--推荐方式及内容--%>：</label>
                    <div class="col-sm-5">
                        <c:forEach items="${command.languageList}" var="p" varStatus="status">
                            <input type="hidden" name="siteI18nContentList[${status.index}].id" value="${command.siteI18nContentMap.get(p.language).id}"/>
                            <input type="hidden" name="siteI18nContentList[${status.index}].locale" value="${p.language}"/>
                            <input type="hidden" name="siteI18nContentList[${status.index}].siteId" value="${command.search.siteId}"/>
                            <input type="hidden" name="siteI18nContentList[${status.index}].module" value="${content.module.code}"/>
                            <input type="hidden" name="siteI18nContentList[${status.index}].type" value="${content.type}"/>
                            <input type="hidden" name="siteI18nContentList[${status.index}].key" value="${content.code}"/>
                            <input type="hidden" name="siteI18nContentList[${status.index}].defaultValue" value="${command.siteI18nContentMap.get(p.language).defaultValue}" class="defaultValue"/>
                            <textarea tt="${p.language}" local="${p.language}" style="display: ${status.index=='0'?'':'none'}" name="siteI18nContentList[${status.index}].value"   class="form-control recommended rec text_${p.language}_content">${command.siteI18nContentMap.get(p.language).value}</textarea>

                        </c:forEach>
                    </div>
                </div>
                <div class="clearfix m-t-md">
                    <label class="ft-bold col-sm-3 al-right line-hi34">${views.setting['recommended.hdgz']}<%--活动规则--%>：</label>
                    <div class="col-sm-5">
                        <c:forEach items="${command.languageList}" var="p" varStatus="status">
                            <input type="hidden" name="siteI18nRuleList[${status.index}].id" value="${command.siteI18nRuleMap.get(p.language).id}"/>
                            <input type="hidden" name="siteI18nRuleList[${status.index}].siteId" value="${command.search.siteId}"/>
                            <input type="hidden" name="siteI18nRuleList[${status.index}].locale" value="${p.language}"/>
                            <input type="hidden" name="siteI18nRuleList[${status.index}].module" value="${rule.module.code}"/>
                            <input type="hidden" name="siteI18nRuleList[${status.index}].type" value="${rule.type}"/>
                            <input type="hidden" name="siteI18nRuleList[${status.index}].key" value="${rule.code}"/>
                            <input type="hidden" name="siteI18nRuleList[${status.index}].defaultValue" value="${command.siteI18nRuleMap.get(p.language).defaultValue}" class="defaultValue"/>
                            <textarea tt="${p.language}" local="${p.language}" style="display: ${status.index=='0'?'':'none'}" name="siteI18nRuleList[${status.index}].value"   class="form-control recommended rule${status.index} text_${p.language}_rule">${command.siteI18nRuleMap.get(p.language).value}</textarea>
                        </c:forEach>
                    </div>
                </div>
                <div class="operate-btn">
                    <soul:button cssClass="btn btn-filter btn-lg" text="${views.common['OK']}" dataType="json" opType="ajax"
                                 target="${root}/param/saveRecommended.html" precall="validateForm" post="getCurrentFormData"
                                 callback="saveCallbak"/>
                </div>
            </div>
        </div>

        <!--//endregion your codes 2-->
    </div>
</form:form>

<!--//region your codes 3-->
<soul:import res="site/setting/param/recommended/Edit"/>
<!--//endregion your codes 3-->