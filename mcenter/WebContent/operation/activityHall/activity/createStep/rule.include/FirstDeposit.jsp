<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.VActivityMessageListListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<%--首存送,存就送--%>
<div class="clearfix m-t-md">
    <label class="ft-bold col-sm-3 al-right line-hi34">${views.operation['Activity.step.conditions']}：</label>
    <div class="col-sm-9" id="bb">
        <div class="tab-content table-responsive">
            <table class="table border" id="first_deposit">
                <tr>
                    <td colspan="5">
                        <input id="percentageHandsel" type="radio" class="i-checks" name="ｍosaicGold" value="true" checked="checked">${views.operation['Activity.step.proportion']}
                        <input id="regularHandsel" type="radio" class="i-checks" name="ｍosaicGold" value="false">${views.operation['Activity.step.fixed']}${siteCurrency}
                    </td>

                </tr>
                <tr>
                    <td class="bg-gray ft-bold">${views.operation['Activity.step.depositAmount']}${siteCurrency}</td>
                    <td class="bg-gray ft-bold"></td>
                    <td class="bg-gray ft-bold"></td>
                    <td class="bg-gray ft-bold">${views.operation['Activity.step.audit']}<span tabindex="0" class=" help-popover m-l-sm" role="button" data-container="body" data-toggle="popover" data-html="true" data-trigger="focus" data-placement="top" data-content=" ${views.operation['Activity.step.message9']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span></td>
                </tr>
                <c:forEach items="${activitypreferentialList}" var="f" varStatus="status">
                    <tr class="fd">
                        <td>
                            <div class="content-width-limit-250 input-group">
                                <span class="input-group-addon">${views.operation['Activity.step.isFull']}</span>
                                <input type="text" class="form-control" value="${f.preferential_value}" name="depositAmountGe[${status.index}].preferentialValue" data-name="depositAmountGe[{n}].preferentialValue">
                                <span class="input-group-addon">${views.operation['Activity.step.more']}</span>
                            </div>
                        </td>
                        <td>
                            <div class="content-width-limit-10 input-group">
                                <input type="text" class="form-control fd_percentageHandsel" value="${f.preferential_form eq 'percentage_handsel'?f.preferential_val:''}" name="percentageHandsel[${status.index}].preferentialValue" data-name="percentageHandsel[{n}].preferentialValue" >
                                <span class="input-group-addon">%</span>
                            </div>
                        </td>
                        <td>
                            <div class="content-width-limit-10 input-group">
                                <span class="input-group-addon">${views.operation['Activity.step.send']}</span>
                                <input type="text" disabled="disabled" class="form-control fd_regularHandsel" value="${f.preferential_form eq 'regular_handsel'?f.preferential_val:''}" name="regularHandsel[${status.index}].preferentialValue" data-name="regularHandsel[{n}].preferentialValue">
                            </div>
                        </td>
                        <td>
                            <div class="content-width-limit-10 input-group">
                                <input type="text" class="form-control" placeholder="${views.operation['Activity.step.empty']}" value="${f.preferential_audit lt 0.01 ?'':f.preferential_audit}" name="preferentialAudits[${status.index}].preferentialAudit" data-name="preferentialAudits[{n}].preferentialAudit">
                                <span class="input-group-addon">${views.operation['Activity.step.times']}</span>
                            </div>
                        </td>
                        <td><soul:button target="deleteActivityRule" text="" opType="function" tag="button" cssClass="btn btn-danger ${status.first?'disabled':''}">${views.common['delete']}</soul:button></td>
                    </tr>
                </c:forEach>
                <c:if test="${empty activitypreferentialList}">
                    <tr class="fd">
                        <td>
                            <div class="content-width-limit-250 input-group">
                                <span class="input-group-addon">${views.operation['Activity.step.isFull']}</span>
                                <input type="text" class="form-control" name="depositAmountGe[0].preferentialValue" data-name="depositAmountGe[{n}].preferentialValue">
                                <span class="input-group-addon">${views.operation['Activity.step.more']}</span>
                            </div>
                        </td>
                        <td>
                            <div class="content-width-limit-10 input-group">
                                <input type="text" class="form-control fd_percentageHandsel" name="percentageHandsel[0].preferentialValue" data-name="percentageHandsel[{n}].preferentialValue" >
                                <span class="input-group-addon">%</span>
                            </div></td>
                        <td>
                            <div class="content-width-limit-10 input-group">
                                <span class="input-group-addon">${views.operation['Activity.step.send']}</span>
                                <input type="text" disabled="disabled" class="form-control fd_regularHandsel" placeholder="" name="regularHandsel[0].preferentialValue" data-name="regularHandsel[{n}].preferentialValue">
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