<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.VActivityMessageListListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<%--返水优惠--%>
<div class="tab-content">
    <div id="tab-2" class="tab-pane active">
        <div class="gray-chunk clearfix">
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动名称']}：</label>
                <div class="col-sm-8">${views.operation_auto['投注有奖，全民都有']}<span class="co-red">${views.operation_auto['自定义']}</span></div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动分类']}：</label>
                <div class="col-sm-8 ">${views.operation_auto['老玩家专享']}<span class="co-red">${views.operation_auto['自定义']}</span></div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动时间']}：</label>
                <div class="col-sm-8 ">2018-04-13 ${views.operation_auto['至']} 2100-04-13<span class="co-red">${views.operation_auto['自定义']}</span></div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['领奖方式']}：</label>
                <div class="col-sm-8 ">${views.operation_auto['请至活动大厅申请该活动奖励']}${views.operation_auto['自定义']}</div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['优惠条件']}：</label>
                <div class="col-sm-8 "><span class="co-red">${views.operation_auto['自定义单次奖励和闯关奖励二选一']}</span></div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right"></label>
                <div class="col-sm-8 ">
                    <div class="dataTables_wrapper" role="grid">
                        <div class="tab-content table-responsive">
                            <table class="table table-striped border">
                                <tbody>
                                <tr>
                                    <td colspan="4" class="co-red">${views.operation_auto['单次奖励（达到指定有效投注额领取该阶梯奖励）']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['单次奖励阶梯']}</td>
                                    <td>${views.operation_auto['有效投注额']}</td>
                                    <td>${views.operation_auto['优惠方案']}</td>
                                    <td>${views.operation_auto['稽核要求']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['阶梯一']}</td>
                                    <td>${views.operation_auto['有效投注额满3000元']}</td>
                                    <td>50${views.operation_auto['元']}</td>
                                    <td>${views.operation_auto['5倍流水']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['阶梯二']}</td>
                                    <td>${views.operation_auto['有效投注额满5000元']}</td>
                                    <td>100${views.operation_auto['元']}</td>
                                    <td>${views.operation_auto['5倍流水']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['阶梯三']}</td>
                                    <td>${views.operation_auto['有效投注额满20000元']}</td>
                                    <td>500${views.operation_auto['元']}</td>
                                    <td>${views.operation_auto['5倍流水']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['阶梯四']}</td>
                                    <td>${views.operation_auto['有效投注额满50000元']}</td>
                                    <td>1500${views.operation_auto['元']}</td>
                                    <td>${views.operation_auto['5倍流水']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['阶梯五']}</td>
                                    <td>${views.operation_auto['有效投注额满100000元']}</td>
                                    <td>3500${views.operation_auto['元']}</td>
                                    <td>${views.operation_auto['5倍流水']}</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <br>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right"></label>
                <div class="col-sm-8 ">
                    <div class="dataTables_wrapper" role="grid">
                        <div class="tab-content table-responsive">
                            <table class="table table-striped border">
                                <tbody>
                                <tr>
                                    <td colspan="4" class="co-red">${views.operation_auto['闯关奖励（达到指定有效投注额包揽旗下所有阶梯奖励）']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['关卡一']}</td>
                                    <td>${views.operation_auto['有效投注额满3000元']}</td>
                                    <td>20${views.operation_auto['元']}</td>
                                    <td>${views.operation_auto['5倍流水']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['关卡二']}</td>
                                    <td>${views.operation_auto['有效投注额满5000元']}</td>
                                    <td>50${views.operation_auto['元']}</td>
                                    <td>${views.operation_auto['5倍流水']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['关卡三']}</td>
                                    <td>${views.operation_auto['有效投注额满20000元']}</td>
                                    <td>200${views.operation_auto['元']}</td>
                                    <td>${views.operation_auto['5倍流水']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['关卡四']}</td>
                                    <td>${views.operation_auto['有效投注额满50000元']}</td>
                                    <td>500${views.operation_auto['元']}</td>
                                    <td>${views.operation_auto['5倍流水']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['关卡五']}</td>
                                    <td>${views.operation_auto['有效投注额满100000元']}</td>
                                    <td>1500${views.operation_auto['元']}</td>
                                    <td>${views.operation_auto['5倍流水']}</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动详情']}：</label>
                <div class="col-sm-8 co-red">${views.operation_auto['自定义文宣、包装很重要、很重要、很重要']}</div>
            </div>

            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right"></label>
                <div class="col-sm-8 ">
                    <p>${views.operation_auto['阳光普照']}</p>
                </div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动规则']}：</label>
                <div class="col-sm-8 co-red">
                    <span class="co-red">${views.operation_auto['自定义']}</span>
                </div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right"></label>
                <div class="col-sm-8">
                    <p>1. ${views.operation_auto['所有玩家可以报名参与，随时查询当前有效投注额的进度']}
                    </p>
                    <p>2. ${views.operation_auto['本活动有效投注额的统计方式']}</p>
                    <p>3. ${views.operation_auto['报名完成会公布派奖时间']}
                        <span class="co-red">${views.operation_auto['根据申领周期来配置']}</span>
                        ${views.operation_auto['可以参与1次']}
                    </p>
                    <p>4. ${views.operation_auto['若符合活动条件']}&nbsp;
                        <span class="co-red">${views.operation_auto['例_多个相同银行卡的账号']}</span>
                    </p>
                    <p>5. ${views.operation_auto['参与该优惠活动_即表示您同意']}</p>

                </div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['优惠条款']}：</label>
                <div class="col-sm-8">
                    <p>1. ${views.operation_auto['所有优惠以人民币为结算金额']}</p>
                    <p>2. ${views.operation_auto['视为同一位会员']} <%= SessionManager.getSiteName(request) %>
                        ${views.operation_auto['保留收回或取消申请优惠金的权利']}
                    </p>
                    <p>3. <%= SessionManager.getSiteName(request) %>${views.operation_auto['所有优惠特为玩家而设']}</p>
                    <p>4. ${views.operation_auto['若会员对活动有争议时为确保双方利益']}<%= SessionManager.getSiteName(request) %>
                        ${views.operation_auto['有权要求会员向我们提供充足有效的文件']}
                    </p>
                    <p>5. ${views.operation_auto['本活动最终解释权归属']}<%= SessionManager.getSiteName(request) %>
                        ${views.operation_auto['并保留修改以上条款的最终权利']}
                    </p>
                </div>
            </div>
            <br>
            <br>

            <div class="clearfix line-hi34 co-red">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['致各位尊敬的站长']}：</label>
                <div class="col-sm-8">
                    <p>${views.operation_auto['玩家层级不满足活动要求']}</p>

                </div>
            </div>




        </div>
    </div>
</div>
<!--//endregion your codes 1-->

