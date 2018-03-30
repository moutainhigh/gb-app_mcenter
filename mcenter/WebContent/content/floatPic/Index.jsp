<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.VCttCarouselListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/cttFloatPic/list.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
        <!--//region your codes 2-->
        <div class="row">
            <div class="position-wrap clearfix">
                <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
                <span>${views.sysResource['内容']}</span>
                <span>/</span><span>${views.sysResource['浮动图管理']}</span>
                <soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                    <em class="fa fa-caret-left"></em>${views.common['return']}
                </soul:button>
                <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
                <input type="hidden" name="floatType" value="${floatType}">
            </div>
            <div class="col-lg-12">
                <div class="wrapper white-bg shadow">
                    <ul class="clearfix sys_tab_wrap">
                        <li id="li_top_1" class="<c:if test="${empty floatType}">active</c:if>">
                            <a href="/cttFloatPic/list.html" nav-target="mainFrame">${views.common['客服浮动图']}</a>
                        </li>
                        <li id="li_top_2" class="<c:if test="${'activity'.equals(floatType)}">active</c:if>">
                            <a href="/cttFloatPic/list.html?floatType=activity" nav-target="mainFrame">${views.common['活动浮动图']}</a>
                        </li>
                    </ul>
                    <!--筛选条件-->
                    <div class="clearfix filter-wraper border-b-1">
                        <%--<soul:button target="${root}/cttFloatPic/create.html" callback="query" title="${views.common['newFloatPic']}"
                                     cssClass="btn btn-info btn-addon" text="${views.common['newFloatPic']}" opType="dialog" tag="button">
                            <i class="fa fa-plus"></i><span class="hd">${views.common['newFloatPic']}</span>
                        </soul:button>--%>
                        <a href="/cttFloatPic/create.html?editType=1&floatType=${floatType}" nav-target="mainFrame" class="btn btn-info btn-addon pull-left" style="margin: 0px 10px 5px 0px">
                            <i class="fa fa-plus"></i><span class="hd">${views.common['newFloatPic']}</span></a>

                        <c:if test="${not empty floatType}">
                            <a class="btn btn-outline btn-filter" nav-target="mainFrame"
                               href="/cttFloatPic/FloatOrder.html">
                                <i class="fa fa-sort-amount-desc m-r-xs"></i>${views.common['order']}
                            </a>
                        </c:if>
                        <div class="function-menu-show hide">
                            <soul:button tag="button" cssClass="btn btn-danger-hide" target="batchDelete"
                                         text="${views.common['delete']}" opType="function" dataType="json" callback="query">
                                <i class="fa fa-trash-o"></i><span class="hd">${views.common['delete']}</span></soul:button>
                        </div>

                    </div>
                    <!--表格内容-->
                    <div id="editable_wrapper" class="search-list-container dataTables_wrapper" role="grid">
                        <%@ include file="IndexPartial.jsp" %>
                    </div>
                </div>
            </div>
        </div>
        <!--//endregion your codes 2-->
</form:form>

<!--//region your codes 3-->
<soul:import res="site/content/floatPic/FloatList"/>
<!--//endregion your codes 3-->