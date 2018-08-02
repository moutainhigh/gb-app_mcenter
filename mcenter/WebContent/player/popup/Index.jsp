<%@ page import="org.soul.commons.dict.DictTool" %>
<%@ page import="so.wwb.gamebox.model.DictEnum" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<head>
    <title></title>
    <%@ include file="/include/include.head.jsp" %>
</head>

<body id="mainFrame">
    <form action="${root}/player/popup/list.html" method="post" name="playerForm">
        <div id="validateRule" style="display: none">${validateRule}</div>
        <%--代理ID过滤条件--%>
        <input name="search.agentId" value="${command.search.agentId}" type="hidden">
        <%--总代ID过滤条件--%>
        <input name="search.generalAgentId" value="${command.search.generalAgentId}" type="hidden">
        <%--返佣方案ID过滤条件--%>
        <input name="search.rakebackId" value="${command.search.rakebackId}" type="hidden">
        <input name="search.ip" value="${operateIp}" type="hidden"/>
        <input name="startTime" value="${soulFn:formatDateTz(command.startTime,DateFormat.DAY_SECOND,timeZone)}" type="hidden">
        <input name="endTime" value="${soulFn:formatDateTz(command.endTime,DateFormat.DAY_SECOND ,timeZone )}" type="hidden">
        <input name="promoteLink" value="${command.promoteLink}" type="hidden"/>
        <input name="outer" value="${command.outer}" type="hidden"/>
        <input name="comp" value="${command.comp}" type="hidden"/>
        <input name="search.tagId" value="${tagIds}" type="hidden">
        <div class="modal-body">
            <div>
                <div class="wrapper white-bg">
                    <div class="m-t-md">
                        <div class="m-b-xs clearfix">
                            <div class="col-sm-11 clearfix" style="padding-left: 0;">
                                <%--玩家账号--%>
                                <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                                    <div class="input-group">
                                        <span class="input-group-addon bg-gray">${views.player_auto['玩家']}</span>
                                            <input type="text" class="form-control account_input list-search-input-text"
                                                   name="search.username" id="operator" value="${command.search.username}"
                                                   placeholder="${views.player_auto['多个账号，用半角逗号隔开']}">
                                    </div>
                                </div>
                                <%--注册时间--%>
                                <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                                    <div class="input-group date time-select-a">
                                        <span class="input-group-addon bg-gray">${views.player_auto['注册时间']}</span>
                                        <gb:dateRange format="${DateFormat.DAY_SECOND}" style="width:38%" useRange="true"
                                                      opens="right" position="down"
                                                      startDate="${command.search.createTimeBegin}"
                                                      endDate="${command.search.createTimeEnd}"
                                                      startName="search.createTimeBegin" endName="search.createTimeEnd"/>
                                    </div>
                                </div>
                                <%--真实姓名--%>
                                <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                                    <div class="input-group">
                                        <span class="input-group-addon bg-gray">${views.player_auto['真实姓名']}</span>
                                        <input type="text" class="form-control account_input list-search-input-text"
                                               name="search.realName"
                                               value="${command.search.realName}"
                                               placeholder="">
                                    </div>
                                </div>
                                <div class="clearfix pull-left col-md-1 col-sm-12 m-b-sm padding-r-none-sm">
                                    <soul:button cssClass="btn btn-filter mediate-search-btn _enter_submit" tag="button" opType="function"
                                                 text="${views.common['search']}" target="query" precall="validateForm">
                                        <i class="fa fa-search"></i><span class="hd">&nbsp;${views.common['search']}</span>
                                    </soul:button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--表格内容-->
            <div class="search-list-container">
                <%@ include file="IndexPartial.jsp" %>
            </div>
        </div>
    </form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/popup/Index"/>
</html>