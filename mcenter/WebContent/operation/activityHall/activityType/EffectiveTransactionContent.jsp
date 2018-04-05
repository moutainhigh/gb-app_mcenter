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
                <div class="col-sm-8">${views.operation_auto['不计输赢，只要投注就送彩金']}</div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动概述']}：</label>
                <div class="col-sm-8 ">${views.operation_auto['有效交易量达到一定额度，赠送一定额度的彩金']}</div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['优惠条件']}：</label>
                <div class="col-sm-8 ">
                    <div class="dataTables_wrapper" role="grid">
                        <div class="tab-content table-responsive">
                            <table class="table table-striped border">
                                <tbody>
                                <tr>
                                    <td>${views.operation_auto['活动规则']}</td>
                                    <td colspan="3">${views.operation_auto['优惠形式']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['总有效交易量']}</td>
                                    <td>${views.operation_auto['按比例赠送彩金']}</td>
                                    <td>${views.operation_auto['固定赠送彩金CNY']}</td>
                                    <td>${views.operation_auto['优惠稽核']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['达到（）以上']}</td>
                                    <td>（）%</td>
                                    <td>&nbsp;</td>
                                    <td>${views.operation_auto['(可为空)倍']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['达到（）以上']}</td>
                                    <td>（）%</td>
                                    <td>&nbsp;</td>
                                    <td>${views.operation_auto['(可为空)倍<']}/td>
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
                    <p>1.${views.operation_auto['申明有效交易量等级以及派送彩金的层次、取款的稽核限制']}</p>
                    <p>2.${views.operation_auto['注明适用的API游戏项目']}</p>
                    <p>3.${views.operation_auto['活动细则以及优惠规则与条款']}</p>
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
                                    <td>${views.operation_auto['活动规则']}</td>
                                    <td colspan="3">${views.operation_auto['优惠形式']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['总有效交易量']}</td>
                                    <td>${views.operation_auto['按比例赠送彩金']}</td>
                                    <td>${views.operation_auto['固定赠送彩金CNY']}</td>
                                    <td>${views.operation_auto['优惠稽核']}</td>
                                </tr>
                                <tr>
                                    <td>${fn:replace(views.operation_auto['达到以上'],"[0]" ,50000 )}</td>
                                    <td>（）%</td>
                                    <td>80</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>${fn:replace(views.operation_auto['达到以上'],"[0]" ,100000 )}</td>
                                    <td>（）%</td>
                                    <td>180</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>${fn:replace(views.operation_auto['达到以上'],"[0]" ,500000 )}</td>
                                    <td>（）%</td>
                                    <td>1000</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>${fn:replace(views.operation_auto['达到以上'],"[0]" ,1000000 )}</td>
                                    <td>（）%</td>
                                    <td>2500</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>${fn:replace(views.operation_auto['达到以上'],"[0]" ,10000000 )}</td>
                                    <td>（）%</td>
                                    <td>8888</td>
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
                        <div>${views.operation_auto['凡是在甲公司进行电子游艺游戏']}</div>
                        <div class="tab-content table-responsive">
                            <table class="table table-striped border">
                                <tbody>
                                <tr>
                                    <td>${views.operation_auto['周有效投注']}</td>
                                    <td>${views.operation_auto['奖励彩金']}</td>
                                    <td>${views.operation_auto['稽核限制']}</td>
                                </tr>
                                <tr>
                                    <td>5${views.operation_auto['万']}+</td>
                                    <td>80</td>
                                    <td>1${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>10${views.operation_auto['万']}+</td>
                                    <td>180</td>
                                    <td>1${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>50${views.operation_auto['万']}+</td>
                                    <td>1000</td>
                                    <td>1${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>100${views.operation_auto['万']}+</td>
                                    <td>2500</td>
                                    <td>1${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>1000${views.operation_auto['万']}+</td>
                                    <td>8888</td>
                                    <td>1${views.operation_auto['倍']}</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动细则']}：</label>
                <div class="col-sm-8 ">
                    <p>1.${views.operation_auto['所获得奖金需一倍稽核方可申请提款。']}</p>
                    <p>2.${views.operation_auto['每位会员每周仅限申请一次，天数按照美东时间计算。']}</p>
                    <p>3.${views.operation_auto['该活动除开户彩金与体验金优惠外，可与其他优惠共同享有。']}</p>
                    <p>4.${views.operation_auto['符合申请条件的会员']}</p>
                    <p>5.${views.operation_auto['参与该优惠，即表示您同意《优惠规则与条款》。']}</p>
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

