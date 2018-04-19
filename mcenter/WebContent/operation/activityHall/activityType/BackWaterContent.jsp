<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.VActivityMessageListListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<%--返水优惠--%>
<div class="tab-content">
    <div id="tab-2" class="tab-pane active">

        <div class="gray-chunk clearfix">
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动分类']}：</label>
                <div class="col-sm-8 ">${views.operation_auto['活动分类']}</div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动时间']}：</label>
                <div class="col-sm-8 ">${views.operation_auto['无限制时间']}</div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动名称']}：</label>
                <div class="col-sm-8">${views.operation_auto['返水']}

                </div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动概述']}：</label>
                <div class="col-sm-8 ">${views.operation_auto['不计输赢']}</div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['优惠条件']}：</label>
                <div class="col-sm-8 ">${views.operation_auto['站长可点击系统设置中的返水设置设定该活动优惠条件']}</div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动内容']}：</label>
                <div class="col-sm-5 ">
                    <p>1.${views.operation_auto['包括各个API的返水比例以及VIP返水比例']}</p>
                    <p>2.${views.operation_auto['声明发放方式以及返水时间']}</p>
                    <p>3.${views.operation_auto['注明优惠细则']}</p>
                </div>
            </div>

            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动详情']}：</label>
                <div class="col-sm-8 ">
                    <div class="clearfix m-b-sm">${views.operation_auto['甲公司超级返水火热进行中']}</div>
                    <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
                        <div class="tab-content table-responsive">
                            <table class="table table-striped border">
                                <tbody>

                                <tr>
                                    <td>${views.operation_auto['有效投注']}</td>
                                    <td>${views.operation_auto['体育投注']}</td>
                                    <td>${views.operation_auto['真人视讯']}</td>
                                    <td>${views.operation_auto['电子游艺']}</td>
                                    <td>${views.operation_auto['最高金额']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['500万起']}</td>
                                    <td>1.0%</td>
                                    <td>1.3%</td>
                                    <td>1.5%</td>
                                    <td>${views.operation_auto['无上限']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['100万起']}</td>
                                    <td>1.0%</td>
                                    <td>1.3%</td>
                                    <td>1.5%</td>
                                    <td>${views.operation_auto['无上限']}</td>
                                </tr>
                                </tbody></table>
                        </div></div>

                    <div class="clearfix m-b-sm">${views.operation_auto['VIP贵宾尊享更高返水']}</div>
                    <div class="dataTables_wrapper" role="grid">
                        <div class="tab-content table-responsive">
                            <table class="table table-striped border">
                                <tbody>

                                <tr>
                                    <td>${views.operation_auto['有效投注']}</td>
                                    <td>${views.operation_auto['体育投注']}</td>
                                    <td>${views.operation_auto['真人视讯']}</td>
                                    <td>${views.operation_auto['电子游艺']}</td>
                                    <td>${views.operation_auto['最高金额']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['500万起']}</td>
                                    <td>1.0%</td>
                                    <td>1.3%</td>
                                    <td>1.5%</td>
                                    <td>${views.operation_auto['无上限']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['100万起']}</td>
                                    <td>1.0%</td>
                                    <td>1.3%</td>
                                    <td>1.5%</td>
                                    <td>${views.operation_auto['无上限']}</td>
                                </tr>
                                </tbody></table>
                        </div></div>

                    <div class="clearfix m-b-sm">${views.operation_auto['返水优惠无需申请']}</div>
                    <div class="dataTables_wrapper" role="grid">
                        <div class="tab-content table-responsive">
                            <table class="table table-striped border">
                                <tbody>

                                <tr>
                                    <td></td>
                                    <td>${views.operation_auto['美东时间']}</td>
                                    <td>${views.operation_auto['北京时间']}</td>

                                </tr>
                                <tr>
                                    <td>${views.operation_auto['返水结算时间']}</td>
                                    <td>${views.operation_auto['当日']}00:00-23:59</td>
                                    <td>${views.operation_auto['当日']}12:00${views.operation_auto['至次日']}11:59</td>

                                </tr>
                                <tr>
                                    <td>${views.operation_auto['返水发放时间']}</td>
                                    <td>${views.operation_auto['次日']}2:30-4:00</td>
                                    <td>${views.operation_auto['次日']}14:30-16:00</td>

                                </tr>
                                </tbody></table>
                        </div></div>
                    <div class="clearfix m-b-sm">${views.operation_auto['活动时间生效中']}</div>
                    <div class="clearfix m-b-sm">${views.operation_auto['例如']}</div>

                </div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动细则']}：</label>
                <div class="col-sm-8 ">${views.operation_auto['每日返水彩金无需稽核即可提现']}<br>
                    ${views.operation_auto['申请18元现金活动产生的有效投注不参与计算每日返水']}<br>
                    ${views.operation_auto['参与该优惠']}。</div>
            </div>

            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['站点时区']}：</label>
                <div class="col-sm-8">
                    <p>1. ${views.operation_auto['所有优惠以人民币(CNY)为结算金额，以美东时间(EDT)为计时区间。']}</p>
                    <p>2. ${views.operation_auto['每位玩家']}</p>
                    <p>3. ${views.operation_auto['甲公司的所有优惠特为玩家而设']}</p>
                    <p>4. ${views.operation_auto['若会员对活动有争议时']}</p>
                    <p>5. ${views.operation_auto['甲公司保留对活动的最终解释权；以及在无通知的情况下修改、终止活动的权利；适用于所有优惠。']}</p>
                </div>
            </div>
        </div>
    </div>
</div>
<!--//endregion your codes 1-->

