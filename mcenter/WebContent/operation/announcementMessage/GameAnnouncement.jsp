<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--${views.sysResource['运营']}-${views.sysResource['消息公告']}-->
<div class="row">
    <form:form action="${root}/operation/announcementMessage/gameAnnouncement.html" method="post">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['系统设置']}</span><span>/</span><span>${views.sysResource['消息公告']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <ul class="clearfix sys_tab_wrap">
                    <li><a href="/operation/announcementMessage/messageList.html" nav-target="mainFrame">${views.operation['SystemAnnouncement.sysMessage']}<span class="badge badge-blue m-l-sm">${length}</span></a></li>
                    <li><a href="/operation/announcementMessage/systemNoticeHistory.html" nav-target="mainFrame">${views.operation['SystemAnnouncement.sysAnnouncement']}</a></li>
                    <li class="active">
                        <a href="javascript:void(0)">${views.operation['SystemAnnouncement.gamemAnnouncement']}</a>
                    </li>
                    <%--<li><a href="/operation/announcementMessage/advisoryMessage.html" nav-target="mainFrame">${views.operation['SystemAnnouncement.playersAdvisory']}<span class="badge badge-blue m-l-sm">${advisoryUnReadCount}</span></a></li>--%>
                </ul>
                <div class="clearfix" style="padding:10px 10px;">
                    <div class="input-group content-width-limit-400 pull-left">
                        <gb:dateRange format="${DateFormat.DAY}" style="width:100px" useRange="true" useToday="true"
                                      startName="search.startTime" endName="search.endTime" maxDate="${maxDate}"
                                      startDate="${command.search.startTime}" endDate="${command.search.endTime}"></gb:dateRange>
                    </div>
                    <div class="input-group pull-left m-l m-r">
                        <select style="width: 200px" btnStyle="width:200px" ulStyle="width:200px" class="btn-group chosen-select-no-single chosen-select-add-mid-width" name="search.apiId" data-placeholder="${views.common['pleaseSelect']}">
                            <option value="">${views.operation['SystemAnnouncement.gamemAnnouncement.allGames']}</option>
                            <c:forEach items="${apiMap}" var="s">
                                <option value="${s.value.apiId}">${gbFn:getSiteApiName(s.value.apiId)}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <soul:button text="" target="query" opType="function" cssClass="btn btn-outline btn-filter _enter_submit" tag="button">
                        <i class="fa fa-search"></i>
                        <span class="hd">&nbsp;${views.common['search']}</span>
                    </soul:button>
                </div>
                <!--表格内容-->
                <div class="search-list-container">
                    <%@include file="GameAnnouncementPartial.jsp" %>
                </div>
            </div>
        </div>
    </form:form>
</div>

<soul:import res="site/operation/announcementMessage"/>


