<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>

<form:form action="${root}/operation/announcementMessage/systemNoticeHistory.html" method="post">
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['系统设置']}</span><span>/</span><span>${views.sysResource['消息公告']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12 m-b">
            <div class="wrapper white-bg shadow">
                <ul class="clearfix sys_tab_wrap">
                    <li><a href="/operation/announcementMessage/messageList.html" nav-target="mainFrame">${views.operation['SystemAnnouncement.sysMessage']}<span class="badge badge-blue m-l-sm">${length}</span></a></li>
                    <li class="active"><a href="javascript:void(0)">${views.operation['SystemAnnouncement.sysAnnouncement']}</a></li>
                    <li><a href="/operation/announcementMessage/gameAnnouncement.html" nav-target="mainFrame">${views.operation['SystemAnnouncement.gamemAnnouncement']}</a></li>
                    <%--<li><a href="/operation/announcementMessage/advisoryMessage.html" nav-target="mainFrame">${views.operation['SystemAnnouncement.playersAdvisory']}<span class="badge badge-blue m-l-sm">${advisoryUnReadCount}</span></a></li>--%>
                </ul>
                <div class="clearfix" style="padding:10px 10px;">
                    <div class="input-group content-width-limit-400 pull-left m-r">
                        <gb:dateRange format="${DateFormat.DAY}" style="width:100px" useRange="true" useToday="true"
                                      startName="search.startTime" endName="search.endTime" maxDate="${maxDate}"
                                      startDate="${command.search.startTime}" endDate="${command.search.endTime}"/>
                    </div>
                    <soul:button text="" target="query" opType="function" cssClass="btn btn-outline btn-filter" tag="button">
                        <i class="fa fa-search"></i>
                        <span class="hd">&nbsp;${views.common['search']}</span>
                    </soul:button>
                </div>

                <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
                    <div class="search-list-container">
                        <%@ include file="SystemNoticeHistoryPartial.jsp" %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form:form>

<soul:import res="site/operation/SystemNoticeHistory"/>
