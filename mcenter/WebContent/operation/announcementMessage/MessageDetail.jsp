<%@ page contentType="text/html;charset=UTF-8" %>
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
            <div class="line-34 m-t-md p-sm">
                <%--<h3 class="al-center">${command.result.get(0).title}</h3>--%>
                    <pre style="white-space: pre-wrap;word-wrap: break-word;border: 0px;background-color: white">${command.result.get(0).content}</pre>
                <div class="al-right co-grayc2 m-b">${soulFn:formatDateTz(command.result.get(0).publishTime, DateFormat.DAY_SECOND,timeZone)}</div>
            </div>
        </div>
    </div>
</div>
</form>
<soul:import res="site/operation/announcementMessage"/>
