<%--@elvariable id="command" type="so.wwb.gamebox.model.company.sys.vo.SysSiteVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

    <%--<form:hidden path="result.id" id="mstId"/>--%>
    <%--<input type="hidden" value="${command.result.id}" id="mstId" name="result.id">--%>
    <div id="validateRule" style="display: none">${command.validateRule}</div>

    <div class="clearfix">
        <div class="col-lg-6 site-switch">
            <h3>${views.setting['basic.webSite']}</h3>

            <div class="content line-hi34 clearfix">
                <div class="clearfix">
                    <label class="ft-bold">${views.setting_auto['站点名称']}：</label>
                    <c:forEach var="lang" items="${command.siteLanguageList}">
                        <c:if test="${lang.status=='1'}">
                            <div class="input-group date"><span class="input-group-addon bg-gray"><div
                                    style="width: 100px;text-align: right">${dicts.common.local[lang.language]}</div></span>
                                <input type="text" class="form-control"
                                       value="${command.siteI18nMap.get(lang.language).value}" disabled="">
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
                <div class="clearfix">
                    <label class="ft-bold">${views.setting['basic.webSite']}：</label>
                    <span>${command.result.webSite}</span>
                        <%--<a class="m-l" href="javascript:void(0)">${views.setting['basic.seoSet']}</a>--%>
                </div>
                <div class="clearfix">
                    <label class="ft-bold">${views.setting['basic.webSite.openingTime']}：</label>
                    <span><fmt:formatDate value="${command.result.openingTime}" type="date"
                                          pattern="${DateFormat.DAY_SECOND}"/></span>


                    <span class="m-l co-grayc2">${views.setting['basic.webSite.ago']}
                            <c:if test="${command.year>0}">
                                ${command.year}${views.setting['basic.webSite.year']}
                            </c:if>
                            <c:if test="${command.month>0}">
                                ${command.month}${views.setting['basic.webSite.month']}
                            </c:if>
                            <c:if test="${command.month==0&&command.year==0}">
                                ${command.day}${dicts.common.time['day']}
                            </c:if>

                    </span>
                </div>
                <div class="clearfix m-b">
                    <label class="ft-bold pull-left">${views.setting['basic.webSite.useLogo']}：</label>
                    <c:set var="logo" value="<%=SessionManager.getLogo()%>"/>
                    <img src="${soulFn:getThumbPath(domain,logo,66,24)}">
                    <a class="m-l" href="/cttLogo/list.html?hasReturn=true"
                       nav-target="mainFrame">${views.setting['basic.webSite.logoSet']}</a>
                </div>
            </div>
        </div>
        <div class="col-lg-6 site-switch">
            <h3>${views.setting['basic.useLanguage']}</h3>
            <ul class="content clearfix">
                <li class="clearfix">
                    <c:set value="${ fn:split(dicts.common.language[command.result.mainLanguage], '#') }"
                           var="img"/>
                    <span class="m-r-sm control_state_1"><img class="m-r-sm"
                                                              src="${resRoot}/${img[1]}">${dicts.common.nations[command.result.mainLanguage]}</span>
                    <span class="co-grayc2 m-r-sm fs12 control_state_2">
                            ${views.common.local[command.result.mainLanguage]}
                    </span>
                    <span class="co-grayc2">${views.setting['basic.useLanguage.mainLanguage']}</span>
                </li>


                <c:forEach items="${command.siteLanguageList}" var="lang" varStatus="statu">
                    <c:if test="${command.result.mainLanguage!=lang.language}">
                        <li class="clearfix  ${statu.index>3?"language":""}"
                            style="display: ${statu.index>3?"none":""}">
                            <span class="m-r-sm control_state_1"><img class="m-r-sm"
                                                                      src="${resRoot}/${lang.logo}">${dicts.common.nations[lang.language]}</span>
                            <span class="co-grayc2 m-r-sm fs12 control_state_2">${dicts.common.local[lang.language]}</span>
                            <span class="${lang.status=="1"?"co-green":"co-grayc2"} fs12"
                                  id="languageStatus${statu.index}">${lang.transLangByLocale}</span>
                            <span class="pull-right"><input
                                    address="/param/changeLanguage.html?result.id=${lang.id}"
                                    statusId="languageStatus${statu.index}" type="checkbox" data-size="mini"
                                    name="my-checkbox"
                                    mold="language"
                                    status="${lang.status}"  ${lang.status=="1"?"checked":""}></span>
                        </li>
                    </c:if>
                </c:forEach>
                <li>
                    <a ${command.siteLanguageList.size()>4?"":"hidden=hidden"} class="co-gray6 more"
                                                                               href="javascript:void(0)"
                                                                               className="language"
                                                                               moreId="#langMore"><span
                            id="langMore">${views.setting['basic.useLanguage.exhibitionlanguage']}</span> <span
                            class="caret"></span></a>
                </li>
            </ul>
        </div>
    </div>
    <div class="col-lg-6 site-switch" id="siteInfoDiv">
        <h3>${views.setting_auto['站点信息']}</h3>
        <input type="hidden" name="siteInfo.id" value="${siteInfo.id}">
        <div class="content clearfix" style="padding-top: 10px">

            <div id="resource">
                <div class="modal-body">
                    <div class="clearfix save lgg-version">
                        <c:forEach items="${command.siteLanguageList}" var="p" varStatus="status">
                            <a id="tag${status.index+1}" aria-expanded="${index.index==0?'true':'false'}" name="tag" tagIndex="${status.index+1}" class="${status.index=='0'?'current':''} a_${p.language} tag${status.index+1}"
                               tagIndex="${status.index+1}" siteSize="${siteTile.size()}"
                               href="javascript:void(0)" local="${p.language}">${dicts.common.local[p.language]}</a>
                        </c:forEach>
                        <div class="pull-right inline">
                            <div class="btn-group">
                                <button type="button" class="btn btn-link dropdown-toggle fzyx" data-toggle="dropdown">${views.setting['serviceTrems.copy']}&nbsp;&nbsp;<span class="caret"></span></button>
                                <ul class="dropdown-menu pull-right">
                                    <c:forEach items="${command.siteLanguageList}" var="p" varStatus="status">
                                        <li id="option${p.language}" class="temp"><a class="co-gray copy" href="javascript:void(0)" local="${p.language}" style="height: 100%; text-align: center; padding-top: 12px;">${dicts.common.local[p.language]}</a></li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="">
                            <%--标题--%>
                        <c:set var="seoIndex" value="0" />
                        <c:forEach items="${command.siteLanguageList}" var="lang" varStatus="status">

                            <div tt="${lang.language}" style="display: ${status.index=='0'?'':'none'};width: 750px;margin-top: 30px;" name="result[${status.index}].content" class="clearfix contentSource ann m-b content${status.index} content${lang.language} contentVal${lang.language}" >
                                <input type="hidden"  name="siteI18ns[${seoIndex}].id" value="${siteTile.get(lang.language).id}">
                                <input type="hidden"  name="siteI18ns[${seoIndex}].locale" value="${lang.language}">
                                <div class="clearfix m-b left-arrow">
                                    <div class="ft-bold pull-left" style="width: 100px;text-align: right;margin-top: 7px;">
                                        ${views.setting['basic.webSite.title']}：
                                    </div>
                                    <div class="col-xs-5">
                                        <input type="text" name="siteI18ns[${seoIndex}].value" value="${siteTile.get(lang.language).value}" placeholder="${views.setting_auto['站点标题']}" class="form-control siteTitle${lang.language}" maxlength="50">
                                    </div>
                                </div>
                                <c:set var="seoIndex" value="${seoIndex+1}" />
                                <input type="hidden"  name="siteI18ns[${seoIndex}].id" value="${siteKeywords.get(lang.language).id}">
                                <input type="hidden"  name="siteI18ns[${seoIndex}].locale" value="${lang.language}">
                                <div class="clearfix m-b">
                                    <div class="ft-bold pull-left line-hi34" style="width: 100px;text-align: right;">
                                        ${views.setting['basic.webSite.keywords']}：
                                    </div>
                                    <div class="col-xs-5">
                                        <textarea  name="siteI18ns[${seoIndex}].value" class="form-control siteKeywords${lang.language}" placeholder="${views.setting_auto['关键词1']}">${siteKeywords.get(lang.language).value}</textarea>
                                    </div>
                                </div>
                                <c:set var="seoIndex" value="${seoIndex+1}" />
                                <input type="hidden"  name="siteI18ns[${seoIndex}].id" value="${siteDescription.get(lang.language).id}">
                                <input type="hidden"  name="siteI18ns[${seoIndex}].locale" value="${lang.language}">
                                <div class="clearfix m-b">
                                    <div class="ft-bold pull-left line-hi34" style="width: 100px;text-align: right;">
                                        ${views.setting['basic.webSite.description']}：
                                    </div>
                                    <div class="col-xs-5">
                                        <textarea  name="siteI18ns[${seoIndex}].value" class="form-control siteDescription${lang.language}" placeholder="${views.setting_auto['站点描述']}">${siteDescription.get(lang.language).value}</textarea>
                                    </div>
                                </div>
                                <c:set var="seoIndex" value="${seoIndex+1}" />
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <c:set var="siteLang" value="${command.siteLanguageList}" />
                <input type="hidden" placeholder="" class="form-control m-b" name="langSize" value="${siteLang.size()}">
                <!--//region your codes 3-->
                <div class="modal-footer">
                    <soul:button cssClass="btn btn-filter" text="${views.common['save']}" opType="ajax"
                                 dataType="json"
                                 target="${root}/siteI18n/batchSaveSeo.html"
                                 precall="" post="getSiteInfoFormData"
                                 callback="isRefresh"/>
                </div>
            </div>

        </div>
    </div>
    <div class="clearfix">
        <div class="col-lg-6 site-switch">
            <h3>${views.setting['basic.operateArea']}</h3>
            <ul class="content clearfix">
                <c:forEach items="${command.siteOperateAreaList}" var="area" varStatus="statu">
                    <li class="clearfix ${statu.index>4?"area":""}"
                        style="display: ${statu.index>4?"none":""}">
                        <span>
                            <%--<img class="m-r-sm" src="${resRoot}/${dicts.common.img[area.code]}">--%>
                            <div class="flag">
                                <div id="region_${area.code.toLowerCase()}"></div>
                            </div>
                            ${dicts.region.region[area.code]}
                        </span>
                        <span class="${area.status=="1"?"co-green":"co-grayc2"} m-r-sm fs12 status"
                              id="areaStatus${statu.index}">${dicts.setting.site_operate[area.status]}</span>
                        <span class="pull-right"><input
                                address="/param/changeArea.html?result.id=${area.id}"
                                type="checkbox"
                                promptMain="${dicts.common.nations[area.code]}"
                                statusId="areaStatus${statu.index}" data-size="mini"
                                name="my-checkbox" mold="area"
                                area="${area.code}" ${area.status=="1"?"checked":""}></span>
                    </li>
                </c:forEach>
                <li>
                    <a ${command.siteOperateAreaList.size()>5?"":"hidden=hidden"} class="co-gray6 more"
                                                                                  href="javascript:void(0)"
                                                                                  className="area"
                                                                                  moreId="#areaMore"><span
                            id="areaMore">${views.setting['basic.operateArea.exhibitionarea']} </span><span
                            class="caret"></span></a>
                </li>
            </ul>
        </div>
        <div class="col-lg-6 site-switch">
            <h3>${views.setting['basic.useCurrency']}</h3>
            <ul class="content clearfix">
                <li class="clearfix">
                    <span class="m-r-sm control_state_2">${dicts.common.currency[command.result.mainCurrency]}</span>
                    <span class="m-r-sm control_state_2">${dicts.common.conpany[command.result.mainCurrency]}</span>
                    <span class="co-grayc2 m-r-sm control_state_2" data-toggle="tooltip"
                          data-placement="right"
                          title="1${command.result.mainCurrency} : 1${command.result.mainCurrency}">1：1</span>
                    <span class="co-red3 m-r-sm">${views.setting['basic.useCurrency.mainCurrency']}</span>
                </li>
                <c:forEach items="${command.siteCurrencyList}" var="curry" varStatus="statu">
                    <li class="clearfix  ${statu.index>3?"currency":""} "
                        style="display: ${statu.index>3?"none":""}">
                        <span class="m-r-sm control_state_2">${dicts.common.currency[curry.code]}</span>
                        <span class="m-r-sm control_state_2">${dicts.common.conpany[curry.code]}</span>
                            <%--<span class="m-r-sm">GBP</span>--%>
                            <span class="co-grayc2 m-r-sm control_state_2" data-toggle="tooltip"
                                  data-placement="right"
                                  title=" 1${curry.code}:${soulFn:formatRate(curry.rate)}${command.result.mainCurrency}">1:${soulFn:formatRate(curry.rate)}</span>
                            <span class="${curry.status=="1"?"co-green":"co-grayc2"} m-r-sm fs12"
                                  id="curryStatus${statu.index}">${dicts.setting.site_operate[curry.status]}</span>
                        <span class="pull-right">
                            <input  ${curry.playerNum>0&&curry.status=="1"?'disabled':""} type="checkbox"
                                                                                          status="${curry.status}"
                                                                                          address="/param/changeCurrency.html?result.id=${curry.id}"
                                                                                          playerNum="${curry.playerNum}"
                                                                                          statusId="curryStatus${statu.index}"
                                                                                          data-size="mini"
                                                                                          name="my-checkbox"
                                                                                          mold="curry"
                                                                                          code="${curry.code}"  ${curry.status=="1"?"checked":""}>
                        </span>
                    </li>
                </c:forEach>
                <li>
                    <a ${command.siteCurrencyList.size()>4?"":"hidden=hidden"} class="co-gray6 more"
                                                                               href="javascript:void(0)"
                                                                               className="currency"
                                                                               moreId="#currMore"><span
                            id="currMore">${views.setting['basic.useCurrency.exhibitioncurrency']} </span><span
                            class="caret"></span></a>
                </li>
                <li>
                    ${views.setting_auto['取款方式']}：${views.setting_auto['现金取款']}
                   <%-- <span class="pull-right">
                        <input type="checkbox" data-size="mini" model="withdraw" name="my-checkbox"  ${withdrawCashParam.paramValue=="true"?"checked":""}>
                    </span>--%>
                    <span class="${withdrawCashParam.paramValue=="true"?"co-green":"co-grayc2"} m-r-sm fs12 status" style="margin-left: 10px">${withdrawCashParam.paramValue=="true"?'开启':'关闭'}</span>
                </li>
                <li>
                    ${views.setting_auto['取款方式']}：${views.setting_auto['bitCoin取款']}
                    <%-- <span class="pull-right">
                         <input type="checkbox" data-size="mini" model="withdraw" name="my-checkbox" ${withdrawBitcoinParam.paramValue=="true"?"checked":""}>
                     </span>--%>
                    <span class="${withdrawBitcoinParam.paramValue=="true"?"co-green":"co-grayc2"} m-r-sm fs12 status" style="margin-left: 10px">${withdrawBitcoinParam.paramValue=="true"?'开启':'关闭'}</span>

                </li>
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
        <div class="col-lg-6 site-switch">
            <h3>${views.setting['basic.otherSet']}</h3>

            <div class="content line-hi34 clearfix">
                <div class="clearfix">
                    <c:set var="dd" value="<%= SessionManager.getTimeZone().getID() %>"/>
                    <label class="ft-bold">${views.setting['basic.otherSet.useTimeZone']}：</label>
                        ${fn:substring(dd,0 ,dd.length()-3 )}
                    <span> </span>
                    <span>${soulFn:formatDateTz(dateQPicker.now, DateFormat.DAY_SECOND, timeZone)}</span>
                </div>
                <div class="clearfix">
                    <label class="ft-bold">${views.setting['basic.otherSet.postfix']}：</label>
                    <span>${command.result.postfix}</span>
                </div>
                <div class="clearfix">
                    <label class="ft-bold">${views.setting['basic.otherSet.trafficStatistics']}：<span
                            data-content="${views.setting['trafficStatistics.prompt']}" data-placement="top"
                            data-trigger="focus"
                            data-toggle="popover" data-container="body" role="button"
                            class="help-popover m-l-sm" tabindex="0"><i class="fa fa-question-circle"></i></span></label>
                    <textarea class="form-control m-b"
                              name="result.trafficStatistics">${command.result.trafficStatistics}</textarea>
                </div>
                <div class="modal-footer">
                    <soul:button cssClass="btn btn-filter" text="${views.common['save']}" opType="ajax"
                                 dataType="json" target="${root}/param/saveTrafficStatistics.html"
                                 precall="staticValidateForm" post="getStaticValidateForm" callback="saveCallbak"/>
                </div>
            </div>
        </div>
    </div>
    <div class="clearfix">
        <div id="pcCustomService" class="col-lg-6 site-switch">
            <h3>${views.setting['PC端客服参数']}</h3>
            <input type="hidden" name="pc.id" value="${pcCustomerService.id}">
            <div class="content clearfix" style="padding-top: 10px">
                <div class="clearfix m-b">
                    <div class="ft-bold pull-left" style="width: 100px;text-align: right;">${views.setting_auto['名称']}：</div>
                    <div class="col-xs-5"><input type="text" name="pc.name"
                                                 value="${pcCustomerService.name}"
                                                 class="form-control" maxlength="20"></div>
                </div>
                <div class="clearfix m-b">
                    <div class="ft-bold pull-left line-hi34" style="width: 100px;text-align: right;">
                        ${views.setting_auto['在线客服参数']}：
                    </div>
                    <div class="col-xs-5">
                        <textarea  name="pc.parameter" class="form-control">${pcCustomerService.parameter}</textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <soul:button cssClass="btn btn-filter" text="${views.common['save']}" opType="ajax"
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
                    <div class="ft-bold pull-left line-hi34" style="width: 100px;text-align: right;">${views.setting_auto['名称']}：
                    </div>
                    <div class="col-xs-5"><input type="text" name="mobile.name"
                                                 value="${mobileCustomerService.name}"
                                                 class="form-control" maxlength="20"></div>
                </div>
                <div class="clearfix m-b">
                    <div class="ft-bold pull-left line-hi34" style="width: 100px;text-align: right;">
                        ${views.setting_auto['在线客服参数']}：
                    </div>
                    <div class="col-xs-5">
                        <textarea name="mobile.parameter" class="form-control">${mobileCustomerService.parameter}</textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <soul:button cssClass="btn btn-filter" text="${views.common['save']}" opType="ajax"
                                 dataType="json"
                                 target="${root}/siteCustomerService/mobile.html"
                                 precall="validMobileCustomerService"
                                 post="getMobileFormData" callback="saveCallbak"/>
                </div>
            </div>
        </div>
    </div>
    <div class="clearfix">
        <div id="appDownloadDomain" class="col-lg-6 site-switch">
            <h3>${views.setting_auto['APP下载域名设置']}</h3>
            <input type="hidden" name="mobile.id" value="${mobileCustomerService.id}">
            <div class="content clearfix" style="padding-top: 10px">
                <div class="clearfix m-b">
                    <div class="ft-bold pull-left line-hi34" style="width: 100px;text-align: right;">
                        ${views.setting_auto['APP下载域名']}
                    </div>
                    <div class="col-xs-5">
                        <gb:select name="result.paramValue" value="${domain}" list="${appDomain}" listKey="domain" listValue="domain"/>
                    </div>
                </div>
                <div class="modal-footer">
                    <soul:button cssClass="btn btn-filter" text="${views.common['save']}" opType="ajax"
                                 dataType="json"
                                 target="${root}/siteCustomerService/appDomain.html"
                                 precall="validMobileCustomerService"
                                 post="getAppDomainFormData" callback="saveCallbak"/>
                </div>
            </div>
        </div>
    </div>