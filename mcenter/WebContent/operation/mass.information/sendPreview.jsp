<%--
  Created by IntelliJ IDEA.
  User: snekey
  Date: 15-9-7
  Time: 下午12:01
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div id="step2" style="display: none">

    <form id="step2Form">
        <input type="hidden" name="sendType" value="${massInformationVo.sendType}">
        <input type="hidden" name="pushMode" value="${massInformationVo.pushMode}">
        <input type="hidden" name="targetUser" value="${massInformationVo.targetUser}">
        <input type="hidden" name="group" value="${massInformationVo.group}">
        <input type="hidden" name="appointPlayer" value="${massInformationVo.appointPlayer}">
        <input type="hidden" name="rank" value="${massInformationVo.joinRank}">
        <input type="hidden" name="tags" value="${massInformationVo.joinTags}">
        <input type="hidden" name="master" value="${massInformationVo.joinMaster}">
        <input type="hidden" name="agent" value="${massInformationVo.joinAgent}">
        <input type="hidden" name="masterAndAgent" value="${massInformationVo.joinMasterAndAgent}">
        <input type="hidden" name="timingFlag" value="${massInformationVo.timingFlag}">
        <input type="hidden" name="timing" value="${soulFn:formatDateTz(massInformationVo.timing, DateFormat.DAY_SECOND,timeZone)}">
        <gb:token/>
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['内容']}</span>
            <span>/</span><span>${views.sysResource['信息群发']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <ul class="artificial-tab clearfix">
                    <li class="col-sm-2 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">1</span>
                        <span class="con">${views.operation['MassInformation.sendMethod']}</span></a></li>
                    <li class="col-sm-2 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">2</span>
                        <span class="con">${views.operation['MassInformation.chooseUser']}</span></a></li>
                    <li class="col-sm-2 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">3</span>
                        <span class="con">${views.operation['MassInformation.sendContent']}</span></a></li>
                    <li class="col-sm-2 col-xs-12 p-x"><a class="current" href="javascript:void(0)"><span class="no">4</span>
                        <span class="con">${views.operation['MassInformation.preview']}</span></a></li>
                    <li class="col-sm-2 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">5</span>
                        <span class="con">${views.operation['MassInformation.finish']}</span></a></li>
                </ul>
                <div class="clearfix m-l-lg line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.operation['MassInformation.sendMethod']}：</label>
                    <div class="col-sm-5">${dicts.notice.publish_method[massInformationVo.sendType]}</div>
                </div>
                <div class="clearfix m-l-lg line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.operation['MassInformation.step4.sendToUser']}：</label>
                    <div class="col-sm-5">${massInformationVo.targetUser eq "player"?views.operation['MassInformation.step4.player']:views.operation['MassInformation.step4.agents']}</div>
                </div>
                <div class="clearfix m-l-lg line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.operation['MassInformation.chosen']}：</label>
                    <div class="col-sm-5">
                        ${massInformationVo.selected}
                    </div>
                </div>
                <c:if test="${massInformationVo.sendType eq 'siteMsg'}" >
                <div class="clearfix m-l-lg line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.operation['MassInformation.step4.pushMode']}：</label>
                    <div class="col-sm-5">${massInformationVo.pushMode ne "window"?views.operation['MassInformation.step4.only']:""}
                        <c:choose>
                            <c:when test="${massInformationVo.sendType eq 'siteMsg'}">
                                ${messages.common['msg']}
                            </c:when>
                            <c:otherwise>
                                ${dicts.notice.publish_method[massInformationVo.sendType]}
                            </c:otherwise>
                        </c:choose>
                    ${massInformationVo.pushMode ne "window"?'':views.operation['MassInformation.step4.pop']}</div>
                </div>
                </c:if>
                <div class="clearfix m-l-lg line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.operation['MassInformation.step4.sendingTime']}：</label>
                    <div class="col-sm-5">
                        <c:if test="${not empty massInformationVo.timing}">
                            ${soulFn:formatDateTz(massInformationVo.timing, DateFormat.DAY_SECOND,timeZone)}
                        </c:if>
                        <c:if test="${empty massInformationVo.timing}">
                            ${views.operation['MassInformation.step4.sendNow']}
                        </c:if>
                    <%--${massInformationVo.timing eq null?"立即发送":soulFn:formatDateTz(massInformationVo.timing, DateFormat.DAY_SECOND,timeZone)}--%>
                    </div>
                </div>
                <ul class="artificial-tab clearfix bg-gray m-t">
                    <li class="col-sm-3"></li>
                    <c:forEach var="siteLang" items="${massInformationVo.language}" varStatus="index">
                        <li class="m-l-lg ${siteLang eq language?'active':''}">
                            <a class="_clickHightlight p-r-sm ${siteLang eq language?'current':''}" data-toggle="tab" href="#tab${index.index}" data-edit="${views.common['edited']}" data-index="${index.index}" data-lang="${fn:substringBefore(dicts.common.language[siteLang], '#')}" aria-expanded="${index.index==0?'true':'false'}">
                                    ${fn:substringBefore(dicts.common.language[siteLang], '#')}<span class="con _editStatus${index.index}">${views.common['edited']}</span>
                            </a>
                        </li>
                        <input type="hidden" name="language[${index.index}]" value="${siteLang}">
                    </c:forEach>
                </ul>

                <div class="clearfix m-l-lg line-hi34">
                    <div class="panel-body col-sm-12">
                        <div class="tab-content">
                            <c:forEach begin="0" end="${fn:length(massInformationVo.language)}" var="siteLang" items="${massInformationVo.language}" varStatus="index">
                                <div id="tab${index.index}" class="tab-pane ${siteLang eq language?'active':''}">

                                <%-- title --%>
                                <div class="clearfix m-l-lg line-hi34">
                                    <label class="ft-bold col-sm-3 al-right">${views.operation['MassInformation.step4.title']}：</label>
                                    <div class="col-sm-5">${massInformationVo.title[index.index]}</div>
                                </div>

                                <%-- content --%>
                                <div class="clearfix m-l-lg line-hi34">
                                    <label class="ft-bold col-sm-3 al-right">${views.operation['MassInformation.sendContent']}：</label>
                                    <div class="col-sm-5">
                                        ${gbFn:unescapeXml(massInformationVo.content[index.index])}
                                    </div>
                                        <input type="hidden" class="formData" name="title[${index.index}]" value="${massInformationVo.title[index.index]}">
                                        <input type="hidden" class="formData" name="content[${index.index}]" value="${massInformationVo.content[index.index]}">
                                </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="operate-btn">
                    <soul:button target="editContent" text="${views.common['previous']}" opType="function" cssClass="btn btn-filter btn-lg"></soul:button>
                    <soul:button target="finish" text="${views.common['send']}" opType="function" cssClass="btn btn-filter btn-lg"></soul:button>
                </div>
            </div>
        </div>
    </div>
    </form>
</div>
