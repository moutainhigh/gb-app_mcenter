<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="row">
    <form name="detectForm" action="${root}/fund/playerDetect/userPlayView.html" method="post">
        <input style='display:none' title="${views.fund_auto['防止按回车键自动提交表单']}" />
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont"></i> </a></h2>
            <span>${views.sysResource['角色']}&nbsp;&nbsp;&nbsp;&nbsp;/ </span>
            <span>${views.sysResource['玩家检测']}</span>
            <soul:button target="goToLastPage" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <div class="present_wrap"><b>${views.fund['fund.playerDetect.index.playerTest']}</b></div>
                <%--<div class="clearfix m-b bg-gray p-t-xs p-l-sm p-r-sm">--%>
                    <%--<span class="co-orange fs36 line-hi25 pull-left m-r-sm">--%>
                        <%--<i class="fa fa-exclamation-circle m-t-n-sm"></i>--%>
                    <%--</span>--%>
                    <%--<div class="line-hi25 pull-left m-b-sm">可通过玩家账号检测该玩家是否存在手机号，真实姓名，邮箱，IP等是否存在相同的情况！</div>--%>
                <%--</div>--%>
                <div class="clearfix filter-wraper border-b-1">
                    <div class="search-wrapper btn-group pull-left m-r-n-xs">
                        <div class="input-group">
                            <input type="text" name="search.username" class="form-control" placeholder="${views.fund['playerDetect.view.playerAccount']}" value="${command1.search.username}"/>
                            <span class="input-group-btn">
                                <soul:button target="checkQuery" opType="function" cssClass="btn btn-filter btn-query-css _enter_submit" tag="button" text="">
                                    <i class="fa fa-search"></i>
                                    <span class="hd">&nbsp;${views.common['detection']}</span>
                                </soul:button>
                            </span>
                        </div>
                    </div>
                </div>
                <div id="editable_wrapper" class="dataTables_wrapper check-search-list" role="grid">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
            </div>
        </div>
    </form>
</div>
<soul:import res="site/fund/player.detect/Index"/>