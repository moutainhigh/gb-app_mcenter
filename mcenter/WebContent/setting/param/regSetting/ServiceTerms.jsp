<%--@elvariable id="command" type="so.wwb.gamebox.model.company.site.vo.SiteConfineAreaVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/param/getFieldSort.html" method="post" nav-target="mainFrame">
    <!--//region your codes 2-->
    <form:hidden path="paramId" id="paramId"/>
    <input name="type" value="${command.type}" id="type" type="hidden">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['系统设置']}</span><span>/</span><span>${views.sysResource['站点参数']}</span>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <!--筛选条件-->
                <form class="m-t" action="">
                    <div class="form-group clearfix line-hi34">
                        <label class="ft-bold col-sm-3 al-right">${views.setting['serviceTrems.showTitle']}：</label>
                        <div class="col-sm-5">
                            <form:hidden path="phoneParam.id"/>
                            <label class="m-r-sm"><input type="radio" name="phoneParam.paramValue" class="i-checks" value="true" ${command.phoneParam.paramValue=="true"?"checked":""}>${dicts.common.flag['true']}</label>
                            <label class="m-r-sm"><input type="radio" name="phoneParam.paramValue" class="i-checks" value="false" ${command.phoneParam.paramValue=="false"?"checked":""}>${dicts.common.flag['false']}</label>
                            <span class="help-popover co-grayc2" data-original-title="" title="">${views.setting['serviceTrems.regShow']}</span>
                        </div>
                    </div>
                    <div class="form-group clearfix line-hi34">
                        <label class="ft-bold col-sm-3 al-right">${views.setting['serviceTrems.forced']}：</label>
                        <div class="col-sm-5">
                            <form:hidden path="mailParam.id"/>
                            <label class="m-r-sm"><input type="radio" ${command.phoneParam.paramValue?"":"disabled"} name="mailParam.paramValue" class="i-checks" value="true" ${command.mailParam.paramValue=="true"?"checked":""}>${dicts.common.flag['true']}</label>
                            <label class="m-r-sm"><input type="radio" ${command.phoneParam.paramValue?"":"disabled"} name="mailParam.paramValue" class="i-checks" value="false" ${command.mailParam.paramValue=="false"?"checked":""}>${dicts.common.flag['false']}</label>
                            <c:choose>
                                <c:when test="${command.type== 'agent'}">
                                    <span class="help-popover co-grayc2" tabindex="0" data-original-title="" title="">${views.setting['serviceTrems.agentAfter']}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="help-popover co-grayc2" tabindex="0" data-original-title="" title="">${views.setting['serviceTrems.playerAfter']}</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="form-group clearfix">
                        <label class="ft-bold col-sm-3 al-right line-hi34">${views.setting['serviceTrems.content']}：</label>
                        <div class="col-sm-8">
                            <div class="context">
                                <div class="clearfix save lgg-version">
                                    <c:forEach items="${command.siteLanguageList}" var="p" varStatus="status">
                                        <a id="tag${status.index}" name="tag" class="${status.index=='0'?'current':''} a_${p.language}"
                                           tagIndex="${status.index}" siteSize="${command.siteLanguageList.size()}" href="javascript:void(0)" local="${p.language}">
                                                ${dicts.common.local[p.language]}
                                            <span id="span${p.language}">
                                                    ${status.index=='0'?messages.setting['switch.CloseReminder.editing']:command.siteI18nMap.get(p.language).value.length()>0?views.setting['switch.CloseReminder.edited']:views.setting['switch.CloseReminder.unedited']}
                                            </span>
                                        </a>
                                    </c:forEach>
                                    <span class="more"><a href="javascript:void(0)" id="next"><i class="fa fa-angle-double-right"></i></a></span>
                                    <div class="pull-right inline" style="margin-top: -20px;">
                                        <soul:button text="${views.setting['serviceTrems.revert']}" opType="function" dataType="function" target="resetDefault"/>
                                        <div class="btn-group">

                                            <button data-toggle="dropdown" class="btn btn-link dropdown-toggle fzyx">${views.setting['serviceTrems.copy']}&nbsp;&nbsp;<span class="caret"></span></button>
                                            <ul class="dropdown-menu pull-right">
                                                <c:forEach items="${command.siteLanguageList}" var="p" varStatus="status">
                                                    <li id="option${p.language}" class="temp ${empty command.siteI18nMap.get(p.language).value||status.index==0?"hide":""}">
                                                        <a class="co-gray copy" href="javascript:void(0)" orderIndex="${status.index}" local="${p.language}">
                                                        ${dicts.common.local[p.language]}
                                                        </a>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="" style="height: 600px;">
                                    <input type="hidden" name="lsize" value="${command.siteLanguageList.size()}" />
                                <c:forEach items="${command.siteLanguageList}" var="p" varStatus="status">
                                    <div class="content${p.language} ann tab-pane" style="display: ${status.index=='0'?'':'none'}" lang="${p.language}">
                                        <input type="hidden" name="siteI18nList[${status.index}].id" value="${command.siteI18nMap.get(p.language).id}"/>
                                        <input type="hidden" name="siteI18nList[${status.index}].locale" value="${p.language}"/>
                                        <input type="hidden" name="siteI18nList[${status.index}].siteId" value="${command.search.siteId}"/>
                                        <input type="hidden" name="siteI18nList[${status.index}].module" value="${service.module.code}"/>
                                        <input type="hidden" name="siteI18nList[${status.index}].type" value="${service.type}"/>
                                        <input type="hidden" name="siteI18nList[${status.index}].key" value="${service.code}"/>
                                        <%--<input type="hidden" name="siteI18nList[${status.index}].defaultValue" value='${command.siteI18nMap.get(p.language).defaultValue}' class="defaultValue"/>--%>
                                        <div>
                                            <textarea tt="${p.language}" local="${p.language}"
                                                      name="siteI18nList[${status.index}].value" id="editContent${status.index}" rows="15"
                                                      class="form-textarea">${command.siteI18nMap.get(p.language).value}
                                            </textarea>
                                        </div>
                                        <div>
                                            <input id="orginContent${status.index}" class="hide" name="orginContent[${status.index}].orginContent" indexId="${status.index}" tt="${p.language}"/>
                                        </div>

                                    </div>
                                </c:forEach>
                                </div>
                            </div>

                        </div>
                    </div>

                </form>
            </div>
            <div class="operate-btn">
                    <%--<button class="btn btn-filter btn-lg">${views.common['save']}</button>--%>
                        <soul:button cssClass="btn btn-filter btn-lg" text="${views.common['OK']}" opType="ajax" dataType="json"
                                     target="${root}/param/saveServiceTrems.html" post="getCurrentFormData" precall="myValidateForm"
                                     callback="saveCallbak"/>
                        <soul:button cssClass="btn btn-outline btn-filter btn-lg m-r" opType="function" target="close" text="${views.common['cancel']}"/>
                        <%--<soul:button target="goToLastPage" refresh="true" cssClass="btn btn-outline btn-filter btn-lg m-r" text="${views.common_report['取消']}" opType="function">
                        </soul:button>--%>
            </div>
        </div>

        <!--//endregion your codes 2-->
    </div>
</form:form>

<!--//region your codes 3-->
<soul:import res="site/setting/param/regSetting/ServiceTerms"/>
<!--//endregion your codes 3-->