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
                            <div id="saveContact" class="col-lg-6 site-switch">
                                <input type="hidden" name="sysParam[0].id" value="${phone.id}">
                                <input type="hidden" name="sysParam[1].id" value="${email.id}">
                                <input type="hidden" name="sysParam[2].id" value="${qq.id}">
                                <input type="hidden" name="sysParam[3].id" value="${skyep.id}">
                                <input type="hidden" name="sysParam[4].id" value="${copyright.id}">
                                <h3>${views.setting_auto['站点联系方式设置']}</h3>
                                <div class="content clearfix" style="padding-top: 10px">
                                    <div class="clearfix m-b">
                                        <div class="ft-bold pull-left line-hi34"
                                             style="width: 100px;text-align: right;">
                                                ${views.setting_auto['联系电话']}：
                                        </div>
                                        <div class="col-xs-5">
                                            <input id="phoneId" type="text" name="sysParam[0].paramValue"
                                                   value="${phone.paramValue}" placeholder="请输入7-20位纯数字" class="form-control">
                                        </div>
                                    </div>
                                    <div class="clearfix m-b">
                                        <div class="ft-bold pull-left line-hi34"
                                             style="width: 100px;text-align: right;">
                                                ${views.setting_auto['联系邮箱']}：
                                        </div>
                                        <div class="col-xs-5">
                                            <input id="emailId" type="text" name="sysParam[1].paramValue"
                                                   value="${email.paramValue}"
                                                   placeholder="输入的长度请小于30个字符" class="form-control"></div>
                                    </div>
                                    <div class="clearfix m-b">
                                        <div class="ft-bold pull-left line-hi34"
                                             style="width: 100px;text-align: right;">
                                                ${views.setting_auto['联系QQ']}：
                                        </div>
                                        <div class="col-xs-5">
                                            <input id="qqId" type="text" name="sysParam[2].paramValue"
                                                   value="${qq.paramValue}"
                                                   placeholder="请输入5-20位纯数字" class="form-control">
                                        </div>
                                    </div>
                                    <div class="clearfix m-b">
                                        <div class="ft-bold pull-left line-hi34"
                                             style="width: 100px;text-align: right;">
                                                ${views.setting_auto['联系Skype']}：
                                        </div>
                                        <div class="col-xs-5">
                                            <input  id="skyepId" type="text" name="sysParam[3].paramValue" value="${skyep.paramValue}"
                                                    placeholder="输入的长度请小于30个字符" class="form-control" >
                                        </div>
                                    </div>
                                    <div class="clearfix m-b">
                                        <div class="ft-bold pull-left line-hi34"
                                             style="width: 100px;text-align: right;">
                                                ${views.setting_auto['版权信息']}：
                                        </div>
                                        <div class="col-xs-5">
                                            <textarea id="copyrightId" name="sysParam[4].paramValue" class="form-control"
                                                      placeholder="输入的长度请小于200个字符" >${copyright.paramValue}</textarea>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <soul:button cssClass="btn btn-filter" text="${views.common['save']}"
                                                     opType="ajax"
                                                     dataType="json" target="${root}/param/saveContactInformation.html"
                                                     precall="validationSettings" post="getSaveContactValidateForm"
                                                     callback="saveCallbak"/>
                                    </div>
                                </div>
                            </div>
                            <div id="smsInterface" class="col-lg-6 site-switch">
                                <h3>${views.setting_auto['个人信息显示设置']}</h3>
                                <ul class="content clearfix" style="padding-top: 10px">
                                    <div class="clearfix m-b"  >
                                        <div class="ft-bold pull-left line-hi34">
                                                ${views.setting_auto['真实姓名']}：
                                        </div>
                                        <div class="col-xs-2">
                                            <input type="checkbox" data-size="mini" name="showRealName"
                                                ${playerItemMessage.showRealName=='1'?'checked':''} value="${playerItemMessage.showRealName}"
                                                   <%--value="${personal_information.paramValue}"--%>
                                                   class="form-control _player_item_message">
                                        </div>
                                    </div>
                                    <div class="clearfix m-b">
                                        <div class="ft-bold pull-left line-hi34">
                                                ${views.setting_auto['主语言']}：
                                        </div>
                                        <div class="col-xs-2">
                                            <input type="checkbox"data-size="mini" name="showMainLanguage"
                                                ${playerItemMessage.showMainLanguage=='1'?'checked':''}
                                                   value="${playerItemMessage.showMainLanguage}"
                                                   class="form-control _player_item_message">
                                        </div>
                                    </div>
                                    <div class="clearfix m-b">
                                        <div class="ft-bold pull-left line-hi34">${views.setting_auto['性别']}：
                                        </div>
                                        <div class="col-xs-2">
                                            <input type="checkbox" data-size="mini" name="showSex"
                                                ${playerItemMessage.showSex=='1'?'checked':''}
                                                   value="${playerItemMessage.showSex}"
                                                   class="form-control _player_item_message">
                                        </div>
                                    </div>
                                    <div class="clearfix m-b">
                                        <div class="ft-bold pull-left line-hi34"
                                        >${views.setting_auto['生日']}：
                                        </div>
                                        <div class="col-xs-2">
                                            <input type="checkbox" data-size="mini" name="showBirthday"
                                                ${playerItemMessage.showBirthday=='1'?'checked':''}
                                                   value="${playerItemMessage.showBirthday}"
                                                   class="form-control _player_item_message">
                                        </div>
                                    </div>

                                    <div class="clearfix m-b">
                                        <div class="ft-bold pull-left line-hi34"
                                             >${views.setting_auto['手机']}：
                                        </div>
                                        <div class="col-xs-2">
                                            <input type="checkbox" data-size="mini" name="showMobilePhone"
                                                ${playerItemMessage.showMobilePhone=='1'?'checked':''}
                                                   value="${playerItemMessage.showMobilePhone}"
                                                   class="form-control _player_item_message">
                                        </div>
                                    </div>
                                    <div class="clearfix m-b">
                                        <div class="ft-bold pull-left line-hi34"
                                             >${views.setting_auto['邮箱']}：
                                        </div>
                                        <div class="col-xs-2">
                                            <input type="checkbox" data-size="mini" name="showMail"
                                                ${playerItemMessage.showMail=='1'?'checked':''}
                                                   value="${playerItemMessage.showMail}"
                                                   class="form-control _player_item_message">
                                        </div>
                                    </div>
                                    <div class="clearfix m-b">
                                        <div class="ft-bold pull-left line-hi34"
                                             >${views.setting_auto['微信']}：
                                        </div>
                                        <div class="col-xs-2">
                                            <input type="checkbox" data-size="mini" name="showWechat"
                                                ${playerItemMessage.showWechat=='1'?'checked':''}
                                                   value="${playerItemMessage.showWechat}"
                                                   class="form-control _player_item_message">
                                        </div>
                                    </div>
                                    <div class="clearfix m-b" style="margin-right: 300px">
                                                <div class=" pull-left line-hi34"
                                                     >${views.setting_auto['QQ']}：
                                                </div>
                                                <div class="col-xs-2">
                                                    <input type="checkbox" data-size="mini"  name="showQq"
                                                        ${playerItemMessage.showQq=='1'?'checked':''}
                                                           value="${playerItemMessage.showQq}"
                                                           class="form-control _player_item_message">
                                                </div>
                                    </div>
                                    <div class="modal-footer">
                                        <soul:button cssClass="btn btn-filter" text="${views.common['save']}"
                                                     opType="ajax"
                                                     dataType="json"
                                                     target="${root}/param/savePlayerItem.html"
                                                     post="getPlayerItemForm" confirm="${views.common['confirm.modify']}" callback="saveCallbak"/>
                                    </div>
                                </ul>
                            </div>

                        </div>
                        <div class="clearfix">
                            <div class="col-lg-6 site-switch" id="validCodeDiv">
                                <h3>${views.setting_auto['验证码']}</h3>
                                <div class="content line-hi34 clearfix">
                                    <%@ include file="../verification/validCode.jsp" %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form:form>
<soul:import res="site/setting/param/siteParam/FrontEnd"/>