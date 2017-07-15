<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.PlayerTransactionVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form action="${root}/operation/announcementMessage/advisoryMessage.html" method="post">
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['角色']}</span><span>/</span><span>${views.sysResource['消息公告']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <ul class="clearfix sys_tab_wrap">
                    <li><a href="/operation/announcementMessage/messageList.html" nav-target="mainFrame">${views.operation['SystemAnnouncement.sysMessage']}<span class="badge badge-blue m-l-sm">${length}</span></a></li>
                    <li><a href="/operation/announcementMessage/systemNoticeHistory.html" nav-target="mainFrame">${views.operation['SystemAnnouncement.sysAnnouncement']}</a></li>
                    <li><a href="/operation/announcementMessage/gameAnnouncement.html" nav-target="mainFrame">${views.operation['SystemAnnouncement.gamemAnnouncement']}</a></li>
                    <li class="active"><a href="javascript:void(0)">${views.operation['SystemAnnouncement.playersAdvisory']}<span class="badge badge-blue m-l-sm">${advisoryUnReadCount}</span></a></li>
                </ul>
                <div class="clearfix filter-wraper border-b-1">
                    <div class="function-menu-show hide">
                        <soul:button target="deleteAdvisoryMessage" text="${views.common['delete']}" opType="function" cssClass="btn btn-outline btn-filter" confirm="${views.role['player.view.advisory.sureToDelete']}？"/>
                    </div>
                </div>
                <!--表格内容-->
                <div class="search-list-container">
                    <%@ include file="AdvisoryMessagePartial.jsp" %>
                </div>
            </div>
        </div>
    </div>
</form:form>

<soul:import res="site/operation/announcementMessage"/>


