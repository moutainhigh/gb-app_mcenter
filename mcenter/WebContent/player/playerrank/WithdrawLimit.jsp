<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.PlayerRankVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${views.common['edit']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>

<body>
<form:form method="post">
<form:hidden path="result.id"/>
<div id="validateRule" style="display: none">${command.validateRule}</div>
    <%--是否启用普通提现审核--%>
<form:hidden path="result.withdrawCheckStatus"/>
    <%--是否启用超额提现审核--%>
<form:hidden path="result.withdrawExcessCheckStatus"/>

    <%--类型：固定 比例--%>
<form:hidden path="result.withdrawFeeType"/>

    <%--固定 比例 值--%>
<input type="hidden" name="result.withdrawFeeNum" id="result.withdrawFeeNum" value="${soulFn:formatInteger(command.result.withdrawFeeNum)}
                                   ${soulFn:formatDecimals(command.result.withdrawFeeNum)}"/>

    <%--是否启用取款--%>
<form:hidden path="result.isWithdrawLimit"/>

<form:hidden path="result.isWithdrawFeeZeroReset"/>
<a id="saveReturnCallbak" cssClass="btn btn-outline btn-filter" href="/vPlayerRankStatistics/list.html" nav-target="mainFrame"></a>
<div id="wrapper">
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a href="javascript:void(0)" class="navbar-minimalize"><i class="icon iconfont"></i> </a></h2>
            <span>${views.sysResource['角色']}</span>
            <span>/</span><span>${views.sysResource['层级设置']}</span>
            <soul:button target="goToLastPage" refresh="true"
                         cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text=""
                         opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <div class="rechargeCon">
                    <div class="line-hi34 col-sm-12 bg-gray m-b m-t">
                        <label class="ft-bold col-sm-3 al-right line-hi34"></label>
                        <span class="co-yellow m-r-sm m-l-sm"><i class="fa fa-exclamation-circle"></i></span>
                            ${views.role['withdrawlimit.pagePrompt']}
                    </div>
                </div>
                <div class="clearfix m-t m-b fzcs">
                    <b class="pull-left col-xs-3 al-right line-hi34">${views.role['withdrawlimit.copyParame']}</b>

                    <div class="col-xs-5">
                        <gb:select name="" cssClass="chosen-select-no-single" callback="copyParam"
                                   prompt="${views.common['pleaseSelect']}" list="${command.playerRankAllList}"
                                   listKey="id" listValue="rankName"/>
                    </div>


                </div>
                <div class="clearfix m-b limit_title_wrap">
                        <%--玩家单笔手续费设置--%>
                    <b class="limit_title cur">${views.role['withdrawlimit.singleCharge']}</b>
                </div>
                <!--                <hr class="m-t-sm m-b">-->
                <div class="form-group clearfix">
                    <label class="ft-bold col-sm-3 al-right line-hi34">${views.column['启用0000重置']}</label>

                    <div class="col-xs-5 line-hi34">
                        <input type="checkbox" id="isWithdrawFeeZeroReset" data-size="mini"
                               name="my-checkbox" ${command.result.isWithdrawFeeZeroReset?'checked':''}/>
                    </div>

                </div>
                <%--<div class="form-group clearfix" style="${command.result.isWithdrawFeeZeroReset?'display:none':''}">--%>
                <div class="form-group clearfix" style="${command.result.isWithdrawFeeZeroReset?'display:none':'display:block'}" id="withdrawTimeLimitDiv">
                        <%--时限/小时--%>
                    <label for="result.withdrawTimeLimit"
                           class="col-xs-3 al-right line-hi34">${views.column['PlayerRank.withdrawTimeLimit']}</label>

                    <div class="col-xs-5">
                        <div class="input-group" style="width: 100%;">
                            <form:input value="" id="withdrawTimeLimit" path="result.withdrawTimeLimit"
                                        cssClass="form-control m-b isNum" cssStyle="width: 100%"
                                        placeholder="${views.role['withdrawlimit.timelimit']}" disabled="${command.result.isWithdrawFeeZeroReset}"/>
                            <%--<span data-content=""
                                  data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                  role="button" class="input-group-addon help-popover" tabindex="0"
                                  data-original-title="" title="">&nbsp;&nbsp;</span>--%>
                            <!--                          <span class="input-group-addon bdn">&nbsp;&nbsp;<i class="fa fa-search"></i></span>-->
                        </div>
                    </div>
                </div>
                <div class="form-group clearfix">
                    <!--免手续费次数-->
                    <label class="col-xs-3 al-right line-hi34">${views.column['PlayerRank.withdrawFreeCount']}</label>

                    <div class="col-xs-5">
                        <div class="input-group date">
                            <form:input value="" id="withdrawFreeCount" path="result.withdrawFreeCount"
                                        cssClass="form-control m-b isNum"
                                        placeholder="${views.role['withdrawlimit.txFreeCount']}" />
                            <span data-content="${views.role['withdrawlimit.setting.tips.1']}"
                                  data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                  role="button" class="input-group-addon help-popover" tabindex="0"
                                  data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
                        </div>
                    </div>
                </div>
                <div class="form-group clearfix">
                    <!--手续费上限金额CNY-->
                    <label class="col-xs-3 al-right line-hi34">${views.role['paylimit.fee.max']}${command.currency}</label>

                    <div class="col-xs-5">
                        <div class="input-group date">

                            <input name="result.withdrawMaxFee" id="withdrawMaxFee" class="form-control m-b isNum"
                                   value="${command.result.withdrawMaxFee.intValue()}${soulFn:formatDecimals(command.result.withdrawMaxFee)}"/>
                            <span data-content="${views.role['withdrawlimit.setting.tips.2']}"
                                  data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                  role="button" class="input-group-addon help-popover" tabindex="0"
                                  data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
                        </div>

                    </div>
                </div>
                <div class="form-group clearfix">
                    <!--按比例收费-->
                    <label class="col-xs-3 al-right line-hi34">${views.role['withdrawlimit.proportion']}</label>

                    <div class="col-xs-5">
                        <div class="input-group date">
                                <span class="input-group-addon"><input type="radio" class="i-checks"
                                                                       name="withdrawFeeTypeRedio"
                                                                       value="1" checked></span>
                                <input name="returnPercentageAmount" id="Type1"
                                                        placeholder="${views.role['withdrawlimit.returnPercentageAmount']}"
                                                        type="text" class="form-control withdrawFeeType"
                                                         ${command.result.withdrawFeeType == ''||command.result.withdrawFeeType eq '2'||empty command.result.withdrawMaxFee?"disabled":""}>
                            <span data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                  role="button" class="input-group-addon help-popover" tabindex="0"
                                  data-original-title="" title="">%</span>
                        </div>
                            <%--<form:input path="result.withdrawFeeNum" cssClass="form-control m-b isNum" maxlength="10"/>--%>
                    </div>
                </div>
                <div class="form-group clearfix">
                    <!--固定收费-->
                    <label class="col-xs-3 al-right line-hi34">${views.role['withdrawlimit.fixed']}</label>

                    <div class="col-xs-5">
                        <div class="input-group date">
                                <span class="input-group-addon"><input type="radio" class="i-checks"
                                                                       name="withdrawFeeTypeRedio"
                                                                       value="2"></span>
                            <input name="returnFixedAmount" id="Type2" type="text" class="form-control withdrawFeeType"
                                     ${command.result.withdrawFeeType == '1'||command.result.withdrawFeeType == ''||empty command.result.withdrawMaxFee?"disabled":""} >
                            <span data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                  role="button" class="input-group-addon help-popover maxFee" tabindex="0"
                                  data-original-title="" title=""></span>

                        </div>
                    </div>
                </div>
                <div class="clearfix m-b limit_title_wrap">
                    <h3 class="limit_title cur">${views.role['withdrawlimit.txSetting']}</h3>
                </div>
                <div class="form-group clearfix">
                    <!--取款设置-->
                    <label class="ft-bold col-sm-3 al-right line-hi34">${views.column['PlayerRank.isWithdrawLimit']}</label>

                    <div class="col-xs-5 line-hi34">
                        <input type="checkbox" id="isWithdrawLimit" data-size="mini"
                               name="my-checkbox" ${command.result.isWithdrawLimit&&command.result.withdrawCount>0?'checked':''}/>
                    </div>
                </div>
                <div class="form-group clearfix">
                    <label class="ft-bold col-sm-3 al-right line-hi34">${views.column['PlayerRank.withdrawCount']}</label>

                    <div class="col-sm-5 line-hi34">
                        <input id="withdrawCount" class="form-control" name="result.withdrawCount"
                               value="${command.result.withdrawCount}" ${command.result.withdrawCount>0?'':'disabled'}/>
                    </div>
                </div>
                <div class="clearfix m-b limit_title_wrap">
                    <!--提现审核设置-->
                    <b class="limit_title cur">${views.role['withdrawlimit.txLimitSetting']}</b>
                </div>
                <div class="form-group clearfix">
                    <!--启用普通提现审核-->
                    <label class="col-xs-3 al-right line-hi34">${views.column['PlayerRank.withdrawCheckStatus']}</label>

                    <div class="col-xs-5 line-hi34">
                        <input type="checkbox" id="withdrawCheckStatus" data-size="mini"
                               name="my-checkbox" ${command.result.withdrawCheckStatus&&command.result.withdrawCheckTime>0?'checked':''}/>
                    </div>
                </div>
                <div class="form-group clearfix">
                    <!--处理时间/小时-->
                    <label class="col-xs-3 al-right line-hi34">${views.column['PlayerRank.withdrawCheckTime']}</label>

                    <div class="col-xs-5">
                        <div class="input-group date">
                            <input id="withdrawCheckTime" class="form-control" name="result.withdrawCheckTime"

                                   value="${command.result.withdrawCheckTime}" ${command.result.withdrawCheckTime>0?'':'disabled'}/>
                            <span data-content="${views.role['withdrawlimit.setting.tips.3']}"
                                  data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                  role="button" class="input-group-addon help-popover" tabindex="0"
                                  data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
                        </div>
                    </div>
                </div>
                <div class="form-group clearfix">
                    <!--启用超额提现审核-->
                    <label class="col-xs-3 al-right line-hi34">${views.column['PlayerRank.withdrawExcessCheckStatus']}</label>

                    <div class="col-xs-5 line-hi34">
                        <input id="withdrawExcessCheckStatus" type="checkbox" name="my-checkbox"
                               data-size="mini" ${command.result.withdrawExcessCheckStatus&&command.result.withdrawExcessCheckNum>0&&command.result.withdrawExcessCheckTime>0?'checked':''}>

                    </div>
                </div>
                <div class="form-group clearfix">
                    <!--超出金额CNY-->
                    <label class="col-xs-3 al-right line-hi34">${views.column['PlayerRank.withdrawExcessCheckNum']}${command.currency}</label>

                    <div class="col-xs-5">
                        <input id="withdrawExcessCheckNum" class="form-control" name="result.withdrawExcessCheckNum"

                               value="${command.result.withdrawExcessCheckNum}" ${command.result.withdrawExcessCheckNum>0?'':'disabled'}/>
                    </div>
                </div>
                <div class="form-group clearfix">
                    <!--处理时间/小时-->
                    <label class="col-xs-3 al-right line-hi34">${views.column['PlayerRank.withdrawExcessCheckTime']}</label>

                    <div class="col-xs-5">
                        <div class="input-group date">
                            <input id="withdrawExcessCheckTime" class="form-control"
                                   name="result.withdrawExcessCheckTime"
                                   value="${command.result.withdrawExcessCheckTime}" ${command.result.withdrawExcessCheckTime>0?'':'disabled'}/>
                            <span data-content="${views.role['withdrawlimit.setting.tips.4']}"
                                  data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                  role="button" class="input-group-addon help-popover" tabindex="0"
                                  data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
                        </div>
                    </div>
                </div>
                <div class="clearfix m-b limit_title_wrap">
                    <!--提现稽核设置-->
                    <b class="limit_title cur">${views.role['withdrawlimit.relaxSetting']}</b>
                </div>
                <div class="form-group clearfix">
                    <!--单笔上限金额CNY-->
                    <label class="col-xs-3 al-right line-hi34">${views.column['PlayerRank.withdrawMaxNum']}${command.currency}</label>

                    <div class="col-xs-5">
                        <form:input id="withdrawMaxNum" path="result.withdrawMaxNum" cssClass="form-control m-b isNum"
                                    />
                    </div>
                </div>
                <div class="form-group clearfix">
                    <!--单笔下限金额CNY-->
                    <label class="col-xs-3 al-right line-hi34">${views.column['PlayerRank.withdrawMinNum']}${command.currency}</label>

                    <div class="col-xs-5">
                        <form:input id="withdrawMinNum" path="result.withdrawMinNum" cssClass="form-control m-b isNum"
                                    />
                    </div>
                </div>
                <div class="form-group clearfix">
                    <!--常态稽核-->
                    <label class="col-xs-3 al-right line-hi34">${views.column['PlayerRank.withdrawNormalAudit']}</label>

                    <div class="col-xs-5">
                        <div class="input-group date">
                            <form:input id="withdrawNormalAudit" name="result.withdrawNormalAudit" path="result.withdrawNormalAudit"
                                        cssClass="form-control m-b isNum" />
                            <span class="input-group-addon">${views.role['withdrawlimit.bei']}</span>
                            <span data-content="${views.role['withdrawlimit.setting.tips.5']}"
                                  data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                  role="button" class="input-group-addon help-popover" tabindex="0"
                                  data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
                        </div>
                    </div>
                </div>
                <div class="form-group clearfix">
                    <!--行政费-->
                    <label class="col-xs-3 al-right line-hi34">${views.column['PlayerRank.withdrawAdminCost']}</label>

                    <div class="col-xs-5">
                        <div class="input-group date">
                            <form:input  id="withdrawAdminCost" name="result.withdrawAdminCost" path="result.withdrawAdminCost"
                                        cssClass="form-control m-b isNum" />
                            <span class="input-group-addon">%</span>
                            <span data-content="${views.role['withdrawlimit.setting.tips.6']}"
                                  data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                  role="button" class="input-group-addon help-popover" tabindex="0"
                                  data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
                        </div>
                    </div>
                </div>
                <div class="form-group clearfix">
                    <!--放宽额度CNY-->
                    <label class="col-xs-3 al-right line-hi34">${views.column['PlayerRank.withdrawRelaxCredit']}${command.currency}</label>

                    <div class="col-xs-5">
                        <div class="input-group date">
                            <form:input id="withdrawRelaxCredit" path="result.withdrawRelaxCredit"
                                        cssClass="form-control m-b isNum" />
                            <span data-content="${views.role['withdrawlimit.setting.tips.7']}"
                                  data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                  role="button" class="input-group-addon help-popover" tabindex="0"
                                  data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
                        </div>
                    </div>
                </div>
               <%-- <div class="form-group clearfix">
                    <!--优惠余额稽核-->
                    <label class="col-xs-3 al-right line-hi34">${views.column['PlayerRank.withdrawDiscountAudit']}</label>

                    <div class="col-xs-5">
                        <div class="input-group date">
                            <form:input id="withdrawDiscountAudit" path="result.withdrawDiscountAudit"
                                        cssClass="form-control m-b isNum proportion"  />
                            <span data-content="${views.role['withdrawlimit.setting.tips.8']}"
                                  data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                  role="button" class="input-group-addon help-popover" tabindex="0"
                                  data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
                        </div>
                    </div>
                </div>--%>
                <hr class="m-t-sm m-b">
                <!--
                                <div class="m-b">
                                    <b class="pull-left m-r-sm">${views.player_auto['使用于所有层级']}</b>
                                    <input type="checkbox" class="i-checks" checked />
                                </div>
                -->
                <div class="modal-footer">
                    <soul:button cssClass="btn btn-filter btn-lg" text="${views.common['commit']}" opType="ajax"
                                 target="${root}/playerRank/updateWithdrawLimit.html" precall="saveWithdrawLimit"
                                 post="getCurrentFormData" callback="saveReturnCallbak"/>
                    <soul:button target="goToLastPage" refresh="true" cssClass="btn btn-outline btn-filter btn-lg m-r"
                                 text="${views.common['cancel']}" opType="function">
                    </soul:button>
                </div>
            </div>
        </div>
    </div>
    </form:form>
</body>
<soul:import res="site/player/playerrank/WithdrawLimit"/>
</html>