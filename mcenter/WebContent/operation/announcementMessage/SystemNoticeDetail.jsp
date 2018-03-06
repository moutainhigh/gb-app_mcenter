<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>

<form>
<div class="row">
    <div class="position-wrap clearfix">
        <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
        <span>${views.sysResource['系统设置']}</span><span>/</span><span>${views.sysResource['消息公告']}</span>
        <soul:button target="goToLastPage" text="${views.common['return']}" opType="function" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" refresh="true">
            <em class="fa fa-caret-left"></em>${views.common['return']}
        </soul:button>
    </div>
    <div class="col-lg-12">
        <div class="wrapper white-bg shadow">
            <br>
            <div class="al-right pull-right">
                &lt;
                <c:if test="${vSystemAnnouncementListVo.paging.pageNumber != 1}">
                    <a href="/operation/announcementMessage/systemNoticeDetail.html?search.id=&search.startTime=${soulFn:formatDateTz(vSystemAnnouncementListVo.search.startTime, DateFormat.DAY_SECOND,timeZone)}&search.endTime=${soulFn:formatDateTz(vSystemAnnouncementListVo.search.endTime, DateFormat.DAY_SECOND,timeZone)}&paging.pageNumber=${vSystemAnnouncementListVo.paging.pageNumber-1}"  nav-target="mainFrame" class="co-gray6">上一条</a>
                </c:if>
                &nbsp;
                <c:if test="${vSystemAnnouncementListVo.paging.pageNumber != vSystemAnnouncementListVo.paging.totalCount}">
                    <a href="/operation/announcementMessage/systemNoticeDetail.html?search.id=&search.startTime=${soulFn:formatDateTz(vSystemAnnouncementListVo.search.startTime, DateFormat.DAY_SECOND,timeZone)}&search.endTime=${soulFn:formatDateTz(vSystemAnnouncementListVo.search.endTime, DateFormat.DAY_SECOND,timeZone)}&paging.pageNumber=${vSystemAnnouncementListVo.paging.pageNumber+1}"  nav-target="mainFrame" class="co-gray6">下一条</a>
                </c:if>

                &gt;&nbsp;&nbsp;&nbsp;
            </div>
            <div class="line-34 m-t-md p-sm">
                <pre style="white-space: pre-wrap;word-wrap: break-word;border: 0px;background-color: white"><p>${vSystemAnnouncementListVo.result.get(0).content}</p></pre>
                <div class="al-right co-grayc2 m-b">${soulFn:formatDateTz(vSystemAnnouncementListVo.result.get(0).publishTime, DateFormat.DAY_SECOND,timeZone)}</div>
            </div>
        </div>
    </div>
</div>
</form>
<soul:import res="site/operation/SystemNoticeDetail"/>
