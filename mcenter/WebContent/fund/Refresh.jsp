<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.vo.VPlayerDepositListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<%--定时刷新页面--%>
<div class="btn-group m-r-sm pull-right" id="timer">
    <a href="javascript:void(0)" class="btn btn-primary-hide" id="refreshQuery"><i class="fa fa-refresh"></i><span class="hd" totalMillisecond="refresh" data-value="refresh">${views.fund_auto['不刷新']}</span></a>
    <a href="javascript:void(0)" class="btn btn-primary-hide dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><span class="caret"></span></a>
    <ul class="dropdown-menu" style="max-height: 300px; min-width: 100px; min-height: 25px; overflow-y: auto; overflow-x: visible;">
        <li><a href="javascript:void(0)" role="menuitem" style="white-space: normal;" data-value="">${views.fund_auto['不刷新']}</a></li>
        <li><a href="javascript:void(0)" role="menuitem" style="white-space: normal;" data-value="refresh">${views.fund_auto['自动']}</a></li>
        <li><a href="javascript:void(0)" role="menuitem" style="white-space: normal;" data-value="15">15${views.fund_auto['秒']}</a></li>
        <li><a href="javascript:void(0)" role="menuitem" style="white-space: normal;" data-value="30">30${views.fund_auto['秒']}</a></li>
        <li><a href="javascript:void(0)" role="menuitem" style="white-space: normal;" data-value="60">60${views.fund_auto['秒']}</a></li>
        <li><a href="javascript:void(0)" role="menuitem" style="white-space: normal;" data-value="120">120${views.fund_auto['秒']}</a></li>
    </ul>
</div>