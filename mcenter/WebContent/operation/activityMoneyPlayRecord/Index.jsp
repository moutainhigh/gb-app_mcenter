<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>

<div class="row">
    <form:form action="${root}/activityMoneyPlayRecord/list.html" method="post" name="playerOnlineForm">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['运营']}&nbsp;&nbsp;/</span><span>${views.sysResource['活动管理']}</span>
            <soul:button target="goToLastPage" refresh="false" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <div class="clearfix filter-wraper border-b-1">
                    <div class="search-wrapper btn-group pull-left m-r-n-xs">
                        <div class="input-group">
                            <input type="text" name="search.username" class="form-control" placeholder="${views.fund['playerDetect.view.playerAccount']}" value="${command1.search.username}"/>
                            <span class="input-group-btn">
                                <soul:button target="checkQuery" opType="function" cssClass="btn btn-filter btn-query-css" tag="button" text="">
                                    <i class="fa fa-search"></i>
                                    <span class="hd">&nbsp;${views.common['search']}</span>
                                </soul:button>
                            </span>
                        </div>
                    </div>


                </div>
                <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
                    <div class="search-list-container">
                        <%@ include file="IndexPartial.jsp" %>
                    </div>
                </div>
            </div>
        </div>
    </form:form>
</div>
<soul:import res="site/player/playeronline/Playeronline"/>