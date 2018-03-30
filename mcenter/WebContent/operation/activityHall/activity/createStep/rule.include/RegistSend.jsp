<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.VActivityMessageListListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<%--注册送--%>
<div class="clearfix m-t-md">

    <div class="clearfix m-t-md">
        <label class="ft-bold col-sm-3 al-right line-hi34">
                    <span tabindex="0"
                          role="button" data-container="body"
                          data-toggle="popover" data-trigger="focus"
                          data-placement="top" data-html="true"
                          data-original-title="" title=""></span>${views.operation['有效条件']}：</label>

        <div class="col-sm-3 input-group">
            <label class="m-r-sm">
                <input type="checkbox" class="i-checks" name="effectiveCondition[0].preferentialCode" value="bankcard_unique" ${effectiveConditionSet.contains('bankcard_unique')?'checked':''}>
                    ${views.operation['bankcard_unique']}
            </label>
            <label class="m-r-sm">
                <input type="checkbox" class="i-checks" name="effectiveCondition[1].preferentialCode" value="real_name_unique" ${effectiveConditionSet.contains('real_name_unique')?'checked':''}>
                ${views.operation['real_name_unique']}
            </label>
            <label class="m-r-sm">
                <input type="checkbox" class="i-checks" name="effectiveCondition[2].preferentialCode" value="register_ip_unique" ${effectiveConditionSet.contains('register_ip_unique')?'checked':''}>
                ${views.operation['register_ip_unique']}
            </label>
            <label class="m-r-sm">
                <input type="checkbox" class="i-checks" name="effectiveCondition[3].preferentialCode" value="device_no_unique" ${effectiveConditionSet.contains('device_no_unique')?'checked':''}>
                ${views.operation['device_no_unique']}
            </label>
        </div>
    </div>

    <label class="ft-bold col-sm-3 al-right line-hi34">${views.operation['Activity.step.conditions']}：</label>
    <div class="col-sm-9">
        <div class="tab-content table-responsive">
            <table class="table border" id="regist_send">
                <tr>
                    <td class="bg-gray ft-bold" colspan="2">${views.operation['Activity.step.offerForm']}</td>
                </tr>
                <tr>
                    <td>${views.operation['Activity.step.caijin']}${siteCurrency}</td>
                    <td>${views.operation['Activity.step.audit']}<span tabindex="0" class=" help-popover m-l-sm" role="button" data-container="body" data-toggle="popover" data-html="true" data-trigger="focus" data-placement="top" data-content=" ${views.operation['Activity.step.message9']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span></td>
                </tr>
                <tr>
                    <td>
                        <div class="content-width-limit-10 input-group">
                            <span class="input-group-addon">${views.operation['Activity.step.send']}</span>
                            <input type="text" class="form-control" placeholder="" value="${activityWayRelation.preferentialValue}" name="activityWayRelation.preferentialValue">
                        </div>
                    </td>
                    <td>
                        <div class="content-width-limit-10 input-group">
                            <input type="text" class="form-control" placeholder="${views.operation['Activity.step.empty']}" value="${activityWayRelation.preferentialAudit lt 0.01 ?'':activityWayRelation.preferentialAudit}" name="activityWayRelation.preferentialAudit">
                            <span class="input-group-addon">${views.operation['Activity.step.times']}</span>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <soul:button target="registSystemRecommendCase" text="" opType="function" cssClass="btn btn-info btn-addon pull-right m-t">
        <i class="fa fa-plus"></i><span class="hd">${views.operation['系统推荐']}</span>
    </soul:button>
</div>
<!--//endregion your codes 1-->

