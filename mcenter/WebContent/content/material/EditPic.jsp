<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<%@ include file="/include/include.head.jsp" %>
<form:form>
    <div id="validateRule" style="display: none">${validateRule}</div>
    <gb:token/>
    <div class="modal-body">

        <div class="clearfix save lgg-version">

            <c:forEach items="${siteLang}" var="p" varStatus="status">
                <a id="tag${status.index+1}" aria-expanded="${index.index==0?'true':'false'}" name="tag" tagIndex="${status.index+1}"
                   class="${status.index=='0'?'current':''} a_${p.language} tag${status.index+1} tabLanguage"
                   tagIndex="${status.index+1}" siteSize="" href="javascript:void(0)" local="${p.language}">${dicts.common.local[p.language]}
                    <span id="span${p.language}">
                            ${p.isEdit?views.setting['switch.CloseReminder.edited']:views.setting['switch.CloseReminder.unedited']}
                    </span>
                </a>
            </c:forEach>
            <input type="hidden" name="curLanguage" id="curLanguage" value="1">
            <span class="more">
                <soul:button target="changeCurrentLang" tag="a" opType="function" cssClass="next_lang" text="">
                    <i class="fa fa-angle-double-right"></i>
                </soul:button>
            </span>
            <div class="pull-right inline">
                <div class="btn-group">

                    <button class="btn btn-link dropdown-toggle fzyx" data-toggle="dropdown">${views.setting['serviceTrems.copy']}&nbsp;&nbsp;<span class="caret"></span></button>
                    <ul class="dropdown-menu pull-right">
                        <c:forEach items="${siteLang}" var="p" varStatus="status">
                            <li style="display: ${status.index==0 || empty picMap.get(p.language).title?"none":""}" id="option${p.language}" class="temp">
                                <a class="co-gray copy" href="javascript:void(0)" local="${p.language}">${dicts.common.local[p.language]}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>

        <div class="hfsj-wrap">
            <c:forEach begin="0" end="${fn:length(siteLang)}" var="p" items="${siteLang}" varStatus="index">
                <c:if test="${fn:length(listVo.result)>0}">
                    <c:forEach begin="0" end="${fn:length(listVo.result)}" var="item" items="${listVo.result}" varStatus="status">
                        <c:if test="${item.language==p.language}">
                            <div class="content${p.language} ann tab-pane" style="display: ${index.index=='0'?'':'none'}" lang="${p.language}">
                                <input type="hidden" name="cttMaterialPicList[${index.index}].language" value="${item.language}">
                                <input type="hidden" name="cttMaterialPicList[${index.index}].groupCode" value="${item.groupCode}">
                                <input type="hidden" name="cttMaterialPicList[${index.index}].id" value="${item.id}">
                                <div class="form-group m-b-xs">
                                    <label class="col-sm-3 al-right line-hi34 ft-bold">${views.content['material.name']}：</label>
                                    <div class="col-sm-5">
                                        <input type="text" lang="${p.language}" maxlength="20" placeholder="" class="title form-control field picTitleVal${p.language}" name="cttMaterialPicList[${index.index}].title" value="${item.title}">
                                    </div>
                                </div>

                                <div class="form-group clearfix">
                                    <label class="col-sm-3 ft-bold al-right line-hi34">${views.content['material.uploadPicture']}:</label>
                                    <div class="col-sm-5">
                                        <input class="file" type="file" id="picFile${index.index}" multiple="" accept="image/jpg,image/jpeg,image/gif,image/png" target="cttMaterialPicList[${index.index}].pic">
                                    </div>
                                    <div class="col-sm-5">${views.content['material.uploadPictureTips']}</div>
                                </div>
                                <div class="col-sm-5 clearfix m-t-sm">
                                    <div class="input-agroup">
                                        <img src="${soulFn:getThumbPath(domain, item.pic,500,500)}" width="500" height="500" id="picPicImg${p.language}" name="picPicImg${index.index}"></div>
                                    <input type="hidden" id="picPath${index.index}" lang="${p.language}" class="materialPic field picPicVal${p.language}" name="cttMaterialPicList[${index.index}].pic" value="${item.pic}"/>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </c:if>
                <c:if test="${fn:length(listVo.result)==0}">
                    <div class="content${p.language} ann tab-pane" style="display: ${index.index=='0'?'':'none'}" lang="${p.language}">
                        <input type="hidden" name="cttMaterialPicList[${index.index}].language" value="${p.language}">
                        <div class="form-group m-b-xs">
                            <label class="col-sm-3 al-right line-hi34 ft-bold">${views.content['material.name']}:</label>
                            <div class="col-sm-5">
                                <input type="text" lang="${p.language}" placeholder="" class="title form-control field picTitleVal${p.language}" name="cttMaterialPicList[${index.index}].title">
                            </div>
                        </div>

                        <div class="form-group clearfix">
                            <label class="col-sm-3 ft-bold al-right line-hi34">${views.content['material.uploadPicture']}:</label>
                            <div class="col-sm-5">
                                <input class="file" type="file" id="picFile${index.index}" lang="${p.language}"
                                       multiple="" accept="image/jpg,image/jpeg,image/gif,image/PNG,image/JPG,image/JPEG,image/GIF,image/PNG"
                                       target="cttMaterialPicList[${index.index}].pic">
                            </div>
                            <div class="col-sm-5">${views.content['material.uploadPictureTips']}</div>
                        </div>
                        <div class="col-sm-5 clearfix  m-t-sm" style="display: none;">
                            <div class="input-group"><img src="${soulFn:getThumbPath(domain, item.pic,500,500)}" width="500" height="500" id="picPicImg${p.language}" name="picPicImg${index.index}"></div>
                            <input type="hidden" id="picPath${index.index}" lang="${p.language}" class="materialPic field picPicVal${p.language}" name="cttMaterialPicList[${index.index}].pic"/>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>
    <div class="modal-footer">
        <%--<soul:button precall="_validateForm" tag="button" opType="function" target="saveCttText" cssClass="btn btn-filter" text="${views.content_auto['确认']}">${views.content_auto['确认']}</soul:button>--%>
        <soul:button tag="button" cssClass="btn btn-filter" text="${views.common['OK']}" opType="ajax" target="${root}/cttMaterialText/saveCttPic.html" precall="uploadFile"
                     post="getCurrentFormData" callback="saveCallbak"/>
        <soul:button target="closePage" tag="button" opType="function" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter">${views.common['cancel']}</soul:button>
    </div>
    <input type="hidden" value="${maxLang}" id="maxLang">
    <input type="hidden" value="${fn:length(siteLang)}" id="langLen">
    <%--<input type="hidden" name="groupCode" value="${groupCode}">--%>
</form:form>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/content/material/EditMaterialPic"/>