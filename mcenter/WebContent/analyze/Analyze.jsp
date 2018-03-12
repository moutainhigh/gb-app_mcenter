<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>

<form:form action="${root}/vAnalyzePlayer/analyze.html" method="post">
    <style>
        .table th, .table td {
            text-align: center;
        }
    </style>
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['分析']}</span><span>/</span><span>${views.sysResource['代理新进']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12 m-b">
            <div class="wrapper white-bg shadow">
                <ul class="clearfix sys_tab_wrap">
                    <li class="active"><a href="javascript:void(0)">${views.analyze['新近情况']}</a></li>
                    <li><a href="/vAnalyzePlayer/analyzeSurvey.html" nav-target="mainFrame">${views.analyze['总况']}</a></li>
                </ul>
                <div class="clearfix" style="padding:10px 10px;" id="searchDiv">
                        <%--时间--%>
                    <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm ">
                        <div class="input-group date time-select-a">
                            <span class="input-group-addon bg-gray">${views.analyze_auto['时间']}</span>
                            <gb:dateRange format="${DateFormat.DAY_SECOND}" minDate="${minDate}" maxDate="${maxDate}"
                                          useRange="true" style="width:40%;" useToday="true" btnClass="search"
                                          startName="search.startStaticTime" endName="search.endStaticTime"
                                          startDate="${command.search.startStaticTime}"
                                          endDate="${command.search.endStaticTime}"/>
                        </div>
                    </div>


                        <%--玩家账号--%>
                    <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                        <div class="input-group date">
                            <span class="input-group-addon bg-gray">&nbsp;&nbsp;${views.analyze['代理账号']}&nbsp;</span>
                            <input class="form-control search" type="text" name="search.username"
                                   placeholder="${views.analyze['多个账号，用半角逗号隔开']}" value="${command.search.username}"/>
                        </div>
                    </div>


                    <soul:button text="" target="query" opType="function" cssClass="btn btn-outline btn-filter queryAnalyze _enter_submit"
                                 tag="button">
                        <i class="fa fa-search"></i>
                        <span class="hd">&nbsp;${views.common['search']}</span>
                    </soul:button>
                            <span hidden id="staticEnd">${command.staticTimeParam.paramValue}</span>
                            <div class="btn-group m-r-sm pull-right">
                                <soul:button target="staticToday" text=""
                                              opType="function" cssClass="btn btn-outline btn-filter pull-right searchToday">
                                    <i class="fa fa-search"></i>
                                    ${views.analyze['分析截止']}:<span id="searchToday">${command.staticTimeParam.paramValue}</span>
                                </soul:button>
                            </div>



                    <div class="btn-group m-r-sm pull-right">
                        <soul:button target="${root}/vAnalyzePlayer/analyzeParam.html" text="${views.analyze_auto['有效玩家']}" title="${views.analyze_auto['有效玩家']}"
                                     callback="query" opType="dialog"
                                     cssClass="btn btn-outline btn-filter pull-right"><i
                                class="fa fa-gear"></i>${views.analyze['有效玩家']}</soul:button>
                    </div>

                </div>


                <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
                    <div class="search-list-container">
                        <%@ include file="AnalyzePartial.jsp" %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form:form>

<soul:import res="site/analyze/Index"/>
