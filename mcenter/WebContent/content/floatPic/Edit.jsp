<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.CttFloatPicVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->
<link href="${resComRoot}/themes/${curTheme}/dist/bootstrapSwitch.css">
<!--//endregion your codes 1-->

<html lang="zh-CN">
<head>
    <title>${views.common['edit']}</title>
    <%@ include file="/include/include.head.jsp" %>
    <!--//region your codes 2-->

    <!--//endregion your codes 2-->
</head>

<body>

<form:form id="editForm" action="${root}/cttFloatPic/edit.html" method="post" enctype="multipart/form-data">
    <form:hidden path="result.id" id="floatId"/>
    <form:hidden path="result.tempId"/>
    <form:hidden path="result.status"/>
    <form:hidden path="editType"/>
    <div id="validateRule" style="display: none;">${command.validateRule}</div>
    <!--//region your codes 3-->
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['内容']}</span>
            <span>/</span><span>${views.sysResource['浮动图管理']}</span>
            <span id="returnBtn"><soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function"><em class="fa fa-caret-left"></em>${views.common['return']}</soul:button></span>
            <span id="preReturn" class="hide"><soul:button target="returnEdit" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function"><em class="fa fa-caret-left"></em>${views.common['return']}</soul:button></span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12" id="editContent">
            <div class="wrapper white-bg shadow clearfix">
                <div class="present_wrap"><b>${command.editType=='1' ? views.common['newFloatPic'] : views.common['editFloatPic']}</b></div>
                <div class="m-t">
                        <%-- 标题 --%>
                    <div class="form-group clearfix">
                        <label class="ft-bold col-sm-3 al-right line-hi34"><span class="co-red m-r-sm">*</span>${views.column['CttFloatPic.title']}</label>
                        <div class="col-sm-5">
                            <form:input path="result.title" cssClass="form-control" placeholder="${views.content['floatPic.placeholder.title']}"/>
                        </div>
                    </div>
                            <%-- 适用语序 --%>
                    <div class="form-group clearfix">
                        <label class="ft-bold col-sm-3 al-right line-hi34"><span class="co-red m-r-sm">*</span>${views.column['CttFloatPic.language']}</label>
                        <div class="col-sm-5">

                            <div class="input-group" style="width: 125px;">
                                <select class="chosen-select-no-single" data-placeholder="${views.content['floatPic.choose.a.language']}" name="result.language">
                                    <c:forEach items="${langs}" var="lang">
                                        <option value="${lang.language}" ${(lang.language == command.result.language) ? 'selected' : ''}>${views.common[lang.language]}</option>
                                    </c:forEach>
                                </select>
                                <span tabindex="0" class="input-group-addon help-popover" role="button"
                                      data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                                      data-content="${views.content['floatPic.language.data-content']}">
                                    <i class="fa fa-question-circle"></i>
                                </span>
                            </div>
                        </div>
                    </div>
                                <%-- 边距 --%>
                    <div class="form-group clearfix">
                        <label class="ft-bold col-sm-3 al-right">${views.column['CttFloatPic.location']}</label>
                        <div class="col-sm-5">
                            <label><input type="radio" class="i-checks" name="result.location" value="left" ${(command.result.location != 'right') ? 'checked' : ''}>${views.column['CttFloatPic.left']}</label>
                            <label><input type="radio" class="i-checks" name="result.location" value="right" ${(command.result.location == 'right') ? 'checked' : ''}>${views.column['CttFloatPic.right']}</label>
                            <div class="input-group date tooltip-demo">
                                <span class="input-group-addon bg-gray"><span class="co-red m-r-sm">*</span>
                               <%-- ${views.column['CttFloatPic.distanceTop']} --%>
                                    <select name="result.distanceType" >
                                        <option value="1" ${command.result.distanceType=='1'?'select':''}>${views.content['顶边距']}</option>
                                        <option value="2" ${command.result.distanceType=='2'?'selected':''}>${views.content['底边距']}</option>
                                    </select>px
                                </span>
                                <form:input path="result.distanceValue" cssClass="form-control" maxlength="5"/>
                                <span class="input-group-addon" data-container="body" data-toggle="popover" data-placement="right" data-content="${views.content['floatPic.position.date-content.top']}">
                                    <i class="fa fa-question-circle"></i>
                                </span>
                            </div>
                            <div class="input-group date">
                                <span class="input-group-addon bg-gray"><span class="co-red m-r-sm">*</span>${views.column['CttFloatPic.distanceSide']} px</span>
                                <form:input path="result.distanceSide" cssClass="form-control" maxlength="5"/>
                                <span class="input-group-addon" data-container="body" data-toggle="popover" data-placement="right" data-content="${views.content['floatPic.position.date-content.side']}">
                                    <i class="fa fa-question-circle"></i>
                                </span>
                            </div>
                        </div>
                    </div>
                                <%-- 页面交互效果 --%>
                    <div class="form-group clearfix">
                        <label class="ft-bold col-sm-3 al-right line-hi34">${views.column['CttFloatPic.interactivity']}</label>
                        <div class="col-sm-5">
                            <select class="btn-group chosen-select-no-single" name="result.interactivity">
                                <c:forEach items="${interactivityMaps}" var="map">
                                    <option value="${map.key}" ${(map.key== command.result.interactivity) ? 'selected' : ''}>${views.content['floatPic.interactivity.'.concat(map.key)]}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                                <%-- 鼠标移入效果开关 --%>
                    <div class="form-group clearfix" id="content_float_pic_mouseInEffect_div">
                        <label class="ft-bold col-sm-3 al-right">${views.column['CttFloatPic.mouseInEffect']}</label>
                        <div class="col-sm-5"><input type="checkbox" switch="boostrapSwitch" name="mouseInEffect" value="true" data-size="mini" ${empty command.result.id || command.result.mouseInEffect ? 'checked' : ''}></div>
                        <form:hidden path="result.mouseInEffect" value="${empty command.result.mouseInEffect?true:command.result.mouseInEffect}"/>
                    </div>
                                <%-- 关闭按钮开关 --%>
                    <div class="form-group clearfix">
                        <label class="ft-bold col-sm-3 al-right">${views.column['CttFloatPic.hideCloseButton']}</label>
                        <div class="col-sm-5"><input type="checkbox" switch="boostrapSwitch" name="hideCloseButton" value="true" data-size="mini" ${empty command.result.id || command.result.hideCloseButton ? 'checked' : ''}></div>
                        <form:hidden path="result.hideCloseButton" value="${empty command.result.hideCloseButton?true:command.result.hideCloseButton}"/>
                    </div>






                    <%-- start模板模式--%>
                    <div class="form-group clearfix">
                        <div class="form-group clearfix">
                            <label class="ft-bold col-sm-3 al-right">${views.column['CttFloatPic.type']}</label>
                            <div class="col-sm-5">
                                <input type="radio" class="i-checks" name="result.picType" value="1" ${command.result.picType == '1' || empty command.result.picType? 'checked' : ''}>${views.column['CttFloatPic.template.type.server']}
                                <input type="radio" class="i-checks" name="result.picType" value="2" ${command.result.picType == '2' ? 'checked' : ''}>${views.column['CttFloatPic.template.type.promo']}
                            </div>
                        </div>
                        <label class="ft-bold col-sm-3 al-right">${views.column['CttFloatPic.display.style']}</label>
                        <div class="col-sm-8">
                            <input type="radio" class="i-checks" name="result.singleMode" value="true" ${command.result.singleMode==true||empty command.result.singleMode ? 'checked' : ''}>${views.column['CttFloatPic.template.style.system']}
                            <input type="radio" class="i-checks" name="result.singleMode" value="false" ${command.result.singleMode==false ? 'checked' : ''}>${views.column['CttFloatPic.template.style.custom']}
                                <%-- 单图模式的模板 --%>
                            <div class="${command.result.singleMode==false?'hide':''}" id="singleMode_templateType_div">
                                <ul class="tempstyle clearfix ${command.result.picType=='1' || empty command.result.picType ? '' : 'hide'}" id="singleMode_service_pic">
                                    <li>
                                        <img src="${soulFn:getImagePath(domain, "floatImage/floatpic/panel-red.png")}" data-image=""
                                             alt="${command.result.title}" class="singleModeTemplateImageType">
                                        <%--<img src="${resRoot}/images/floatpic/panel-red.png" class="singleModeTemplateImageType">--%>
                                        <input type="radio" name="templateType" class="i-checks" value="1" ${empty command.result.tempId || command.result.tempId==1 || !(command.result.tempId>0&&command.result.tempId<10)?"checked":""}>
                                    </li>
                                    <li>
                                        <img src="${soulFn:getImagePath(domain, "floatImage/floatpic/panel-gold.png")}"
                                             alt="${command.result.title}" class="singleModeTemplateImageType">
                                        <%--<img src="${resRoot}/images/floatpic/panel-gold.png" class="singleModeTemplateImageType">--%>
                                        <input type="radio" name="templateType" class="i-checks" value="2" ${command.result.tempId==2?"checked":""}>
                                    </li>
                                    <li>
                                        <img src="${soulFn:getImagePath(domain, "floatImage/floatpic/panel-green.png")}"
                                             alt="${command.result.title}" class="singleModeTemplateImageType">
                                        <%--<img src="${resRoot}/images/floatpic/panel-green.png" class="singleModeTemplateImageType">--%>
                                        <input type="radio" name="templateType" class="i-checks" value="3" ${command.result.tempId==3?"checked":""}>
                                    </li>
                                    <li>
                                        <img src="${soulFn:getImagePath(domain, "floatImage/floatpic/panel-blue.png")}"
                                             alt="${command.result.title}" class="singleModeTemplateImageType">
                                        <%--<img src="${resRoot}/images/floatpic/panel-blue.png" class="singleModeTemplateImageType">--%>
                                        <input type="radio" name="templateType" class="i-checks" value="4" ${command.result.tempId==4?"checked":""}>
                                    </li>
                                    <li>
                                        <img src="${soulFn:getImagePath(domain, "floatImage/floatpic/panel-white.png")}"
                                             alt="${command.result.title}" class="singleModeTemplateImageType">
                                        <%--<img src="${resRoot}/images/floatpic/panel-white.png" class="singleModeTemplateImageType">--%>
                                        <input type="radio" name="templateType" class="i-checks" value="5" ${command.result.tempId==5?"checked":""}>
                                    </li>
                                    <li>
                                        <img src="${soulFn:getImagePath(domain, "floatImage/floatpic/panel-black.png")}"
                                             alt="${command.result.title}" class="singleModeTemplateImageType">
                                        <%--<img src="${resRoot}/images/floatpic/panel-black.png" class="singleModeTemplateImageType">--%>
                                        <input type="radio" name="templateType" class="i-checks" value="6" ${command.result.tempId==6?"checked":""}>
                                    </li>
                                </ul>

                                    <%-- 新增bykobefor优惠浮动图单图模式 --%>
                                <ul class="tempstyle clearfix ${command.result.picType=='2' ? '' : 'hide'}" id="singleMode_promo_pic">
                                    <li>
                                        <img src="${soulFn:getImagePath(domain, "floatImage/floatpic/panel-red.png")}" data-image=""
                                             alt="${command.result.title}" class="singleModeTemplateImageType">
                                            <%--<img src="${resRoot}/images/floatpic/panel-red.png" class="singleModeTemplateImageType">--%>
                                        <input type="radio" name="templateType" class="i-checks" value="7" ${command.result.tempId==7 ?"checked":""}>
                                    </li>
                                    <li>
                                        <img src="${soulFn:getImagePath(domain, "floatImage/floatpic/panel-gold.png")}"
                                             alt="${command.result.title}" class="singleModeTemplateImageType">
                                            <%--<img src="${resRoot}/images/floatpic/panel-gold.png" class="singleModeTemplateImageType">--%>
                                        <input type="radio" name="templateType" class="i-checks" value="8" ${command.result.tempId==8?"checked":""}>
                                    </li>
                                    <li>
                                        <img src="${soulFn:getImagePath(domain, "floatImage/floatpic/panel-green.png")}"
                                             alt="${command.result.title}" class="singleModeTemplateImageType">
                                            <%--<img src="${resRoot}/images/floatpic/panel-green.png" class="singleModeTemplateImageType">--%>
                                        <input type="radio" name="templateType" class="i-checks" value="9" ${command.result.tempId==9?"checked":""}>
                                    </li>
                                </ul>
                            </div>

                        </div>
                    </div>
                                <%-- 单图模式的链接 --%>
                    <div class="form-group clearfix ${command.result.singleMode==false?'hide':''}" id="content_float_pic_single_link_div">
                        <label class="ft-bold col-sm-3 al-right line-hi34">${views.column['CttFloatPic.image.link']}</label>
                        <div class="col-sm-5">
                            <div class="input-group date">
                                <div class="input-group" style="width:100%;">
                                    <div class="input-group-btn">
                                        <div class="bg-gray">
                                            <select class="chosen-select-no-single" name="floatPicItem.imgLinkType" callback="changeSelect">
                                                <c:forEach items="${floatPicLinkTypeMaps}" var="map">
                                                    <c:if test="${map.key ne 'close_btn'}">
                                                        <option value="${map.key}" ${not empty command.floatPicItem.imgLinkType && (command.floatPicItem.imgLinkType == map.key) ? 'selected' : '' }>${views.content['floatPic.linkType.'.concat(map.key)]}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <select name="imgServiceValue" class="btn-group chosen-select-no-single content_float_pic_image_service_value ${empty command.floatPicItem.imgLinkType || (command.floatPicItem.imgLinkType == 'customer_service') ? '' : 'hide'}">
                                        <c:if test="${fn:length(SiteCustomerService) > 0}">
                                            <c:forEach items="${SiteCustomerService}" var="cs">
                                                <option value="${cs.id}" ${not empty command.floatPicItem.imgLinkValue && (command.floatPicItem.imgLinkValue.toString() == cs.id.toString()) ? 'selected' : '' }>${cs.name}</option>
                                            </c:forEach>
                                        </c:if>
                                    </select>
                                    <span class="input-group-addon ${not empty command.floatPicItem.imgLinkType && (command.floatPicItem.imgLinkType == 'link') ? '' : 'hide'}" id="content_float_pic_type_http">http://</span>
                                    <input type="text" name="imgLinkTypeValue" class="form-control ${not empty command.floatPicItem.imgLinkType && (command.floatPicItem.imgLinkType == 'link') ? '' : 'hide'}" value="${command.floatPicItem.imgLinkType == 'link' ? command.floatPicItem.imgLinkValue : ''}">
                                    <span class="input-group-addon bdn _editTags">
                                        <a href="javascript:void(0)" name="placeholder"
                                           class="variable ${not empty command.floatPicItem.imgLinkType && (command.floatPicItem.imgLinkType == 'link') ? '' : 'hide'}">
                                           ${views.operation['MassInformation.step3.website']}<span>{website}</span>
                                        </a>
                                    </span>
                                    <input type="hidden" name="floatPicItem.imgLinkValue" value="${command.floatPicItem.imgLinkType == 'link' ? '' : (empty command.floatPicItem.imgLinkType ? SiteCustomerService[0].id : command.floatPicItem.imgLinkValue)}"/>
                                    <span class="input-group-addon bdn ${not empty command.floatPicItem.imgLinkType && (command.floatPicItem.imgLinkType == 'link') ? 'hide' : '' }" id="content_float_pic_type_custom_service_setting_link">
                                        <a href="/param/siteParam.html?hasReturn=true&index=li_top_1" nav-target="mainFrame" class="m-l-sm">${views.column['CttFloatPic.image.setting']}</a>
                                    </span>
                                </div>

                            </div>
                        </div>
                    </div>
                    <%--end模板模式--%>

                    <%--自定义模板--%>
                    <div class="form-group clearfix ${empty command.result.singleMode || command.result.singleMode==true?'hide':''}" id="float_template_list_div">
                        <label class="ft-bold col-sm-3 al-right line-hi34"></label>
                        <div class="col-sm-5">
                            <ul class="middle-img-list">
                                <c:forEach var="item" items="${command.itemList}" varStatus="vs">
                                    <li>
                                        <div class="tit">${views.content['float.picture']}<span>${vs.index+1}</span>
                                            <soul:button cssClass="co-gray" target="removeAddOne" text="${views.common['delete']}" opType="function"><i class="fa fa-times"></i></soul:button>
                                        </div>
                                        <div class="form-group date m-b-sm normalEffectDiv">
                                            <span class=""><b>${views.content['float.normalEffect']}</b></span>
                                            <div id="normalEffectImgDiv${vs.index+1}">
                                                <c:if test="${not empty item.normalEffect}">
                                                    <img id="normalEffectImg${vs.index+1}" src="${soulFn:getThumbPath(domain, item.normalEffect,0,0)}" />
                                                </c:if>
                                            </div>
                                            <input class="file" type="file" accept="image/*" name="normalEffect" target="itemList[${vs.index}].normalEffect">
                                            <input type="hidden" name="itemList[${vs.index}].normalEffect" value="${item.normalEffect}">
                                            <input type="hidden" name="itemList[${vs.index}].imgWidth" value="${item.imgWidth}">
                                            <input type="hidden" name="itemList[${vs.index}].imgHeight" value="${item.imgHeight}">
                                        </div>
                                        <div class="form-group date m-b-sm mouseInEffectDiv">
                                            <span class=""><b>${views.content['float.mouseInEffect']}</b></span>
                                            <div id="mouseInEffectImgDiv${vs.index+1}">
                                                <c:if test="${not empty item.mouseInEffect}">
                                                    <img id="mouseInEffectImg${vs.index+1}" src="${soulFn:getThumbPath(domain, item.mouseInEffect,0,0)}" />
                                                </c:if>
                                            </div>
                                            <input class="file" type="file" accept="image/*" target="itemList[${vs.index}].mouseInEffect">
                                            <input type="hidden" name="itemList[${vs.index}].mouseInEffect" value="${item.mouseInEffect}">
                                        </div>
                                        <div class="input-group select_float_pic_link_type" style="width:100%;">
                                            <div class="input-group-btn">
                                                <div class="bg-gray">
                                                    <select class="chosen-select-no-single float_pic_list_item_link_type" name="itemList[${vs.index}].imgLinkType">
                                                        <c:forEach items="${floatPicLinkTypeMaps}" var="map">
                                                            <option value="${map.key}" ${not empty item.imgLinkType && (item.imgLinkType == map.key) ? 'selected' : '' }>${views.content['floatPic.linkType.'.concat(map.key)]}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <select name="imgServiceValue${vs.index+1}" class="btn-group chosen-select-no-single float_pic_list_item_service_value ${empty item.imgLinkType || (item.imgLinkType == 'customer_service') ? '' : 'hide'}">
                                                <c:if test="${fn:length(SiteCustomerService) > 0}">
                                                    <c:forEach items="${SiteCustomerService}" var="cs">
                                                        <option value="${cs.id}" ${not empty item.imgLinkValue && (item.imgLinkValue.toString() == cs.id.toString()) ? 'selected' : '' }>${cs.name}</option>
                                                    </c:forEach>
                                                </c:if>
                                            </select>
                                            <span class="input-group-addon float_pic_list_item_http ${not empty item.imgLinkType && (item.imgLinkType == 'link') ? '' : 'hide'}" id="content_float_pic_type_http${vs.index+1}">http://</span>
                                            <input type="text" name="imgLinkTypeValue${vs.index+1}" class="form-control float_pic_list_item_link_value ${not empty item.imgLinkType && (item.imgLinkType == 'link') ? '' : 'hide'}" value="${item.imgLinkType == 'link' ? item.imgLinkValue : ''}">
                                            <span class="input-group-addon ${command.result.singleMode ?'hide':''} bdn _editTags">
                                                <a href="javascript:void(0)" name="float_pic_list_item_placeholder"
                                                   class="variable ${not empty item.imgLinkType && (item.imgLinkType == 'link') ? '' : 'hide'}">
                                                   ${views.operation['MassInformation.step3.website']}<span>{website}</span>
                                                </a>
                                            </span>
                                            <input type="hidden" name="itemList[${vs.index}].imgLinkValue" class="float_pic_list_item_link_type_value" value="${item.imgLinkType == 'link' ? item.imgLinkValue : (empty item.imgLinkType ? SiteCustomerService[0].id : item.imgLinkValue)}"/>
                                            <span class="input-group-addon bdn ${vs.index > 0 || (item.imgLinkType != 'customer_service') ? 'hide' : '' } setting">
                                                <a href="/param/siteParam.html?hasReturn=true&index=li_top_1" nav-target="mainFrame" class="m-l-sm">${views.column['CttFloatPic.image.setting']}</a>
                                            </span>
                                        </div>
                                    </li>
                                </c:forEach>
                                <c:if test="${empty command.itemList}">
                                    <li>
                                        <div class="tit">${views.content['float.picture']}<span>1</span>
                                            <soul:button cssClass="co-gray" target="removeAddOne" text="${views.common['delete']}" opType="function"><i class="fa fa-times"></i></soul:button>
                                        </div>
                                        <div class="form-group date m-b-sm normalEffectDiv">
                                            <span class=""><b>${views.content['float.normalEffect']}</b></span>
                                            <div>
                                            <input class="file" type="file" accept="image/*" target="itemList[0].normalEffect">
                                            <input type="hidden" name="itemList[0].normalEffect">
                                            <input type="hidden" name="itemList[0].imgWidth">
                                            <input type="hidden" name="itemList[0].imgHeight">
                                            </div>
                                        </div>
                                        <div class="form-group date m-b-sm mouseInEffectDiv">
                                            <span class=""><b>${views.content['float.mouseInEffect']}</b></span>
                                            <div>
                                            <input class="file" type="file" accept="image/*" target="itemList[0].mouseInEffect">
                                            <input type="hidden" name="itemList[0].mouseInEffect">
                                            </div>
                                        </div>
                                        <div class="input-group select_float_pic_link_type" style="width:100%;">
                                            <div class="input-group-btn">
                                                <div class="bg-gray">
                                                    <select class="chosen-select-no-single float_pic_list_item_link_type" name="itemList[0].imgLinkType" name="floatPicItem.imgLinkType">
                                                        <c:forEach items="${floatPicLinkTypeMaps}" var="map">
                                                            <option value="${map.key}" >${views.content['floatPic.linkType.'.concat(map.key)]}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <select name="imgServiceValue0" class="btn-group chosen-select-no-single float_pic_list_item_service_value">
                                                <c:if test="${fn:length(SiteCustomerService) > 0}">
                                                    <c:forEach items="${SiteCustomerService}" var="cs">
                                                        <option value="${cs.id}" >${cs.name}</option>
                                                    </c:forEach>
                                                </c:if>
                                            </select>
                                            <span class="input-group-addon hide float_pic_list_item_http" id="content_float_pic_type_http0">http://</span>
                                            <input type="text" name="imgLinkTypeValue0" class="form-control hide float_pic_list_item_link_value" value="">
                                            <span class="input-group-addon ${command.result.singleMode ?'hide':''} bdn _editTags">
                                                <a href="javascript:void(0)" name="float_pic_list_item_placeholder"
                                                   class="variable ${not empty command.floatPicItem.imgLinkType && (command.floatPicItem.imgLinkType == 'link') ? '' : 'hide'}">
                                                   ${views.operation['MassInformation.step3.website']}<span>{website}</span>
                                                </a>
                                            </span>
                                            <input type="hidden" name="itemList[0].imgLinkValue" class="float_pic_list_item_link_type_value" value="${SiteCustomerService[0].id}"/>
                                            <span class="input-group-addon bdn ${vs.index>0 ? 'hide' : '' } setting">
                                                <a href="/param/siteParam.html?hasReturn=true&index=li_top_1" nav-target="mainFrame" class="m-l-sm">${views.column['CttFloatPic.image.setting']}</a>
                                            </span>
                                        </div>
                                    </li>
                                </c:if>
                                <li><soul:button target="addMiddleImage" text="+ ${views.common['addOne']}" opType="function"/></li>
                            </ul>
                        </div>
                    </div>
                    <%--自定义模板--%>



                    <%--新增bykobefor显示效果--%>
                    <div class="form-group clearfix ${command.result.picType == '1' || empty command.result.picType? 'hide' : ''}" id="pic_showEffect">
                        <label class="ft-bold col-sm-3 al-right"><span class="co-red m-r-sm">*</span>${views.column['CttFloatPic.showEffect']}</label>
                        <div class="col-sm-5">
                            <div>
                                <input type="radio" class="i-checks" name="result.showEffect" value="true" ${command.result.showEffect==true || empty command.result.showEffect ? 'checked' : ''}>${views.column['CttFloatPic.showEffect.hidden']}
                                <input type="radio" class="i-checks" name="result.showEffect" value="false" ${command.result.showEffect==false ? 'checked' : ''}>${views.column['CttFloatPic.showEffect.show.after.refresh']}
                            </div>
                        </div>
                    </div>




                                <%-- 展示页面 --%>
                    <div class="form-group clearfix">
                        <label class="ft-bold col-sm-3 al-right"><span class="co-red m-r-sm">*</span>${views.column['CttFloatPic.image.displayInPages']}</label>
                        <div class="col-sm-5">
                            <div id="service_show_page" class="<%--${command.result.picType=='1'? '' : 'hide'}--%>">
                                <c:forEach items="${floatPicDisplayInMaps}" var="map">
                                    <input type="checkbox" class="i-checks show_page_${map.key}" name="result.displayInPages" value="${map.key}" ${fn:contains(command.result.displayInPages, map.key) ? 'checked' : ''}><span class="show_page_span_${map.key}">${views.content['floatPic.displayIn.'.concat(map.key)]}</span>&nbsp;
                                </c:forEach>
                            </div>
                                <%-- kobe新增for显示页面 --%>
                            <%--<div id="promo_show_page" class="${command.result.picType=='2'? '' : 'hide'}">${views.content['floatPic.displayIn.1']}
                                <input type="checkbox" class="i-checks disabled" name="cjcch" value="1" checked>
                            </div>--%>
                        </div>
                    </div>
                    <hr class="m-t-sm m-b">
                    &nbsp;&nbsp;
                    <soul:button target="goToLastPage" cssClass="btn btn-outline btn-filter btn-lg" text="${views.common['return']}" opType="function" refresh="false"></soul:button>
                    &nbsp;
                    <soul:button target="previewFloatPic" precall="valiDateFormAndUploadFile" text="${views.common['previewAndSave']}" cssClass="btn btn-filter btn-lg m-r" opType="function"/>

                </div>
            </div>
        </div>
    </div>
    <div class="hide" id="ctt_float_pic_item_div">
        <li id="ctt_float_pic_item">
            <div class="tit">${views.content['float.picture']}<span>1</span>
                <soul:button cssClass="co-gray" target="removeAddOne" text="${views.common['delete']}" opType="function"><i class="fa fa-times"></i></soul:button>
            </div>
            <div class="form-group date m-b-sm normalEffectDiv">
                <span class=""><b>${views.content['float.normalEffect']}</b></span>
                <div>
                <input class="file imageFileInput" type="file" accept="image/*" target="itemList[1].normalEffect">
                <input type="hidden" class="imageHiddenValue">
                <input type="hidden" class="imageHiddenWidth">
                <input type="hidden" class="imageHiddenHeight">
                </div>
            </div>
            <div class="form-group date m-b-sm mouseInEffectDiv ${not empty command.result.singleMode && command.result.singleMode?'':'hide'}">
                <span class=""><b>${views.content['float.mouseInEffect']}</b></span>
                <div>
                    <input class="file imageFileInput" type="file" accept="image/*" target="itemList[1].mouseInEffect">
                    <input type="hidden" class="imageHiddenValue">
                </div>
            </div>
            <div class="input-group select_float_pic_link_type" style="width:100%;">
                <div class="input-group-btn">
                    <div class="bg-gray">
                        <select class="btn-group chosen-select-no-single float_pic_list_item_link_type" name="itemList[1].imgLinkType">
                            <c:forEach items="${floatPicLinkTypeMaps}" var="map">
                                <option value="${map.key}" >${views.content['floatPic.linkType.'.concat(map.key)]}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <select name="imgServiceValue1" class="btn-group chosen-select-no-single float_pic_list_item_service_value">
                    <c:if test="${fn:length(SiteCustomerService) > 0}">
                        <c:forEach items="${SiteCustomerService}" var="cs">
                            <option value="${cs.id}" >${cs.name}</option>
                        </c:forEach>
                    </c:if>
                </select>
                <span class="input-group-addon hide float_pic_list_item_http" id="content_float_pic_type_http1">http://</span>
                <input type="text" name="imgLinkTypeValue1" class="form-control hide float_pic_list_item_link_value" value="">
                <span class="input-group-addon bdn _editTags">
                    <a href="javascript:void(0)" name="float_pic_list_item_placeholder"
                       class="variable ${not empty command.floatPicItem.imgLinkType && (command.floatPicItem.imgLinkType == 'link') ? '' : 'hide'}">
                       ${views.operation['MassInformation.step3.website']}<span>{website}</span>
                    </a>
                </span>
                <input type="hidden" name="itemList[1].imgLinkValue" class="float_pic_list_item_link_type_value" value="${SiteCustomerService[0].id}"/>
                <span class="input-group-addon bdn ${vs.index>0 ? 'hide' : '' } setting">
                    <a href="/param/siteParam.html?hasReturn=true&index=li_top_1" nav-target="mainFrame" class="m-l-sm">${views.column['CttFloatPic.image.setting']}</a>
                </span>
            </div>
        </li>
    </div>
    <img id="imgSize" style="display: none;" />
    <!--//endregion your codes 3-->
</form:form>
</body>
<!--//region your codes 4-->
<soul:import res="site/content/floatPic/FloatEdit"/>

<!--//endregion your codes 4-->
</html>