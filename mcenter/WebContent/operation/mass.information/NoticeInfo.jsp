<%--@elvariable id="command" type="org.soul.model.msg.notice.vo.NoticeHistoryDetail"--%>
<%--@elvariable id="siteLang" type="java.util.List<so.wwb.gamebox.model.master.setting.po.SiteLanguage>"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form>
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont"></i> </a></h2>
            <span>${views.sysResource['内容']}</span>
            <span>/</span><span>${views.sysResource['信息群发']}</span>
            <soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <%--<c:if test="${command}">
                    <a href="javascript:void(0)" class="btn btn-outline btn-filter m-l m-t">${views.operation_auto['编辑']}</a><!--待发送时显示此按钮-->
                </c:if>--%>
                <ul class="artificial-tab clearfix bg-gray m-t">
                    <c:forEach items="${siteLang}" var="i" varStatus="vs">
                        <li class="m-l-lg">
                            <soul:button cssClass="${i.language eq locale?'current':'p-r-sm'}" target="changeLang" locale="${i.language}" text="" opType="function">
                                <span class="con">
                                    ${fn:substringBefore(dicts.common.language[i.language], '#')}
                                    <c:choose>
                                        <c:when test="${empty command.localeTmplMap[i.language]}">
                                            ${views.common['unedited']}
                                        </c:when>
                                        <c:otherwise>
                                            ${views.common['edited']}
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </soul:button>
                        </li>
                    </c:forEach>
                </ul>
                <c:forEach items="${siteLang}" var="i" varStatus="vs">
                    <div class="m-l m-r" id="${i.language}" style="${i.language ne locale?'display:none':''}">
                        <h3 class="al-center">${command.localeTmplMap[i.language].title}</h3>
                        <c:choose>
                            <c:when test="${command.status eq '00'}">
                                <div class="al-center co-grayc2 m-b">${views.operation['MassInformation.expected']}${soulFn:formatDateTz(command.sendTime, DateFormat.DAY_SECOND, timeZone)}${views.common['send']}</div>
                            </c:when>
                            <c:otherwise>
                                <div class="al-center co-grayc2 m-b">${soulFn:formatDateTz(command.createTime, DateFormat.DAY_SECOND, timeZone)}</div>
                            </c:otherwise>
                        </c:choose>
                        <div class="al-center co-grayc2 m-b"><p>${command.localeTmplMap[i.language].content}</p></div>
                    </div>
                </c:forEach>

                <div class="bg-gray line-hi25 p-xs">
                    <div class="form-group clearfix">
                        <label class="col-sm-3 ft-bold al-right">${views.operation['MassInformation.step3.receiving']}：</label>
                        <div class="col-sm-8">${command.groupTypes}</div>
                    </div>
                    <div class="form-group clearfix">
                        <label class="col-sm-3 ft-bold al-right">${views.operation['MassInformation.chosen']}：</label>
                        <div class="col-sm-8">${command.groups}</div>
                    </div>
                    <div class="form-group clearfix">
                        <label class="col-sm-3 ft-bold al-right">${views.operation['MassInformation.step3.count']}：</label>
                        <c:choose>
                            <c:when test="${command.status eq '00'}">
                                <div class="col-sm-8">${views.operation['MassInformation.step3.toBeSend']}</div>
                            </c:when>
                            <c:otherwise>
                                <div class="col-sm-8">${command.successCount}/
                                    <c:choose>
                                        <c:when test="${command.failCount>0}">
                                            <a href="/operation/massInformation/getPublishFailUsers.html?search.textId=${command.textId}" nav-target="mainFrame">${command.failCount}</a>
                                        </c:when>
                                        <c:otherwise>
                                            ${command.failCount}
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:otherwise>
                        </c:choose>

                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
<soul:import res="site/operation/mass.information/NoticeInfo"/>