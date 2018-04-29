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
                <div class="col-sm-8">${views.operation_auto['千万红包派送，最高188元']}<span class="co-red">${views.operation_auto['自定义']}</span></div>
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
                <div class="col-sm-8 ">${views.operation_auto['红包领奖方式']}</div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['抢红包次数规则']}：</label>
                <div class="col-sm-8 "><span class="co-red">${views.operation_auto['三选一']}</span></div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right"></label>
                <div class="col-sm-8 "><span class="co-red">${views.operation_auto['方案一：']}</span></div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right"></label>
                <div class="col-sm-8 ">
                    <div class="dataTables_wrapper" role="grid">
                        <div class="tab-content table-responsive">
                            <table class="table table-striped border">
                                <tbody>

                                <tr>
                                    <td>${views.operation_auto['单次存款满']}</td>
                                    <td>${views.operation_auto['时段累计有效投注额']}</td>
                                    <td>${views.operation_auto['抽红包次数']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['满']}100${views.operation_auto['元以上']}</td>
                                    <td>${views.operation_auto['达到']}300${views.operation_auto['元']}</td>
                                    <td>1${views.operation_auto['次']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['满']}2000${views.operation_auto['元以上']}</td>
                                    <td>${views.operation_auto['达到']}10000${views.operation_auto['元']}</td>
                                    <td>20${views.operation_auto['次']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['满']}10000${views.operation_auto['元以上']}</td>
                                    <td>${views.operation_auto['达到']}50000${views.operation_auto['元']}</td>
                                    <td>100${views.operation_auto['次']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['满']}50000${views.operation_auto['元以上']}</td>
                                    <td>${views.operation_auto['达到']}250000${views.operation_auto['元']}</td>
                                    <td>500${views.operation_auto['次']}</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right"></label>
                <div class="col-sm-8 "><span class="co-red">${views.operation_auto['方案二：']}</span></div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right"></label>
                <div class="col-sm-8 ">
                    <div class="dataTables_wrapper" role="grid">
                        <div class="tab-content table-responsive">
                            <table class="table table-striped border">
                                <tbody>

                                <tr>
                                    <td>${views.operation_auto['累计存款金额']}</td>
                                    <td>${views.operation_auto['时段累计有效投注额']}</td>
                                    <td>${views.operation_auto['抽红包次数']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['满']}100${views.operation_auto['元以上']}</td>
                                    <td>${views.operation_auto['达到']}300${views.operation_auto['元']}</td>
                                    <td>1${views.operation_auto['次']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['满']}2000${views.operation_auto['元以上']}</td>
                                    <td>${views.operation_auto['达到']}10000${views.operation_auto['元']}</td>
                                    <td>20${views.operation_auto['次']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['满']}10000${views.operation_auto['元以上']}</td>
                                    <td>${views.operation_auto['达到']}50000${views.operation_auto['元']}</td>
                                    <td>100${views.operation_auto['次']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['满']}50000${views.operation_auto['元以上']}</td>
                                    <td>${views.operation_auto['达到']}250000${views.operation_auto['元']}</td>
                                    <td>500${views.operation_auto['次']}</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right"></label>
                <div class="col-sm-8 "><span class="co-red">${views.operation_auto['方案三：']}</span></div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right"> </label>
                <div class="col-sm-5">
                    ${views.operation_auto['每个时段，每个玩家抽奖上限次数为_____次']}
                </div>
            </div>
            <br>

            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动规则']}：</label>
                <div class="col-sm-8 co-red">
                    <span class="co-red">${views.operation_auto['自定义']}</span>
                </div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right"></label>
                <div class="col-sm-8">
                        <p>1. ${views.operation_auto['红包活动时段累计']}
                        </p>
                        <p>2. ${views.operation_auto['若符合活动条件']}&nbsp;
                            <span class="co-red">${views.operation_auto['例_多个相同银行卡的账号']}</span>
                        </p>
                        <p>3. ${views.operation_auto['参与该优惠活动_即表示您同意']}</p>

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

