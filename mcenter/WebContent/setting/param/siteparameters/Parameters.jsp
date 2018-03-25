<%-- @elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.NoticeTmplListVo" --%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form action="${root}/param/siteParam.html" method="post" id="siteParam">
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

                            <div id="smsInterface" class="col-lg-6 site-switch">
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
                                        <%--<div class="clearfix m-b">
                                            <div class="ft-bold pull-left line-hi34"
                                                 style="width: 100px;text-align: right;">
                                                    ${views.setting_auto['请求接口地址']}：
                                            </div>
                                            <div class="col-xs-5"><input type="text" name="sms.requestUrl"
                                                                         value="${smsInterfaceVo.result.requestUrl}"
                                                                         class="form-control"></div>
                                        </div>--%>
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
                                            <%--<soul:button cssClass="btn btn-filter" text="查询余额"
                                                         opType="ajax"
                                                         dataType="json"
                                                         target="${root}/smsInterface/searchBalance.html"
                                                        />--%>
                                    </div>

                                </ul>
                            </div>
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
                                    <div class="clearfix m-b">
                                        <div style="padding-top: 10px">
                                            <label class="ft-bold pull-left m-r"
                                                   style='float:left;margin-top: 10px'> ${views.setting_auto['电销开关']}：</label>
                                            <input type="checkbox" name="electric_pin" objId="${qrSwitch.id}"
                                                ${electric_pin.paramValue =="true" ?'checked':''} />
                                            <label>${views.setting_auto['您还未接入电销接口，请联系客服进行设置']}</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form:form>

<soul:import res="site/setting/param/siteParam/Paranenters"/>

