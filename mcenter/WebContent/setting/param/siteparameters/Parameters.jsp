<%-- @elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.NoticeTmplListVo" --%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form action="${root}/param/parameterSetting.html" method="post" id="parameterSetting">
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['系统设置']}</span><span>/</span><span>${views.sysResource['站点参数']}</span>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
                    <%@include file="../ParamTop.jsp" %>
                    <div id="content-div">
                        <div id="validateRule" style="display: none">${command.validateRule}</div>
                        <div class="clearfix">
                            <div class="col-lg-6 site-switch">
                                <h3>${views.setting['basic.otherSet']}</h3>
                                <div class="content line-hi34 clearfix">
                                    <div class="clearfix">
                                        <label class="ft-bold">${views.setting['basic.otherSet.trafficStatistics']}：<span
                                                data-content="${views.setting['trafficStatistics.prompt']}"
                                                data-placement="top"
                                                data-trigger="focus"
                                                data-toggle="popover" data-container="body" role="button"
                                                class="help-popover m-l-sm" tabindex="0"><i
                                                class="fa fa-question-circle"></i></span></label>
                                        <textarea class="form-control m-b"
                                                  name="result.trafficStatistics">${command.result.trafficStatistics}</textarea>
                                    </div>
                                    <div class="modal-footer">
                                        <soul:button cssClass="btn btn-filter" text="${views.common['save']}"
                                                     opType="ajax"
                                                     dataType="json" target="${root}/param/saveTrafficStatistics.html"
                                                     precall="staticValidateForm" post="getStaticValidateForm"
                                                     callback="saveCallbak"/>
                                    </div>
                                    <div class="clearfix" id="mobileTrafficStatistics">
                                        <label class="ft-bold">${views.setting['手机端流量统计代码']}：</label>
                                        <textarea class="form-control m-b"
                                                  name="result.paramValue">${mobile_traffic}</textarea>
                                    </div>
                                    <div class="modal-footer">
                                        <soul:button cssClass="btn btn-filter" text="${views.common['save']}"
                                                     opType="ajax"
                                                     dataType="json"
                                                     target="${root}/param/saveMobileTrafficStatistics.html"
                                                     precall="staticValidateForm" post="getMobileStaticValidateForm"
                                                     callback="saveCallbak"/>
                                    </div>
                                </div>
                            </div>

                            <div id="smsSetting" class="col-lg-6 site-switch">
                                <h3>${views.setting_auto['短信参数设置']}</h3>
                                <ul class="content clearfix" style="padding-top: 10px">
                                    <c:if test="${smsInterfaceSize>0}">
                                        <div class="clearfix m-b" style="border-bottom: 1px solid #dfdfdf;">
                                            <input name="smsSwitch.id" type="hidden" value="${smsSwitch.id}">
                                            <input id="smsSwitch" name="smsSwitch.active" type="hidden" value="${smsSwitch.active}">
                                            <div class="ft-bold pull-left line-hi34" style="width: 100px;text-align: right;">短信开关：</div>
                                            <div class="col-xs-8" style="line-height: 30px;">
                                                <input type="checkbox" class="_switch" name="sms-switch" data-size="mini" ${smsSwitch.active?"checked":""}>
                                                <c:choose>
                                                    <c:when test="${smsSwitch.active==true}">
                                                        <span class="smsTips0"><soul:button target="${root}/param/editSmsInterface.html" text="设置短信接口" opType="dialog"/></span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="smsTips0">您还未接入短信接口，请<a href='javascript:'>联系客服</a>进行设置</span>
                                                    </c:otherwise>
                                                </c:choose>
                                                <span class="smsTips1 hidden">您还未接入短信接口，请<a href='javascript:'>联系客服</a>进行设置</span>
                                                <span class="smsTips2 hidden"><soul:button target="${root}/param/editSmsInterface.html" text="设置短信接口" opType="dialog"/></span>
                                            </div>
                                        </div>

                                        <div class="clearfix m-b _smsSwitchIsShow ${smsSwitch.active?"":"hidden"}">
                                            <input name="phoneParam.id" type="hidden" value="${phoneParam.id}">
                                            <input id="phoneParam" name="phoneParam.active" type="hidden" value="${phoneParam.active}">
                                            <div class="ft-bold pull-left line-hi34" style="width: 100px;text-align: right;">
                                                手机验证：
                                            </div>
                                            <div class="col-xs-5">
                                                    <%--暂时隐藏，当开启手机验证时开启--%>
                                                <input type="checkbox" class="_switch" name="sms-checkbox" typeName="phoneParam" data-size="mini" ${phoneParam.active?"checked":""}>
                                                    <%--暂时隐藏，当开启手机验证时开启--%>
                                                <span id="isShowphoneParam" ${phoneParam.active?"":"hidden"}>
                                                    <label  class="m-r-sm"><input type="radio" class="i-checks" name="phoneParam.paramValue" value="before" ${phoneParam.paramValue=="before"?"checked":""}> ${views.setting['PlayerReg.before']}</label>
                                                    <span tabindex="0" class=" help-popover" role="button" data-container="body"
                                                          data-toggle="popover" data-trigger="focus" data-placement="top"
                                                          data-content="${views.setting['PlayerReg.help.phone.befor']}">
                                                        <i class="fa fa-question-circle"></i>
                                                    </span>
                                                    <label class="m-r-sm m-l-xs">
                                                        <input type="radio" class="i-checks" value="after" ${phoneParam.paramValue=="after"?"checked":""} name="phoneParam.paramValue">
                                                         ${views.setting['PlayerReg.after']}
                                                    </label>
                                                    <span tabindex="0" class=" help-popover" role="button" data-container="body"
                                                          data-toggle="popover" data-trigger="focus" data-placement="top"
                                                          data-content="${views.setting['PlayerReg.help.phone.last']}">
                                                        <i class="fa fa-question-circle"></i>
                                                    </span>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="clearfix m-b _smsSwitchIsShow ${smsSwitch.active?"":"hidden"}">
                                            <div class="ft-bold pull-left line-hi34" style="width: 100px;text-align: right;">
                                                找回密码：
                                            </div>
                                            <div class="col-xs-5">
                                                    <input name="recoverPasswordParam.id" type="hidden" value="${recoverPasswordParam.id}">
                                                    <input id="recoverPasswordParam" name="recoverPasswordParam.active" type="hidden" value="${recoverPasswordParam.active}">
                                                    <input type="checkbox" class="_switch recoverPasswordParam" data-size="mini" ${recoverPasswordParam.active?"checked":""}>
                                            </div>
                                        </div>
                                        <div class="clearfix m-b _smsSwitchIsShow ${smsSwitch.active?"":"hidden"}">
                                            <div class="ft-bold pull-left line-hi34" style="width: 100px;text-align: right;">
                                                短信模板：
                                            </div>
                                            <div class="col-xs-5">
                                                <input type="checkbox" class="_switch" name="" data-size="mini">
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <soul:button cssClass="btn btn-filter" text="${views.common['save']}"
                                                         opType="ajax"
                                                         dataType="json"
                                                         target="${root}/param/saveSmsInterfaceParam.html"
                                                         precall="validSmsInterfaceParam"
                                                         post="getSmsInterfaceParamDateForm" callback="saveCallbak"/>
                                        </div>
                                    </c:if>
                                </ul>
                            </div>

                            <%--<div id="smsInterface" class="col-lg-6 site-switch">
                                <h3>${views.setting_auto['短信接口设置']}</h3>
                                <ul class="content clearfix" style="padding-top: 10px">
                                    <div class="clearfix m-b">
                                        <div class="ft-bold pull-left line-hi34"
                                             style="width: 100px;text-align: right;">${views.setting_auto['接口名称']}：
                                        </div>
                                        <div class="col-xs-5">
                                            <gb:select name="sms.id" value="${smsInterfaceVo.result.id}"
                                                       list="${interfaceListVo}" listKey="id" listValue="fullName"/>
                                        </div>
                                    </div>
                                    <div class="clearfix m-b">
                                        <div class="ft-bold pull-left line-hi34"
                                             style="width: 100px;text-align: right;">
                                                ${views.setting_auto['接口用户名']}：
                                        </div>
                                        <div class="col-xs-5"><input type="text" name="sms.username"
                                                                     value="${smsInterfaceVo.result.username}"
                                                                     class="form-control"></div>
                                    </div>
                                    <div class="clearfix m-b">
                                        <div class="ft-bold pull-left line-hi34"
                                             style="width: 100px;text-align: right;">${views.setting_auto['接口密码']}：
                                        </div>
                                        <div class="col-xs-5"><input type="password" name="sms.password"
                                                                     value="${smsInterfaceVo.result.password}"
                                                                     class="form-control"></div>
                                    </div>
                                    <div class="clearfix m-b">
                                        <div class="ft-bold pull-left line-hi34"
                                             style="width: 100px;text-align: right;">${views.setting_auto['接口密钥']}：
                                        </div>
                                        <div class="col-xs-5">
                                            <textarea name="sms.dataKey"
                                                      class="form-control">${smsInterfaceVo.result.dataKey}</textarea>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <soul:button cssClass="btn btn-filter" text="${views.common['save']}"
                                                     opType="ajax"
                                                     dataType="json"
                                                     target="${root}/smsInterface/saveSmsInterface.html"
                                                     precall="validSmsInterface"
                                                     post="getSmsInterfaceDateForm" callback="saveCallbak"/>
                                    </div>
                                </ul>
                            </div>--%>
                        </div>
                        <div class="clearfix">
                            <div id="pcCustomService" class="col-lg-6 site-switch">
                                <h3>${views.setting['PC端客服参数']}</h3>
                                <input type="hidden" name="pc.id" value="${pcCustomerService.id}">
                                <div class="content clearfix" style="padding-top: 10px">
                                    <div class="clearfix m-b">
                                        <div class="ft-bold pull-left"
                                             style="width: 100px;text-align: right;">${views.setting_auto['名称']}：
                                        </div>
                                        <div class="col-xs-5"><input type="text" name="pc.name"
                                                                     value="${pcCustomerService.name}"
                                                                     class="form-control" maxlength="20"></div>
                                    </div>
                                    <div class="clearfix m-b">
                                        <div class="ft-bold pull-left line-hi34"
                                             style="width: 100px;text-align: right;">
                                                ${views.setting_auto['在线客服参数']}：
                                        </div>
                                        <div class="col-xs-5">
                                            <textarea name="pc.parameter"
                                                      class="form-control">${pcCustomerService.parameter}</textarea>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <soul:button cssClass="btn btn-filter" text="${views.common['save']}"
                                                     opType="ajax"
                                                     dataType="json"
                                                     target="${root}/siteCustomerService/pc.html"
                                                     precall="validPCCustomerService" post="getPCFormData"
                                                     callback="saveCallbak"/>
                                    </div>
                                </div>
                            </div>
                            <div id="mobileCustomService" class="col-lg-6 site-switch">
                                <h3>${views.setting_auto['手机端客服参数']}</h3>
                                <input type="hidden" name="mobile.id" value="${mobileCustomerService.id}">
                                <div class="content clearfix" style="padding-top: 10px">
                                    <div class="clearfix m-b">
                                        <div class="ft-bold pull-left line-hi34"
                                             style="width: 100px;text-align: right;">${views.setting_auto['名称']}：
                                        </div>
                                        <div class="col-xs-5"><input type="text" name="mobile.name"
                                                                     value="${mobileCustomerService.name}"
                                                                     class="form-control" maxlength="20"></div>
                                    </div>
                                    <div class="clearfix m-b">
                                        <div class="ft-bold pull-left line-hi34"
                                             style="width: 100px;text-align: right;">
                                                ${views.setting_auto['在线客服参数']}：
                                        </div>
                                        <div class="col-xs-5">
                                            <textarea name="mobile.parameter"
                                                      class="form-control">${mobileCustomerService.parameter}</textarea>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <soul:button cssClass="btn btn-filter" text="${views.common['save']}"
                                                     opType="ajax"
                                                     dataType="json"
                                                     target="${root}/siteCustomerService/mobile.html"
                                                     precall="validMobileCustomerService"
                                                     post="getMobileFormData" callback="saveCallbak"/>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <div class="clearfix">
                            <div  class="col-lg-6 site-switch">
                                <h3>${views.setting_auto['APP下载域名设置']}</h3>
                                <div id="appDownloadDomain" class="content clearfix">
                                    <div style="padding-top: 10px">
                                        <label class="ft-bold pull-left m-r"
                                               style='float:left;margin-top: 10px'> ${views.setting_auto['登录后显示二维码']}：</label>
                                        <input type="checkbox" name="active" objId="${qrSwitch.id}"
                                            ${qrSwitch.paramValue =="true" ?'checked':''} />
                                        <label>${views.setting_auto['开启后，玩家需要登录方可查看二维码！']}</label>
                                    </div>
                                    <br/>
                                    <div class="clearfix m-b">
                                        <div class="ft-bold pull-left line-hi34">
                                                ${views.setting_auto['APP默认下载域名']}
                                        </div>
                                        <div class="col-xs-5">
                                            <gb:select name="sysParam.paramValue" value="${select_domain.paramValue}"
                                                       list="${appDomain}" listKey="domain" listValue="domain"/>
                                        </div>
                                    </div>
                                    <label class="ft-bold col-sm-3 al-right line-hi34"
                                           style='margin-left: -52px;margin-top:-3px'>${views.setting_auto['按层级设置下载域名']}：</label><br/><br/>
                                    <div class="tab-content col-sm-15" id="open-period-div">
                                        <table class="border" id="app-domain-table">
                                            <tr>
                                                <td class="bg-gray ft-bold"
                                                    style="width:300px"> ${views.setting_auto['层级']}</td>
                                                <td class="bg-gray ft-bold"
                                                    style="width: 300px;"> ${views.setting_auto['下载域名']}</td>
                                                <td class="bg-gray ft-bold"
                                                    style="width: 100px"> ${views.setting_auto['操作']}</td>
                                            </tr>
                                            <c:if test="${not empty rankAppDomain.result}">
                                                <c:forEach var="period" items="${rankAppDomain.result}" varStatus="vs">
                                                    <tr>
                                                        <td>
                                                            <gb:select  name="playerRankAppDomains[${vs.index}].rankId"
                                                                        list="${playerRanks}" listValue="rankName" value="${period.rankId}" listKey="id"/>
                                                        </td>
                                                        <td>
                                                            <gb:select name="playerRankAppDomains[${vs.index}].domain"
                                                                       list="${appDomain}" listValue="domain" value="${period.domain}" listKey="domain"/>
                                                        </td>
                                                        <td>
                                                            <soul:button target="deleteAppDomain"  text="${views.common['delete']}" opType="function"  cssClass="btn btn-danger">${views.common['delete']}</soul:button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:if>
                                        </table>
                                        <table style="width: 791px">
                                            <tr>
                                                <td style="width: 100%;padding-right: 47px;padding-top: 10px;padding-bottom: 10px">
                                                    <soul:button target="copyAppDomain" text="" opType="function" cssClass="btn btn-info btn-addon pull-right">
                                                        <span class="hd">新增</span>
                                                    </soul:button>
                                                </td>
                                            </tr>
                                        </table>
                                    </div><br/>
                                    <div style="margin-right: 30px" class="modal-footer">
                                        <soul:button cssClass="btn btn-filter" text="${views.common['save']}"
                                                     opType="ajax"
                                                     dataType="json"
                                                     target="${root}/siteCustomerService/appDomain.html"
                                                     precall="validRankByDomain"
                                                     post="getAppDomainFormData" callback="saveCallbak"/>
                                    </div>
                                </div>
                                <table id="app-domain-template" style="display: none;">
                                    <tr>
                                        <td>
                                            <gb:select cssClass="rankName" name="playerRankAppDomains[{n}].rankId"
                                                       list="${playerRanks}" listValue="rankName"  listKey="id"/>
                                        </td>
                                        <td>
                                            <gb:select name="playerRankAppDomains[{n}].domain"
                                                       list="${appDomain}" listValue="domain" listKey="domain"/>
                                        </td>
                                        <td>
                                            <soul:button target="deleteAppDomain" text="${views.common['delete']}"  opType="function" cssClass="btn btn-danger"></soul:button>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id="accessDomain" class="col-lg-6 site-switch">
                                <h3>${views.setting_auto['访问域名设置']}</h3>
                                <div class="content clearfix" style="padding-top: 10px">
                                    <div class="clearfix m-b">
                                        <div class="ft-bold pull-left line-hi34"
                                             style="width: 100px;text-align: right;">
                                                ${views.setting_auto['访问域名']}
                                        </div>
                                        <div class="col-xs-5">
                                            <gb:select name="result.paramValue" value="${access_domain.paramValue}"
                                                       list="${appDomain}" listKey="domain" listValue="domain"/>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <soul:button cssClass="btn btn-filter" text="${views.common['save']}"
                                                     opType="ajax"
                                                     dataType="json"
                                                     target="${root}/siteCustomerService/accessDomain.html"
                                                     post="getAccessDomainFormData" callback="saveCallbak"/>
                                    </div>
                                </div>
                            </div>
                            <div id="accessDomains" class="col-lg-6 site-switch">
                                <h3>${views.setting_auto['电销参数设置']}</h3>
                                <div class="content clearfix" style="padding-top: 10px">
                                    <c:if test="${ empty phone_url}">
                                        <div class="clearfix m-b">
                                    <div style="padding-top: 10px">
                                            <label class="ft-bold pull-left m-r-xl"
                                                   style='float:left;margin-top: 10px'> ${views.setting_auto['电销开关']}： ${views.setting_auto['您还未接入电销接口，请联系客服进行设置']}</label>
                                            <label class="m-r-md "></label>
                                        <div class="clearfix m-b">
                                    </div>
                                    </c:if>
                                <c:if test="${not empty phone_url}">
                                    <div class="clearfix m-b">
                                        <div style="padding-top: 10px">
                                            <shiro:hasPermission name="system:electricpin_switch ">
                                            <label class="ft-bold pull-left m-r"
                                                   style='float:left;margin-top: 10px'> ${views.setting_auto['电销开关']}：</label>
                                                    <input id="phonePin" type="checkbox" name="electric_pin"
                                                        ${electric_pin.paramValue =="true" ?'checked':''} />
                                            <%--<label class="m-r-md ">${views.setting_auto['您还未接入电销接口，请联系客服进行设置']}</label>--%>
                                                <h3>${views.setting_auto['电销功能开关']}电销功能开关:</h3>
                                            </shiro:hasPermission>
                                        </div>

                                        <div class="${electric_pin.paramValue?"":"hidden"} _swElectric m-t-md "  >
                                            <shiro:hasPermission name="system:electricpin_switch ">
                                            <label class="ft-bold pull-left m-r" style='float:left;margin-top: 10px'>
                                                    ${views.setting_auto['是否加密']}：</label>
                                            <input type="checkbox" name="encryption_switch"
                                                ${encryption_switch.paramValue =="true" ?'checked':''} />
                                            <label class="m-r-md ">${views.setting_auto['启用后拨打的号码将加密']}</label>
                                            </shiro:hasPermission>
                                        </div>

                                        <div class="${electric_pin.paramValue?"":"hidden"} _swElectric m-r-xl" style="padding-top: 10px">
                                            <shiro:hasPermission name="system:electricpin_switch ">
                                                <label class="ft-bold pull-left m-r"
                                                       style='margin-top: 10px'> ${views.setting_auto['前端回call']}：</label>
                                                <input id="playerCall" type="checkbox" name="player_stationmaster"
                                                    ${player_stationmaster.paramValue =="true" ?'checked':''} />
                                                <label class="m-r-md ">${views.setting_auto['启用后需设置坐席号方可使用']}</label>
                                            </shiro:hasPermission>
                                        </div>
                                        <div id="phone" class="${electric_pin.paramValue?"":"hidden"} _swElectric m-r-xl" style="padding-top: 10px" >
                                                <shiro:hasPermission name="system:electricpin_switch ">
                                                    <label class="ft-bold pull-left m-r" style='float:left;margin-top: 10px'>
                                                            ${views.setting_auto['坐席号设置']}：</label>
                                                    <input type="text" id="callMunber"  placeholder="请填写回Call坐席号" name="result.paramValue" value="${poone_number.paramValue}">
                                                    <soul:button cssClass="btn btn-filter" text="${views.common['saveNumber']}"
                                                                 opType="ajax"
                                                                 dataType="json"
                                                                 target="${root}/param/savePhone.html"
                                                                 confirm="${views.common['confirm.modify']}"
                                                                 post="getPhoneNumber"
                                                                 callback="saveCallbak"/>
                                                </shiro:hasPermission>
                                        </div>
                                </div>
                              </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form:form>

<soul:import res="site/setting/param/siteParam/Paranenters"/>

