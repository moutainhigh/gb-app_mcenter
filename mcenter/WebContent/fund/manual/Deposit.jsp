<%@ page import="so.wwb.gamebox.model.master.fund.enums.RechargeTypeEnum" %><%--@elvariable id="rechargeType" type="java.util.List<org.soul.model.sys.po.SysDict>"--%>
<%--@elvariable id="sales" type="java.util.List<java.util.Map<java.lang.String,java.lang.Object>>"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set value="<%=RechargeTypeEnum.MANUAL_FAVORABLE.getCode()%>" var="manualFavorable"/>
<c:set value="<%=RechargeTypeEnum.MANUAL_DEPOSIT.getCode()%>" var="manualDeposit"/>
<c:set value="<%=RechargeTypeEnum.MANUAL_RAKEBACK.getCode()%>" var="manualRakeback"/>
<!--人工存入-->
<form>
    <div class="panel-body p-sm sdcq-wrap">
        <table class="table no-border table-desc-list">
            <tbody>
            <tr>
                <th scope="row" class="text-right">玩家账号：</th>
                <td>
                    <div class="table-desc-right-t width-response">
                        <input type="hidden" value="${username}" name="username"/>
                        <textarea class="form-control resize-vertical" placeholder="${views.fund_auto['多个账号，用半角逗号隔开']}" name="userNames">${username}</textarea>
                        <span class="right-flo">${views.fund['共']} <i class="co-red font-sty ft-bold" id="userCount">0</i>${views.fund_auto['人']}</span>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="row sdcq-xz">
            <div class="col-sm-6">
                <div class="panel-heading">
                    <h3 class="co-blue">存款</h3>
                </div>
                <table class="table no-border table-desc-list">
                    <tbody>
                    <tr>
                        <th scope="row" class="text-right">${views.fund['存款金额：']}</th>
                        <td>
                            <input type="text" name="result.rechargeAmount" class="form-control" style="width:30%;"/>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row" class="text-right">类型：</th>
                        <td>
                            <div class="table-desc-right-t" style="width:30%;">
                                <select name="result.rechargeType" class="btn-group chosen-select-no-single">
                                    <c:forEach items="${rechargeType}" var="i">
                                        <c:if test="${rechargeType != manualFavorable && rechargeType != manualRakeback}">
                                            <option value="${i.dictCode}">${dicts.fund.recharge_type[i.dictCode]}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                                <span class="right-flo co-grayc2" style="display: none" id="spanTips">${views.fund['总代和代理将按分摊比例共同承担']}</span>
                                <span class="right-flo co-grayc2" style="display: none" id="spanTips2">${views.fund['该笔资金记录不对玩家展示']}</span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row" class="text-right">稽核：</th>
                        <td>
                            <div class="line-hi34 m-b-sm min-w">
                                <label class="m-r"><input type="radio" value="false" name="result.isAuditRecharge">${views.fund['免稽核']}</label>
                                <label><input type="radio" value="true" name="result.isAuditRecharge">${views.fund['存款稽核']}</label>
                                <span tabindex="0" class=" help-popover m-r" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top" data-html="true" data-content="${views.fund_auto['勾选并成功存款后']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
                            </div>
                            <div class="table-desc-right-t" id="auditMultipleDiv" style="display: block; width:100px;">
                                <input type="text" class="form-control" name="auditMultiple" placeholder="${views.fund_auto['稽核倍数']}"/>
                                <span class="right-flo co-grayc2">${views.fund['倍']}</span>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="col-sm-6">
                <div class="panel-heading">
                    <h3 class="co-blue">优惠</h3>
                </div>
                <table class="table no-border table-desc-list">
                    <tbody>
                    <tr>
                        <th scope="row" class="text-right">优惠金额：</th>
                        <td>
                            <input type="text" class="form-control" name="favorable.favorableTotalAmount" style="width:30%;">
                        </td>
                    </tr>
                    <tr>
                        <th scope="row" class="text-right">类型：</th>
                        <td>
                            <div class="table-desc-right-t" style="width:30%;">
                                <select name="result.rechargeType" class="btn-group chosen-select-no-single">
                                    <c:forEach items="${rechargeType!=''}" var="i">
                                        <c:if test="${rechargeType != manualDeposit}">
                                            <option value="${i.dictCode}">${dicts.fund.recharge_type[i.dictCode]}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row" class="text-right">稽核：</th>
                        <td>
                            <div class="line-hi34 m-b-sm min-w">
                                <label class="m-r"><input type="radio"  value="0" name="auditType">${views.fund['免稽核']}</label>
                                <label><input type="radio" value="2" name="auditType">${views.fund['优惠稽核']}</label>
                                <span tabindex="0" class=" help-popover m-r" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top" data-html="true" data-content="1、${views.fund_auto['玩家在取款时']}<br>2、${views.fund_auto['当没有通过存款申请获得优惠']}" title=""><i class="fa fa-question-circle"></i></span>
                                <span id="fav_tip" class="right-flo co-grayc2" style="display: none"></span>
                            </div>
                            <div class="table-desc-right-t" id="favorableAuditMultipleDiv" style="display: block; width:100px;">
                                <input type="text" class="form-control" name="playerFavorable.auditFavorableMultiple" placeholder="${views.fund_auto['稽核倍数']}"/>
                                <span class="right-flo co-grayc2">${views.fund['倍']}</span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row" class="text-right">活动名称：</th>
                        <td>
                            <div class="table-desc-right-t">
                                <div class="table-desc-right-t" style="background: white;">
                                    <select name="activityId">
                                        <option value="">${views.fund['请选择']}</option>
                                        <c:forEach items="${sales}" var="i">
                                            <option value="${i.id}">${i.activityName}</option>
                                        </c:forEach>
                                    </select>
                                    <span class="right-flo">
                                        <input type="text" name="activityName" class="form-control" style="width: 100%;">
                                    </span>
                                </div>
                                <div class="right-flo co-grayc2 line-hi34">${views.fund['非必填；选择后，活动名称将在玩家中心-优惠记录页面显示']}</div>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <table class="table no-border table-desc-list">
            <tbody>
            <tr>
                <th scope="row" class="text-right" style="vertical-align: top;">备注：</th>
                <td>
                    <textarea name="result.checkRemark" maxlength="200" class="form-control resize-vertical width-response" rows="4"></textarea>
                </td>
            </tr>
            <tr>
                <th></th>
                <td>
                    <div class="btn-groups text-left">
                        <soul:button target="submit" precall="validateForm" msg="${views.fund['确认提交？']}" text="${views.fund_auto['确定']}" opType="function" cssClass="btn btn-filter p-x-lg m-r-md"/>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</form>
<script type="text/javascript">
    curl(['site/fund/manual/Deposit'], function(Deposit) {
        page.deposit = new Deposit();
        page.deposit.bindButtonEvents();
    });
</script>
