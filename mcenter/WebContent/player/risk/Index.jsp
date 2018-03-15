<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>

<div class="row">
    <form:form action="${root}/riskManagementSite/list.html" method="post" name="playerOnlineForm">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['角色']}</span><span>/</span><span>${views.common['风控数据']}</span>
            <soul:button target="goToLastPage" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>

        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <div class="clearfix filter-wraper border-b-1">

                    <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                        <div class="input-group date time-select-a">
                            <span class="input-group-addon bg-gray">${views.common['创建时间']}</span>
                            <gb:dateRange format="${DateFormat.DAY_SECOND}" style="width:38%" useRange="true"
                                          opens="right" position="down"
                                          startDate="${command.search.startTime}"
                                          endDate="${command.search.endTime}"
                                          startName="search.startTime" endName="search.endTime"/>
                        </div>
                    </div>

                    <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                        <div class="input-group">
                            <span class="input-group-addon bg-gray">${views.player_auto['风控标识']}</span>
                            <gb:select name="search.dataType" value="" prompt="${views.content['全部']}"
                                       list="${command.riskDicts}"/>
                        </div>
                    </div>




                    <span class="input-group-btn">
                        <soul:button target="query" precall="" opType="function" cssClass="btn btn-filter btn-query-css" tag="button" text="">
                            <i class="fa fa-search"></i>
                            <span class="hd">&nbsp;${views.common['search']}</span>
                        </soul:button>
                    </span>


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
