<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VUserPlayerListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>

<div class="row">
    <form:form action="${root}/player/list.html" method="post" name="playerFormOld">
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
        <%--返利方案--%>
        <input name="search.rakebackId" value="${command.search.rakebackId}" type="hidden">
        <input name="search.rankId" value="${command.search.rankId}" type="hidden">
        <input name="search.userAgentId" value="${command.search.userAgentId}" type="hidden">
        <input name="search.generalAgentId" value="${command.search.generalAgentId}" type="hidden">
        <input name="search.ip" value="${operateIp}" type="hidden"/>
        <input name="search.recommendUserId" value="${command.search.recommendUserId}" type="hidden"/>


        <input name="search.registerIp" value="${command.search.registerIp}" type="hidden"/>
        <input name="search.lastLoginIp" value="${command.search.lastLoginIp}" type="hidden"/>
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
            <div class="wrapper white-bg shadow">
                <!--筛选条件-->
                <div class="filter-wraper clearfix">
                    <a nav-target="mainFrame" href="/player/list.html?search.version=old" class="btn btn-primary-hide"><i
                            class="fa fa-refresh"></i><span class="hd">${views.common['refresh']}</span></a>
                    <soul:button tag="button" cssClass="btn btn-warning-hide" text="${views.common['filter']}"
                                 precall="clearExportParam"
                                 target="${root}/player/filters.html" opType="dialog" callback="showFiltersCallBack">
                        <i class="fa fa-filter"></i>
                        <span class="hd">${views.common['filter']}</span>
                    </soul:button>
                    <c:if test="${queryparamValue.paramValue}">
                        <soul:button permission="role:player_export" tag="button"
                                     cssClass="btn btn-export-btn btn-primary-hide" text="${views.common['export']}"
                                     callback="gotoExportHistory"
                                     precall="validExportCount" post="getCurrentFormData"
                                     title="${views.role['player.dataExport']}" target="${root}/player/export.html.html"
                                     opType="ajax">
                            <i class="fa fa-sign-out"></i><span class="hd">${views.common['export']}</span>
                        </soul:button>
                    </c:if>
                    <div class="function-menu-show hide">
                            <%--<soul:button permission="role:player_export" tag="button" cssClass="btn btn-primary-hide" callback="toExportHistory" text="${views.common['export']}"
                                         title="${views.role['player.dataExport']}" target="${root}/player/exportRecords.html" opType="dialog">
                                <i class="fa fa-sign-out"></i><span class="hd">${views.common['export']}</span>
                            </soul:button>--%>
                        <div class="btn-group" id="player_rank" style="padding-right: 10px">
                            <button data-toggle="dropdown" id="player_rank_dropdown"
                                    class="btn btn-primary-hide dropdown-toggle">
                                <i class="fa fa-list"></i>
                                <span class="hd">${views.role['player.list.title.layer']}</span>&nbsp;&nbsp;<span
                                    class="caret"></span>
                            </button>
                            <soul:button cssClass="btn btn-outline btn-filter _unlockrank hidden"
                                         target="${root}/userPlayer/unlock.html" post="getSelectIds" precall=""
                                         opType="ajax" dataType="json" text="${views.role['Player.list.batchUnlock']}"
                                         callback=""></soul:button>
                            <ul class="dropdown-menu rank_ul">
                                <div class="label-menu-o" id="rank_list">

                                </div>
                                <li class="divider"></li>
                                <li class="m-b-sm bt m-t-xs">
                                    <soul:button causeValidate="" tag="button" cssClass="btn btn-filter btn-sm m-r-sm"
                                                 target="${root}/userPlayer/setRank.html" post="playerRankPost"
                                                 opType="ajax" dataType="json" text="${views.common['OK']}"
                                                 callback="query"></soul:button>
                                    <a type="button"
                                       href="/vPlayerRankStatistics/list.html?rankId=${p.id}&hasReturn=return"
                                       class="fil" nav-target="mainFrame">${views.common['manage']}</a>
                                </li>
                            </ul>
                        </div>
                            <%--返水方案--%>
                        <div class="btn-group" id="player_rakeback" style="padding-right: 10px">
                                <%--<button data-toggle="dropdown" class="btn btn-primary-hide dropdown-toggle">
                                    <i class="fa fa-list"></i>
                                    <span class="hd">${views.role['Player.list.rebate']}</span>&nbsp;&nbsp;<span class="caret"></span>
                                </button>--%>

                            <ul class="dropdown-menu">
                                <div class="label-menu-o" id="rakeback_list">

                                </div>
                                <li class="divider"></li>
                                <li class="m-b-sm bt m-t-xs">
                                    <soul:button causeValidate="" precall="changeCheckedRakeback" tag="button"
                                                 cssClass="btn btn-filter btn-sm m-r-sm"
                                                 target="${root}/player/rakeback/changeRakeback.html"
                                                 post="playerRekebackPost" opType="ajax" dataType="json"
                                                 text="${views.common['OK']}" callback="query"></soul:button>
                                    <a type="button" href="/setting/vRakebackSet/list.html?hasReturn=return" class="fil"
                                       nav-target="mainFrame">${views.common['manage']}</a>
                                        <%--<soul:button causeValidate="" tag="button" cssClass="btn btn-sm m-r-sm fil" target="${root}/player/rakeback/chagneRakebackByParent.html" post="playerRekebackPost" opType="ajax" dataType="json" text="${views.player_auto['套用上层']}"></soul:button>--%>
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
                                        <%--<soul:button target="${root}/playerTag/saveTag.html" opType="ajax"
                                                     post="playerTag.playerTagGetData" tag="button"
                                                     precall="playerTag.checkPlayerTagLen"
                                                     cssClass="btn btn-filter btn-sm m-r-sm"
                                                     text="${views.common['confirm']}"
                                                     callback="playerTag.playerTagSaveCallBack">
                                        </soul:button>--%>
                                    <soul:button target="playerTag.saveTag" opType="function"
                                                 tag="button"
                                                 precall="playerTag.checkPlayerTagLen"
                                                 cssClass="btn btn-filter btn-sm m-r-sm"
                                                 text="${views.common['confirm']}"
                                                 callback="playerTag.playerTagSaveCallBack">
                                    </soul:button>
                                    <soul:button target="${root}/vPlayerTag/list.html"
                                                 callback="playerTag.playerTagSaveCallBack"
                                                 size="open-dialog-70"
                                                 cssClass="fil" tag="a" opType="dialog"
                                                 text="${views.role['Player.list.tagManager']}">${views.common['manage']}</soul:button>
                                </li>

                            </ul>
                        </div>

                        <div class="btn-group">
                            <button data-toggle="dropdown"
                                    class="btn btn-primary-hide dropdown-toggle player_tag_dropdown_btn"><span
                                    class="hd">${views.common['more']}&nbsp;&nbsp;</span>
                                <span class="hd-show"><i class="fa fa-ellipsis-h"></i></span>
                                <span class="caret hd"></span>
                            </button>
                            <ul class="dropdown-menu">
                                <li>
                                    <soul:button precall="getSelectPlayerIds" callback="myCallback"
                                                 target="${root}/player/groupSend/chooseSendType.html?playerIds={playerIds}"
                                                 text="${views.role['player.list.button.message']}" opType="dialog"><i
                                            class="fa fa-comments-o"></i>${views.role['player.list.button.message']}</soul:button>
                                </li>
                                <li><soul:button permission="role:player_cleanup" precall=""
                                                 target="${root}/userPlayer/export.html"
                                                 text="${views.role['Player.clearcontact.Export.clearcontact']}"
                                                 callback="toExportHistory" opType="dialog"><i
                                        class="fa fa-eraser"></i>${views.role['Player.clearcontact.ClearContactInfo.index']}</soul:button>
                                </li>
                                <a href="/vNoticeEmailRank/list.html" class="interfaceSet" nav-target="mainFrame"></a>
                                <li>
                                    <soul:button target="getPlayerIds" text="${views.player_auto['人工存入']}" opType="function"><i
                                            class="fa fa-eject"></i>${views.player_auto['人工存入']}</soul:button>
                                    <a href="/fund/manual/fromPlayer.html?username={username}" id="toDepoist"
                                       nav-target="mainFrame"></a>
                                </li>


                                    <%--<li><a href="javascript:void(0)" data-toggle="modal" data-target="#pwd"><i class="fa fa-key"></i>${views.player_auto['重置登录密码']}</a></li>
                                    <li><a href="javascript:void(0)" data-toggle="modal" data-target="#pwd"><i class="fa fa-key"></i>${views.player_auto['重置支付密码']}</a></li>--%>
                            </ul>
                        </div>
                    </div>
                    <div class="search-wrapper btn-group pull-right m-r-n-xs">
                        <div class="input-group">
                            <div class="input-group-btn">
                                <select tabindex="-1" class="chosen-select-no-single" id="searchlist">
                                    <c:forEach items="${command.searchList()}" var="item">
                                        <option ${item.key=='search.username'?'selected':''}
                                                value="${item.key}">${item.value}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <input type="text" class="form-control list-search-input-text" id="searchtext"
                                   name="search.username" value="">
                            <span class="input-group-btn">
                                <input type="hidden" name="search.createTimeBegin"
                                       value="${soulFn:formatDateTz(command.search.createTimeBegin, DateFormat.DAY_SECOND, timeZone) }"/>
                                <input type="hidden" name="search.createTimeEnd"
                                       value="${soulFn:formatDateTz(command.search.createTimeEnd, DateFormat.DAY_SECOND, timeZone) }"/>
                                <soul:button cssClass="btn btn-filter btn-query-css" precall="checksearch" tag="button"
                                             opType="function"
                                             text="${views.common['search']}" target="query">
                                    <i class="fa fa-search"></i><span class="hd">&nbsp;${views.common['search']}</span>
                                </soul:button>
                                <a href="/player/list.html?search.version=new" nav-target="mainFrame">${views.player_auto['切换到新版本']}</a>
                            </span>
                        </div>
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
            </div>
        </div>
    </form:form>
    <form id="toDepoistForm" action="${root}/fund/manual/index.html" target="_self" method="post">
        <input type="hidden" name="username" value="">
    </form>
</div>
<soul:import res="site/player/playerOld"/>