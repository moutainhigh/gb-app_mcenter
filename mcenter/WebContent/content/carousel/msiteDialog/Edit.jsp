<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-7-29
  Time: 上午10:50
--%>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.CttCarouselVo"--%>
<%--@elvariable id="languageList" type="java.util.Map<java.lang.String,so.wwb.gamebox.model.company.site.po.SiteLanguage>"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
    <link href="${resComRoot}/themes/${curTheme}/toastr/toastr.min.css" rel="stylesheet">
    <!-- Gritter -->
    <link href="${resComRoot}/themes/${curTheme}/gritter/jquery.gritter.css" rel="stylesheet">
    <link href="${resComRoot}/themes/${curTheme}/iconfontuploadImageInputstom.css" rel="stylesheet">
    <link href="${resComRoot}/themes/${curTheme}/chosen/chosen.css" rel="stylesheet">
    <link href="${resComRoot}/themes/${curTheme}/nouslider/jquery.nouislider.css" rel="stylesheet">
    <link href="${resComRoot}/themes/${curTheme}/banner/elastislide.css" rel="stylesheet"/>
    <link href="${resComRoot}/themes/${curTheme}/switchery/switchery.css" rel="stylesheet">
    <link href="${resComRoot}/themes/${curTheme}/cropper/cropper.min.css" rel="stylesheet">
    <%--<link href="${resComRoot}/themes/${curTheme}/bootstrap-checkbox/bootstrap-checkbox.css" rel="stylesheet">--%>
    <link href="${resComRoot}/themes/${curTheme}/chosen/chosen.css" rel="stylesheet">
