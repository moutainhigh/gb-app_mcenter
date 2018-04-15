<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.VActivityMessageListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
    <!--//region your codes 3-->
<!--活动发布情况-->
    <div class="row" id="step4" style="display: none">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['运营']}</span>
            <span>/</span><span>${views.sysResource['活动管理']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <ul class="artificial-tab clearfix">
                    <c:choose>
                        <c:when test="${activityType.result.code eq 'content'}">
                            <li class="col-sm-3 col-xs-12 p-x"><a class="no" href="javascript:void(0)"><span class="no">1</span><span class="con">${views.operation['Activity.content']}</span></a></li>
                            <li class="col-sm-3 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">2</span><span class="con">${views.operation['Activity.preview']}</span></a></li>
                            <li class="col-sm-3 col-xs-12 p-x"><a href="javascript:void(0)" class="current"><span class="no">3</span><span class="con">${views.operation['Activity.finish']}</span></a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="col-sm-3 col-xs-12 p-x"><a class="no" href="javascript:void(0)"><span class="no">1</span><span class="con">${views.operation['Activity.content']}</span></a></li>
                            <li class="col-sm-3 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">2</span><span class="con">${views.operation['Activity.rule']}</span></a></li>
                            <li class="col-sm-3 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">3</span><span class="con">${views.operation['Activity.preview']}</span></a></li>
                            <li class="col-sm-3 col-xs-12 p-x"><a href="javascript:void(0)" class="current"><span class="no">4</span><span class="con">${views.operation['Activity.finish']}</span></a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
                <div class="fundsContext step-finish p-b-lg clearfix">
                    <div class="col-xs-5 al-right">
                        <i class="success fa fa-smile-o"></i>
                    </div>
                    <div class=" col-xs-7">
                        <div class="success p-t-sm">${views.operation['operation.success']}</div>
                    </div>
                </div>
                <div class="operate-btn">
                    <shiro:hasPermission name="operate:activity_add">
                        <a href="/activityHall/activityType/customList.html" nav-target="mainFrame" class="btn btn-filter btn-lg m-l">${views.operation['operation.continue']}</a>
                    </shiro:hasPermission>
                    <a nav-target="mainFrame" href="/activityHall/vActivityMessageHall/list.html" class="btn btn-filter btn-lg m-l">${views.operation['operation.searchList']}</a>
                </div>
            </div>
        </div>
    </div>

<div class="row" id="step5" style="display: none">
    <div class="position-wrap clearfix">
        <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
        <span>${views.sysResource['运营']}</span>
        <span>/</span><span>${views.sysResource['活动管理']}</span>
        <a href="javascript:void(0)" nav-target="mainFrame" class="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn"><em class="fa fa-caret-left"></em>${views.common['return']}</a>
        <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
    </div>
    <div class="col-lg-12">
        <div class="wrapper white-bg shadow">
            <ul class="artificial-tab clearfix">
                <li class="col-sm-3 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">1</span><span class="con">${views.operation['Activity.content']}</span></a></li>
                <li class="col-sm-3 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">2</span><span class="con">${views.operation['Activity.rule']}</span></a></li>
                <li class="col-sm-3 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">3</span><span class="con">${views.operation['Activity.preview']}</span></a></li>
                <li class="col-sm-3 col-xs-12 p-x"><a class="current" href="javascript:void(0)"><span class="no">4</span><span class="con">${views.operation['Activity.finish']}</span></a></li>
            </ul>
            <div class="fundsContext step-finish p-b-lg clearfix">
                <div class="col-xs-5 al-right">
                    <i class="success fa fa-smile-o"></i>
                </div>
                <div class=" col-xs-7">
                    <div class="success p-t-sm">${views.operation['operation.failure']}</div>
                </div>
            </div>
            <div class="operate-btn">
                <shiro:hasPermission name="operate:activity_add">
                    <a href="/activityHall/activityType/customList.html" nav-target="mainFrame" class="btn btn-filter btn-lg m-l">${views.operation['operation.retry']}</a>
                </shiro:hasPermission>
                <a nav-target="mainFrame" href="/activityHall/vActivityMessageHall/list.html" class="btn btn-filter btn-lg m-l">${views.operation['operation.abandonOperations']}</a>
            </div>
        </div>
    </div>
</div>
    <!--//endregion your codes 3-->