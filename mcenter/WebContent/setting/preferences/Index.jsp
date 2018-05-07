<!DOCTYPE HTML>
<%-- @elvariable id="command" type="org.soul.model.sys.vo.SysParamListVo" --%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form action="${root}/setting/preference/index.html" method="post" id="siteParam">
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['系统设置']}</span><span>/</span><span>${views.sysResource['站点参数']}</span>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
                    <%@include file="../param/ParamTop.jsp" %>
                    <div id="content-div">
                        <div class="clearfix filter-wraper border-b-1">
                            <soul:button target="resetPreference" text="${views.setting['page.preference.default']}"
                                         opType="function" confirm="${views.setting['page.preference.confirm']}"
                                         callback="reload"
                                         cssClass="btn btn-filter">${views.setting['page.preference.default']}</soul:button>
                        </div>
                        <div class="clearfix line-hi34 bg-gray p-sm">
                            <label class="ft-bold pull-left m-r">${views.setting['preference.privilage']}：</label>
                            <div class="col-xs-10 p-x">
                                <div class="input-group date pull-left m-r">
                                    <select class="btn-group chosen-select-no-single" name="sysParam.paramValue">
                                        <option value="">${views.common['pleaseSelect']}</option>
                                        <c:forEach items="${privilagePassMap}" var="item">
                                            <option value="${item.key}" ${item.key eq privilagePassTime.paramValue?'selected="selected"':''}>${dicts[item.value.module][item.value.dictType][item.value.dictCode]}</option>
                                        </c:forEach>
                                    </select>
                                        <%--<span class="input-group-addon"><i class="fa fa-question-circle"></i></span>--%>
                                    <input type="hidden" name="sysParam.id" value="${privilagePassTime.id}">
                                </div>
                                    ${views.setting['preference.securityPwdSettingTips']}
                                <soul:button text="${views.common['save']}" dataType="json" opType="ajax" refresh="true"
                                             target="${root}/setting/preference/savePreference.html"
                                             post="getCurrentFormData"
                                             cssClass="btn btn-filter m-r"></soul:button>
                            </div>
                        </div>
                        <div class="clearfix line-hi34 bg-gray p-sm">
                            <label class="ft-bold pull-left m-r">${views.setting['preference.popupPrompt']}</label>
                            <div class="col-xs-10 p-x">
                                <div class="input-group date pull-left m-r" id="pcenter-msg-tips">
                                    <input type="checkbox" name="my-checkbox" objId="${popUp.id}"
                                        ${popUp.paramValue =="true" ?'checked':''} />
                                </div>
                                    ${views.setting['preference.openplayercenterwindow']}
                            </div>
                        </div>
                        <div class="clearfix">
                            <div class="col-lg-12 site-switch">
                                <h3>${views.setting['page.preference.remindmusic']}</h3>
                                <ul class="content clearfix">
                                    <div class="table-responsive">
                                        <table class="table table-striped table-hover dataTable m-b-sm m-t">
                                            <thead>
                                            <tr class="bg-gray">
                                                <th>${views.setting['page.preference.remindmusicproject']}</th>
                                                <th>${views.setting['page.preference.currentuse']}</th>
                                                <th>${views.setting['page.preference.enabletone']}</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${warmToneMap}" var="item">
                                                <tr>
                                                    <td>${dicts[item.value.module][item.value.dictType][item.value.dictCode]}</td>
                                                    <c:choose>
                                                        <c:when test="${item.value['dictCode'] eq toneDeposit.paramCode}">
                                                            <c:set var="tonePath" value="${!(empty toneDeposit.paramValue)?toneDeposit.paramValue:toneDeposit.defaultValue}"/>
                                                            <c:set var="tonePathDefined" value="${toneDepositDefined.paramValue}"/>
                                                            <td>
                                                                <div class="pull-left">
                                                                    <c:choose>
                                                                        <c:when test="${tonePath eq tonePathDefined}">
                                                                            <audio src="${imgRoot}/${tonePath}" preload="auto"></audio>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <audio src="${resRoot}/${tonePath}" preload="auto"></audio>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                                <soul:button
                                                                        target="${root}/setting/preference/editTone.html?paramCode=${toneDeposit.paramCode}"
                                                                        cssClass="m-l-sm line-hi30"
                                                                        text="${fn:replace(views.setting_auto['修改提示音'],'[0]',dicts[item.value.module][item.value.dictType][item.value.dictCode])}"
                                                                        tag="a" opType="dialog"
                                                                        callback="reload">${views.setting['page.preference.replace']}</soul:button>
                                                                <soul:button
                                                                        target="${root}/setting/preference/uploadUserDefinedTone.html?result.paramCode=deposit_defined"
                                                                        cssClass="m-l-sm line-hi30"
                                                                        text=""
                                                                        tag="a" opType="dialog"
                                                                        callback="reload">${views.setting_auto['上传']}</soul:button>
                                                            </td>
                                                            <td><input type="checkbox" name="active"
                                                                       objId="${toneDeposit.id}" hidId="toneDeposit"
                                                                       value="${toneDeposit.active?'true':'false'}"
                                                                       data-size="mini" ${toneDeposit.active?'checked':''}>
                                                            </td>
                                                            <input type="hidden" name="toneSysParamList[0].id"
                                                                   value="${toneDeposit.id}">
                                                            <input type="hidden" name="toneSysParamList[0].active"
                                                                   id="toneDeposit"
                                                                   value="${toneDeposit.active?'true':'false'}">
                                                        </c:when>
                                                        <c:when test="${item.value['dictCode'] eq tonePay.paramCode}">
                                                            <c:set var="tonePath" value="${!(empty tonePay.paramValue)?tonePay.paramValue:tonePay.defaultValue}"/>
                                                            <c:set var="tonePathDefined" value="${tonePayDefined.paramValue}"/>
                                                            <td>
                                                                <div class="pull-left">
                                                                    <c:choose>
                                                                        <c:when test="${tonePath eq tonePathDefined}">
                                                                            <audio src="${imgRoot}/${tonePath}" preload="auto"></audio>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <audio src="${resRoot}/${tonePath}" preload="auto"></audio>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                                <soul:button
                                                                        target="${root}/setting/preference/editTone.html?paramCode=${tonePay.paramCode}"
                                                                        cssClass="m-l-sm line-hi30"
                                                                        text="${fn:replace(views.setting_auto['修改提示音'],'[0]',dicts[item.value.module][item.value.dictType][item.value.dictCode])}"
                                                                        tag="a" opType="dialog"
                                                                        callback="reload">${views.setting['page.preference.replace']}</soul:button>
                                                                <soul:button
                                                                        target="${root}/setting/preference/uploadUserDefinedTone.html?result.paramCode=onlinePay_defined"
                                                                        cssClass="m-l-sm line-hi30"
                                                                        text=""
                                                                        tag="a" opType="dialog"
                                                                        callback="reload">${views.setting_auto['上传']}</soul:button>
                                                            </td>
                                                            <td><input type="checkbox" name="active"
                                                                       objId="${tonePay.id}" hidId="tonePay"
                                                                       value="${tonePay.active?'true':'false'}"
                                                                       data-size="mini" ${tonePay.active?'checked':''}>
                                                            </td>
                                                            <input type="hidden" name="toneSysParamList[1].id"
                                                                   value="${tonePay.id}">
                                                            <input type="hidden" name="toneSysParamList[1].active"
                                                                   id="tonePay"
                                                                   value="${tonePay.active?'true':'false'}">
                                                        </c:when>
                                                        <c:when test="${item.value['dictCode'] eq toneDraw.paramCode}">
                                                            <c:set var="tonePath" value="${!(empty toneDraw.paramValue)?toneDraw.paramValue:toneDraw.defaultValue}"/>
                                                            <c:set var="tonePathDefined" value="${toneDrawDefined.paramValue}"/>
                                                            <td>
                                                                <div class="pull-left">
                                                                    <c:choose>
                                                                        <c:when test="${tonePath eq tonePathDefined}">
                                                                            <audio src="${imgRoot}/${tonePath}" preload="auto"></audio>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <audio src="${resRoot}/${tonePath}" preload="auto"></audio>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                                <soul:button
                                                                        target="${root}/setting/preference/editTone.html?paramCode=${toneDraw.paramCode}"
                                                                        cssClass="m-l-sm line-hi30"
                                                                        text="${fn:replace(views.setting_auto['修改提示音'],'[0]',dicts[item.value.module][item.value.dictType][item.value.dictCode])}"
                                                                        tag="a" opType="dialog"
                                                                        callback="reload">${views.setting['page.preference.replace']}</soul:button>
                                                                <soul:button
                                                                        target="${root}/setting/preference/uploadUserDefinedTone.html?result.paramCode=draw_defined"
                                                                        cssClass="m-l-sm line-hi30"
                                                                        text=""
                                                                        tag="a" opType="dialog"
                                                                        callback="reload">${views.setting_auto['上传']}</soul:button>
                                                            </td>
                                                            <td><input type="checkbox" name="active"
                                                                       objId="${toneDraw.id}" hidId="toneDraw"
                                                                       value="${toneDraw.active?'true':'false'}"
                                                                       data-size="mini" ${toneDraw.active?'checked':''}>
                                                            </td>
                                                            <input type="hidden" name="toneSysParamList[2].id"
                                                                   value="${toneDraw.id}">
                                                            <input type="hidden" name="toneSysParamList[2].active"
                                                                   id="toneDraw"
                                                                   value="${toneDraw.active?'true':'false'}">
                                                        </c:when>
                                                        <c:when test="${item.value['dictCode'] eq toneAudit.paramCode}">
                                                            <c:set var="tonePath" value="${!(empty toneAudit.paramValue)?toneAudit.paramValue:toneAudit.defaultValue}"/>
                                                            <c:set var="tonePathDefined" value="${toneAuditDefined.paramValue}"/>
                                                            <td>
                                                                <div class="pull-left">
                                                                    <c:choose>
                                                                        <c:when test="${tonePath eq tonePathDefined}">
                                                                            <audio src="${imgRoot}/${tonePath}" preload="auto"></audio>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <audio src="${resRoot}/${tonePath}" preload="auto"></audio>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                                <soul:button
                                                                        target="${root}/setting/preference/editTone.html?paramCode=${toneAudit.paramCode}"
                                                                        cssClass="m-l-sm line-hi30"
                                                                        text="${fn:replace(views.setting_auto['修改提示音'],'[0]',dicts[item.value.module][item.value.dictType][item.value.dictCode])}"
                                                                        tag="a" opType="dialog"
                                                                        callback="reload">${views.setting['page.preference.replace']}</soul:button>
                                                                <soul:button
                                                                        target="${root}/setting/preference/uploadUserDefinedTone.html?result.paramCode=audit_defined"
                                                                        cssClass="m-l-sm line-hi30"
                                                                        text=""
                                                                        tag="a" opType="dialog"
                                                                        callback="reload">${views.setting_auto['上传']}</soul:button>
                                                            </td>
                                                            <td><input type="checkbox" name="active"
                                                                       objId="${toneAudit.id}" hidId="toneAudit"
                                                                       value="${toneAudit.active?'true':'false'}"
                                                                       data-size="mini" ${toneAudit.active?'checked':''}>
                                                            </td>
                                                            <input type="hidden" name="toneSysParamList[3].id"
                                                                   value="${toneAudit.id}">
                                                            <input type="hidden" name="toneSysParamList[3].active"
                                                                   id="toneAudit"
                                                                   value="${toneAudit.active?'true':'false'}">
                                                        </c:when>
                                                        <c:when test="${item.value['dictCode'] eq toneWarm.paramCode}">
                                                            <c:set var="tonePath" value="${!(empty toneWarm.paramValue)?toneWarm.paramValue:toneWarm.defaultValue}"/>
                                                            <c:set var="tonePathDefined" value="${toneWarmDefined.paramValue}"/>
                                                            <td>
                                                                <div class="pull-left">
                                                                    <c:choose>
                                                                        <c:when test="${tonePath eq tonePathDefined}">
                                                                            <audio src="${imgRoot}/${tonePath}" preload="auto"></audio>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <audio src="${resRoot}/${tonePath}" preload="auto"></audio>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                                <soul:button
                                                                        target="${root}/setting/preference/editTone.html?paramCode=${toneWarm.paramCode}"
                                                                        cssClass="m-l-sm line-hi30"
                                                                        text="${fn:replace(views.setting_auto['修改提示音'],'[0]',dicts[item.value.module][item.value.dictType][item.value.dictCode])}"
                                                                        tag="a" opType="dialog"
                                                                        callback="reload">${views.setting['page.preference.replace']}</soul:button>
                                                                <soul:button
                                                                        target="${root}/setting/preference/uploadUserDefinedTone.html?result.paramCode=warm_defined"
                                                                        cssClass="m-l-sm line-hi30"
                                                                        text=""
                                                                        tag="a" opType="dialog"
                                                                        callback="reload">${views.setting_auto['上传']}</soul:button>
                                                            </td>
                                                            <td><input type="checkbox" name="active"
                                                                       objId="${toneWarm.id}" hidId="toneWarm"
                                                                       value="${toneWarm.active?'true':'false'}"
                                                                       data-size="mini" ${toneWarm.active?'checked':''}>
                                                            </td>
                                                            <input type="hidden" name="toneSysParamList[4].id"
                                                                   value="${toneWarm.id}">
                                                            <input type="hidden" name="toneSysParamList[4].active"
                                                                   id="toneWarm"
                                                                   value="${toneWarm.active?'true':'false'}">
                                                        </c:when>
                                                        <c:when test="${item.value['dictCode'] eq toneNotice.paramCode}">
                                                            <c:set var="tonePath" value="${!(empty toneNotice.paramValue)?toneNotice.paramValue:toneNotice.defaultValue}"/>
                                                            <c:set var="tonePathDefined" value="${toneNoticeDefined.paramValue}"/>
                                                            <td>
                                                                <div class="pull-left">
                                                                    <c:choose>
                                                                        <c:when test="${tonePath eq tonePathDefined}">
                                                                            <audio src="${imgRoot}/${tonePath}" preload="auto"></audio>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <audio src="${resRoot}/${tonePath}" preload="auto"></audio>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                                <soul:button
                                                                        target="${root}/setting/preference/editTone.html?paramCode=${toneNotice.paramCode}"
                                                                        cssClass="m-l-sm line-hi30"
                                                                        text="${fn:replace(views.setting_auto['修改提示音'],'[0]',dicts[item.value.module][item.value.dictType][item.value.dictCode])}"
                                                                        tag="a" opType="dialog"
                                                                        callback="reload">${views.setting['page.preference.replace']}</soul:button>
                                                                <soul:button
                                                                        target="${root}/setting/preference/uploadUserDefinedTone.html?result.paramCode=notice_defined"
                                                                        cssClass="m-l-sm line-hi30"
                                                                        text=""
                                                                        tag="a" opType="dialog"
                                                                        callback="reload">${views.setting_auto['上传']}</soul:button>
                                                            </td>
                                                            <td><input type="checkbox" name="active"
                                                                       objId="${toneNotice.id}" hidId="toneNotice"
                                                                       value="${toneNotice.active?'true':'false'}"
                                                                       data-size="mini" ${toneNotice.active?'checked':''}>
                                                            </td>
                                                            <input type="hidden" name="toneSysParamList[5].id"
                                                                   value="${toneNotice.id}">
                                                            <input type="hidden" name="toneSysParamList[5].active"
                                                                   id="toneNotice"
                                                                   value="${toneNotice.active?'true':'false'}">
                                                        </c:when>
                                                    </c:choose>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form:form>
<soul:import res="site/setting/preference/PreferenceEdit"/>
<script src="${resComRoot}/js/audiojs/audio.min.js"></script>
<script>
    audiojs.events.ready(function () {
        audiojs.createAll();
    });
</script>