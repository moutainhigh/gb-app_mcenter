<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.PlayerRankVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="position-wrap clearfix">
    <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
    <span>${views.content['运营']}</span>
    <span>/</span><span>${views.content['收款账户']}</span>
    <soul:button target="goToLastPage" refresh="false"
                 cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
        <em class="fa fa-caret-left"></em>${views.common['return']}
    </soul:button>
    <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
</div>
<input type="hidden" name="orange.id" value="${orange.id}">
<input type="hidden" name="red.id" value="${red.id}">
<input type="hidden" name="orangeType.id" value="${orangeType.id}">
<input type="hidden" name="redType.id" value="${redType.id}">
<input type="hidden" name="freezeType.id" value="${freezeType.id}">
<input type="hidden" name="inadequateCount.id" value="${inadequateCount.id}">
<input type="hidden" name="inadequateState.id" value="${p6.id}">
<input type="hidden" name="resetDay.id" value="${resetDay.id}">
<input type="hidden" name="unusualType.id" value="${unusualType.id}">
<input type="hidden" name="type" value="${type}">
<div id="validateRule" style="display: none">${validateRule}</div>
<div class="col-lg-12">
    <div class="wrapper white-bg shadow clearfix">
        <div class="present_wrap m-b-lg"><b>${views.content['warningSetting.warning.setting']}</b></div>
        <div class="form-group clearfix line-hi34">
            <label class="ft-bold col-sm-3 al-right">${views.content['warningSetting.account.income.reset.days']}：</label>
            <div class="col-sm-5">
                <div style="display: inline-block;">
                    <span id="resetDaySpan">${empty resetDay.paramValue ? resetDay.defaultValue : resetDay.paramValue}</span>
                    <input style="display: none;width: auto;" type="text" class="form-control" name="resetDay.paramValue" value="${resetDay.paramValue ? resetDay.defaultValue : resetDay.paramValue}"  placeholder="1-7" maxlength="1">
                    <span style="display: none;" id="resetDayInputTip">&nbsp;&nbsp;${views.common.recommend}1${messages.common['time.day']}</span>
                    <soul:button target="editResetDays" text="${views.content_auto['修改']}" opType="function" cssClass="m-l-sm hideInput"/>
                    <span tabindex="0" class=" help-popover m-l-sm" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top" data-content="${views.content_auto['如设置为1']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
                </div>
            </div>
        </div>
        <div class="form-group clearfix">
            <label class="ft-bold col-sm-3 al-right">
                <span class="co-orange">${views.common.orange}</span>
                ${views.content['warningSetting.warning.prompt.type']}：
            </label>
            <div class="col-sm-5">
                <label>
                    <input type="radio" class="i-checks" value="1" name="orangeType.paramValue" ${orangeType.paramValue=='1'|| (orangeType.paramValue == null && orangeType.defaultValue=='1') ? 'checked' : ''}>${views.content['warningSetting.taskbar']}
                </label>
                <label>
                    <input type="radio" class="i-checks" value="3" name="orangeType.paramValue" ${orangeType.paramValue=='3'|| (orangeType.paramValue == null && orangeType.defaultValue=='3') ? 'checked' : ''}>${views.content['warningSetting.pop-upsAndTaskbar']}
                </label>
                <label class="m-r-sm m-l-sm">
                    ${views.content['提醒值']}
                    <span tabindex="0" class="help-popover m-l-sm" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top" data-content="${views.content_auto['当入款达到停用金额的']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
                    :
                </label>
                <label class="warning-b">
                    <input type="text" class="form-control" id="orangeAlert" name="orange.paramValue" value="${orange.paramValue}" maxlength="2"/>
                    <span>%</span>
                </label>
            </div>
        </div>
        <div class="form-group clearfix">
            <label class="ft-bold col-sm-3 al-right">
                <span class="co-red3">${views.common.red}</span>
                ${views.content['warningSetting.warning.prompt.type']}：
            </label>
            <div class="col-sm-5">
                <label>
                    <input type="radio" class="i-checks" value="1" name="redType.paramValue" ${redType.paramValue=='1'|| (redType.paramValue == null && redType.defaultValue=='1') ? 'checked' : ''}>${views.content['warningSetting.taskbar']}
                </label>
                <label>
                    <input type="radio" class="i-checks" value="3" name="redType.paramValue" ${redType.paramValue=='3'|| (redType.paramValue == null && redType.defaultValue=='3') ? 'checked' : ''}>${views.content['warningSetting.pop-upsAndTaskbar']}
                </label>
                <label class="m-r-sm m-l-sm">
                    ${views.content['提醒值']}
                    <span tabindex="0" class="help-popover m-l-sm" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top" data-content="${views.content_auto['当入款达到停用金额的']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
                    :
                </label>
                <label class="warning-b">
                    <input type="text" class="form-control" id="redAlert" name="red.paramValue" value="${red.paramValue}" maxlength="2"/>
                    <span>%</span>
                </label>
                <label class="m-r-sm m-l-sm" id="redMinSpan">&gt;${empty orange.paramValue?1:orange.paramValue}%</label>
            </div>
        </div>
        <div class="form-group clearfix">
            <label class="ft-bold col-sm-3 al-right">
                <span class="co-black">${views.content['warningSetting.account.freeze']}</span>
                ${views.content['warningSetting.prompt.type']}：
            </label>
            <div class="col-sm-5">
                <label>
                    <input type="radio" class="i-checks" value="1" name="freezeType.paramValue" ${freezeType.paramValue=='1'|| (freezeType.paramValue == null && freezeType.defaultValue=='1') ? 'checked' : ''}/>
                    ${views.content['warningSetting.taskbar']}
                </label>
                <label>
                    <input type="radio" class="i-checks" value="3" name="freezeType.paramValue" ${freezeType.paramValue=='3'|| (freezeType.paramValue == null && freezeType.defaultValue=='3') ? 'checked' : ''}/>
                    ${views.content['warningSetting.pop-upsAndTaskbar']}
                </label>
            </div>
        </div>
        <div class="form-group clearfix">
            <label class="ft-bold col-sm-3 al-right">
                <span class="co-blue">${views.content['warningSetting.account.unusual']}</span>
                ${views.content['warningSetting.prompt.type']}：
            </label>
            <div class="col-sm-5">
                <label>
                    <input type="radio" class="i-checks" value="1" name="unusualType.paramValue" ${unusualType.paramValue=='1'|| (unusualType.paramValue == null && unusualType.defaultValue=='1') ? 'checked' : ''}/>
                    ${views.content['warningSetting.taskbar']}
                </label>
                <label>
                    <input type="radio" class="i-checks" value="3" name="unusualType.paramValue" ${unusualType.paramValue=='3'|| (unusualType.paramValue == null && unusualType.defaultValue=='3') ? 'checked' : ''}/>
                    ${views.content['warningSetting.pop-upsAndTaskbar']}
                </label>
                <soul:button cssClass="m-l-sm" target="${root}/payAccount/unusualSettings.html" text="${views.setting['page.preference.modify']}" title="${views.content['warningSetting.account.unusual.edit.title']}" opType="dialog"/>
            </div>
        </div>
        <div class="form-group clearfix line-hi34">
            <label class="ft-bold col-sm-3 al-right">
                ${views.content['warningSetting.rankAccount.insufficient.prompt.type']}：
            </label>
            <div class="col-sm-5">
                <label>
                    <input type="checkbox" class="i-checks" value="true" name="inadequateState.paramValue" ${inadequateState.paramValue|| (inadequateState.defaultValue==null && inadequateState.defaultValue) ? 'checked' : ''}>${views.content['warningSetting.pop-ups']}
                </label>
                <div class="m-l-lg" style="display: inline-block;">
                    <span>${views.content['warningSetting.rankAccount.insufficient.number']}：</span>
                    <span id="warningCountSpan">${empty inadequateCount.paramValue ? inadequateCount.defaultValue : inadequateCount.paramValue}</span>
                    <input type="text" style="display: none;width: auto;" class="form-control" name="inadequateCount.paramValue" value="${empty inadequateCount.paramValue ? inadequateCount.defaultValue : inadequateCount.paramValue}" placeholder="1-10" maxlength="2">
                    <soul:button target="editWarningCount" text="${views.content_auto['修改']}" opType="function" cssClass="m-l-sm hideInput"/>
                    <span tabindex="0" class=" help-popover m-l-sm" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top" data-html="true" data-content="${views.content_auto['当某层级状态为']}</br><b>${views.content_auto['建议设置为“2”']}</b>" data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
                </div>
            </div>
        </div>

        <div class="operate-btn">
            <soul:button cssClass="btn btn-filter btn-lg m-r" text="${views.common.apply}" opType="ajax" dataType="json" precall="validateForm" target="${root}/payAccount/saveWarningSettings.html" post="getCurrentFormData" callback="saveWarningSettingBack" returnValue="true"/>
        </div>
    </div>
</div>
