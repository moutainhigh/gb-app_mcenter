<%--@elvariable id="command" type="so.wwb.gamebox.model.company.sys.vo.VDomainCheckResultStatisticsVo"--%>
<%--@elvariable id="area" type="so.wwb.gamebox.model.master.setting.vo.SiteConfineAreaVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<div class="row">
    <form:form action="${root}/operation/domainCheckData/getDomainCount.html" method="post">

        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a>
            </h2>
            <span>${views.operation['运营']}<%--${views.sysResource['分析']}--%></span><span>/</span><span>${views.operation['域名检测']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>

       <div class="col-lg-12 m-b">
            <div class="wrapper white-bg shadow">
                <ul class="clearfix sys_tab_wrap">
                    <li class="active"><a href="/operation/domainCheckData/getDomainCount.html"
                                          nav-target="mainFrame">${views.operation['域名状态']}</a>
                    </li>
                    <li><a href="/operation/domainCheckResult/list.html"
                           nav-target="mainFrame">${views.operation['检测结果']}</a>
                    </li>
                </ul>


                <div class="sys_tab_wrap shadow m-t clearfix"
                     style="border-bottom: 0; border-top:1px solid #e6e6e6; margin-bottom: -5px;">
                    <div class=" clearfix m-sm">

                            <span>${views.operation['监测点：']} &nbsp;${command.domainCheckResultListVo.checkPointCount}个&nbsp;&nbsp;&nbsp;

                            ${views.operation['检测情况：']}
                            <span class="co-green">${command.domainCheckResultListVo.statusCount.all- command.domainCheckResultListVo.statusCount.errAll}&nbsp;</span>个域名
                                    <span class="co-green">${dicts.common.domain_check_result_status['NORMAL']}</span>
                                &nbsp;&nbsp;&nbsp;
                                   <%-- 被墙 --%>
                            <span class="co-yellow">
                                <c:if test="${!empty command.domainCheckResultListVo.statusCount.wallOF}">
                                    ${command.domainCheckResultListVo.statusCount.wallOF}
                                </c:if>
                            </span>${views.operation['个域名']}
                            <span class="co-yellow">${dicts.common.domain_check_result_status['WALLED_OFF']}</span>
                                &nbsp;&nbsp;&nbsp;


                            <span class="co-yellow">
                                <%-- 被劫持 --%>
                            <c:if test="${empty command.domainCheckResultListVo.statusCount.beHijached}">
                                0
                            </c:if>
                                <c:if test="${!empty command.domainCheckResultListVo.statusCount.beHijached}">
                                    ${command.domainCheckResultListVo.statusCount.beHijached}
                                </c:if>
                            </span>${views.operation['个域名']}
                            <span class="co-yellow">${dicts.common.domain_check_result_status['BE_HIJACKED']}</span>
                                &nbsp;&nbsp;&nbsp;

                            <span class="co-yellow">
                                  <%--UNRESOLVED 未解析--%>
                            <c:if test="${empty command.domainCheckResultListVo.statusCount.unResolved}">
                                0
                            </c:if>
                                <c:if test="${!empty command.domainCheckResultListVo.statusCount.unResolved}">
                                    ${command.domainCheckResultListVo.statusCount.unResolved}
                                </c:if>
                            </span>
                            ${views.operation['个域名']}
                            <span class="co-yellow">${dicts.common.domain_check_result_status['UNRESOLVED']}</span>
                                &nbsp;&nbsp;&nbsp;

                            <span class="co-yellow">
                              <%--  服务器不通 --%>
                            <c:if test="${empty command.domainCheckResultListVo.statusCount.serverUnreachable}">
                                0
                            </c:if>
                                <c:if test="${!empty command.domainCheckResultListVo.statusCount.serverUnreachable}">
                                    ${command.domainCheckResultListVo.statusCount.serverUnreachable}
                                </c:if>
                            </span>
                            ${views.operation['个域名']}
                            <span class="co-yellow">${dicts.common.domain_check_result_status['SERVER_UNREACHABLE']}</span>
                                &nbsp;&nbsp;&nbsp;

                                <span class="co-yellow">
                                    <c:if test="${empty command.domainCheckResultListVo.statusCount.unAuthorized}">
                                        0
                                    </c:if>
                                    <c:if test="${!empty command.domainCheckResultListVo.statusCount.unAuthorized}">
                                        ${command.domainCheckResultListVo.statusCount.unAuthorized}
                                    </c:if>
                            </span>

                                    ${views.operation['个域名']}
                                    <span class="co-yellow">${dicts.common.domain_check_result_status['UNAUTHORIZED']}</span>
&nbsp;                          &nbsp;&nbsp;&nbsp;

                                <span class="co-yellow">
                                    <c:if test="${empty command.domainCheckResultListVo.statusCount.redirect}">
                                        0
                                    </c:if>
                                    <c:if test="${!empty command.domainCheckResultListVo.statusCount.redirect}">
                                            ${command.domainCheckResultListVo.statusCount.redirect}
                                    </c:if>
                                </span>

                                    ${views.operation['个域名']}
                                    <span class="co-yellow">${dicts.common.domain_check_result_status['REDIRECT']}</span>

                                &nbsp;&nbsp;&nbsp;
                                   <%--未知异常--%>
                                <span class="co-yellow">
                                    <c:if test="${empty command.domainCheckResultListVo.statusCount.unknown}">
                                        0
                                    </c:if>
                                    <c:if test="${!empty command.domainCheckResultListVo.statusCount.unknown}">
                                        ${command.domainCheckResultListVo.statusCount.unknown}
                                    </c:if>
                                </span>
                            ${views.operation['个域名']}
                            <span class="co-yellow">${dicts.common.domain_check_result_status['UNKNOWN_ERR']}</span>
                        </span>
                    </div>
                </div>
                <br>


                <div class="clearfix" style="padding:10px 10px;" id="searchDiv">
                        <%--域名--%>
                    <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                        <div class="input-group date">
                            <span class="input-group-addon bg-gray">&nbsp;&nbsp;<%--${views.analyze['代理账号']}--%>${views.operation['域名']}&nbsp;</span>
                            <input class="form-control account_input list-search-input-text" type="text"
                                   name="search.domain"
                                   placeholder="${views.analyze['多个账号，用半角逗号隔开']}"
                                   value="${command.search.domain}"/>
                        </div>
                    </div>
                            <%-- 类型 --%>
                            <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group">
                                    <span class="input-group-addon bg-gray">${views.operation['类型']}</span>
                                    <%--<gb:select name="search.pageUrl" value="" prompt="全部" list="${command.domainCheckResultListVo.pageUrl}"/>--%>
                                    <select btnStyle="width: 100%" ulStyle="width: 100%" class="chosen-select-no-single btn-group days" name="search.pageUrl">
                                        <option value="">${views.content['全部']}</option>
                                        <c:forEach items="${command.domainCheckResultListVo.domainTypes}" var="type" >
                                            <option value="${type.paramValue}" ${type.paramValue eq command.search.pageUrl?'selected':''}>${views.content[type.resourceKey]}</option>
                                        </c:forEach>
                                    </select >
                                </div>
                            </div>

                    <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                        <div class="input-group">
                            <span class="input-group-addon bg-gray">${views.operation['状态']}</span>
                            <gb:select name="search.status" value="" prompt="${views.content['全部']}" list="${command.domainCheckResultListVo.domainStatus}"/>
                        </div>
                    </div>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                        <%-- 搜索--%>
                    <soul:button text="" target="query" opType="function" cssClass="btn btn-filter" tag="button">
                        <i class="fa fa-search"></i>
                        <span class="hd">&nbsp;${views.common['search']}</span>
                    </soul:button>

                </div>
                <div class="clearfix filter-wraper line-hi34 pull-left">
                    <span class="co-yellow"><i class="fa fa-exclamation-circle"></i></span>
                        ${views.operation['检测时间：']}${soulFn:formatDateTz(command.domainCheckResultListVo.checkTime, DateFormat.DAY_SECOND, timeZone )}
                </div>

                <div class="clearfix filter-wraper line-hi34 al-right pull-right">
                        ${views.operation['所有域名检测结果仅供参考，不完全代表整个区域的实际解析情况，不具备故障证据之作用！如有需要请自行核实域名实际情况！']}
                </div>

                <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
                    <div class="search-list-container">
                        <%@ include file="IndexPartial.jsp" %>
                    </div>
                </div>
            </div>
        </div>

    </form:form>
</div>
<!--//region your codes 3-->
<soul:import type="list"/>
<!--//endregion your codes 3-->