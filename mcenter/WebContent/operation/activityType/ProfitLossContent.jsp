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
                <div class="col-sm-8">${views.operation_auto['盈亏送']}</div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动概述']}：</label>
                <div class="col-sm-8 ">${views.operation_auto['根据活动时间内的盈亏额度，派送一定额度的优惠彩金']}</div>
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
                                    <td colspan="2">${views.operation_auto['优惠形式']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['盈利']}</td>
                                    <td>${views.operation_auto['赠送彩金CNY']}</td>
                                    <td>${views.operation_auto['优惠稽核']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['达到()以上']}</td>
                                    <td>&nbsp;</td>
                                    <td>${views.operation_auto['(可为空)倍']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['达到()以上']}</td>
                                    <td>&nbsp;</td>
                                    <td>${views.operation_auto['(可为空)倍']}</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="tab-content table-responsive">
                            <table class="table table-striped border">
                                <tbody>
                                <tr>
                                    <td>${views.operation_auto['活动规则']}</td>
                                    <td colspan="2">${views.operation_auto['优惠形式']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['亏损']}</td>
                                    <td>${views.operation_auto['赠送彩金CNY']}</td>
                                    <td>${views.operation_auto['优惠稽核']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['达到()以上']}</td>
                                    <td>&nbsp;</td>
                                    <td>${views.operation_auto['(可为空)倍']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['达到()以上']}</td>
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
                    <p>1.${views.operation_auto['注明盈亏达到一定额度，亏损或盈利送的彩金额度']}</p>
                    <p>2.${views.operation_auto['注明派送彩金的依据、数据计算时间']}</p>
                    <p>3.${views.operation_auto['申明优惠细则、规则与条款']}</p>
                </div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['填写活动条件']}：</label>
                <div class="col-sm-8 ">
                    <div class="dataTables_wrapper" role="grid">
                        <div class="tab-content table-responsive">
                            <table class="table table-striped border">
                                <tbody>
                                <tr>
                                    <td>${views.operation_auto['活动规则']}</td>
                                    <td colspan="2">${views.operation_auto['优惠形式']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['盈利']}</td>
                                    <td>${views.operation_auto['赠送彩金CNY']}</td>
                                    <td>${views.operation_auto['优惠稽核']}</td>
                                </tr>
                                <tr>
                                    <td>${fn:replace(views.operationauto['达到以上'],"[0]",3000)}</td>
                                    <td>58</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>${fn:replace(views.operationauto['达到以上'],"[0]",6000)}</td>
                                    <td>88</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>${fn:replace(views.operation_auto['达到以上'],"[0]",10000)}</td>
                                    <td>158</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>${fn:replace(views.operation_auto['达到以上'],"[0]",20000)}</td>
                                    <td>388</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>${fn:replace(views.operation_auto['达到以上'],"[0]",40000)}</td>
                                    <td>588</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>${fn:replace(views.operation_auto['达到以上'],"[0]",70000)}</td>
                                    <td>888</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>${fn:replace(views.operation_auto['达到以上'],"[0]",100000)}</td>
                                    <td>1588</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>${fn:replace(views.operation_auto['达到以上'],"[0]",300000)}</td>
                                    <td>3088</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>${fn:replace(views.operation_auto['达到以上'],"[0]",500000)}</td>
                                    <td>5088</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>${fn:replace(views.operation_auto['达到以上'],"[0]",1000000)}</td>
                                    <td>18888</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>${fn:replace(views.operation_auto['达到以上'],"[0]",3000000)}</td>
                                    <td>58888</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="tab-content table-responsive">
                            <table class="table table-striped border">
                                <tbody>
                                <tr>
                                    <td>${views.operation_auto['活动规则']}</td>
                                    <td colspan="2">${views.operation_auto['优惠形式']}</td>
                                </tr>
                                <tr>
                                    <td>${views.operation_auto['亏损']}</td>
                                    <td>${views.operation_auto['赠送彩金CNY']}</td>
                                    <td>${views.operation_auto['优惠稽核']}</td>
                                </tr>
                                <tr>
                                    <td>${fn:replace(views.operation_auto['达到以上'],"[0]",3000)}</td>
                                    <td>58</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>${fn:replace(views.operation_auto['达到以上'],"[0]",6000)}</td>
                                    <td>88</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>${fn:replace(views.operation_auto['达到以上'],"[0]",10000)}</td>
                                    <td>158</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>${fn:replace(views.operation_auto['达到以上'],"[0]",20000)}</td>
                                    <td>388</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>${fn:replace(views.operation_auto['达到以上'],"[0]",40000)}</td>
                                    <td>588</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>${fn:replace(views.operation_auto['达到以上'],"[0]",70000)}</td>
                                    <td>888</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>${fn:replace(views.operation_auto['达到以上'],"[0]",100000)}</td>
                                    <td>1588</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>${fn:replace(views.operation_auto['达到以上'],"[0]",300000)}</td>
                                    <td>3088</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>${fn:replace(views.operation_auto['达到以上'],"[0]",500000)}</td>
                                    <td>5088</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>${fn:replace(views.operation_auto['达到以上'],"[0]",1000000)}</td>
                                    <td>18888</td>
                                    <td>(1)${views.operation_auto['倍']}</td>
                                </tr>
                                <tr>
                                    <td>${fn:replace(views.operation_auto['达到以上'],"[0]",3000000)}</td>
                                    <td>58888</td>
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
                        <div>${views.operation_auto['甲公司感谢新老会员的关注与支持，为了您的满意，我们一直努力着。从现在开始不管您输赢多少，我们都将贴心的回馈您，愿财运时刻伴随每一个会员。']}</div>
                        <div class="tab-content table-responsive">
                            <table class="table table-striped border">
                                <tbody>
                                <tr>
                                    <td>${views.operation_auto['当期亏损或盈利金额']}</td>
                                    <td>${views.operation_auto['亏损可获奖金']}</td>
                                    <td>${views.operation_auto['盈利可获彩金']}</td>
                                    <td>${views.operation_auto['需达有效投注']}</td>
                                    <td>${views.operation_auto['稽核要求']}</td>
                                </tr>
                                <tr>
                                    <td>3000-5999</td>
                                    <td>88${views.operation_auto['元']}</td>
                                    <td>58${views.operation_auto['元']}</td>
                                    <td>≥10000</td>
                                    <td rowspan="11">${views.operation_auto['1倍稽核']}</td>
                                </tr>
                                <tr>
                                    <td>6000-9999</td>
                                    <td>138${views.operation_auto['元']}</td>
                                    <td>88${views.operation_auto['元']}</td>
                                    <td>≥30000</td>
                                </tr>
                                <tr>
                                    <td>10000-19999</td>
                                    <td>238${views.operation_auto['元']}</td>
                                    <td>158${views.operation_auto['元']}</td>
                                    <td>≥50000</td>
                                </tr>
                                <tr>
                                    <td>20000-39999</td>
                                    <td>588${views.operation_auto['元']}</td>
                                    <td>388${views.operation_auto['元']}</td>
                                    <td>≥100000</td>
                                </tr>
                                <tr>
                                    <td>40000-69999</td>
                                    <td>888${views.operation_auto['元']}</td>
                                    <td>588${views.operation_auto['元']}</td>
                                    <td>≥200000</td>
                                </tr>
                                <tr>
                                    <td>70000-99999</td>
                                    <td>1288${views.operation_auto['元']}</td>
                                    <td>888${views.operation_auto['元']}</td>
                                    <td>≥350000</td>
                                </tr>
                                <tr>
                                    <td>100000-299999</td>
                                    <td>2888${views.operation_auto['元']}</td>
                                    <td>1588${views.operation_auto['元']}</td>
                                    <td>≥500000</td>
                                </tr>
                                <tr>
                                    <td>300000-499999</td>
                                    <td>5888${views.operation_auto['元']}</td>
                                    <td>3088${views.operation_auto['元']}</td>
                                    <td>≥1500000</td>
                                </tr>
                                <tr>
                                    <td>500000-999999</td>
                                    <td>8888${views.operation_auto['元']}</td>
                                    <td>5088${views.operation_auto['元']}</td>
                                    <td>≥2500000</td>
                                </tr>
                                <tr>
                                    <td>1000000-2999999</td>
                                    <td>38888${views.operation_auto['元']}</td>
                                    <td>18888${views.operation_auto['元']}</td>
                                    <td>≥5000000</td>
                                </tr>
                                <tr>
                                    <td>3000000-5000000</td>
                                    <td>88888${views.operation_auto['元']}</td>
                                    <td>58888${views.operation_auto['元']}</td>
                                    <td>≥15000000</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <p>${views.operation_auto['计算当月亏损或盈利时间']}</p>
                        <p>${views.operation_auto['会员当月亏损或盈利应扣除优惠与返点的实际输赢金额为标准']}</p>
                        <p>${views.operation_auto['注如果亏损或盈利金额达到申请要求']}</p>
                    </div>
                </div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动细则']}：</label>
                <div class="col-sm-8 ">
                    <p>1.${views.operation_auto['所获彩金需完成一倍稽核即可提款']}；</p>
                    <p>2.${views.operation_auto['任何出现对打情况的投注']}；</p>
                    <p>3.${views.operation_auto['参与该优惠']}。</p>
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

