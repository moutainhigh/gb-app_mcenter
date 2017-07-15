<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>

<div class="row">
    <form:form action="${root}/vPlayerOnline/list.html" method="post">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['角色']}</span><span>/</span><span>${views.sysResource['在线玩家']}</span>
            <soul:button target="goToLastPage" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>

        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <div class="clearfix filter-wraper border-b-1">
                    <div class="search-wrapper btn-group pull-right m-r-n-xs">
                        <div class="input-group">
                            <div class="input-group-btn">
                                <select tabindex="-1" data-placeholder="${views.common['pleaseSelect']}" class="btn-group chosen-select-no-single" id="searchlist" >
                                    <option value="search.username" selected>${views.column['VPlayerOnline.username']}</option>
                                    <option value="search.ip">${views.column['VPlayerOnline.ip']}</option>
                                </select>
                            </div>
                            <form:input path="search.username" type="text" class="form-control list-search-input-text" id="searchtext"/>
                        <span class="input-group-btn">
                            <soul:button target="query" precall="checksearch" opType="function" cssClass="btn btn-filter btn-query-css" tag="button" text="">
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
