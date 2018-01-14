<%--@elvariable id="command" type="so.wwb.gamebox.model.company.sys.vo.VDomainCheckResultStatisticsListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<div class="row">
    <form:form action="${root}/operation/domainCheckResult/list.html?search.isSecondSearch=0" method="post">

        <div class="col-lg-12 m-b">
            <div class="wrapper white-bg shadow">

                <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
                    <div class="search-list-container">



                        <div class="sys_tab_wrap shadow m-t clearfix"
                             style="border-bottom: 0; border-top:1px solid #e6e6e6; margin-bottom: -5px;">
                            <div class=" clearfix m-sm">
                                <center><H1>${views.operation['域名检测完成']}</H1></center>
                                <span>${views.operation['最新检测时间:']}${soulFn:formatDateTz(checkTime, DateFormat.DAY_SECOND, timeZone )}</span><br>
                                <span>${views.operation['域名检测情况如下所示（结果仅供参考）']}</span>
                            </div>
                        </div>
                        <br>

                        <div class="table-responsive table-min-h">
                            <table class="table table-striped table-hover dataTable m-b-sm"
                                   aria-describedby="editable_info"
                                   id="editable">
                                <thead>
                                <tr role="row" class="bg-gray">

                                    <th>${views.operation['域名状态']}</th>
                                    <th>${views.operation['域名条数']}</th>

                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>${dicts.common.domain_check_result_status['NORMAL']}</td>
                                    <td><span
                                            class="co-green">${statusCount.all-statusCount.errAll}</span>
                                    </td>
                                </tr>

                                <tr>
                                    <td>${dicts.common.domain_check_result_status['WALLED_OFF']}</td>
                                    <td><span
                                            class="co-red">${statusCount.wallOF}</span>
                                    </td>
                                </tr>

                                <tr>
                                    <td>${dicts.common.domain_check_result_status['BE_HIJACKED']}</td>
                                    <td><span
                                            class="co-red">${statusCount.beHijached}</span>
                                    </td>
                                </tr>

                                <tr>
                                    <td>${dicts.common.domain_check_result_status['UNRESOLVED']}</td>
                                    <td><span
                                            class="co-red">${statusCount.unResolved}</span>
                                    </td>
                                </tr>

                                <tr>
                                    <td>${dicts.common.domain_check_result_status['SERVER_UNREACHABLE']}</td>
                                    <td><span
                                            class="co-red">${statusCount.serverUnreachable}</span>
                                    </td>
                                </tr>

                                <tr>
                                    <td>${dicts.common.domain_check_result_status['UNKNOWN_ERR']}</td>
                                    <td><span
                                            class="co-red">${statusCount.unknown}</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>${dicts.common.domain_check_result_status['UNAUTHORIZED']}</td>
                                    <td><span
                                            class="co-red">${statusCount.unAuthorized}</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>${dicts.common.domain_check_result_status['REDIRECT']}</td>
                                    <td><span
                                            class="co-red">${statusCount.redirect}</span>
                                    </td>
                                </tr>

                                </tbody>
                            </table>
                            <div class="clearfix filter-wraper border-b-1 line-hi34 al-right">
                                <a class="btn btn-link co-blue"
                                   href="/operation/domainCheckResult/list.html"
                                   nav-target="mainFrame" target="_blank">${views.operation['查看详情']}</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </form:form>
</div>
</html>
<!--//endregion your codes 1-->
