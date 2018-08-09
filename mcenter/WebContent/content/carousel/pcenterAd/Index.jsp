<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.VCttCarouselListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->
<!--//endregion your codes 1-->

<form:form action="${root}/content/vCttCarousel/viewPcenterAd.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>

            <!--//region your codes 2-->
    <div class="row">
    <div class="position-wrap clearfix">
        <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
        <span>${views.sysResource['内容']}</span><span>/</span><span>${views.sysResource['轮播广告']}</span>
        <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
    </div>
    <div class="col-lg-12">
        <div class="wrapper white-bg shadow">
            <%@include file="../CarouselTop.jsp"%>
            <!--筛选条件-->
            <div class="clearfix filter-wraper border-b-1">
                <soul:button target="${root}/content/cttCarousel/pcenterAd/create.html" callback="query"
                             cssClass="btn btn-info btn-addon" text="${views.content['新玩家中心首页广告']}" opType="dialog"
                              tag="button">
                    <i class="fa fa-plus"></i><span class="hd">${views.common['create']}</span>
                </soul:button>
                <a class="btn btn-outline btn-filter" nav-target="mainFrame"
                   href="/content/vCttCarousel/setting.html?search.type=${type}">
                    <i class="fa fa-sort-amount-desc m-r-xs"></i>${views.common['order']}
                </a>
                <div class="function-menu-show hide">
                    <soul:button target="${root}/content/cttCarousel/deleteByBatch.html" precall="deleteBatch" text="${views.common['delete']}"
                                 post="getSelectIds" opType="ajax" tag="button" cssClass="btn btn-danger-hide" callback="query">
                        <i class="fa fa-trash-o"></i><span class="hd">${views.common['delete']}</span>
                    </soul:button>
                </div>
                <div class="search-wrapper btn-group pull-right m-r-n-xs">
                    <div class="input-group">
                         <span class="input-group-addon">
                           ${views.column['CttCarouselI18n.name']}
                         </span>
                        <input type="text" name="search.name" value="${command.search.name}" class="form-control">
                        <span class="input-group-btn">
                            <soul:button cssClass="btn btn-filter _enter_submit" tag="button" target="query" text="${views.common['search']}" opType="function">
                                <i class="fa fa-search"></i>
                                <span class="hd">&nbsp;${views.common['search']}</span>
                            </soul:button>
                        </span>
                    </div>
                </div>
            </div>
            <!--表格内容-->
            <div id="editable_wrapper" class="dataTables_wrapper search-list-container" role="grid">
                <%@ include file="IndexPartial.jsp" %>
            </div>
        </div>
    </div>
    </div>
</form:form>
            <!--//endregion your codes 2-->

<!--//region your codes 3-->
<soul:import res="site/content/carousel/Index"/>
<!--//endregion your codes 3-->