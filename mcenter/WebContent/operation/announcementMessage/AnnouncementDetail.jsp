<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.AnnouncementMessageVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<div class="row">
    <form>
        <input type="hidden" id="read" value="${read}"/>
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['系统设置']}</span><span>/</span><span>${views.sysResource['消息公告']}</span>
            <%--<a href="/operation/announcementMessage/messageList.html" nav-target="mainFrame" class="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn">--%>
            <%--<em class="fa fa-caret-left"></em>${views.common['return']}</a>--%>
            <%--低级多次下一页后，一键返回列表页面，需要直接访问列表页--%>
            <%--<soul:button target="/operation/announcementMessage/messageList.html" text="${views.common['return']}" opType="function" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" refresh="true">--%>
                <%--<em class="fa fa-caret-left"></em>${views.common['return']}--%>
            <%--</soul:button>--%>
            <a href="/operation/announcementMessage/messageList.html" nav-target="mainFrame" class="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn"><em class="fa fa-caret-left"></em>${views.common['return']}</a>

        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <br>
                <div class="al-right pull-right">
                    &lt;
                    <c:if test="${commandList.paging.pageNumber != 1}">
                        <a href="/operation/announcementMessage/announcementDetail.html?search.id=${s.id}&paging.pageNumber=${commandList.paging.pageNumber-1}"  nav-target="mainFrame" class="co-gray6">${views.column['上一条']}</a>
                    </c:if>
                    &nbsp;
                    <c:if test="${commandList.paging.pageNumber != commandList.paging.totalCount}">
                        <a href="/operation/announcementMessage/announcementDetail.html?search.id=${s.id}&paging.pageNumber=${commandList.paging.pageNumber+1}"  nav-target="mainFrame" class="co-gray6">${views.column['下一条']}</a>
                    </c:if>

                    &gt;&nbsp;&nbsp;&nbsp;
                </div>
                <div class="line-34 m-t-md p-sm">
                    <h3 class="al-center">${command.result.title}</h3>

                    <div class="al-center co-grayc2 m-b">${soulFn:formatDateTz(command.result.receiveTime, DateFormat.DAY_SECOND,timeZone)}</div>
                    <p class="con">${command.result.content}</p>
                </div>
            </div>
        </div>
    </form>
</div>
<soul:import res="site/operation/AnnouncementDetail"/>

