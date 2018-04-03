<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.ActivityTypeListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/activityHall/activityType/customList.html" method="post">
    <!--//region your codes 2-->
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['运营']}</span>
            <span>/</span><span>${views.sysResource['活动大厅']}</span>
            <soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <div class="present_wrap"><b>${views.operation['Activity.create']}</b></div>
                <ul class="events-list clearfix">
                    <c:forEach items="${command}" var="p" varStatus="status">
                        <li class="col-lg-3 col-md-4 col-sm-6">
                            <div class="item">
                                <div class="title clearfix">
                                    <img src="${resRoot}${p.logo}">
                                    <div>
                                        <h3>${views.operation[p.code]}</h3>
                                        <span>${views.operation["activity.introduce.".concat(p.code)]}</span>
                                    </div>
                                </div>
                                <%--<c:choose>
                                    <c:when test="${!p.hasUseRank}">
                                        <a href="javascript:void(0)" class="disabled btn btn-filter cj">${views.operation['Activity.create']}</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="/operation/activityType/choose.html?result.code=${p.code}" nav-target="mainFrame" class="btn btn-filter cj">${views.operation['Activity.create']}</a>
                                    </c:otherwise>
                                </c:choose>--%>
                                <a href="/activityHall/activityType/choose.html?result.code=${p.code}" nav-target="mainFrame" class="btn btn-filter cj">
                                        ${views.operation['Activity.create']}
                                </a>

                                <c:if test="${p.code ne 'content' && p.code ne 'money'}">
                                    <a href="/activityHall/activityType/chooseCase.html?result.code=${p.code}"
                                       nav-target="mainFrame" class="btn js">${views.operation['Activity.introduction']}</a>
                                </c:if>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
    <!--//endregion your codes 2-->
</form:form>

<!--//region your codes 3-->
<soul:import res="site/operation/activityHall/Create"/>
<!--//endregion your codes 3-->