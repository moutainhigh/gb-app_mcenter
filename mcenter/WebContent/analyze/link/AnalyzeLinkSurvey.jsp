<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>

<form:form action="${root}/vAnalyzePlayer/analyzeLinkSurvey.html" method="post">
    <style>
        .table th, .table td {
            text-align: center;
        }
    </style>
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['分析']}</span><span>/</span><span>${views.sysResource['推广链接新进']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12 m-b">
            <div class="wrapper white-bg shadow">
                <ul class="clearfix sys_tab_wrap">

                    <li ><a href="/vAnalyzePlayer/analyzeLink.html" nav-target="mainFrame">${views.analyze['新近情况']}</a></li>
                    <li class="active"><a href="javascript:void(0)">${views.analyze['总况']}</a></li>
                </ul>
                <div class="clearfix" style="padding:10px 10px;" id="searchDiv">
                        <%--玩家账号--%>
                    <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                        <div class="input-group date">
                            <span class="input-group-addon bg-gray">&nbsp;&nbsp;${views.analyze['代理账号']}&nbsp;</span>
                            <input  class="form-control search" type="text" name="search.username" placeholder="${views.analyze['多个账号，用半角逗号隔开']}" value="${command.search.username}"/>
                        </div>
                    </div>

                            <%--推广链接--%>
                        <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                            <div class="input-group date">
                                <span class="input-group-addon bg-gray">&nbsp;&nbsp;${views.analyze['推广链接']}&nbsp;</span>
                                <input  class="form-control search" type="text" name="search.promoteLink" placeholder="" value="${command.search.promoteLink}"/>
                            </div>
                        </div>

                            <%--<div class="search-wrapper form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm senior">--%>
                                <%--<div class="input-group">--%>
                                    <%--<div class="input-group-btn">--%>
                                        <%--<c:choose>--%>
                                            <%--<c:when test="${!empty command.search.agentName}">--%>
                                                <%--<c:set var="searchVal" value="${command.search.agentName}"/>--%>
                                                <%--<c:set var="searchkey" value="search.agentName"/>--%>
                                            <%--</c:when>--%>
                                            <%--<c:otherwise>--%>
                                                <%--<c:set var="searchVal" value="${command.search.promoteLink}"/>--%>
                                                <%--<c:set var="searchkey" value="search.promoteLink"/>--%>
                                            <%--</c:otherwise>--%>

                                        <%--</c:choose>--%>
                                        <%--<gb:select name="stSel" list="${command.searchList()}" listKey="key" listValue="value" value="${searchkey}" callback="selectListChange" prompt="" cssClass="chosen-select-no-single"/>--%>
                                    <%--</div>--%>
                                    <%--<input type="text" class="form-control list-search-input-text searchKey" name="${searchkey}" value="${search}" placeholder="${views.analyze_auto['推广链接']}">--%>
                                <%--</div>--%>
                            <%--</div>--%>


                    <soul:button text="" target="query" opType="function" cssClass="btn btn-filter" tag="button">
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
                        <%--<soul:button target="${root}/vAnalyzePlayer/analyzeParam.html" text="${views.analyze_auto['有效玩家']}" title="${views.analyze_auto['有效玩家']}" callback="query" opType="dialog" cssClass="btn btn-outline btn-filter pull-right"><i class="fa fa-gear"></i>${views.analyze_auto['有效玩家']}</soul:button>--%>
                </div>


                <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
                    <div class="search-list-container">
                        <%@ include file="AnalyzeLinkSurveyPartial.jsp" %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form:form>

<soul:import res="site/analyze/Index"/>
