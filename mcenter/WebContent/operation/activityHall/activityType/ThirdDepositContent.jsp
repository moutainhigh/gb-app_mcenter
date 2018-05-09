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
                <div class="col-sm-8">${views.operation_auto['第三次存款有奖，即送888元彩金']}<span class="co-red">${views.operation_auto['自定义']}</span></div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动分类']}：</label>
                <div class="col-sm-8 ">${views.operation_auto['新人优惠']}<span class="co-red">${views.operation_auto['自定义']}</span></div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动时间']}：</label>
                <div class="col-sm-8 ">2018-04-13 ${views.operation_auto['至']} 2100-04-13<span class="co-red">${views.operation_auto['自定义']}</span></div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['领奖方式']}：</label>
                <div class="col-sm-8 ">${views.operation_auto['完成第三次存款后，请至活动大厅申请该活动奖励']}${views.operation_auto['自定义']}</div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['优惠条件']}：</label>
                <div class="col-sm-8 "><span class="co-red">${views.operation_auto['固定彩金和比例赠送为单选']}</span></div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right"></label>
                <div class="col-sm-8 ">
                    <div class="dataTables_wrapper" role="grid">
                        <div class="tab-content table-responsive">
                            <table class="table table-striped border">
                                <tbody>
                                <tr>
                                    <td colspan="3" class="co-red">${views.operation_auto['比例赠送']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['存款金额']}</td>
                                    <td>${views.operation_auto['优惠方案']}</td>
                                    <td>${views.operation_auto['稽核要求']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['第三次存款金额达到100元以上']}</td>
                                    <td>${views.operation_auto['额外赠送30%彩金']}</td>
                                    <td>${views.operation_auto['5倍流水']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['第三次存款金额达到500元以上']}</td>
                                    <td>${views.operation_auto['额外赠送40%彩金']}</td>
                                    <td>${views.operation_auto['5倍流水']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['第三次存款金额达到1000元以上']}</td>
                                    <td>${views.operation_auto['额外赠送50%彩金']}</td>
                                    <td>${views.operation_auto['5倍流水']}</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right"> </label>
                <div class="col-sm-5">
                    ${views.operation_auto['最高奖励金额为888元']}
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
                                    <td colspan="3" class="co-red">${views.operation_auto['固定彩金赠送']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['存款金额']}</td>
                                    <td>${views.operation_auto['优惠方案']}</td>
                                    <td>${views.operation_auto['稽核要求']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['第三次存款金额达到100元以上']}</td>
                                    <td>${views.operation_auto['额外赠送30元']}</td>
                                    <td>${views.operation_auto['5倍流水']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['第三次存款金额达到500元以上']}</td>
                                    <td>${views.operation_auto['额外赠送200元']}</td>
                                    <td>${views.operation_auto['5倍流水']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['第三次存款金额达到1000元以上']}</td>
                                    <td>${views.operation_auto['额外赠送500元']}</td>
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
                    <p>${views.operation_auto['存款三部曲']}</p>
                    <p>${views.operation_auto['答案是_该']}</p>
                    <p>${views.operation_auto['我们敢优惠']}</p>
                    <p>${views.operation_auto['答案是_敢']}</p>
                    <p>${views.operation_auto['凡是第三笔存款达到指定金额要求即可申请三存送优惠']}</p>
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
                        <p>1. ${views.operation_auto['每位会员终身仅能享受1次第三次存款优惠活动']}
                            <span class="co-red">${views.operation_auto['自定义']}</span>
                            ${views.operation_auto['内申请奖励']}
                        </p>
                        <p>2. ${views.operation_auto['第三次存款金额不符则失去次存优惠的机会']}</p>
                        <p>3. ${views.operation_auto['若符合活动条件']}&nbsp;
                            <span class="co-red">${views.operation_auto['例_多个相同银行卡的账号']}</span>
                        </p>
                        <p>4. ${views.operation_auto['活动存款方式包含']}
                            <span class="co-red">${views.operation_auto['自定义']}</span>
                        </p>
                        <p>5. ${views.operation_auto['此存款订单号只能用于一种活动的申请']}</p>
                        <p>6. ${views.operation_auto['参与该优惠活动_即表示您同意']}</p>

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

