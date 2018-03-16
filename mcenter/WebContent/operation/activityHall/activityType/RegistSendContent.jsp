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
                <div class="col-sm-8">${views.operation_auto['新会员新人礼金，注册就送']}</div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动概述']}：</label>
                <div class="col-sm-8 ">${views.operation_auto['注册我司新会员']}</div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['优惠条件']}：</label>
                <div class="col-sm-8 ">
                    <div class="dataTables_wrapper" role="grid">
                        <div class="tab-content table-responsive">
                            <table class="table table-striped border">
                                <tbody>
                                <tr>
                                    <td colspan="2">${views.operation_auto['优惠形式']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['赠送彩金CNY']}</td>
                                    <td>${views.operation_auto['优惠稽核']}</td>
                                </tr>
                                <tr>
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
                    <p>1.${views.operation_auto['申明必须是首次注册的方可申请']}</p>
                    <p>2.${views.operation_auto['说明注册彩金适用的API游戏']}</p>
                    <p>3.${views.operation_auto['注明注册彩金活动的细则以及活动规则与条款']}</p>
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
                                    <td colspan="2">${views.operation_auto['优惠形式']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['赠送彩金CNY']}</td>
                                    <td>${views.operation_auto['优惠稽核']}</td>
                                </tr>
                                <tr>
                                    <td>(25)</td>
                                    <td>()${views.operation_auto['倍']}</td>
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
                        <div>${views.operation_auto['即日起加入甲公司']}</div>
                        <div class="tab-content table-responsive">
                            <table class="table table-striped border">
                                <tbody>
                                <tr>
                                    <td>${views.operation_auto['会员账号']}</td>
                                    <td>${views.operation_auto['赠送金额']}</td>
                                    <td>${views.operation_auto['稽核限制']}</td>
                                    <td>${views.operation_auto['游戏限制']}</td>
                                    <td>${views.operation_auto['最低取款']}</td>
                                </tr>
                                <tr>
                                    <td>2015gg</td>
                                    <td>25</td>
                                    <td>${views.operation_auto['无']}</td>
                                    <td>${views.operation_auto['无']}</td>
                                    <td>250${views.operation_auto['元']}</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <div>${views.operation_auto['会员注册后并绑定好出款银行卡无需申请']}</div>
                    </div>
                </div>
            </div>
            <div class="clearfix line-hi34">
                <label class="col-sm-3 al-right"><span class="ft-bold">${views.operation_auto['活动细则']}：</span><span>（${views.operation_auto['站长自行设定有关该活动的细则']}）</span></label>
                <div class="col-sm-8 ">
                    <p>1.${views.operation_auto['会员注册资料必须真实有效']}</p>
                    <p>2.${views.operation_auto['每位会员每天仅限申请一次，天数按照美东时间计算']}</p>
                    <p>3.${views.operation_auto['参与该优惠体验期间']}</p>
                    <p>4.${views.operation_auto['任何出现对打情况的投注']}；</p>
                    <p>5.${views.operation_auto['参与该优惠']}。</p>
                </div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['优惠规则与条款']}</label>
                <div class="col-sm-8">
                    <p>1.${views.operation_auto['所有优惠以人民币(CNY)为结算金额，以美东时间(EDT)为计时区间。']}</p>
                    <p>2.${views.operation_auto['每位玩家']}</p>
                    <p>3.${views.operation_auto['甲公司的所有优惠特为玩家而设']}</p>
                    <p>4.${views.operation_auto['若会员对活动有争议时']}</p>
                    <p>5.${views.operation_auto['当参与优惠会员未能完全遵守']}</p>
                    <p>6.${views.operation_auto['甲公司保留对活动的最终解释权；以及在无通知的情况下修改、终止活动的权利；适用于所有优惠。']}</p>
                </div>
            </div>
        </div>
    </div>
</div>
<!--//endregion your codes 1-->

