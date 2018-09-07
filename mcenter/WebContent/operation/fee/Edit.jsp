<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<link href="${resComRoot}/themes/${curTheme}/dist/bootstrapSwitch.css">
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form id="editForm" action="" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <input type="hidden" name="result.feeType" id="feeType" value="${command.result.feeType}">
    <input type="hidden" name="result.returnType" id="returnType" value="${command.result.returnType}">
    <input type="hidden" name="result.id" value="${command.result.id}">
    <input type="hidden" name="result.createTime" value="${soulFn:formatDateTz(command.result.createTime, DateFormat.DAY_SECOND,timeZone)}">


    <div id="wrapper">
        <div class="row">
            <div class="position-wrap clearfix">
                <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
                <span>${views.sysResource['角色']}</span><span>/</span>
                <span>${views.sysResource['层级设置']}</span>
                <soul:button target="goToLastPage" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                    <em class="fa fa-caret-left"></em>${views.common['return']}
                </soul:button>
            </div>
            <div class="col-lg-12">
                <div class="wrapper white-bg">
                    <div class="">
                        <hr class="m-t-xs">

                        <div class="clearfix m-t m-b fzcs">
                            <b class="pull-left col-sm-3 al-left line-hi34">手续费方案名称${siteCurrency}</b>
                            <div class="col-sm-5">
                                <form:input path="result.schemaName" cssClass="form-control" maxlength="150"/>
                            </div>
                        </div>

                        <div class="clearfix m-b limit_title_wrap">
                            <h3 class="limit_title divSelect div1 ${command.result.isFee?'cur':''}" tt="fee" ff="return" dd="isReturnFee">
                                <i class="fa fa-check-square-o m-r-sm"></i>${views.role['paylimit.one.fee']}
                            </h3>
                        </div>
                        <div class="div_css" id="div_fee">
                            <div class="clearfix m-t m-b fzcs">
                                <b class="pull-left col-sm-3 al-right line-hi34">${views.role['paylimit.fee.money']}</b>
                                <div class="col-sm-5">
                                    <input type="checkbox" class="i-checks" id="box_fee" name="my-checkbox" type="maxFee" data-size="mini" tt="isFee" ${command.result.isFee?'checked':''} />
                                    <input id="isFee" name="result.isFee" type="hidden" value="${empty command.result.isFee?'false':command.result.isFee}">
                                </div>
                            </div>
                            <div id="first_div_fee">
                                <div class="clearfix m-t m-b fzcs">
                                    <b class="pull-left col-sm-3 al-right line-hi34">${views.role['paylimit.timecount']}</b>
                                    <div class="col-sm-5 input-group">
                                        <input type="text" class="form-control feeStatus" name="result.feeTime" placeholder="1-720" id="feeTime" maxlength="10" value="${command.result.feeTime}" >
                                        <span data-content="${views.role['paylimit.setting.tips.4']}"
                                              data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                              role="button" class="input-group-addon help-popover" tabindex="0"
                                              data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
                                    </div>
                                </div>
                                <div class="clearfix m-t m-b fzcs">
                                    <b class="pull-left col-sm-3 al-right line-hi34">${views.role['paylimit.fee.count']}</b>
                                    <div class="col-sm-5">
                                        <input type="text" class="form-control  feeStatus" name="result.freeCount" placeholder="1-1500" id="freeCount" maxlength="10" value="${command.result.freeCount}" >
                                    </div>
                                </div>
                                <div class="clearfix m-t m-b fzcs">
                                    <b class="pull-left col-sm-3 al-right line-hi34">${views.role['paylimit.fee.max']}${siteCurrency}</b>
                                    <div class="col-sm-5 input-group">
                                        <input value='<fmt:formatNumber value='${command.result.maxFee}' pattern="#.0"/>' class="form-control  feeStatus" name="result.maxFee"  tt="div1"  id="maxFee" maxlength="10"/>
                                        <span data-content="${views.role['paylimit.setting.tips.5']}"
                                              data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                              role="button" class="input-group-addon help-popover" tabindex="0"
                                              data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
                                    </div>
                                </div>
                                <div class="form-group clearfix">
                                    <label class="ft-bold col-sm-3 al-right line-hi34">${views.role['paylimit.rata.charges']}</label>
                                    <div class="col-sm-5">
                                        <div class="input-group date">
                                            <span class="input-group-addon"><input type="radio" class="i-checks maxFeeRadio  maxFee" name="radio_feeType" tt="feeType" ff="feeFixedAmount" ${command.result.isFee?'':'disabled="disabled"'} value="1" ${command.result.feeType=='1'?'checked':''}></span>
                                            <input type="text" class="form-control  feeStatus maxFee maxFee1" tt="div1" name="percentageAmount" id="feePercentageAmount" ${command.result.feeType=='1'?'':'disabled="disabled"'} value="${command.result.feeType=='1'?command.result.feeMoney:''}" >
                                            <span   data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="input-group-addon help-popover" tabindex="0" data-original-title="" title="">%</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group clearfix">
                                    <label class="ft-bold col-sm-3 al-right line-   hi34">${views.role['paylimit.fixed.charge']}</label>
                                    <div class="col-sm-5">
                                        <div class="input-group date">
                                            <span class="input-group-addon"><input type="radio" class="i-checks maxFeeRadio  maxFee" name="radio_feeType" tt="feeType" ff="feePercentageAmount" value="2"  ${command.result.isFee?'':'disabled="disabled"'} ${command.result.feeType=='2'?'checked':''}></span>

                                            <input type="text" class="form-control  feeStatus maxFee maxFee2" tt="div1" name="fixedAmount" id="feeFixedAmount" ${command.result.feeType=='2'?'':'disabled="disabled"'}  value="${command.result.feeMoney}" >
                                            <span class="input-group-addon help-popover" id="span_maxFee">&nbsp;≤${soulFn:formatCurrency(command.result.maxFee)}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="clearfix m-b limit_title_wrap">
                            <h3 class="limit_title divSelect div2 default ${command.result.isReturnFee?'cur':''} " tt="return" ff="fee" dd="isFee">
                                <i class="fa fa-check-square-o m-r-sm"  ></i>${views.role['paylimit.one.return.fee']}
                            </h3>
                        </div>

                        <div  class="div_css" id="div_return">
                            <div class="clearfix m-t m-b fzcs">
                                <b class="pull-left col-sm-3 al-right line-hi34">${views.role['paylimit.return.fee']}</b>
                                <div class="col-sm-5">
                                    <input type="checkbox" class="i-checks" name="my-checkbox" id="box_return" data-size="mini" tt="isReturnFee" ${command.result.isReturnFee==true?'checked':''} />
                                    <input id="isReturnFee" name="result.isReturnFee" type="hidden" value="${empty command.result.isReturnFee?'false':command.result.isReturnFee}">
                                </div>
                            </div>
                            <div  id="first_div_return">
                                <div class="clearfix m-t m-b fzcs">
                                    <b class="pull-left col-sm-3 al-right line-hi34">${views.role['paylimit.full.amount']}${siteCurrency}</b>
                                    <div class="col-sm-5 input-group">
                                        <form:input path="result.reachMoney" tt="div2" id="reachMoney" cssClass="form-control returnFeeStatus" maxlength="10"/>
                                        <span data-content="${views.role['paylimit.setting.tips.2']}"
                                              data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                              role="button" class="input-group-addon help-popover" tabindex="0"
                                              data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
                                    </div>
                                </div>
                                <div class="clearfix m-t m-b fzcs">
                                    <b class="pull-left col-sm-3 al-right line-hi34">${views.role['paylimit.return.max']}${siteCurrency}</b>
                                    <div class="col-sm-5 input-group">
                                        <set var="decimals" value="${soulFn:formatDecimals(command.result.maxReturnFee)}"/>
                                        <input value='${command.result.isReturnFee?command.result.maxReturnFee.intValue():''}${command.result.isReturnFee?decimals:''}' class="form-control  returnFeeStatus" name="result.maxReturnFee" tt="div2" id="maxReturnFee" maxlength="10"/>
                                        <span data-content="${views.role['paylimit.setting.tips.3']}"
                                              data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                              role="button" class="input-group-addon help-popover" tabindex="0"
                                              data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
                                    </div>
                                </div>
                                <div class="clearfix m-t m-b fzcs">
                                    <b class="pull-left col-sm-3 al-right line-hi34">${views.role['paylimit.timecount']}</b>
                                    <div class="col-sm-5 input-group">
                                        <form:input path="result.returnTime" id="returnTime" placeholder="1-720" cssClass="form-control  returnFeeStatus" maxlength="10"/>
                                        <span data-content="${views.role['paylimit.setting.tips.1']}"
                                              data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                              role="button" class="input-group-addon help-popover" tabindex="0"
                                              data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
                                    </div>
                                </div>
                                <div class="clearfix m-t m-b fzcs">
                                    <b class="pull-left col-sm-3 al-right line-hi34">${views.role['paylimit.return.count']}</b>
                                    <div class="col-sm-5">
                                        <form:input path="result.returnFeeCount" placeholder="1-1500" id="returnFeeCount" cssClass="form-control  returnFeeStatus" maxlength="10"/>
                                    </div>
                                </div>
                                <div class="form-group clearfix">
                                    <label class="ft-bold col-sm-3 al-right line-hi34">${views.role['paylimit.rata.return']}</label>
                                    <div class="col-sm-5">
                                        <div class="input-group date">
                                            <span class="input-group-addon"><input type="radio" class="i-checks returnType fee_txt returnTypeRadio" name="radio_returnType" tt="returnType" ff="returnFixedAmount" value="1"  ${command.result.isReturnFee?'':'disabled="disabled"'} ${command.result.returnType=='1'?'checked':''}></span>
                                            <c:set value="${soulFn:formatInteger(command.result.returnMoney)}${soulFn:formatDecimals(command.result.returnMoney)}" var="rr"></c:set>
                                            <input type="text" tt="div2" class="form-control  returnFeeStatus fee_txt fee1" name="returnPercentageAmount" ${command.result.returnType=='1'?'':'disabled="disabled"'} id="returnPercentageAmount" value="${command.result.isReturnFee&&command.result.returnType=='1'?rr:''}" >
                                            <span   data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="input-group-addon help-popover" tabindex="0" data-original-title="" title="">%</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group clearfix">
                                    <label class="ft-bold col-sm-3 al-right line-hi34">${views.role['paylimit.fixed.return']}</label>
                                    <div class="col-sm-5">
                                        <div class="input-group date">
                                            <span class="input-group-addon"><input  type="radio" class="i-checks returnType fee_txt returnTypeRadio" name="radio_returnType" tt="returnType" ff="returnPercentageAmount" value="2"  ${command.result.isReturnFee?'':'disabled="disabled"'} ${command.result.returnType=='2'?'checked':''}></span>
                                            <input type="text" tt="div2" class="form-control  returnFeeStatus fee_txt fee2" name="returnFixedAmount" ${command.result.returnType=='2'?'':'disabled="disabled"'}  id="returnFixedAmount" value="${command.result.returnType=='2'?command.result.returnMoney:''}" >
                                            <span class="input-group-addon help-popover" id="span_maxReturnFee">&nbsp;≤<fmt:formatNumber value='${command.result.maxReturnFee}' pattern='#.0'/></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group clearfix">
                                    <label class="ft-bold col-sm-3 al-right line-hi34">${views.player_auto['优惠稽核']}</label>
                                    <div class="col-sm-5 input-group">
                                        <input type="text" id="favorableAudit" name="result.favorableAudit" class="form-control m-b isNum  returnFeeStatus"
                                               value="${command.result.favorableAudit}">
                                        <span data-content="1、${views.player_auto['优惠稽核倍数为空，视为不对该笔优惠进行稽核；']}<br>2、${views.player_auto['玩家在取款时，有效投注额需要达到（存款金额+优惠金额）*优惠稽核倍数，否则将被扣除该笔优惠；']}<br>3、${views.player_auto['当没有通过存款申请获得优惠，而是直接获得优惠时，则直接按优惠金额*优惠稽核倍数来算即可；']}"
                                              data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" data-html="true"
                                              role="button" class="input-group-addon help-popover" tabindex="0"
                                              data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr class="m-t-sm m-b-sm">
                    <div style="text-align: right;padding-right: 20px">
                            <%--<soul:button target="goToLastPage" text="${views.player_auto['上一步']}" opType="function" cssClass="btn btn-outline btn-filter btn-lg"></soul:button>--%>
                        <soul:button cssClass="btn btn-filter btn-lg m-l-sm" text="${views.player_auto['完成存款设置']}" opType="ajax" dataType="json"
                                     target="${root}/rechargeFeeSchema/persist.html" precall="myValidateForm" post="getCurrentFormData" callback="saveCallbak" />
                                <a href="" id="tot" nav-target="mainFrame" style="display: none"></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form:form>
<soul:import res="site/operation/fee/Edit"/>
<%--<soul:import res="site/content/withdrawAccount/Edit"/>--%>

<!--//region your codes 4-->
<!--//endregion your codes 4-->