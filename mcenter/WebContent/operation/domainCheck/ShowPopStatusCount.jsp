<%--@elvariable id="command" type="so.wwb.gamebox.model.company.sys.vo.VDomainCheckResultStatisticsListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<div class="row">
        <div class="col-lg-12 m-b">

                    <div class="search-list-container">

                        <center><H1>${views.operation['域名检测完成！']}</H1></center>

                        <div class="sys_tab_wrap shadow m-t clearfix"
                             style="border-bottom: 0; border-top:1px solid #e6e6e6; margin-bottom: -5px;">
                            <div class=" clearfix m-sm">

                                <span>${views.operation['最新检测时间:']}${soulFn:formatDateTz(command.checkTime, DateFormat.DAY_SECOND, timeZone )}</span><br>
                                <span>${views.operation['域名检测情况如下所示（结果仅供参考）']}</span>
                            </div>
                        </div>
                        <br>

                        <div class="table-min-h">
                            <table class="table table-striped"
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
                                            class="co-green">${command.statusCount.all-command.statusCount.errAll}</span>
                                    </td>
                                </tr>

                                <tr>
                                    <td>${dicts.common.domain_check_result_status['WALLED_OFF']}</td>
                                    <td><span
                                            class="co-red">${command.statusCount.wallOF}</span>
                                    </td>
                                </tr>

                                <tr>
                                    <td>${dicts.common.domain_check_result_status['BE_HIJACKED']}</td>
                                    <td><span
                                            class="co-red">${command.statusCount.beHijached}</span>
                                    </td>
                                </tr>

                                <tr>
                                    <td>${dicts.common.domain_check_result_status['UNRESOLVED']}</td>
                                    <td><span
                                            class="co-red">${command.statusCount.unResolved}</span>
                                    </td>
                                </tr>

                                <tr>
                                    <td>${dicts.common.domain_check_result_status['SERVER_UNREACHABLE']}</td>
                                    <td><span
                                            class="co-red">${command.statusCount.serverUnreachable}</span>
                                    </td>
                                </tr>

                                <tr>
                                    <td>${dicts.common.domain_check_result_status['UNKNOWN_ERR']}</td>
                                    <td><span
                                            class="co-red">${command.statusCount.unknown}</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>${dicts.common.domain_check_result_status['UNAUTHORIZED']}</td>
                                    <td><span
                                            class="co-red">${command.statusCount.unAuthorized}</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>${dicts.common.domain_check_result_status['REDIRECT']}</td>
                                    <td><span
                                            class="co-red">${command.statusCount.redirect}</span>
                                    </td>
                                </tr>

                                <tr>　　　　
                                    <td colspan="2">
                                    </td>
                                </tr>

                                </tbody>
                            </table>
                            <div class="clearfix filter-wraper line-hi34 al-right">
                                <a class="btn btn-link co-blue"
                                   href="${root}#/operation/domainCheckData/getDomainCount.html" onclick="window.top.topPage.closeDialog();"
                                   nav-target="mainFrame" target="_blank">${views.operation['查看详情']}</a>
                            </div>
                        </div>
                    </div>
                </div>

</div>
</html>
<!--//endregion your codes 1-->
