<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.VActivityMessageListListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/activityHall/activity/order/list.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <!--//region your codes 2-->
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['运营']}&nbsp;&nbsp;/</span><span>${views.sysResource['活动管理']}</span>
                <soul:button tag="a" target="goToLastPage" text="" opType="function" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn">
                    <em class="fa fa-caret-left"></em>${views.common['return']}
                </soul:button>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <div class="sys_tab_wrap clearfix">
                    <div class=" clearfix m-sm">
                        <%--从活动大厅进入，展示下拉框--%>
                        <c:if test="${command.search.classify}">
                            <gb:select name="search.activityClassifyKey" value="${command.search.activityClassifyKey}"
                                       cssClass="btn-group chosen-select-no-single" callback="query"
                                       prompt="${views.operation['Activity.list.allCategory']}" list="${siteI18ns}" listKey="key"
                                       listValue="value"></gb:select>
                        </c:if>
                        &nbsp;&nbsp;&nbsp;
                        <i class="fa fa-exclamation-circle"></i><span class="co-yellow m-l-sm">${views.common['DynamicLie.draggingSort']}</span>
                    </div>
                </div>
                <!--表格内容-->
                <div id="editable_wrapper" class="dataTables_wrapper search-list-container" role="grid">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
                <div class="operate-btn">
                    <soul:button  permission="operate:activityHall_order"  target="saveActivityOrder" text="${views.common['save']}" opType="function"
                                 cssClass="btn btn-outline btn-filter btn-lg m-r" >${views.common['save']}</soul:button>
                </div>
            </div>
        </div>
    </div>

    <!--//endregion your codes 2-->
</form:form>

<!--//region your codes 3-->
<soul:import res="site/operation/activityHall/ActivityOrder"/>
<!--//endregion your codes 3-->