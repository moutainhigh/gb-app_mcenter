<%--@elvariable id="command" type="so.wwb.gamebox.model.company.sys.vo.VDomainCheckResultStatisticsVo"--%>
<%--@elvariable id="area" type="so.wwb.gamebox.model.master.setting.vo.SiteConfineAreaVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<div class="row">
    <form:form action="${root}/vDomainCheckResultStatistics/getCount.html" method="post">

        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a>
            </h2>
            <span>运营<%--${views.sysResource['分析']}--%></span><span>/</span><span><%--${views.sysResource['推广链接新进']}--%>域名检测</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>

       <div class="col-lg-12 m-b">
            <div class="wrapper white-bg shadow">
                <ul class="clearfix sys_tab_wrap">
                    <li class="active"><a href="/vDomainCheckResultStatistics/getCount.html"
                                          nav-target="mainFrame">域名状态</a>
                    </li>
                    <li><a href="/operation/domainCheckResult/list.html"
                           nav-target="mainFrame">域名检测结果</a>
                    </li>
                </ul>


                <div class="sys_tab_wrap shadow m-t clearfix"
                     style="border-bottom: 0; border-top:1px solid #e6e6e6; margin-bottom: -5px;">
                    <div class=" clearfix m-sm">

                            <span>监测点 &nbsp;${checkPointCount}个&nbsp;&nbsp;&nbsp;

                            检测情况：
                            <span class="co-green">${statusCount.all- statusCount.errAll}&nbsp;</span>个域名
                                    <span class="co-green">${dicts.common.domain_check_result_status['NORMAL']}</span>
                                &nbsp;&nbsp;&nbsp;
                                   <%-- 被墙 --%>
                            <span class="co-yellow">
                                <c:if test="${empty statusCount.wallOF}">
                                    ${statusCount.wallOF}
                                </c:if>
                                <c:if test="${!empty statusCount.wallOF}">
                                    ${statusCount.wallOF}
                                </c:if>
                            </span>个域名
                            <span class="co-yellow">${dicts.common.domain_check_result_status['WALLED_OFF']}</span>
                                &nbsp;&nbsp;&nbsp;


                            <span class="co-yellow">
                                <%-- 被劫持 --%>
                            <c:if test="${empty statusCount.beHijached}">
                                0
                            </c:if>
                                <c:if test="${!empty statusCount.beHijached}">
                                    ${statusCount.beHijached}
                                </c:if>
                            </span>个域名
                            <span class="co-yellow">${dicts.common.domain_check_result_status['BE_HIJACKED']}</span>
                                &nbsp;&nbsp;&nbsp;

                            <span class="co-yellow">
                                  <%--UNRESOLVED 未解析--%>
                            <c:if test="${empty statusCount.unResolved}">
                                0
                            </c:if>
                                <c:if test="${!empty statusCount.unResolved}">
                                    ${statusCount.unResolved}
                                </c:if>
                            </span>
                            个域名<span class="co-yellow">${dicts.common.domain_check_result_status['UNRESOLVED']}</span>
                                &nbsp;&nbsp;&nbsp;

                            <span class="co-yellow">
                              <%--  服务器不通 --%>
                            <c:if test="${empty statusCount.serverUnreachable}">
                                0
                            </c:if>
                                <c:if test="${!empty statusCount.serverUnreachable}">
                                    ${statusCount.serverUnreachable}
                                </c:if>
                            </span>
                            个域名<span class="co-yellow">${dicts.common.domain_check_result_status['SERVER_UNREACHABLE']}</span>
                                &nbsp;&nbsp;&nbsp;

                                <span class="co-yellow">
                                    <c:if test="${empty statusCount.unAuthorized}">
                                        0
                                    </c:if>
                                    <c:if test="${!empty statusCount.unAuthorized}">
                                        ${statusCount.unAuthorized}
                                    </c:if>
                            </span>

                            个域名<span class="co-yellow">未授权</span>
&nbsp;                          &nbsp;&nbsp;&nbsp;

                                <span class="co-yellow">
                                    <c:if test="${empty statusCount.redirect}">
                                        0
                                    </c:if>
                                    <c:if test="${!empty statusCount.redirect}">
                                            ${statusCount.redirect}
                                    </c:if>
                                </span>

                            个域名<span class="co-yellow">被跳转</span>

                                &nbsp;&nbsp;&nbsp;
                                   <%--未知异常--%>
                                <span class="co-yellow">
                                    <c:if test="${empty statusCount.unknown}">
                                        0
                                    </c:if>
                                    <c:if test="${!empty statusCount.unknown}">
                                        ${statusCount.unknown}
                                    </c:if>
                                </span>
                            个域名<span class="co-yellow">${dicts.common.domain_check_result_status['UNKNOWN_ERR']}</span>
                        </span>
                    </div>
                </div>
                <br>


                <div class="clearfix" style="padding:10px 10px;" id="searchDiv">
                        <%--域名--%>
                    <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                        <div class="input-group date">
                            <span class="input-group-addon bg-gray">&nbsp;&nbsp;<%--${views.analyze['代理账号']}--%>域名&nbsp;</span>
                            <input class="form-control account_input list-search-input-text" type="text"
                                   name="search.domain"
                                   placeholder="多个账号，用半角逗号隔开<%--${views.analyze['多个账号，用半角逗号隔开']}--%>"
                                   value="${command.search.domain}"/>
                        </div>
                    </div>
                        <%--<div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                            <div class="input-group">
                                <span class="input-group-addon bg-gray">地区省</span>
                                <gb:select name="search.serverProvince"
                                           prompt="省" value=""
                                           ajaxListPath="${root}/regions/states/CN.html"
                                           listValue="remark" listKey="dictCode"
                                           cssClass="btn-group chosen-select-no-single"
                                           relSelect="search.serverCity"/>

                            </div>
                        </div>
                        <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                            <div class="input-group">
                                <span class="input-group-addon bg-gray">城市</span>


                                <gb:select name="search.serverCity" prompt="${views.common['pleaseSelect']}"
                                           value=""
                                           ajaxListPath="${root}/regions/cities/CN-${command.search.serverCity}.html"
                                           relSelectPath="${root}/regions/cities/CN-#search.serverProvince#.html"
                                           listValue="remark"
                                           listKey="dictCode"
                                           cssClass="btn-group chosen-select-no-single"/>
                            </div>
                        </div>--%>

                        <%--地区--%>
                            <%-- 类型 --%>
                            <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group">
                                    <span class="input-group-addon bg-gray">类型</span>
                                    <gb:select name="search.pageUrl" value="" prompt="类型" list="${domainType}"/>
                                </div>
                            </div>

                    <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                        <div class="input-group">
                            <span class="input-group-addon bg-gray">状态</span>
                            <gb:select name="search.status" value="" prompt="状态" list="${domainStatus}"/>
                        </div>
                    </div>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                        <%-- 搜索--%>
                    <soul:button text="" target="query" opType="function" cssClass="btn btn-filter" tag="button">
                        <i class="fa fa-search"></i>
                        <span class="hd">&nbsp;${views.common['search']}</span>
                    </soul:button>

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