<%@ page import="org.soul.commons.dict.DictTool" %>
<%@ page import="so.wwb.gamebox.model.DictEnum" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VUserPlayerListVo"--%>
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
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['角色']}</span><span>/</span>
            <span>${views.sysResource['玩家管理']}</span>
        </div>

        <input name="search.rankId" value="${command.search.rankId}" type="hidden">
        <input name="search.agentId" value="${command.search.agentId}" type="hidden">
        <input name="search.generalAgentId" value="${command.search.generalAgentId}" type="hidden">
        <input name="search.ip" value="${operateIp}" type="hidden"/>
        <input name="search.recommendUserId" value="${command.search.recommendUserId}" type="hidden"/>
        <input name="search.timeZoneInterval" value="${command.search.timeZoneInterval}" type="hidden">
        <input name="analyzeNewAgent" value="${command.analyzeNewAgent}" type="hidden">
        <input name="searchType" value="${command.searchType}" type="hidden">
        <input name="startTime" value="${soulFn:formatDateTz(command.startTime,DateFormat.DAY_SECOND,timeZone)}"
               type="hidden">
        <input name="endTime" value="${soulFn:formatDateTz(command.endTime,DateFormat.DAY_SECOND ,timeZone )}"
               type="hidden">
        <input name="search.registerIp" value="${command.search.registerIp}" type="hidden"/>
        <input name="outer" value="${command.outer}" type="hidden"/>
        <input name="comp" value="${command.comp}" type="hidden"/>
        <input type="hidden" name="search.tagId" value="${tagIds}">
        <%--返水方案--%>
        <input name="search.rakebackId" value="${command.search.rakebackId}" type="hidden">
        <%--<input name="search.lastLoginIp" value="${command.search.lastLoginIp}" type="hidden"/>--%>
        <%-- //没有这几项从检测页面跳转过来时如果有翻页会有问题，但又会和查询条件冲突
        <input name="search.qq" value="${command.search.qq}" type="hidden"/>
        <input name="search.mobilePhone" value="${command.search.mobilePhone}" type="hidden"/>
        <input name="search.mail" value="${command.search.mail}" type="hidden"/>
        <input name="search.weixin" value="${command.search.weixin}" type="hidden"/>
        --%>
        <div class="modal-body">
            <div class="col-lg-12">
                <div class="wrapper white-bg shadow">
                    <div class="m-t-md">
                        <div class="m-b-xs clearfix">
                            <div class="col-sm-11 clearfix" style="padding-left: 0;">
                                    <%--玩家OK--%>
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
            <div class="search-list-container" style="min-height: 1150px">
                <%@ include file="IndexPartial.jsp" %>
            </div>
        </div>
    </form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/popup/Index"/>
</html>