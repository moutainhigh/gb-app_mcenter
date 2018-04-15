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
                <div class="col-sm-8">${views.operation_auto['首存送']}</div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动概述']}：</label>
                <div class="col-sm-8 ">${views.operation_auto['开户有奖，首次存款即送高达8888新人彩金']}</div>
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
                                    <td>${views.operation_auto['存款额度CNY']}</td>
                                    <td>${views.operation_auto['按比例赠送彩金']}</td>
                                    <td>${views.operation_auto['固定赠送CNY']}</td>
                                    <td>${views.operation_auto['优惠稽核']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['达到()以上']}</td>
                                    <td>()%</td>
                                    <td>&nbsp;</td>
                                    <td>${views.operation_auto['(可为空)倍']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['达到()以上']}</td>
                                    <td>()%</td>
                                    <td>&nbsp;</td>
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
                    <p>（${views.operation_auto['站长可根据自身需要将本活动做成图片或者文字的形式']}）</p>
                    <p>1.${views.operation_auto['介绍该活动的详情']}</p>
                    <p>2.${views.operation_auto['注明活动需要注意事项']}</p>
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
                                    <td>${views.operation_auto['活动规则']}</td>
                                    <td colspan="3">${views.operation_auto['优惠形式']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['存款额度CNY']}</td>
                                    <td>${views.operation_auto['按比例赠送彩金']}</td>
                                    <td>${views.operation_auto['固定赠送CNY']}</td>
                                    <td>${views.operation_auto['优惠稽核']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['存满（1000）以上']}</td>
                                    <td>（20）%</td>
                                    <td>&nbsp;</td>
                                    <td>(40)${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['存满（）以上']}</td>
                                    <td>（）%</td>
                                    <td>&nbsp;</td>
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
                        <div>${views.operation_auto['新会员成功注册后，首次存款之后可获得20%的开户礼金，详情如下：']}</div>
                        <div class="tab-content table-responsive">
                            <table class="table table-striped border">
                                <tbody>
                                <tr>
                                    <td>${views.operation_auto['活动规则']}</td>
                                    <td colspan="3">${views.operation_auto['优惠形式']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['存款额度']}</td>
                                    <td>${views.operation_auto['赠送比例']}</td>
                                    <td>${views.operation_auto['稽核要求']}</td>
                                    <td>${views.operation_auto['彩金上限']}</td>
                                </tr>
                                <tr>
                                    <td>1000+</td>
                                    <td>20%</td>
                                    <td>${views.operation_auto['（本金+彩金）*40倍']}</td>
                                    <td>5888</td>
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
                    <p>1.${views.operation_auto['会员需在存入活动要求的额度后未进行任何投注']}</p>
                    <p>2.${views.operation_auto['会员注册资料']}</p>
                    <p>3.${views.operation_auto['任何出现无风险投注']}</p>
                    <p>4.${views.operation_auto['参与该优惠，即表示您同意《优惠规则与条款》。']}</p>
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

