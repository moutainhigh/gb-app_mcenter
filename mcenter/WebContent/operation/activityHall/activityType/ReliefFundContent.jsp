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
                <div class="col-sm-8">${views.operation_auto['亏损救援彩金']}</div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动概述']}：</label>
                <div class="col-sm-8 ">${views.operation_auto['当日亏损达到']}</div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['优惠条件']}：</label>
                <div class="col-sm-8 ">
                    <div class="dataTables_wrapper" role="grid">
                        <div class="tab-content table-responsive">
                            <table class="table table-striped border">
                                <tbody>
                                <tr>
                                    <td colspan="3">${views.operation_auto['活动规则']}</td>
                                    <td colspan="2">${views.operation_auto['优惠形式']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['有效交易量']}</td>
                                    <td>${views.operation_auto['总资产']}</td>
                                    <td>${views.operation_auto['亏损额度']}</td>
                                    <td>${views.operation_auto['赠送彩金CNY']}</td>
                                    <td>${views.operation_auto['优惠稽核']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['满()以上']}</td>
                                    <td>${views.operation_auto['剩余()以下']}</td>
                                    <td>${views.operation_auto['达到()以上']}</td>
                                    <td>(${views.operation_auto['固定金额']})</td>
                                    <td>${views.operation_auto['(可为空)倍']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['满()以上']}</td>
                                    <td>${views.operation_auto['剩余()以下']}</td>
                                    <td>${views.operation_auto['达到()以上']}</td>
                                    <td>(${views.operation_auto['固定金额']})</td>
                                    <td>${views.operation_auto['(可为空)倍']}</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动内容']}：</label>
                <div class="col-sm-5">
                    <p>1.${views.operation_auto['注明领取救济金的条件']}</p>
                    <p>2.${views.operation_auto['如有API以及游戏项目的限制需申明该活动适用的API以及游戏范围']}</p>
                    <p>3.${views.operation_auto['申明活动细则以及优惠规则与条款']}</p>
                </div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['填写优惠条件']}：</label>
                <div class="col-sm-8 ">
                    <div class="dataTables_wrapper" role="grid">
                        <div class="tab-content table-responsive">
                            <table class="table table-striped border">
                                <tbody>
                                <tr>
                                    <td colspan="3">${views.operation_auto['活动规则']}</td>
                                    <td colspan="2">${views.operation_auto['优惠形式']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['有效交易量']}</td>
                                    <td>${views.operation_auto['总资产']}</td>
                                    <td>${views.operation_auto['亏损额度']}</td>
                                    <td>${views.operation_auto['赠送彩金CNY']}</td>
                                    <td>${views.operation_auto['优惠稽核']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['满()以上']}</td>
                                    <td>${views.operation_auto['剩余()以下']}</td>
                                    <td>${fn:replace(views.operation['达到以上'],"[0]",1000)}</td>
                                    <td>(20)</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['满()以上']}</td>
                                    <td>${views.operation_auto['剩余()以下']}</td>
                                    <td>${fn:replace(views.operation['达到以上'],"[0]",5000)}</td>
                                    <td>(150)</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['满()以上']}</td>
                                    <td>${views.operation_auto['剩余()以下']}</td>
                                    <td>${fn:replace(views.operation['达到以上'],"[0]",10000)}</td>
                                    <td>(500)</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动详情']}：</label>
                <div class="col-sm-8 ">
                    <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
                        <div>${views.operation_auto['甲公司']}</div>
                        <div>${views.operation_auto['电子游艺7部曲']}</div>
                        <div class="tab-content table-responsive">
                            <table class="table table-striped border">
                                <tbody>
                                <tr>
                                    <td>${views.operation_auto['亏损金额']}</td>
                                    <td>${views.operation_auto['可获赠救援金']}</td>
                                    <td>${views.operation_auto['稽核倍数']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['1000元及以下']}</td>
                                    <td>20</td>
                                    <td>1</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['5000元及以下']}</td>
                                    <td>150</td>
                                    <td>1</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['10000元及以下']}</td>
                                    <td>500</td>
                                    <td>1</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clearfix line-hi34">
                <label class="col-sm-3 al-right"><span class="ft-bold">${views.operation_auto['活动细则']}：</span><span>（${views.operation_auto['站长自行设定有关该活动的细则']}）</span></label>
                <div class="col-sm-8 ">
                    <p>1.${views.operation_auto['所获得奖金需一倍稽核方可申请提款；']}</p>
                    <p>2.${views.operation_auto['每位会员每天仅限申请一次，天数按照美东时间计算']}；</p>
                    <p>3.${views.operation_auto['符合申请条件的会员请在次日24小时内发送邮件进行申请']}</p>
                    <p>4.${views.operation_auto['参与该优惠']}</p>
                </div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['优惠规则与条款']}</label>
                <div class="col-sm-8">
                    <p>1.${views.operation_auto['所有优惠以人民币(CNY)为结算金额，以美东时间(EDT)为计时区间。']}</p>
                    <p>2.${views.operation_auto['每位玩家']}</p>
                    <p>3.${views.operation_auto['甲公司的所有优惠特为玩家而设']}</p>
                    <p>4.${views.operation_auto['若会员对活动有争议时']}
                    <p>5.${views.operation_auto['当参与优惠会员未能完全遵守']}</p>
                    <p>6.${views.operation_auto['甲公司保留对活动的最终解释权；以及在无通知的情况下修改、终止活动的权利；适用于所有优惠。']}</p>
                </div>
            </div>
        </div>
    </div>
</div>
<!--//endregion your codes 1-->

