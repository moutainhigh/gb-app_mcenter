<%--@elvariable id="command" type="so.wwb.gamebox.model.company.sys.vo.VDomainCheckResultStatisticsListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>

<div class="modal-body m-sm">
    <span class="ym-title">${views.operation['域名检测完成！']}</span>
    <div class="bg-gray ym-title1">
        <div>
            <span>${views.operation['last_check_time']} <em class="ym-date">${soulFn:formatDateTz(command.checkTime, DateFormat.DAY_SECOND, timeZone )}</em></span>
        </div>
        <div>
            <span>${views.operation['域名检测情况如下所示（结果仅供参考）']}</span>
        </div>
    </div>
    <div class="table-ym" style="border-left: 1px solid #e7e7e7;border-right: 1px solid #e7e7e7;">
        <table class="table">
            <thead>
            <tr role="row" class="bg-gray">
                <th>${views.operation['域名状态']}</th>
                <th>${views.operation['域名条数']}</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>${dicts.common.domain_check_result_status['NORMAL']}</td>
                <td style="color: #0ba31e">${command.statusCount.all-command.statusCount.errAll}</td>
            </tr>
            <tr>

                <td>${dicts.common.domain_check_result_status['WALLED_OFF']}</td>
                <td class="curr">${command.statusCount.wallOF}</td>
            </tr>
            <tr>
                <td>${dicts.common.domain_check_result_status['BE_HIJACKED']}</td>
                <td class="curr">${command.statusCount.beHijached}</td>
            </tr>
            <tr>
                <td>${dicts.common.domain_check_result_status['UNRESOLVED']}</td>
                <td class="curr">${command.statusCount.unResolved}</td>
            </tr>
            <tr>
                <td>${dicts.common.domain_check_result_status['SERVER_UNREACHABLE']}</td>
                <td class="curr">${command.statusCount.serverUnreachable}</td>
            </tr>
            <tr>
                <td>${dicts.common.domain_check_result_status['UNKNOWN_ERR']}</td>
                <td class="curr">${command.statusCount.unknown}</td>
            </tr>
            <tr>
                <td>${dicts.common.domain_check_result_status['UNAUTHORIZED']}</td>
                <td class="curr">${command.statusCount.unAuthorized}</td>
            </tr>
            <tr>
                <td>${dicts.common.domain_check_result_status['REDIRECT']}</td>
                <td class="curr">${command.statusCount.redirect}</td>
            </tr>
            </tbody>
        </table>
    </div>
    <div class="modal-footer ym-btn">
        <a class="btn btn-link co-blue" onclick="closeDialog();"
           nav-target="mainFrame">${views.operation['查看详情']}</a>
    </div>
</div>
<script type="text/javascript">
   function closeDialog(){
       window.top.topPage.closeDialog();
       window.top.location.href="${root}#/operation/domainCheckData/getDomainCount.html";
   }
</script>
</html>
<!--//endregion your codes 1-->