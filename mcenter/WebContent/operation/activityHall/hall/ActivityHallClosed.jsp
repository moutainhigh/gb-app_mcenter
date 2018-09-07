<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.VActivityMessageListListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/activityHall/vActivityMessageHall/list.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <!--//region your codes 2-->
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['运营']}&nbsp;&nbsp;/</span><span>${views.sysResource['活动大厅']}</span>
            <soul:button tag="a" target="goToLastPage" text="" opType="function"
                         cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                活动大厅参数关闭，请联系客服确认是否开启活动大厅。
        </div>
    </div>
    <!--//endregion your codes 2-->
</form:form>

<!--//region your codes 3-->
<soul:import res="site/operation/activityHall/Activity"/>
<!--//endregion your codes 3-->