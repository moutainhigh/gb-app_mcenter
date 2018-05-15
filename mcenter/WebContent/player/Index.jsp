<%@ page import="org.soul.commons.dict.DictTool" %>
<%@ page import="so.wwb.gamebox.model.DictEnum" %><%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VUserPlayerListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>

<div class="row">
    <form:form action="${root}/player/list.html" method="post" name="playerForm">
        <div id="validateRule" style="display: none">${validateRule}</div>
        <input type="hidden" id="playerRanksMemory" value="">
        <input type="hidden" id="playerTagsMemory" value="">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['角色']}</span><span>/</span>
            <span>${views.sysResource['玩家管理']}</span>
            <c:if test="${hasReturn}">
                <soul:button target="goToLastPage"
                             cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text=""
                             opType="function">
                    <em class="fa fa-caret-left"></em>${views.common['return']}
                </soul:button>
            </c:if>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <%--返水方案--%>
        <%--<input name="search.rakebackId" value="${command.search.rakebackId}" type="hidden">--%>
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
        <%--<input name="search.lastLoginIp" value="${command.search.lastLoginIp}" type="hidden"/>--%>
        <input name="outer" value="${command.outer}" type="hidden"/>
        <input name="comp" value="${command.comp}" type="hidden"/>

        <%-- //没有这几项从检测页面跳转过来时如果有翻页会有问题，但又会和查询条件冲突
        <input name="search.qq" value="${command.search.qq}" type="hidden"/>
        <input name="search.mobilePhone" value="${command.search.mobilePhone}" type="hidden"/>
        <input name="search.mail" value="${command.search.mail}" type="hidden"/>
        <input name="search.weixin" value="${command.search.weixin}" type="hidden"/>
        --%>
        <input type="hidden" name="search.tagId" value="${tagIds}">

        <div class="col-lg-12">
            <!--新的开始 by kobe-->
            <div class="wrapper white-bg shadow">
                <div class="m-t-md">
                    <div class="m-b-xs clearfix function-menu-hide hide">
                        <div class="col-sm-11 clearfix" style="padding-left: 0;">
                                <%--玩家OK--%>
                            <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group">
                                    <span class="bg-gray input-group-addon bdn">
                                        <gb:selectPure name="search.userTypes" list="${userTypeSearchKeys}"
                                                       listKey="key"
                                                       value="${command.search.userTypes}" listValue="value"
                                                       callback="changeKey"
                                                       prompt="" cssClass="chosen-select-no-single"/>
                                    </span>
                                    <c:if test="${not empty command.search.username||(empty command.search.username&&empty command.search.agentName&&empty command.search.generalAgentName)}">
                                        <input type="text" class="form-control account_input list-search-input-text"
                                               name="search.username" id="operator" value="${command.search.username}"
                                               placeholder="${views.player_auto['多个账号，用半角逗号隔开']}">
                                    </c:if>
                                    <c:if test="${not empty command.search.agentName}">
                                        <input type="text" class="form-control account_input list-search-input-text"
                                               name="search.username" id="operator" value="${command.search.agentName}"
                                               placeholder="">
                                    </c:if>
                                    <c:if test="${not empty command.search.generalAgentName}">
                                        <input type="text" class="form-control account_input list-search-input-text"
                                               name="search.username" id="operator"
                                               value="${command.search.generalAgentName}" placeholder="">
                                    </c:if>
                                </div>
                            </div>
                                <%--注册时间ok--%>
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
                                <%--银行卡--%>
                            <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group">
                                    <span class="input-group-addon bg-gray">${views.player_auto['银行卡']}</span>
                                    <input type="text" class="form-control account_input list-search-input-text"
                                           name="search.bankcardNumber"
                                           value="${command.search.bankcardNumber}"
                                           placeholder="">
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


                            <div class="show-demand-a">

                                    <%--备注--%>
                                <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                                    <div class="input-group">
                                        <span class="bg-gray input-group-addon bdn">
                                            <gb:selectPure name="search.messages" list="${command.searchChatList()}"
                                                           listKey="key"
                                                           value="${command.search.messages}" listValue="value"
                                                           callback="changeKey2"
                                                           prompt="" cssClass="chosen-select-no-single"/>
                                        </span>
                                        <c:if test="${not empty command.search.remarks || (empty command.search.remarks&&empty command.search.registCode&&empty command.search.mobilePhone&&empty command.search.mail&&empty command.search.qq&&empty command.search.weixin&&empty command.search.bankcardNumber)}">
                                            <input type="text" class="form-control account_input list-search-input-text"
                                                   name="search.remarks" id="operator2"
                                                   value="${command.search.remarks}"
                                                   placeholder="">
                                        </c:if>
                                        <c:if test="${not empty command.search.registCode}">
                                            <input type="text" class="form-control account_input list-search-input-text"
                                                   name="search.registCode" id="operator2"
                                                   value="${command.search.registCode}"
                                                   placeholder="">
                                        </c:if>
                                        <c:if test="${not empty command.search.mobilePhone}">
                                            <input type="text" class="form-control account_input list-search-input-text"
                                                   name="search.mobilePhone" id="operator2"
                                                   value="${command.search.mobilePhone}"
                                                   placeholder="">
                                        </c:if>
                                        <c:if test="${not empty command.search.mail}">
                                            <input type="text" class="form-control account_input list-search-input-text"
                                                   name="search.mail" id="operator2"
                                                   value="${command.search.mail}"
                                                   placeholder="">
                                        </c:if>
                                        <c:if test="${not empty command.search.qq}">
                                            <input type="text" class="form-control account_input list-search-input-text"
                                                   name="search.qq" id="operator2"
                                                   value="${command.search.qq}"
                                                   placeholder="">
                                        </c:if>
                                        <c:if test="${not empty command.search.weixin}">
                                            <input type="text" class="form-control account_input list-search-input-text"
                                                   name="search.weixin" id="operator2"
                                                   value="${command.search.weixin}"
                                                   placeholder="">
                                        </c:if>
                                    </div>
                                </div>
                                    <%--最后登录ok--%>
                                <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                                    <div class="input-group date time-select-a">
                                        <span class="input-group-addon bg-gray">${views.player_auto['最后登录']}</span>
                                        <gb:dateRange format="${DateFormat.DAY_SECOND}" style="width:38%"
                                                      useRange="true"
                                                      opens="right" position="down"
                                                      startDate="${command.search.loginTimeBegin}"
                                                      endDate="${command.search.loginTimeEnd}"
                                                      startName="search.loginTimeBegin" endName="search.loginTimeEnd"/>
                                    </div>
                                </div>

                                    <%--存款总额ok--%>
                                <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                                    <div class="input-group time-select-a">
                                        <span class="input-group-addon bg-gray">${views.player_auto['存款总额']}</span>
                                        <span class="input-group-addon border-right-none">${views.player_auto['起']}</span>
                                        <input type="type" class="form-control border-left-none" name=""
                                               id="rechargeTotalBegin"
                                               value="${command.search.rechargeTotalBegin}">
                                        <span class="input-group-addon time-select-t">~</span>
                                        <span class="input-group-addon border-right-none">${views.player_auto['止']}</span>
                                        <input type="type" class="form-control border-left-none" name=""
                                               id="rechargeTotalEnd"
                                               value="${command.search.rechargeTotalEnd}">
                                    </div>
                                </div>

                                    <%----%>
                                <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                                    <div class="input-group time-select-a right-ico">
                                        <span class="input-group-addon bg-gray">${views.player_auto['未登录超过']}</span>
                                        <span class="input-group-addon time-select-ico">${views.player_auto['天']}</span>
                                        <input type="text" class="form-control" name="search.noLoginTime"
                                               value="${command.search.noLoginTime}">
                                    </div>
                                </div>


                                    <%--登录IP--ok--%>
                                <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                                    <div class="input-group date">
                                        <span class="input-group-addon bg-gray">${views.player_auto['登录IP']}</span>
                                        <input type="text" class="form-control" name="search.lastLoginIpv4"
                                               value="${command.search.lastLoginIpv4}">
                                    </div>
                                </div>

                                    <%--注册URL--ok--%>
                                <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                                    <div class="input-group date">
                                        <span class="input-group-addon bg-gray">${views.player_auto['注册URL']}</span>
                                        <input type="text" class="form-control" name="search.registerSite"
                                               value="${command.search.registerSite}">
                                    </div>
                                </div>
                                    <%--取款总额--ok--%>
                                <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                                    <div class="input-group time-select-a">
                                        <span class="input-group-addon bg-gray">${views.player_auto['取款总额']}</span>
                                        <span class="input-group-addon border-right-none">${views.player_auto['起']}</span>
                                        <input type="type" class="form-control border-left-none" name=""
                                               id="txTotalBegin"
                                               value="${command.search.txTotalBegin}">
                                        <span class="input-group-addon time-select-t">~</span>
                                        <span class="input-group-addon border-right-none">${views.player_auto['止']}</span>
                                        <input type="type" class="form-control border-left-none" name="" id="txTotalEnd"
                                               value="${command.search.txTotalEnd}">
                                    </div>
                                </div>
                                    <%----%>
                                <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                                    <div class="input-group">
                                        <span class="input-group-addon bg-gray">${views.player_auto['返水方案']}</span>
                                        <gb:selectPure name="search.rakebackId" list="${rakebackSet}"
                                                       listKey="id"
                                                       value="${command.search.rakebackId}" listValue="name"
                                                       callback=""
                                                       prompt="${views.player_auto['全部']}"
                                                       cssClass="chosen-select-no-single"/>
                                    </div>
                                </div>

                                    <%--注册IP--ok--%>
                                <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                                    <div class="input-group date">
                                        <span class="input-group-addon bg-gray">${views.player_auto['注册IP']}</span>
                                        <input id="ipv4" type="text" class="form-control" name="search.registerIpv4"
                                               value="${command.search.registerIpv4}"/>
                                    </div>
                                </div>
                                    <%--来源终端ok--%>
                                <div class="form-group clearfix pull-left col-md-1 col-sm-12 m-b-sm padding-r-none-sm h-line-a">
                                    <div class="input-group">
                                        <span class="input-group-addon bg-gray">${views.player_auto['来源终端']}</span>
                                        <gb:select name="search.createChannel" list="<%=DictTool.get(DictEnum.PLAYER_CREATE_CHANNEL)%>" prompt="${views.player_auto['全部']}"/>
                                    </div>
                                </div>
                                    <%--钱包余额等ok--%>
                                <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                                    <div class="input-group time-select-a">
                                        <span class="bg-gray input-group-addon bdn">
                                            <c:set var="_value" value=""></c:set>
                                            <c:choose>
                                                <c:when test="${command.search.fundTypes == 'search.walletBalance'}">
                                                    <c:set var="_value" value="search.walletBalance"></c:set>
                                                </c:when>
                                                <c:when test="${command.search.fundTypes == 'search.totalAssets'}">
                                                    <c:set var="_value" value="search.totalAssets"></c:set>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:set var="_value" value=""></c:set>
                                                </c:otherwise>
                                            </c:choose>
                                            <gb:selectPure name="search.fundTypes" list="${command.searchMoneyList()}"
                                                           listKey="key"
                                                           value="${_value}" listValue="value"
                                                           callback="changeKey3"
                                                           prompt="" cssClass="chosen-select-no-single"/>
                                        </span>
                                        <input value="${command.search.fundTypes}" type="hidden" id="fundType">
                                        <c:if test="${not empty command.search.walletBalanceBegin||(empty command.search.walletBalanceBegin&&empty command.search.totalAssetsBegin)}">
                                            <span class="input-group-addon border-right-none">${views.player_auto['起']}</span>
                                            <input type="type" class="form-control border-left-none"
                                                   name="search.walletBalanceBegin"
                                                   value="${command.search.walletBalanceBegin}"
                                                   id="operator3">
                                            <span class="input-group-addon time-select-t">~</span>
                                            <span class="input-group-addon border-right-none">${views.player_auto['止']}</span>
                                            <input type="type" class="form-control border-left-none"
                                                   name="search.walletBalanceEnd"
                                                   value="${command.search.walletBalanceEnd}"
                                                   id="operator4">
                                        </c:if>
                                        <c:if test="${not empty command.search.totalAssetsBegin}">
                                            <span class="input-group-addon border-right-none">${views.player_auto['起']}</span>
                                            <input type="type" class="form-control border-left-none"
                                                   name="search.totalAssetsBegin"
                                                   value="${command.search.totalAssetsBegin}"
                                                   id="operator3">
                                            <span class="input-group-addon time-select-t">~</span>
                                            <span class="input-group-addon border-right-none">${views.player_auto['止']}</span>
                                            <input type="type" class="form-control border-left-none"
                                                   name="search.totalAssetsEnd"
                                                   value="${command.search.totalAssetsEnd}"
                                                   id="operator4">
                                        </c:if>
                                    </div>
                                </div>

                                    <%--层级--%>
                                <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                                    <div class="input-group">
                                        <span class="input-group-addon bg-gray">${views.player_auto['层级']}</span>
                                        <span class="bdn right-btn-down">
                                            <div class="btn-group table-desc-right-t-dropdown" initprompt="10条"
                                                 callback="query">
                                                <button type="button" class="btn btn btn-default right-radius rank-btn">
                                                    <span class="rankText"
                                                          prompt="prompt">${views.player_auto['请选择']}</span>
                                                    <span class="caret-a pull-right"></span>
                                                </button>
                                                <c:forEach items="${command.search.playerRanks}" var="p">
                                                    <input type="hidden" class="playerRanks" data-value="${p}"/>
                                                </c:forEach>
                                                <div class="dropdown-menu playerRank">
                                                    <div class="search-top-menu"
                                                         style="margin-top: 10px;margin-left: 10px;">
                                                        <button type="button" data-type="all"
                                                                class="btn btn-filter btn-xs">${views.operation['backwater.settlement.choose.allChoose']}</button>
                                                        <button type="button" data-type="clear"
                                                                class="btn btn-outline btn-filter btn-xs">${views.operation['backwater.settlement.choose.clear']}</button>
                                                    </div>
                                                    <div class="m-t">
                                                        <table class="table table-bordered m-b-xxs">
                                                            <tr>
                                                                <th class="al-left">
                                                                    <c:forEach items="${playerRanks}" var="pr"
                                                                               varStatus="i">
                                                                        <label class="m-r-sm">
                                                                            <input type="checkbox"
                                                                                   name="search.playerRanks"
                                                                                   class="i-checks" value="${pr.id}">
                                                                            <span class="m-l-xs">${pr.rankName}</span>
                                                                        </label>
                                                                    </c:forEach>
                                                                </th>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </div>

                                            </div>
                                        </span>
                                    </div>
                                </div>
                                    <%--标签--%>
                                <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                                    <div class="input-group">
                                        <span class="input-group-addon bg-gray">${views.player_auto['标签']}</span>
                                        <span class="bdn right-btn-down">
                                            <div class="btn-group table-desc-right-t-dropdown" initprompt="10条"
                                                 callback="query">
                                                <button type="button" class="btn btn btn-default right-radius rank-btn">
                                                    <span class="tagText"
                                                          prompt="prompt">${views.player_auto['请选择']}</span>
                                                    <span class="caret-a pull-right"></span>
                                                </button>
                                                <c:forEach items="${playerTag.result}" var="p">
                                                    <input type="hidden" class="playerRanks" data-value="${p}"/>
                                                </c:forEach>
                                                <div class="dropdown-menu playerRank">
                                                    <div class="search-top-menu"
                                                         style="margin-top: 10px;margin-left: 10px;">
                                                        <button type="button" data-type-tag="all"
                                                                class="btn btn-filter btn-xs">${views.operation['backwater.settlement.choose.allChoose']}</button>
                                                        <button type="button" data-type-tag="clear"
                                                                class="btn btn-outline btn-filter btn-xs">${views.operation['backwater.settlement.choose.clear']}</button>
                                                    </div>
                                                    <div class="m-t">
                                                        <table class="table table-bordered m-b-xxs">
                                                            <tr>
                                                                <th class="al-left">
                                                                    <c:forEach items="${playerTag.result}" var="pl"
                                                                               varStatus="i">
                                                                        <label class="m-r-sm">
                                                                            <input type="checkbox" name="search.tagIds"
                                                                                   class="i-checks" value="${pl.id}">
                                                                            <span class="m-l-xs">${pl.tagName}</span>
                                                                        </label>
                                                                    </c:forEach>
                                                                </th>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </div>

                                            </div>
                                        </span>
                                    </div>
                                </div>
                                <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                                    <div class="input-group time-select-a">
                                        <span class="input-group-addon bg-gray">${views.player_auto['存款次数']}</span>
                                        <span class="input-group-addon border-right-none">${views.player_auto['起']}</span>
                                        <input type="type" class="form-control border-left-none" name=""
                                               id="rechargeCountBegin"
                                               value="${command.search.rechargeCountBegin}">
                                        <span class="input-group-addon time-select-t">~</span>
                                        <span class="input-group-addon border-right-none">${views.player_auto['止']}</span>
                                        <input type="type" class="form-control border-left-none" name=""
                                               id="rechargeCountEnd"
                                               value="${command.search.rechargeCountEnd}">
                                    </div>
                                </div>
                                <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                                    <div class="input-group time-select-a">
                                        <span class="input-group-addon bg-gray">${views.player_auto['取款次数']}</span>
                                        <span class="input-group-addon border-right-none">${views.player_auto['起']}</span>
                                        <input type="type" class="form-control border-left-none" name=""
                                               id="txCountBegin"
                                               value="${command.search.txCountBegin}">
                                        <span class="input-group-addon time-select-t">~</span>
                                        <span class="input-group-addon border-right-none">${views.player_auto['止']}</span>
                                        <input type="type" class="form-control border-left-none" name="" id="txCountEnd"
                                               value="${command.search.txCountEnd}">
                                    </div>
                                </div>

                                <%--  --%>
                                <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                                    <div class="input-group">
                                        <span class="input-group-addon bg-gray">${views.player_auto['风控标识']}</span>
                                        <gb:select name="search.riskDataType" value="" prompt="${views.content['全部']}" list="${riskDicts}"/>

                                    </div>
                                </div>


                                    <%--总盈亏--ok--%>
                                <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm"
                                     style="display: none">
                                    <div class="input-group time-select-a">
                                        <span class="bg-gray input-group-addon bdn">
                                            <gb:select name="search.favorableTypes" list="" listKey="key"
                                                       value="" listValue="value" callback="changeKey4"
                                                       prompt=""/>
                                        </span>
                                        <input value="${command.search.favorableTypes}" type="hidden"
                                               id="favorableType">
                                        <c:if test="${not empty command.search.rakebackBegin||(empty command.search.rakebackBegin&&empty command.search.favorableTotalBegin&&empty command.search.totalProfitLossBegin)}">
                                            <span class="input-group-addon border-right-none">${views.player_auto['起']}</span>
                                            <input type="number" class="form-control border-left-none"
                                                   name="search.rakebackBegin"
                                                   value="${command.search.rakebackBegin}"
                                                   id="operator7">
                                            <span class="input-group-addon time-select-t">~</span>
                                            <span class="input-group-addon border-right-none">${views.player_auto['止']}</span>
                                            <input type="number" class="form-control border-left-none"
                                                   name="search.rakebackEnd"
                                                   value="${command.search.rakebackEnd}"
                                                   id="operator8">
                                        </c:if>
                                        <c:if test="${not empty command.search.favorableTotalBegin}">
                                            <span class="input-group-addon border-right-none">${views.player_auto['起']}</span>
                                            <input type="number" class="form-control border-left-none"
                                                   name="search.favorableTotalBegin"
                                                   value="${command.search.favorableTotalBegin}"
                                                   id="operator7">
                                            <span class="input-group-addon time-select-t">~</span>
                                            <span class="input-group-addon border-right-none">${views.player_auto['止']}</span>
                                            <input type="number" class="form-control border-left-none"
                                                   name="search.favorableTotalEnd"
                                                   value="${command.search.favorableTotalEnd}"
                                                   id="operator8">
                                        </c:if>
                                        <c:if test="${not empty command.search.totalProfitLossBegin}">
                                            <span class="input-group-addon border-right-none">${views.player_auto['起']}</span>
                                            <input type="number" class="form-control border-left-none"
                                                   name="search.totalProfitLossBegin"
                                                   value="${command.search.totalProfitLossBegin}"
                                                   id="operator7">
                                            <span class="input-group-addon time-select-t">~</span>
                                            <span class="input-group-addon border-right-none">${views.player_auto['止']}</span>
                                            <input type="number" class="form-control border-left-none"
                                                   name="search.totalProfitLossEnd"
                                                   value="${command.search.totalProfitLossEnd}"
                                                   id="operator8">
                                        </c:if>
                                    </div>
                                </div>

                            </div>

                        </div>

                        <c:if test="${queryparamValue.paramValue}">
                            <div class="col-sm-1 clearfix">
                                <div class="pull-right">
                                    <soul:button permission="role:player_export" tag="button"
                                                 cssClass="btn btn-export-btn btn-primary-hide"
                                                 text="${views.common['export']}" callback="gotoExportHistory"
                                                 precall="validExportCount" post="getCurrentFormData"
                                                 title="${views.role['player.dataExport']}"
                                                 target="${root}/player/export.html" opType="ajax">
                                        <i class="fa fa-sign-out"></i><span class="hd">${views.common['export']}</span>
                                    </soul:button>
                                </div>
                            </div>

                        </c:if>


                        <div class="col-sm-12 clearfix template-menu m-b-xs">
                            <button type="button" class="btn btn-filter btn-outline pull-right  show-demand-b"><i
                                    class="fa fa-chevron-down"></i> ${views.player_auto['高级搜索']}
                            </button>

                            <soul:button cssClass="btn btn-filter mediate-search-btn _enter_submit" tag="button" opType="function"
                                         text="${views.common['search']}" target="query" precall="validateForm">
                                <i class="fa fa-search"></i><span class="hd">&nbsp;${views.common['search']}</span>
                            </soul:button>

                            <soul:button target="reset" opType="function" text="${views.player_auto['重置']}"
                                         cssClass="btn btn-filter reset-condition-button"/>
                            <shiro:hasPermission name="role:player_add">
                                <soul:button target="${root}/player/addNewPlayer.html" opType="dialog"
                                             permission="role:player_add" ccc=""
                                             text="${views.player_auto['新增玩家']}" callback="query"
                                             cssClass="btn btn-filter pull-right m-r"/>
                            </shiro:hasPermission>
                                <%--<a href="/player/list.html?search.version=old" nav-target="mainFrame"--%>
                                <%--style="right: 21%;position: absolute;z-index: 888; padding-top: 10px;">${views.player_auto['切换到旧版本']}</a>--%>

                            <div class="input-group-btn pull-left" style="padding-right: 200px">
                                <%@include file="/sysSearchTemplate/SearchTemplate.jsp" %>
                            </div>

                        </div>
                    </div>
                </div>


                <div class="filter-wraper clearfix">
                        <%--<a nav-target="mainFrame" href="/player/list.html" class="btn btn-primary-hide" ><i class="fa fa-refresh"></i><span class="hd">${views.common['refresh']}</span></a>--%>
                    <div class="function-menu-show">
                        <%--<c:if test="${queryparamValue.paramValue}">
                            <div class="btn-group" style="padding-right: 10px">
                                <soul:button permission="role:player_export" tag="button"
                                             cssClass="btn btn-export-btn btn-primary-hide"
                                             text="${views.common['export']}" callback="gotoExportHistory"
                                             precall="validExportCount" post="getCurrentFormData"
                                             title="${views.role['player.dataExport']}"
                                             target="${root}/player/export.html" opType="ajax">
                                    <i class="fa fa-sign-out"></i><span class="hd">${views.common['export']}</span>
                                </soul:button>
                            </div>
                        </c:if>--%>

                            <%--层级--%>
                        <div class="btn-group" id="player_rank" style="padding-right: 10px">
                            <button data-toggle="dropdown" id="player_rank_dropdown"
                                    class="btn btn-primary-hide dropdown-toggle">
                                <i class="fa fa-list"></i>
                                <span class="hd">${views.role['player.list.title.layer']}</span>&nbsp;&nbsp;<span
                                    class="caret"></span>
                            </button>

                            <soul:button cssClass="btn btn-outline btn-filter _unlockrank hidden"
                                         target="${root}/userPlayer/unlock.html"
                                         post="getSelectIds" precall="" opType="ajax" dataType="json"
                                         text="${views.role['Player.list.batchUnlock']}" callback=""></soul:button>
                            <ul class="dropdown-menu rank_ul">
                                <div class="label-menu-o" id="rank_list">

                                </div>
                                <li class="divider"></li>
                                <li class="m-b-sm bt m-t-xs">
                                    <soul:button causeValidate="" tag="button" cssClass="btn btn-filter btn-sm m-r-sm"
                                                 target="${root}/userPlayer/setRank.html"
                                                 post="playerRankPost" opType="ajax" dataType="json"
                                                 text="${views.common['OK']}" callback="query"></soul:button>
                                    <a type="button"
                                       href="/vPlayerRankStatistics/list.html?rankId=${p.id}&hasReturn=return"
                                       class="fil" nav-target="mainFrame">${views.common['manage']}</a>
                                </li>
                            </ul>
                        </div>

                        <div class="btn-group" id="player_tag" style="padding-right: 10px">
                            <input type="hidden" value="true" id="hasLoadTag">
                            <button data-toggle="dropdown" type="button" id="player_tag_btn" data-has-load="true"
                                    class="btn btn-primary-hide dropdown-toggle player_tag_dropdown_btn">
                                <i class="fa fa-tags"></i>
                                <span class="hd">${views.role['Player.list.playerTag.tag']}</span>
                                &nbsp;&nbsp;
                                <span class="caret"></span>
                            </button>

                            <ul class="dropdown-menu player_tag_dropdown_ul">
                                <div class="input-group label-search tag_stop_propagation">
                                    <input type="text" class="form-control tag_search_input">
                                    <span class="input-group-addon cancel_search hide">×</span>
                                    <span class="input-group-addon go_search">
                                        <a href="javascript:void(0)">${views.common['search']}</a>
                                    </span>
                                </div>
                                <div class="label-menu-o tag_stop_propagation" id="player_tag_div"></div>
                                <li class="divider m-t-none"></li>
                                <li class="m-b-xs bt m-t-n-xs" id="player_tag_btn_li">
                                    <soul:button target="playerTag.saveTag" opType="function"
                                                 tag="button"
                                                 precall="playerTag.checkPlayerTagLen"
                                                 cssClass="btn btn-filter btn-sm m-r-sm"
                                                 text="${views.common['confirm']}"
                                                 callback="playerTag.playerTagSaveCallBack">
                                    </soul:button>
                                    <soul:button target="${root}/vPlayerTag/list.html"
                                                 callback="playerTag.playerTagSaveCallBack"
                                                 size="open-dialog-95p"
                                                 cssClass="fil" tag="a" opType="dialog"
                                                 text="${views.role['Player.list.tagManager']}">${views.common['manage']}</soul:button>
                                </li>
                            </ul>
                        </div>

                        <div class="btn-group" style="padding-right: 10px">
                            <soul:button target="getPlayerIds" permission="fund:artificial"
                                         text="${views.player_auto['人工存入']}" opType="function" tag="button"
                                         cssClass="btn btn-primary-hide dropdown-toggle player_tag_dropdown_btn">
                                <i class="fa fa-eject"></i>${views.player_auto['人工存入']}</soul:button>
                            <a href="/fund/manual/index.html?hasReturn=true&username={username}" id="toDepoist"
                               nav-target="mainFrame"></a>
                        </div>

                        <div class="btn-group" style="padding-right: 10px">
                            <soul:button permission="role:player_cleanup" precall=""
                                         target="${root}/userPlayer/export.html" tag="button"
                                         text="${views.role['Player.clearcontact.Export.clearcontact']}"
                                         callback="toExportHistory" opType="dialog"
                                         cssClass="btn btn-primary-hide dropdown-toggle player_tag_dropdown_btn"><i
                                    class="fa fa-eraser"></i>${views.role['Player.clearcontact.ClearContactInfo.index']}</soul:button>
                            <a href="/vNoticeEmailRank/list.html" class="interfaceSet" nav-target="mainFrame"></a>
                        </div>

                        <div class="btn-group" style="padding-right: 10px">
                            <soul:button precall="getSelectPlayerIds" callback="myCallback" tag="button"
                                         target="${root}/player/groupSend/chooseSendType.html?playerIds={playerIds}"
                                         text="${views.role['player.list.button.message']}" opType="dialog"
                                         cssClass="btn btn-primary-hide dropdown-toggle player_tag_dropdown_btn">
                                <i class="fa fa-comments-o"></i>${views.role['player.list.button.message']}
                            </soul:button>
                        </div>

                        <div class="btn-group" style="padding-right: 10px">
                            <soul:button tag="button" target="freezenAccount" opType="function"
                                         text="${views.player_auto['账号冻结']}"
                                         cssClass="btn btn-danger-hide _delete" callback="query"
                                         confirm="${views.player_auto['确认冻结']}"><i class="fa fa-road"></i>
                                <span class="hd">${views.player_auto['账号冻结']}</span></soul:button>
                        </div>

                        <%--<shiro:hasPermission name="operate:reset_storage">
                            <div class="btn-group" style="padding-right: 10px">
                                    <soul:button tag="button" target="resetStorage" opType="function"
                                                 text="${views.player_auto['重置前三存送']}"
                                                 cssClass="btn btn-danger-hide _delete" callback="query"
                                                 confirm="${views.player_auto['重置前三存送弹窗提示']}"><i></i>
                                        <span class="hd">${views.player_auto['重置前三存送']}</span></soul:button>
                            </div>
                        </shiro:hasPermission>--%>
                    </div>

                </div>
                <!--表格内容-->
                <dl class="clearfix filter-conditions p-xxs p-b-xs m-b-none border-b-1 hide">
                    <dt>${views.common['filterCondition']}（<a href="javascript:void(0)">${views.common['clear']}</a>）
                    </dt>
                </dl>
                <div id="editable_wrapper" class="search-list-container dataTables_wrapper" role="grid">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
                <div id="playerPage"></div>
            </div>
        </div>
        <a href="/exports/exportHistoryList.html?search.hasReturn=true" nav-target="mainFrame" class="hide"
           id="toExportHistory"></a>
    </form:form>

    <form id="toDepoistForm" action="${root}/fund/manual/index.html" target="_self" method="post">
        <input type="hidden" name="username" value="">
    </form>
</div>

<script type="text/javascript">
    curl(["site/player/player", 'gb/sysSearchTemplate/SysSearchTemplate'], function (Page, SysSearchTemplate) {
        page = new Page();
        page.bindButtonEvents();
        page.sysSearchTmp = new SysSearchTemplate();
    });
</script>