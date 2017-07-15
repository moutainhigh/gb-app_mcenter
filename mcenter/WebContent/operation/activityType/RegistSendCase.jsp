<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.VActivityMessageListListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<%--返水优惠案例介绍--%>
<form:form>
<div class="row">
    <div class="position-wrap clearfix">
        <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
        <span>${views.sysResource['运营']}</span>
        <span>/</span><span>${views.sysResource['活动管理']}</span>
        <soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
            <em class="fa fa-caret-left"></em>${views.common['return']}
        </soul:button>
        <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
    </div>
    <div class="col-lg-12">
        <div class="wrapper white-bg clearfix shadow">
            <div class="sys_tab_wrap clearfix m-b-sm">
                <div class="m-sm">
                    <b class="fs16">${views.operation_auto['注册送案例介绍']}</b>
                </div>
            </div>
            <div class="panel blank-panel">
                <div class="panel-body">
                    <%@include file="RegistSendContent.jsp"%>
                </div>
            </div>
        </div>
    </div>

</div>
<soul:import type="view"/>
</form:form>
<!--//endregion your codes 1-->

