<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--${views.sysResource['运营']}-${views.sysResource['消息公告']}-->
<form:form>
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['系统设置']}</span><span>/</span><span>${views.sysResource['消息公告']}</span>
            <a style="display: none" name="returnMain" href="/operation/announcementMessage/messageList.html" nav-target="mainFrame">${views.operation['SystemAnnouncement.sysAnnouncement']}</a>
        </div>

        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <ul class="clearfix sys_tab_wrap">
                    <li class="active"><a href="javascript:void(0)">${views.operation['SystemAnnouncement.sysMessage']}<span class="badge badge-blue m-l-sm">${length}</span></a></li>
                    <li><a href="/operation/announcementMessage/systemNoticeHistory.html" nav-target="mainFrame">${views.operation['SystemAnnouncement.sysAnnouncement']}</a></li>
                    <li><a href="/operation/announcementMessage/gameAnnouncement.html" nav-target="mainFrame">${views.operation['SystemAnnouncement.gamemAnnouncement']}</a></li>
                    <%--<li><a href="/operation/announcementMessage/advisoryMessage.html" nav-target="mainFrame">${views.operation['SystemAnnouncement.playersAdvisory']}<span class="badge badge-blue m-l-sm">${advisoryUnReadCount}</span></a></li>--%>
                </ul>
                <!--表格内容-->
                <div id="editable_wrapper" class="dataTables_wrapper search-list-container" role="grid">
                    <%@include file="IndexPartial.jsp"%>
                </div>
            </div>
        </div>
    </div>
</form:form>
<soul:import res="site/operation/announcementMessage"/>


