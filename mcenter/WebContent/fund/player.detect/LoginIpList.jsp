<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="detect-title">${views.fund['fund.playerDetect.index.register']}</div>
<div class="clearfix p-xs">
    <soul:button target="loginIpException" opType="function" cssClass="pull-right btn btn-outline btn-filter" text="${views.fund['fund.playerDetect.index.showExceptionMessage']}" tag="button"/>
</div>
<div class="table-responsive">
    <table class="table table-striped table-bordered table-desc-list">
        <thead>
        <tr>
            <th>${views.fund['fund.playerDetect.index.time']}</th>
            <th>${views.fund['fund.playerDetect.index.ipAddr']}</th>
            <th>${views.fund['fund.playerDetect.index.device']}</th>
            <th>${views.fund['fund.playerDetect.index.otherAccountLogin']}</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${loginIpList}" var="loginIp" varStatus="status" begin="0" end="9">
            <tr>
                <td>${soulFn:formatDateTz(loginIp.operateTime, DateFormat.DAY_SECOND,timeZone)}</td>
                <td>IP:${soulFn:formatIp(loginIp.operateIp)}<br/>${gbFn:getShortIpRegion(loginIp.operateIpDictCode)}</td>
                <td>${views.fund['fund.playerDetect.index.system']}:${loginIp.clientOs}<br/>${views.fund['fund.playerDetect.index.browser']}:${loginIp.clientBrowser}</td>
                <td><a href="/player/list.html?search.ip=${loginIp.operateIp}&search.hasReturn=true" nav-target="mainFrame">${loginIp.otherUserLoginCount}</a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<div class="clearfix p-xs"><a href="/report/log/logList.html?search.roleType=player&hasReturn=true&search.operator=${username}" class="pull-right" nav-target="mainFrame">${views.fund['fund.playerDetect.index.showAll']}</a></div>
<!--展示异常信息-->
<div class="modal inmodal in" id="loginIpException" tabindex="-1" role="dialog" aria-hidden="false">
    <div class="modal-dialog">
        <div class="modal-content animated bounceInRight family">
            <div class="modal-header">
                <span class="filter">${views.fund['fund.playerDetect.index.showExceptionMessage']}</span>
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">${views.fund['fund.playerDetect.index.close']}</span> </button>
            </div>
            <div class="modal-body">
                <div class="tab-content">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover dataTable m-b-none">
                            <thead>
                            <tr>
                                <th>${views.fund['fund.playerDetect.index.time']}</th>
                                <th>${views.fund['fund.playerDetect.index.ipAddr']}</th>
                                <th>${views.fund['fund.playerDetect.index.device']}</th>
                                <th>${views.fund['fund.playerDetect.index.otherAccountLogin']}</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${loginIpListExc}" var="loginIp" varStatus="status" begin="0" end="9">
                                <tr>
                                    <td>${soulFn:formatDateTz(loginIp.operateTime, DateFormat.DAY_SECOND,timeZone)}</td>
                                    <td>IP:${soulFn:formatIp(loginIp.operateIp)}<br/>${gbFn:getShortIpRegion(loginIp.operateIpDictCode)}</td>
                                    <td>${views.fund['fund.playerDetect.index.system']}:${loginIp.clientOs}<br/>${views.fund['fund.playerDetect.index.browser']}:${loginIp.clientBrowser}</td>
                                    <td>${loginIp.otherUserLoginCount}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>