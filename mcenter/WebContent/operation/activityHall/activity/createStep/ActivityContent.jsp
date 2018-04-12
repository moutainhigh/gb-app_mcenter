<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.VActivityMessageListVo"--%>
<%--@elvariable id="languageList" type="java.util.Map<java.lang.String,so.wwb.gamebox.model.company.site.po.SiteLanguage>"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 3-->
<div class="row" id="step1">
    <div class="position-wrap clearfix">
        <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
        <span>${views.sysResource['运营']}&nbsp;&nbsp;/</span><span>${views.sysResource['活动管理']}</span>
        <soul:button target="goToLastPage" refresh="true"
                     cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
            <em class="fa fa-caret-left"></em>${views.common['return']}
        </soul:button>
        <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
    </div>
    <div class="col-lg-12">
        <!--活动内容第一步-->
        <div class="wrapper white-bg shadow">
            <%@include file="rule.include/ActivityStepTitle.jsp" %>
            <%@include file="rule.include/ActivityType.jsp" %>
            <div class="clearfix m-t-sm line-hi34" style="display: none;">
                <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.isDisplay']}：</label>
                <div class="col-sm-5">
                    <c:if test="${activityType.result.code ne 'money'}">
                        <label><input type="radio" value="true" name="activityMessage.isDisplay"
                                      class="i-checks" ${(empty activityMessageVo.result || activityMessageVo.result.isDisplay) eq 'true'? "checked":""}>${views.operation['Activity.step.isDisplay.true']}
                        </label>
                        <label><input type="radio" value="false" name="activityMessage.isDisplay"
                                      class="i-checks" ${activityMessageVo.result.isDisplay eq 'false'? "checked":""}>${views.operation['Activity.step.isDisplay.false']}
                        </label>

                    </c:if>
                    <c:if test="${activityType.result.code eq 'money'}">
                        <label><input type="radio" value="true" name="activityMessage.isDisplay"
                                      class="i-checks" ${(activityMessageVo.result.isDisplay) eq 'true'? "checked":""}>${views.operation['Activity.step.isDisplay.true']}
                        </label>
                        <label><input type="radio" value="false" name="activityMessage.isDisplay"
                                      class="i-checks" ${empty activityMessageVo.result || activityMessageVo.result.isDisplay eq 'false'? "checked":""}>${views.operation['Activity.step.isDisplay.false']}
                        </label>

                    </c:if>
                </div>
            </div>


            <c:if test="${activityType.result.code eq 'money'}">
                <div class="clearfix m-t-sm line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.operation['浮窗PC端展示']}</label>
                    <div class="col-sm-5">
                            <label><input type="radio" value="true" name="activityMessage.floatPicShowInPc"
                                          class="i-checks" ${(empty activityMessageVo.result || activityMessageVo.result.floatPicShowInPc) eq 'true'? "checked":""}>${views.operation['Activity.step.isDisplay.true']}
                            </label>
                            <label><input type="radio" value="false" name="activityMessage.floatPicShowInPc"
                                          class="i-checks" ${activityMessageVo.result.floatPicShowInPc eq 'false'? "checked":""}>${views.operation['Activity.step.isDisplay.false']}
                            </label>

                    </div>
                </div>

                <div class="clearfix m-t-sm line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.operation['浮窗手机端展示']}</label>
                    <div class="col-sm-5">
                        <label><input type="radio" value="true" name="activityMessage.floatPicShowInMobile"
                                      class="i-checks" ${(empty activityMessageVo.result || activityMessageVo.result.floatPicShowInMobile) eq 'true'? "checked":""}>${views.operation['Activity.step.isDisplay.true']}
                        </label>
                        <label><input type="radio" value="false" name="activityMessage.floatPicShowInMobile"
                                      class="i-checks" ${activityMessageVo.result.floatPicShowInMobile eq 'false'? "checked":""}>${views.operation['Activity.step.isDisplay.false']}
                        </label>

                    </div>
                </div>
            </c:if>

            <%--红包首页浮层弹窗--%>
            <c:if test="${activityType.result.code eq 'money'}">
                <div class="clearfix m-t-sm">
                    <label class="ft-bold col-sm-3 al-right"><span tabindex="0" class="" role="button"
                                                                   data-container="body" data-toggle="popover"
                                                                   data-trigger="focus" data-placement="top"
                                                                   data-html="true"
                                                                   data-content="${views.operation_auto['设置后']}">
                        <i class="fa fa-question-circle"></i>
                    </span>${views.operation_auto['首页浮层弹窗']}</label>
                    <div class="col-sm-5">
                        <c:choose>
                            <c:when test="${isPicType eq false}">
                                <a nav-target="mainFrame"
                                   href="/cttFloatPic/edit.html?id=${id}&editType=2">${views.operation_auto['已设置']}</a>
                                &nbsp;&nbsp;<span>${views.operation_auto['编辑抢红包浮动图']}</span>
                            </c:when>
                            <c:otherwise>
                                <a nav-target="mainFrame"
                                   href="/cttFloatPic/create.html?editType=1">${views.operation_auto['未设置']}</a>
                                &nbsp;&nbsp;<span>${views.operation_auto['设置抢红包浮动图']}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:if>
            <%--活动分类--%>
            <div class="clearfix m-t-sm">
                <label class="ft-bold col-sm-3 al-right line-hi34">${views.operation['Activity.step.activityClass']}：</label>
                <%@include file="content.include/Classification.jsp" %>
            </div>
            <%--活动时间--%>
            <div class="clearfix m-t-md">
                <label class="ft-bold col-sm-3 al-right line-hi34">${views.operation['Activity.step.activityTime']}：</label>
                <div class="col-sm-5">
                    <gb:dateRange format="${DateFormat.DAY_SECOND}" style="width:160px" useRange="true"
                                  startDate="${activityMessageVo.result.startTime}"
                                  endDate="${activityMessageVo.result.endTime}"
                                  startName="activityMessage.startTime"
                                  endName="activityMessage.endTime"></gb:dateRange>
                </div>

            </div>
            <%--活动内容 层级--%>
            <c:if test="${activityType.result.code eq 'content'}">
                <input type="hidden" name="rank" id="prank" value="${activityRule.rank}"/>
                <div class="clearfix m-t-md line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.rank']}：</label>
                    <span class="col-sm-5"><input type="checkbox" class="i-checks" id="levels"
                                                  name="activityRule.isAllRank" ${activityRule.isAllRank ?"checked":""}/>${views.operation['Activity.step.allRank']}</span>
                    <div class="col-sm-5 col-sm-offset-3" id="playerRank">
                        <c:forEach items="${playerRanks}" var="a">
                            <c:set value="${a.id}," var="b"></c:set>
                            <span class="m-r-sm"><input type="checkbox" class="i-checks" name="activityRule.rank"
                                                        value="${a.id}" ${fn:contains(playerRank,b)?"checked":""}>${a.rankName}</span>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
            <%--终端类型--%>
            <div class="clearfix m-t-sm line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation['Activity.step.isDisplay']}：</label>
                <div class="col-sm-5">
                    <a class="btn btn-filter" id="pc-terminal" href="javascript:void(0)">PC端</a>
                    <a class="btn btn-default btn-filter" id="mb-terminal" href="javascript:void(0)">手机端</a>
                </div>
            </div>
            <%--语言版本--%>
            <div class="pc terminal">
                <div class="form-group clearfix">
                    <div class="clearfix save lgg-version lang_label">
                        <ul class="nav nav-tabs">
                            <span class="col-sm-3"></span>
                            <c:forEach var="siteLang" items="${languageList}" varStatus="index">
                                <li class=" ${index.index==0?'active':''}">
                                    <a id="a_${index.index}" data-toggle="tab" href="#tab${index.index}"
                                       aria-expanded="${index.index==0?'true':'false'}">
                                            ${fn:substringBefore(dicts.common.language[siteLang.value.language], '#')}
                                        <span class="_editStatus${index.index}">
                                            <c:choose>
                                                <c:when test="${((not empty activityMessageI18ns['1'][siteLang.value.language].activityCover) and not empty activityMessageI18ns['1'][siteLang.value.language].activityAffiliated) and (not empty activityMessageI18ns['1'][siteLang.value.language].activityName) and (not empty activityMessageI18ns['1'][siteLang.value.language].activityDescription)}">
                                                    ${views.common['edited']}
                                                </c:when>
                                                <c:otherwise>
                                                    ${views.common['unedited']}
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </a>
                                </li>
                                <input type="hidden" name="activityMessageI18ns[${index.index}].activityVersion"
                                       value="${siteLang.value.language}">
                                <input type="hidden" name="activityMessageI18ns[${index.index}].activityTerminalType"
                                       value="1">
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="tab-content">
                        <c:forEach var="siteLang" items="${languageList}" varStatus="index">
                            <div id="tab${index.index}" class="tab-pane ${index.index==0?'active':''}">
                                <div class="clearfix m-t-md">
                                    <label class="ft-bold col-sm-3 al-right line-hi34">${views.operation['Activity.name']}：</label>
                                    <div class="col-sm-5"><input bbb="${index.index}" id="title${index.index}"
                                                                 type="text"
                                                                 name="activityMessageI18ns[${index.index}].activityName"
                                                                 class="form-control title"
                                                                 placeholder="${views.operation['Activity.step.message1']}"
                                                                 value="${activityMessageI18ns['1'][siteLang.value.language].activityName}">
                                    </div>
                                </div>
                                <div class="clearfix m-t-md" id="main${index.index}">
                                    <label class="ft-bold col-sm-3 al-right line-hi34">${views.operation['Activity.step.activityCover']}：</label>
                                    <div class="col-sm-5">
                                        <div class="form-group m-b-sm">
                                            <div id="activityContentImage${index.index}">
                                                <c:if test="${not empty activityMessageI18ns['1'][siteLang.value.language].activityCover}">
                                                    <img id="bb_${index.index}"
                                                         src="${soulFn:getThumbPath(domain, activityMessageI18ns['1'][siteLang.value.language].activityCover,500,500)}"
                                                         class="logo-size-h100"
                                                         style="margin: 10px 0; width: auto;height: 250px;"/>
                                                </c:if>
                                            </div>
                                            <input id="activityContentFile" bbb="${index.index}" class="file file1"
                                                   type="file"
                                                   target="activityMessageI18ns[${index.index}].activityCover"
                                                   accept="image/*" name="activityCoverImg">
                                            <input type="hidden" class="activityContentFile" bbb="${index.index}"
                                                   name="activityMessageI18ns[${index.index}].activityCover"
                                                   value="${activityMessageI18ns['1'][siteLang.value.language].activityCover}">
                                            <input type="hidden"
                                                   value="${activityMessageI18ns['1'][siteLang.value.language].activityCover}">
                                        </div>
                                        <div id="activityContentImg${index.index}">
                                            <img id="aa_${index.index}" src=""
                                                 style="display: none;width: 100%;height: auto;"/>
                                        </div>
                                        <div>${views.operation['Activity.step.message13']}</div>
                                    </div>
                                </div>

                                    <%--附图--%>
                                <div class="clearfix m-t-md" id="secondary${index.index}">
                                    <label class="ft-bold col-sm-3 al-right line-hi34">${views.operation['Activity.step.affiliated']}：</label>
                                    <div class="col-sm-5">
                                        <div class="form-group m-b-sm">
                                            <div id="activityAffiliatedImage${index.index}">
                                                <c:if test="${not empty activityMessageI18ns['1'][siteLang.value.language].activityAffiliated}">
                                                    <img id="cc_${index.index}"
                                                         src="${soulFn:getThumbPath(domain, activityMessageI18ns['1'][siteLang.value.language].activityAffiliated,0,0)}"
                                                         class="logo-size-h100"
                                                         style="margin: 10px 0; width: auto;height: 130px;"/>
                                                </c:if>
                                            </div>
                                            <input id="activityAffiliated" bbb="${index.index}" class="file file2"
                                                   type="file"
                                                   target="activityMessageI18ns[${index.index}].activityAffiliated"
                                                   accept="image/*" name="activityAffiliated">
                                            <input type="hidden" class="activityAffiliated" bbb="${index.index}"
                                                   name="activityMessageI18ns[${index.index}].activityAffiliated"
                                                   value="${activityMessageI18ns['1'][siteLang.value.language].activityAffiliated}">
                                            <input type="hidden"
                                                   value="${activityMessageI18ns['1'][siteLang.value.language].activityAffiliated}">
                                        </div>
                                        <div id="activityAffiliatedImg${index.index}">
                                            <img id="dd_${index.index}" src=""
                                                 style="display: none;width:100%;height: auto;"/>
                                        </div>
                                        <div>${views.operation['Activity.step.message2']}</div>
                                    </div>
                                </div>

                                <div class="clearfix m-t-md">
                                    <label class="ft-bold col-sm-3 al-right line-hi34">${views.operation['Activity.step.activityDescription']}：</label>
                                    <div class="col-sm-9">
                                        <textarea class="_editArea${index.index} contents" bbb="${index.index}"
                                                  id="editContent${index.index}" ueditorId="editContent${index.index}"
                                                  name="activityMessageI18ns[${index.index}].activityDescription">${activityMessageI18ns['1'][siteLang.value.language].activityDescription}</textarea>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <c:set var="length" value="${languageList.size()}"></c:set>
            <div class="mb terminal" style="display: none;">
                <div class="form-group clearfix">
                    <div class="clearfix save lgg-version lang_label">
                        <ul class="nav nav-tabs">
                            <span class="col-sm-3"></span>
                            <c:forEach var="siteLang" items="${languageList}" varStatus="index">
                                <li class=" ${index.index+length==length?'active':''}">
                                    <a id="a_${index.index+length}" data-toggle="tab" href="#tab${index.index+length}"
                                       aria-expanded="${index.index+length==length?'true':'false'}">
                                            ${fn:substringBefore(dicts.common.language[siteLang.value.language], '#')}mobile
                                        <span class="_editStatus${index.index+length}">
                                            <c:choose>
                                                <c:when test="${(not empty activityMessageI18ns['2'][siteLang.value.language].activityCover) and (not empty activityMessageI18ns['2'][siteLang.value.language].activityName) and (not empty activityMessageI18ns['2'][siteLang.value.language].activityDescription)}">
                                                    ${views.common['edited']}
                                                </c:when>
                                                <c:otherwise>
                                                    ${views.common['unedited']}
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </a>
                                </li>
                                <input type="hidden" name="activityMessageI18ns[${index.index+length}].activityVersion"
                                       value="${siteLang.value.language}">
                                <input type="hidden" name="activityMessageI18ns[${index.index+length}].activityTerminalType"
                                       value="2">
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="tab-content">
                        <c:forEach var="siteLang" items="${languageList}" varStatus="index">
                            <div id="tab${index.index+length}"
                                 class="tab-pane ">
                                <div class="clearfix m-t-md">
                                    <label class="ft-bold col-sm-3 al-right line-hi34">${views.operation['Activity.name']}：</label>
                                    <div class="col-sm-5"><input bbb="${index.index+length}"
                                                                 id="title${index.index+length}" type="text"
                                                                 name="activityMessageI18ns[${index.index+length}].activityName"
                                                                 class="form-control title"
                                                                 placeholder="${views.operation['Activity.step.message1']}"
                                                                 value="${activityMessageI18ns['2'][siteLang.value.language].activityName}">
                                    </div>
                                </div>

                                <%--主图--%>
                                <div class="clearfix m-t-md" id="main${index.index+length}">
                                    <label class="ft-bold col-sm-3 al-right line-hi34">${views.operation['Activity.step.activityCover']}：</label>
                                    <div class="col-sm-5">
                                        <div class="form-group m-b-sm">
                                            <div id="activityContentImage${index.index+length}">
                                                <c:if test="${not empty activityMessageI18ns['2'][siteLang.value.language].activityCover}">
                                                    <img id="bb_${index.index+length}"
                                                         src="${soulFn:getThumbPath(domain, activityMessageI18ns['2'][siteLang.value.language].activityCover,500,500)}"
                                                         class="logo-size-h100"
                                                         style="margin: 10px 0; width: auto;height: 250px;"/>
                                                </c:if>
                                            </div>
                                            <input id="" bbb="${index.index+length}" class="file file1"
                                                   type="file"
                                                   target="activityMessageI18ns[${index.index+length}].activityCover"
                                                   accept="image/*" name="activityCoverImg">
                                            <input type="hidden" class="activityContentFile" bbb="${index.index+length}"
                                                   name="activityMessageI18ns[${index.index+length}].activityCover"
                                                   value="${activityMessageI18ns['2'][siteLang.value.language].activityCover}">
                                            <input type="hidden"
                                                   value="${activityMessageI18ns['2'][siteLang.value.language].activityCover}">
                                        </div>
                                        <div id="activityContentImg${index.index+length}">
                                            <img id="aa_${index.index+length}" src=""
                                                 style="display: none;width: 100%;height: auto;"/>
                                        </div>
                                        <div>${views.operation['Activity.step.message13']}</div>
                                    </div>
                                </div>

                                <div class="clearfix m-t-md">
                                    <label class="ft-bold col-sm-3 al-right line-hi34">${views.operation['Activity.step.activityDescription']}：</label>
                                    <div class="col-sm-9">
                                        <textarea class="_editArea${index.index+length} contents"
                                                  bbb="${index.index+length}" id="editContent${index.index+length}"
                                                  ueditorId="editContent${index.index+length}"
                                                  name="activityMessageI18ns[${index.index+length}].activityDescription">${activityMessageI18ns['2'][siteLang.value.language].activityDescription}</textarea>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <div class="operate-btn">
                <c:if test="${!(activityMessageVo.result.checkStatus eq '1' && (activityMessageVo.states eq 'processing' || activityMessageVo.states eq 'notStarted'))  || activityMessageVo.result.checkStatus eq '2'}">
                    <soul:button callback="getActivityMessageId" precall="uploadFile"
                                 target="${root}/activityHall/activity/activityContentDraft.html?activityState=draft"
                                 text="${views.operation['Activity.step.saveAndDraft']}" opType="ajax"
                                 cssClass="btn btn-filter btn-lg" post="getCurrentFormData"/>
                </c:if>
                <c:choose>
                    <c:when test="${activityType.result.code eq 'content'}">
                        <soul:button precall="validateForm" opType="function" target="activityContentTypeNext"
                                     cssClass="btn btn-filter btn-lg" text="${views.common['next']}"/>
                    </c:when>
                    <c:otherwise>
                        <soul:button precall="validateForm" opType="function" target="activityContentNext"
                                     cssClass="btn btn-filter btn-lg" text="${views.common['next']}"/>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>
<!--//endregion your codes 3-->
<!--//region your codes 4-->
<script>
    var languageCounts = ${fn:length(languageList)*2};
</script>
<!--//endregion your codes 4-->