</head>
<body>
<form:form>
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <input input type="hidden" id="oldContent" name="oldContent">
    <input input type="hidden" name="result.type" value="${command.search.type}">
    <input type="hidden" id="">
    <div class="modal-body">
        <div class="form-group">
            <label>${views.content['carousel.showTime']}：<span class="co-red m-l-sm">*</span>
                <c:if test="${not empty command.result.id}">
                    <%--<span class="co-yellow">(待使用)</span>--%>
                    <c:choose>
                        <c:when test="${command.result.status}">
                            <%--停用--%>
                            <span>(${dicts.content.carousel_state['using']})</span>
                        </c:when>
                        <c:when test="${command.now < command.result.startTime}">
                            <%--未使用--%>
                            <span>（${dicts.content.carousel_state['wait']}）</span>
                        </c:when>
                        <c:when test="${command.now > command.result.endTime}">
                            <%--过期--%>
                            <span class="co-grayc2">（${dicts.content.carousel_state['expired']}）</span>
                        </c:when>
                        <c:otherwise>
                            <span class="co-green">（${dicts.content.carousel_state['stop']}）</span>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </label>
            <div class="input-daterange input-group" id="datepicker" style="width:100%">
                <gb:dateRange format="${DateFormat.DAY_SECOND}" style="width:160px" useRange="true"
                              opens="right" minDate="${command.now}"
                              startName="result.startTime" endName="result.endTime"
                              startDate="${command.result.startTime}" endDate="${command.result.endTime}"></gb:dateRange>
            </div>
        </div>
        <div class="form-group">
            <label class="al-right">广告类型：</label>
            <div class="col-sm-3">
                <input type="radio" class="i-checks" name="result.contentType" value="1"
                ${command.result.contentType=='1' || empty command.result.contentType ? 'checked' : ''}>图片
                <input type="radio" class="i-checks" name="result.contentType" value="2"
                ${command.result.contentType=='2' ? 'checked' : ''}>文字
            </div>
        </div>
        <div class="form-group ${command.result.contentType=='2'?'hide':''}" id="showModel">
            <div class="col-sm-3">
                <input type="checkbox" class="i-checks" name="result.showModel" value="1" ${command.result.showModel=='1' ? 'checked' : ''}>
                <span>启用透明PNG图片模式</span>
                <span style="font-size: 14px;margin-left: 50px;color: #9c9c9c;">启用后以纯图片形式展示弹窗广告，无边框</span>
            </div>
        </div>
        <div class="form-group ${command.result.contentType=='2'?'hide':''}" id="content_picture_link">
            <label>${views.column['VCttCarousel.link']}：</label>
            <div class="clearfix col-sm-8">
                <input type="text" class="form-control" style="width: 340px; display: inline-block;"
                       id="url" name="result.link" value="${command.result.link}"
                       placeholder="${views.content['carousel.pictureLinkTips']}" />
                <span class="input-group-addon bdn _editTags" style="display: inline-block;">
                    <a href="javascript:void(0)" name="float_pic_list_item_placeholder"
                       class="variable">
                            ${views.operation['MassInformation.step3.website']}<span>{website}</span>
                    </a>
                </span>
            </div>
        </div>

    <div class="clearfix save lgg-version">
        <c:forEach items="${command.siteLanguages}" var="p" varStatus="status">
            <a id="tag${status.index+1}" aria-expanded="${index.index==0?'true':'false'}" name="tag" tagIndex="${status.index+1}"
               class="${status.index=='0'?'current':''} a_${p.language} tag${status.index+1} tabLanguage"
               tagIndex="${status.index+1}" siteSize="" href="javascript:void(0)" local="${p.language}">${dicts.common.local[p.language]}
                <span id="span${p.language}">
                        ${status.index=='0'?views.setting['switch.CloseReminder.editing']:typeI18nMap.get(p.language).name.length()>0&&typeI18nMap.get(p.language).cover.length()>0?views.setting['switch.CloseReminder.edited']:views.setting['switch.CloseReminder.unedited']}
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
                <button class="btn btn-link dropdown-toggle fzyx" data-toggle="dropdown">
                        ${views.setting['serviceTrems.copy']}&nbsp;&nbsp;<span class="caret"></span>
                </button>
                <ul class="dropdown-menu pull-right">
                    <c:forEach items="${command.siteLanguages}" var="p" varStatus="status"><%--typeI18nMap.get(p.language).name||--%>
                        <li ${empty typeI18nMap.get(p.language).name||status.index==0?"hidden":""} id="option${p.language}" class="temp">
                            <a class="co-gray copy" href="javascript:void(0)" local="${p.language}">${dicts.common.local[p.language]}</a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>

        <div class="hfsj-wrap">
            <c:forEach var="p" items="${command.siteLanguages}" varStatus="index">
                <c:forEach var="carousel" items="${command.cttCarouselI18n}" varStatus="status">
                    <c:if test="${carousel.language==p.language}">
                        <input type="hidden" name="cttCarouselI18n[${index.index}].id" value="${carousel.id}">
                        <input type="hidden" name="cttCarouselI18n[${index.index}].carouselId" value="${carousel.carouselId}">
                        <input type="hidden" name="cttCarouselI18n[${index.index}].language" value="${carousel.language}">
                        <div class="content${p.language} ann tab-pane" style="display: ${index.index=='0'?'':'none'}" lang="${p.language}">
                            <div class="form-group">
                                <div class="clearfix ${command.result.contentType=='2'?'hide':''} content_picture_title">
                                    <label>${views.column['CttCarouselI18n.name']}：</label>
                                </div>
                                <div class="clearfix ${command.result.contentType=='2'?'':'hide'} content_word_title">
                                    <label>弹窗标题：</label>
                                </div>
                                <div>
                                    <input type="text" placeholder="" tt="${p.language}" class="form-control field carouselNameVal${p.language} _edit"
                                           maxlength="40"   name="cttCarouselI18n[${index.index}].name" value="${carousel.name}">
                                </div>
                            </div>

                            <div class="form-group ${command.result.contentType=='2'?'hide':''} content_picture">
                                <label>${views.content['carousel.uploadPicture']}：</label>
                                <span class="m-l co-grayc2">${views.content['carousel.uploadPictureTips']}</span>
                                <div class="form-group m-b-sm">
                                    <div id="carouselI18nsCover${index.index}">
                                        <c:if test="${not empty carousel.cover}">
                                            <img id="carouselCoverImg${p.language}" src="${soulFn:getThumbPath(domain, carousel.cover,500,500)}" class="logo-size-h100" style="margin: 10px 0; width: auto;height: 250px;"/>
                                        </c:if>
                                    </div>
                                    <input id="activityContentFile" class="file " type="file" accept="image/*" name="carouselCoverFile"
                                           target="cttCarouselI18n[${index.index}].cover" value="${carousel.cover}">
                                    <input type="hidden" class="carouselCoverVal${p.language} _edit cover" bbb="${index.index}" tt="${p.language}"
                                           name="cttCarouselI18n[${index.index}].cover" id="carouselCover${index.index}" value="${carousel.cover}">
                                </div>
                            </div>
                            <div class="form-group ${command.result.contentType=='2'?'':'hide'} content_word_title">
                                <div class="clearfix">
                                    <label>弹窗内容：</label>
                                    <div>
                                        <textarea class="_editArea${index.index} contents_textarea word_content" bbb="${index.index}" id="editContent${index.index}"
                                                  ueditorId="editContent${index.index}" name="cttCarouselI18n[${index.index}].content">
                                                ${carousel.content}
                                        </textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </c:forEach>
        </div>
    </div>
    <div class="modal-footer">
        <soul:button precall="preSave" tag="button" target="saveCarousel" callback="" cssClass="btn btn-filter" text="${views.common['OK']}" opType="function"></soul:button>
        <soul:button target="closePageConfirm" tag="button" opType="function" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter"></soul:button>
    </div>
    <%--隐藏域--%>
    <input type="hidden" value="${command.titleMaxLength}" id="titleMaxLength">
    <form:hidden path="search.id"/>
    <form:hidden path="result.id"/>
    <input type="hidden" value="${command.userName}" id="userName">
    <script>
        var languageCounts = ${fn:length(languageList)};
    </script>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/content/carousel/msiteDialog/Edit"/>
</html>