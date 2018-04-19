<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.VActivityMessageListListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<%--救济金--%>
<div class="clearfix m-t-md">
    <label class="ft-bold col-sm-3 al-right line-hi34">${views.operation['Activity.step.conditions']}：</label>
    <div class="col-sm-9">
        <div class="tab-content table-responsive">
            <table class="table border" id="first_deposit">
                <tr>
                    <td class="bg-gray ft-bold" colspan="2">${views.operation['Activity.rule']}</td>
                    <td class="bg-gray ft-bold" colspan="2">${views.operation['Activity.step.offerForm']}</td>
                    <td class="bg-gray ft-bold" rowspan="2">${views.common['operate']}</td>
                </tr>
                <tr>
                    <td>${views.operation['Activity.step.totalAssets']}</td>
                    <td>${views.operation['Activity.step.lossAmount']}</td>
                    <td>${views.operation['Activity.step.caijin']}${siteCurrency}</td>
                    <td>${views.operation['Activity.step.audit']}<span tabindex="0" class=" help-popover m-l-sm" role="button" data-container="body" data-toggle="popover" data-html="true" data-trigger="focus" data-placement="top" data-content=" ${views.operation['Activity.step.message9']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span></td>
                </tr>
                <c:forEach items="${activityPreferentialRelationTotal}" var="re" varStatus="status">
                    <tr class="fd">
                        <td>
                            <div class="content-width-limit-10 input-group">
                                <span class="input-group-addon">${views.operation['Activity.step.surplus']}</span>
                                <input type="text" class="form-control" value="${activityPreferentialRelationList[re.orderColumn].preferentialValue}" name="totalAssetsLe[${status.index}].preferentialValue" data-name="totalAssetsLe[{n}].preferentialValue">
                                <span class="input-group-addon">${views.operation['Activity.step.less']}</span>
                            </div>
                        </td>
                        <td>
                            <div class="content-width-limit-10 input-group">
                                <span class="input-group-addon">${views.operation['Activity.step.reach']}</span>
                                <input type="text" class="form-control" value="${activityPreferentialRelationList1[re.orderColumn].preferentialValue}" name="lossAmount[${status.index}].preferentialValue" data-name="lossAmount[{n}].preferentialValue">
                                <span class="input-group-addon">${views.operation['Activity.step.more']}</span>
                            </div>
                        </td>
                        <td>
                            <div class="content-width-limit-10 input-group">
                                <span class="input-group-addon">${views.operation['Activity.step.send']}</span>
                                <input type="text" class="form-control" placeholder="" value="${activityWayRelations[re.orderColumn].preferentialValue}" name="regularHandsel[${status.index}].preferentialValue" data-name="regularHandsel[{n}].preferentialValue">
                            </div>
                        </td>
                        <td>
                            <div class="content-width-limit-10 input-group">
                                <input type="text" class="form-control" placeholder="${views.operation['Activity.step.empty']}" value="${activityWayRelations[re.orderColumn].preferentialAudit lt 0.01 ?'':activityWayRelations[re.orderColumn].preferentialAudit}" name="preferentialAudits[${status.index}].preferentialAudit" data-name="preferentialAudits[{n}].preferentialAudit">
                                <span class="input-group-addon">${views.operation['Activity.step.times']}</span>
                            </div>
                        </td>
                        <td><soul:button target="deleteActivityRule" text="" opType="function" tag="button" cssClass="btn btn-danger ${status.first?'disabled':''}">${views.common['delete']}</soul:button></td>
                    </tr>
                </c:forEach>

                <c:if test="${empty activityPreferentialRelationTotal}">
                    <tr class="fd">
                        <td>
                            <div class="content-width-limit-10 input-group">
                                <span class="input-group-addon">${views.operation['Activity.step.surplus']}</span>
                                <input type="text" class="form-control" name="totalAssetsLe[0].preferentialValue" data-name="totalAssetsLe[{n}].preferentialValue">
                                <span class="input-group-addon">${views.operation['Activity.step.less']}</span>
                            </div>
                        </td>
                        <td>
                            <div class="content-width-limit-10 input-group">
                                <span class="input-group-addon">${views.operation['Activity.step.reach']}</span>
                                <input type="text" class="form-control" name="lossAmount[0].preferentialValue" data-name="lossAmount[{n}].preferentialValue">
                                <span class="input-group-addon">${views.operation['Activity.step.more']}</span>
                            </div>
                        </td>
                        <td>
                            <div class="content-width-limit-10 input-group">
                                <span class="input-group-addon">${views.operation['Activity.step.send']}</span>
                                <input type="text" class="form-control" placeholder="" name="regularHandsel[0].preferentialValue" data-name="regularHandsel[{n}].preferentialValue">
                            </div>
                        </td>
                        <td>
                            <div class="content-width-limit-10 input-group">
                                <input type="text" class="form-control" placeholder="${views.operation['Activity.step.empty']}" name="preferentialAudits[0].preferentialAudit" data-name="preferentialAudits[{n}].preferentialAudit">
                                <span class="input-group-addon">${views.operation['Activity.step.times']}</span>
                            </div>
                        </td>
                        <td><soul:button target="deleteActivityRule" text="" opType="function" tag="button" cssClass="btn btn-danger disabled">${views.common['delete']}</soul:button></td>
                    </tr>
                </c:if>
            </table>
        </div>
        <soul:button target="addActivityRule" text="" opType="function" cssClass="btn btn-info btn-addon pull-right m-t">
            <i class="fa fa-plus"></i><span class="hd">${views.common['create']}</span>
        </soul:button>
    </div>
</div>
<!--//endregion your codes 1-->

