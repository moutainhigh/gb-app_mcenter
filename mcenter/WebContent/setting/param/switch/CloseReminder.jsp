<%--@elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.SiteCustomerServiceVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<html lang="zh-CN">
<head>
    <title>${views.common['edit']}</title>
    <%@ include file="/include/include.head.jsp" %>
    <!--//region your codes 2-->

    <!--//endregion your codes 2-->
</head>

<body>

<form:form id="editForm" action="${root}/param/saveCloseReminder.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <div class="modal-body">

        <div class="form-group clearfix m-b-xxs">
            <label class="form_lab_block line-hi34 m-r-sm"><b>${views.setting['switch.CloseReminder.copywriter.title']} :</b> <span cclass="co-grayc2"></span></label>

        </div>
        <div class="clearfix save lgg-version">
            <c:forEach items="${list}" var="p" varStatus="status">
                <c:choose>
                    <c:when test="${status.index==0}">
                        <a href="javascript:void(0)" id="a_${status.index}" tt="${status.index}" name="tab_name" ${status.index==0?'class="current"':''} >${dicts.common.local[p.language]}<span id="span_${status.index}">${views.setting['switch.CloseReminder.editing']}</span></a>
                    </c:when>
                    <c:otherwise>
                        <a href="javascript:void(0)" id="a_${status.index}" tt="${status.index}" name="tab_name" ${status.index==0?'class="current"':''} >${dicts.common.local[p.language]}<span id="span_${status.index}">${views.setting['switch.CloseReminder.unedited']}</span></a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <span class="more">
                <%--<a href="javascript:void(0)"><i class="fa fa-angle-double-right"></i></a>--%>
                <soul:button target="changeCurrentLang" tag="a" opType="function" cssClass="next_lang" text="">
                    <i class="fa fa-angle-double-right"></i>
                </soul:button>
            </span>
        </div>
        <c:forEach items="${list}" var="p" varStatus="status">
            <div class="hfsj-wrap" id="div_${status.index}" ${status.index>0?'style="display:none"':''}>
                <div class="form-group" >
                    <label>${views.setting['switch.CloseReminder.copywriter.content']}</label>
                    <textarea error-holder="11" id="area_${status.index}" class="form-control m-b" tt="${status.index}" name="sv[${status.index}].value">${siteI18n.get(p.language).value}</textarea>
                    <input type="hidden" name="sv[${status.index}].module" value="${command.result.module}">
                    <input type="hidden" name="sv[${status.index}].type" value="${command.result.paramType}">
                    <input type="hidden" name="sv[${status.index}].key" value="${command.result.paramCode}">
                    <input type="hidden" name="sv[${status.index}].locale" value="${p.language}">
                </div>
            </div>
        </c:forEach>
        <div class="clearfix m-t bg-gray p-t-xs">
            <form:hidden path="result.paramCode"/>
            <input name="sysParam.id" type="hidden" value="${command.result.id}">
            <div class="input-group ${command.result.paramCode=='closure'?'':'hide'}" >
                <span class="input-group-addon abroder-no bg-gray" style="width: 94px;"><b>${views.setting['switch.CloseReminder.close.time']}：</b></span>
                <span class="input-group-addon bdn" style="width: 80px;text-align: left">
                    <gb:select name="sysParam.paramValue" prompt="${views.common['pleaseSelect']}" callback="CloseReminderChange" list="${types}"></gb:select>
                </span>
                <div class="form-group clearfix m-b-xxs timecss" id="div_close" style="display:none">
                    <gb:dateRange format="${DateFormat.DAY_SECOND}" style="width:160px" position="up"
                                  minDate="${dateQPicker.today}" name="closeTime" id="closeTime"></gb:dateRange>
                </div>
            </div>
        </div>
        <div class="clearfix m-t bg-gray p-t-xs timecss " style="display:none">
                    <span class="co-orange fs36 line-hi25 col-xs-1 al-right">
                        <i class="fa fa-exclamation-circle m-t-n-sm"></i>
                    </span>
            <div class="line-hi25 pull-left col-xs-11 m-b-sm">${views.setting['switch.CloseReminder.noticePlayer']}<soul:button target="goToNotice" text="${views.setting['switch.CloseReminder.gotoNotice']}" opType="function"/></div>
        </div>
        <input type="hidden" name="result.module" value="${command.result.module}">
        <input type="hidden" name="result.type" value="${command.result.paramType}">
        <input type="hidden" name="result.key" value="${command.result.paramCode}">
        <input type="hidden" name="curLanguage" id="curLanguage" value="0">
        <c:if test="${command.result.paramCode!='closure'}">
            <input type="hidden" name="type" value="3">
        </c:if>

    </div>
    <div class="modal-footer">
        <soul:button cssClass="btn btn-filter" text="${views.setting['common.ok']}" opType="ajax" dataType="json"
                     target="${root}/param/saveCloseReminder.html" precall="validateForm" post="getCurrentFormData"
                     callback="updateSwitch"/>
        <soul:button target="closePage" text="${views.setting['common.cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
    </div>
    <!--//endregion your codes 3-->

</form:form>

</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import res="site/setting/param/switch/CloseReminder"/>
<!--//endregion your codes 4-->
</html>