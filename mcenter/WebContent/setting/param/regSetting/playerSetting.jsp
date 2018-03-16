<%--@elvariable id="command" type="so.wwb.gamebox.model.company.site.vo.SiteConfineAreaVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<html lang="zh-CN">
<head>
    <title>${views.common['edit']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>

<body>
<form:form id="editForm" action="${root}/sysRole/edit.html" method="post">
<form:hidden path="result.id"/>
<form:hidden path="result.status"/>
<form:hidden path="paramId" id="paramId"/>
<form:hidden path="fieldSortStr" id="fieldSortStr"/>

<form:hidden path="ipRegIntervalParam.id" />
<form:hidden path="ipDayMaxRegNumParam.id" />
<form:hidden path="regAddressParam.id" />
<form:hidden path="phoneParam.id"/>
<form:hidden path="mailParam.id" />
<form:hidden path="type"/>
<div id="validateRule" style="display: none">${command.validateRule}</div>

    <div class="modal-body">
        <div class="panel blank-panel p-b-sm">
            <div class="">
                <div class="panel-options">
                    <ul class="nav nav-tabs p-l-sm p-r-sm">
                        <li class="active">
                            <a data-toggle="tab" href="../#tab-1" aria-expanded="false">${views.setting['PlayerReg.regField']}</a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="panel-body">
                <div class="tab-content">
                    <div id="tab-1" class="tab-pane active">
                        <c:forEach items="${command.fieldSortList}" var="p" varStatus="s">
                            <c:if test="${p.name!='302'&&p.name!='303'&&p.name!='countryCity'&&p.name!='constellation'&&p.name!='nickName'}">
                                <label style="display:${p.bulitIn?"none":""}" class="m-r-sm">
                                    <input id="field${s.index}" name="isRegField" type="checkbox" class="i-checks" ${p.isRegField=="1"?"checked":""} value="1">
                                        ${views.column[p.name]}
                                </label>
                            </c:if>
                        </c:forEach>

                    </div>
                </div>
            </div>
        </div>

        <div class="panel blank-panel p-b-sm">
            <div class="">
                <div class="panel-options">
                    <ul class="nav nav-tabs p-l-sm p-r-sm">
                        <li class="active">
                            <a data-toggle="tab" href="../#tab-2" aria-expanded="true">${views.setting['PlayerReg.required']}</a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="panel-body">
                <div class="tab-content">
                    </div>
                    <div id="tab-2" class="tab-pane">
                        <c:forEach items="${command.fieldSortList}" var="p">
                            <c:if test="${p.name!='302'&&p.name!='303'&&p.name!='countryCity'&&p.name!='constellation'&&p.name!='nickName'}">
                                <label style="display:${p.bulitIn?"none":""};" class="m-r-sm">
                                    <input name="isRequired" _name="${p.name}" _bulitIn="${p.bulitIn}"  _sort="${p.sort}" type="checkbox"
                                           class="i-checks" ${p.isRequired=="1"?"checked":""} value="1">
                                        ${views.column[p.name]}
                                </label>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </div>

        <c:if test="${empty command.type}">
            <div class="panel blank-panel p-b-sm">
                <div class="">
                    <div class="panel-options">
                        <ul class="nav nav-tabs p-l-sm p-r-sm">
                            <li class="active">
                                <a data-toggle="tab" href="../#tab-3" aria-expanded="true">${views.setting['PlayerReg.only']}</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="tab-content">
                    </div>
                    <div id="tab-3" class="tab-pane">
                        <c:forEach items="${command.fieldSortList}" var="p" varStatus="s">
                            <c:if test="${p.name!='302'&&p.name!='303'&&p.name!='countryCity'&&p.name!='constellation'&&p.name!='nickName'}">
                                <label style="<c:if test="${p.name!='realName'&&p.name!='110'&&p.name!='201'&&p.name!='304'&&p.name!='301'}">display:none;</c:if>" class="m-r-sm">
                                    <input name="isOnly" id="only${s.index}" type="checkbox"
                                           class="i-checks" ${p.isOnly=="1"?"checked":""} value="1">
                                        ${views.column[p.name]}
                                </label>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </c:if>

        <div class="panel blank-panel p-b-sm">

            <div class="">
                <div class="panel-options">
                    <ul class="nav nav-tabs p-l-sm p-r-sm">
                        <span class="co-blue"><h3>${views.setting['PlayerReg.validPhoneMail']}</h3></span>
                    </ul>
                </div>
            </div>
            <div class="panel-body">
                <div class="tab-content">
                    <div class="tab-pane active">
                        <div class="form-group clearfix line-hi34 m-b-none">
                            <form:hidden path="phoneParam.active" id="phoneParam"/>
                            <form:hidden path="mailParam.active" id="mailParam"/>

                            <label class="form_lab_block line-hi34 m-r-sm"><b>${views.setting['PlayerReg.validPhone']} : </b></label>
                            <div class="col-sm-8">
                                    <%--暂时隐藏，当开启手机验证时开启--%>
                                <input type="checkbox" name="my-checkbox" typeName="phoneParam" data-size="mini" ${command.phoneParam.active?"checked":""}>
                                <%--暂时隐藏，当开启手机验证时开启--%>
                                <span id="isShowphoneParam" ${command.phoneParam.active?"":"hidden"}><label  class="m-r-sm"><input type="radio" class="i-checks" name="phoneParam.paramValue" value="before" ${command.phoneParam.paramValue=="before"?"checked":""}> ${views.setting['PlayerReg.before']}</label><span
                                    tabindex="0" class=" help-popover" role="button" data-container="body"
                                    data-toggle="popover" data-trigger="focus" data-placement="top"
                                    data-content="${views.setting['PlayerReg.help.phone.befor']}"><i
                                    class="fa fa-question-circle"></i></span>
                                <label class="m-r-sm m-l-xs"><input type="radio" class="i-checks" value="after" ${command.phoneParam.paramValue=="after"?"checked":""} name="phoneParam.paramValue"> ${views.setting['PlayerReg.after']}</label><span
                                    tabindex="0" class=" help-popover" role="button" data-container="body"
                                    data-toggle="popover" data-trigger="focus" data-placement="top"
                                    data-content="${views.setting['PlayerReg.help.phone.last']}"><i class="fa fa-question-circle"></i></span>
                                 </span>
                            </div>
                        </div>


                        <div class="form-group clearfix line-hi34 m-b-none hide">
                            <label class="form_lab_block line-hi34 m-r-sm"><b>${views.setting['PlayerReg.validMail']} : </b></label>

                            <div class="col-sm-8">
                                <input type="checkbox" name="my-checkbox" data-size="mini" typeName="mailParam" ${command.mailParam.active?"checked":""}>
                               <span id="isShowmailParam" ${command.mailParam.active?"":"hidden"}>
                                   <label  class="m-r-sm"><input  type="radio" class="i-checks" name="mailParam.paramValue" value="before" ${command.mailParam.paramValue=="before"?"checked":""}>  ${views.setting['PlayerReg.before']}</label>
                                   <label  class="m-r-sm"><input  type="radio" class="i-checks" name="mailParam.paramValue" value="after" ${command.mailParam.paramValue=="after"?"checked":""}  >  ${views.setting['PlayerReg.after']}</label>
                               </span>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <div class="panel blank-panel p-b-sm">

            <div class="">
                <div class="panel-options">
                    <ul class="nav nav-tabs p-l-sm p-r-sm">
                        <span class="co-blue"><h3>${views.setting['PlayerReg.regLimit']}</h3></span>
                    </ul>
                </div>
            </div>
            <div class="panel-body">
                <div class="tab-content">
                    <div class="tab-pane active">

                        <div class="form-group clearfix m-b-xxs">
                            <label>${views.setting['PlayerReg.ip_reg_interval']}:</label>

                            <div class="input-group date m-b">
                                <%--<form:input path="ipRegIntervalParam.paramValue" cssClass="form-control"/>--%>

                                <input name="ipRegIntervalParam.paramValue"   value="${empty command.ipRegIntervalParam.paramValue?command.ipRegIntervalParam.defaultValue:command.ipRegIntervalParam.paramValue}" class="form-control" />
                                <span class="input-group-addon bg-gray">${views.role['hour']}</span>
                        <span class="input-group-addon adjust">
                            <a href="javascript:void(0)" max="24" baseNum="0.5"  class="adjust up"><i class="fa fa-angle-up"></i></a>
                            <a href="javascript:void(0)" class="adjust down" dowmNum="0.5"><i class="fa fa-angle-down"></i></a>
                        </span>
                            </div>
                        </div>
                        <div class="form-group clearfix m-b-xxs">
                            <label>${views.setting['PlayerReg.ip_day_max_regNum']}:</label>

                            <div class="input-group date m-b">
                                <input name="ipDayMaxRegNumParam.paramValue" value="${empty command.ipDayMaxRegNumParam.paramValue?command.ipDayMaxRegNumParam.defaultValue:command.ipDayMaxRegNumParam.paramValue}" class="form-control" />
                                <span class="input-group-addon bg-gray">${views.common['privilege.password.suffix']}</span>
                        <span class="input-group-addon adjust">
                            <a href="javascript:void(0)" max="48" class="adjust up" baseNum="1"><i class="fa fa-angle-up"></i></a>
                            <a href="javascript:void(0)" class="adjust down" dowmNum="1"><i class="fa fa-angle-down"></i></a>
                        </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <soul:button cssClass="btn btn-filter" text="${views.setting['common.ok']}" opType="ajax" dataType="json"
                     target="${root}/param/savePlayerSetting.html" precall="savaPlayerSetting" post="getCurrentFormData"
                     callback="saveCallbak"/>
        <soul:button target="closePage" text="${views.setting['common.cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
    </div>

    </form:form>

</body>
<%@ include file="/include/include.js.jsp" %>
<%--<soul:import type="edit"/>--%>
<soul:import res="site/setting/param/regSetting/playerSetting"/>
</html>
