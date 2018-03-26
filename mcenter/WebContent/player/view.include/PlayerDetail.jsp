<%@ page import="so.wwb.gamebox.model.master.fund.enums.FundTypeEnum" %>
<%@ page import="so.wwb.gamebox.model.master.fund.enums.TransactionWayEnum" %>
<%@ page import="so.wwb.gamebox.model.master.fund.enums.TransactionTypeEnum" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VUserPlayerVo"--%>
<form action="${root}/player/playerView.html?search.id=${command.result.id}" method="post">
    <div class="row" name="playerViewDiv">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont"></i> </a></h2>
            <span>${views.sysResource['角色']}</span><span>/</span><span>${views.sysResource['玩家管理']}</span>
            <soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
        </div>
        <div class="col-lg-12">
            <input type="hidden" name="result.id" value="${command.result.id}" id="userId">
            <div class="wrapper white-bg clearfix shadow">
                <div class="sys_tab_wrap clearfix m-b-sm">
                    <div class="m-sm">
                        <b class="fs16">${views.player_auto['玩家详细']}</b>
                        <a href="" nav-target="mainFrame" id="toGameOrder"></a>
                        <input type="hidden" value="${command.result.username}" name="username" id="username">
                    </div>
                </div>
                <div class="panel-body p-sm">
                    <ul class="new-detail-list">
                        <li class="detail-list-name">
                            <span class="player-name" style="font-size: 30px;">${command.result.username}</span>
<%--<soul:riskTag playerId="34015"></soul:riskTag>yy--%>
                            <c:if test="${command.result.riskMarker == true}">
                                <span data-content="${views.player_auto['危险层级']}" style="padding: 3px;"
                                      data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                      role="button" class="help-popover co-red3" tabindex="0"
                                      data-original-title="" title=""><i class="fa fa-warning"></i></span>
                            </c:if>
                            ${gbFn:showRiskImg(riskDataType)}
                            <a href="javascript:void(0)" class="btn btn-outline btn-filter btn-sm m-l-sm" style="opacity: 0.6">ID ${command.result.id}</a>
                            <c:if test="${command.result.onLineId>0}">
                                <span data-content="${views.player_auto['在线']}" style="padding: 3px;"
                                      data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                      role="button" class="co-blue help-popover co-gray" tabindex="0"
                                      data-original-title="" title=""><i class="fa fa-flash"></i></span>
                                <span class="co-gray">${views.player_auto['在线']}</span>
                            </c:if>
                            <c:if test="${command.result.onLineId<=0}">
                                <span class="co-gray">${views.player_auto['离线']}</span>
                            </c:if>


                            <c:if test="${command.result.playerStatus eq '2'}">
                                <c:set value="true" var="option_btn_disabled"></c:set>
                            </c:if>
                            <shiro:hasPermission name="role:player_resetLoginPwd">
                            <soul:button title="${views.role['Player.detail.resetLoginPwd']}"
                                         target="${root}/player/resetPwd/index.html?resetType=loginPwd&userId=${command.result.id}"
                                         cssClass="${option_btn_disabled ?'disabled':''} btn btn-outline btn-filter btn-sm m-l" text="" opType="dialog" tag="button">
                                ${views.role['Player.detail.resetLoginPwd']}
                            </soul:button>
                            </shiro:hasPermission>
                            <shiro:hasPermission name="role:player_resetpayPwd">
                            <soul:button title="${views.role['Player.detail.resetpayPwd']}"
                                         target="${root}/player/resetPwd/index.html?resetType=payPwd&userId=${command.result.id}"
                                         cssClass="${option_btn_disabled ?'disabled':''} ${command.result.accountfreeze?'disabled':''} btn btn-outline btn-filter btn-sm m-l" text="" opType="dialog" tag="button">
                                ${views.role['Player.detail.resetpayPwd']}
                            </soul:button>
                            </shiro:hasPermission>
                            <c:if test="${command.result.createChannel=='1' || command.result.createChannel=='4'}">
                                <div style="font-size: 12px;margin-top: 10px;color: #9c9c9c;">
                                        ${fn:replace(fn:replace(fn:replace(views.player_auto['于通过'],"[0]",soulFn:formatDateTz(command.result.createTime, DateFormat.DAY_SECOND,timeZone)),"[1]",soulFn:formatTimeMemo(command.result.createTime,locale)),"[2]",dicts.player.create_channel[command.result.createChannel])}
                                    <a href="/player/list.html?search.registerIpv4=${soulFn:formatIp(command.result.registerIp)}" nav-target="mainFrame">${soulFn:formatIp(command.result.registerIp)}</a>
                                            <c:if test="${not empty command.result.registerIpDictCode}">
                                                [ ${gbFn:getShortIpRegion(command.result.registerIpDictCode)}]
                                            </c:if>
                                            <span data-content="${command.result.registerSite}" style="padding: 3px;"
                                                  data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                                  role="button" class="btn co-blue help-popover" tabindex="0"
                                                  data-original-title="" title=""><a href="http://${command.result.registerSite}" target="_blank">${views.player_auto['查看来源URL']}</a></span>

                                                <%--<a tabindex="0" role="button" data-container="body" data-toggle="popover" data-trigger="focus"
                                             data-placement="top" data-html="true" data-content="<a href='#'>youtob.com/mens/html/5481?</a> "
                                             class="btn btn-link co-blue help-popover">查看来源URL</a>--%>
                                </div>
                            </c:if>
                            <c:if test="${command.result.createChannel=='2'}">
                                <div style="font-size: 12px;margin-top: 10px;color: #9c9c9c;">${fn:replace(fn:replace(fn:replace(fn:replace(views.player_auto['由于'],"[0]",command.result.createUser),"[1]",soulFn:formatDateTz(command.result.createTime, DateFormat.DAY_SECOND,timeZone)),"[2]",soulFn:formatTimeMemo(command.result.createTime,locale)),"[3]",dicts.player.create_channel[command.result.createChannel])}</div>
                            </c:if>
                            <c:if test="${command.result.createChannel=='3'}">
                                <div style="font-size: 12px;margin-top: 10px;color: #9c9c9c;">${fn:replace(fn:replace(fn:replace(views.player_auto['于导入玩家'],"[0]",command.result.createUser),"[1]",soulFn:formatDateTz(command.result.createTime, DateFormat.DAY_SECOND,timeZone)),"[2]",soulFn:formatTimeMemo(command.result.createTime,locale))}
                                    <c:if test="${command.result.username!=fn:toLowerCase(command.result.importUsername)}">
                                        ${views.player_auto['原账号']}${command.result.importUsername}
                                    </c:if>
                                </div>
                            </c:if>


                        </li>

                        <c:if test="${not empty playerWithdraw}">
                            <li style="background-color: #fcf8e3;">
                                <div class="content" style="padding: 10px 40px;font-size: 16px;text-align: center">
                                    <a href="/fund/withdraw/withdrawAuditView.html?search.id=${playerWithdraw.id}&pageType=detail" nav-target="mainFrame" style="color: #333">
                                            ${views.player_auto['该玩家当前有一笔']}
                                        <span style="color: red">
                                                ${dicts.common.currency_symbol[command.result.defaultCurrency]}
                                                ${soulFn:formatInteger(playerWithdraw.withdrawAmount)}${soulFn:formatDecimals(playerWithdraw.withdrawAmount)}
                                        </span>
                                                    ${views.player_auto['取款订单待处理，交易号']}
                                                <span class="co-gray">【${playerWithdraw.transactionNo}】</span>

                                    </a>
                                </div>
                            </li>
                        </c:if>
                        <li class="detail-list-cow">
                            <span class="title">${views.player_auto['总资产']}</span>
                            <div class="content">
                                <span class=" fs20 co-orange">
                                    ${dicts.common.currency_symbol[command.result.defaultCurrency]}
                                </span>
                                <span class=" fs20 co-orange" id="total-asset">
                                    ${soulFn:formatInteger(command.result.totalAssets)}${soulFn:formatDecimals(command.result.totalAssets)}
                                </span>
                            </div>
                            <span class="" style="padding-left: 10px">${views.player_auto['钱包余额']}</span>
                            <span class=" fs20 co-orange">
                                ${dicts.common.currency_symbol[command.result.defaultCurrency]}
                            </span>
                            <span class=" fs20 co-orange" id="wallet-balance">
                                ${soulFn:formatInteger(command.result.walletBalance)}${soulFn:formatDecimals(command.result.walletBalance)}
                            </span>
                            <c:if test="${!isLotterySite}">
                            <div class="content">
                                </c:if>
                                <shiro:hasPermission name="fund:artificial">
                                    <a href="/fund/manual/index.html?hasReturn=true&fromPlayerDetail=true&playerId=${command.result.id}&username=${command.result.username}" nav-target="mainFrame" class="btn btn-link co-blue">${views.player_auto['人工存入']}</a>
                                    <a href="/fund/manual/index.html?hasReturn=true&fromPlayerDetail=true&playerId=${command.result.id}&type=withdraw&username=${command.result.username}" nav-target="mainFrame" class="btn btn-link co-blue">${views.player_auto['人工取出']}</a>
                                </shiro:hasPermission>
                                <c:if test="${!isLotterySite}">
                                <a href="/report/vPlayerFundsRecord/fundsLog.html?search.outer=-1&search.usernames=${command.result.username}&search.userTypes=username" nav-target="mainFrame" class="btn btn-link co-blue">${views.player_auto['查看资金记录']}</a>
                                    <%--<a href="/report/fundsTrans/apiTrans.html?search.username=${command.result.username}&searchKey=search.username&search.type=playerDetail" nav-target="mainFrame" class="btn btn-link co-blue">${views.player_auto['查看转账记录']}</a>--%>
                            </div>
                            </c:if>
                            <soul:button target="showApiData" text="${views.player_auto['查看游戏账户']}" opType="function" fromShowBtn="true" cssClass="btn btn-link co-blue show-api-data-btn"></soul:button>
                            <soul:button target="hideApiData" text="${views.player_auto['返回']}" opType="function" fromShowBtn="true" cssClass="btn btn-link co-blue hide hide-data-btn"></soul:button>
                            <div id="api_data" class="dataTables_wrapper hide" role="grid">
                            </div>
                        </li>
                        <li class="detail-list-cow">
                            <span class="title">${views.player_auto['当前状态']}</span>
                            <div class="content" id="player-stauts-detail">
                                <c:if test="${command.result.playerStatus=='1'}">
                                    <span class="label label-success">
                                            ${dicts.player.player_status[command.result.playerStatus]}
                                    </span>
                                </c:if>
                                <c:if test="${command.result.playerStatus=='2'}">
                                    <span class="label label-danger">
                                            ${dicts.player.player_status[command.result.playerStatus]}
                                    </span>
                                </c:if>
                                <c:if test="${command.result.playerStatus=='3'}">
                                    <span class="label label-info">
                                            ${dicts.player.player_status[command.result.playerStatus]}
                                    </span>
                                </c:if>
                                <c:if test="${command.result.playerStatus=='4'}">
                                    <span class="label label-warning">
                                            ${dicts.player.player_status[command.result.playerStatus]}
                                    </span>
                                </c:if>
                                <soul:button target="editPlayerStatus" text="${views.player_auto['修改状态']}" opType="function" cssClass="btn btn-link co-blue ${option_btn_disabled?'hide':''}"></soul:button>
                                <input type="hidden" name="current-status" id="current-status" value="${command.result.playerStatus}">
                            </div>
                            <div class="content hide" id="palyer-status-edit">
                                <gb:select name="result.playerStatus" value="${command.result.playerStatus}" callback="showSaveBtn"
                                           cssClass="result-playerStatus" prompt="" list="${playerStatus}"/>

                                <soul:button target="${root}/share/account/freezeAccount.html?result.id=${command.result.id}"
                                             text="${views.role['Player.detail.freezeAccount']}" callback="queryView"
                                             opType="dialog" cssClass="btn btn-link co-blue save-status-btn freeze-account-btn hide"
                                             permission="role:player_freezeaccout">
                                        ${views.common['save']}
                                    </soul:button>
                                    <soul:button target="${root}/share/account/freezeBalance.html?result.id=${command.result.id}"
                                                 text="${views.role['Player.detail.freezeBalance']}"
                                                 opType="dialog" cssClass="btn btn-link co-blue save-status-btn freeze-balance-btn hide"
                                                 callback="queryView" permission="role:player_freezebalance">
                                        ${views.common['save']}
                                    </soul:button>
                                    <soul:button
                                            target="${root}/share/account/disabledAccount.html?result.id=${command.result.id}"
                                            text="${messages['playerTag']['accountDisabled']}"
                                            opType="dialog" cssClass="btn btn-link co-blue save-status-btn disable-account-btn hide"
                                            callback="queryView">
                                        ${views.common['save']}
                                    </soul:button>

                                    <soul:button target="updatePlayerStatus" text="${views.common['save']}" opType="function" cssClass="btn btn-link co-blue save-status-btn save-normal-btn hide"></soul:button>
                                    <soul:button target="cancelEditPlayerStatus" text="${views.common['cancel']}" opType="function" cssClass="btn btn-link co-blue"></soul:button>
                        </li>

                        <li class="detail-list-cow">
                            <span class="title">${views.player_auto['所属代理']}</span>
                            <div class="content" id="agent-rank-detail">
                                <c:if test="${not empty command.result.generalAgentName}">
                                    <a href="/vUserTopAgentManage/list.html?search.id=${command.result.generalAgentId}" nav-target="mainFrame">
                                            ${command.result.generalAgentName}
                                    </a>
                                </c:if>
                                <c:if test="${empty command.result.generalAgentName}"><span class="co-gray">${views.player_auto['无总代']}</span></c:if>
                                <i>→</i>
                                <c:if test="${not empty command.result.agentName}">
                                    <a href="/vUserAgentManage/list.html?search.id=${command.result.agentId}" nav-target="mainFrame">
                                            ${command.result.agentName}
                                    </a>
                                </c:if>
                                <c:if test="${empty command.result.agentName}"><span class="co-gray">${views.player_auto['无代理']}</span></c:if>
                                <i>→</i>
                                ${command.result.username}
                                <input type="hidden" name="current-agentRank" id="current-agentRank" value="${command.result.agentId}">
                                <soul:button target="editAgentLine" text="${'修改代理'}" opType="function" cssClass="btn btn-link co-blue" permission="role:update_agent"></soul:button>
                                <c:if test="${not empty sysAuditLog}">
                                    <span data-content="<div>${views.common['content.editUser']}：${sysAuditLog.operator}</div>
                                <div>${views.common['content.editTime']}：${soulFn:formatDateTz(sysAuditLog.operateTime, DateFormat.DAY_SECOND,timeZone)}-${soulFn:formatTimeMemo(sysAuditLog.operateTime, locale)}</div>"
                                          data-placement="bottom" data-trigger="focus" data-toggle="popover" data-container="body" data-html="true"
                                          role="button" class="ico-lock" tabindex="0"
                                          data-original-title="" title="" style="font-size: 14px;color: #9c9c9c; display: inline-block;">${soulFn:formatLogDesc(sysAuditLog)}</span>
                                </c:if>
                            </div>
                            <div class="content hide" id="agent-rank-edit">
                                <gb:select name="search.agentRanks" prompt="${views.common['pleaseSelect']}" cssClass="btn-group chosen-select-no-single"
                                           relSelect="result.agentId" value="" />
                                <gb:select name="result.agentId" prompt="${views.common['pleaseSelect']}" cssClass="btn-group chosen-select-no-single" callback="changeAgentLine"
                                           relSelectPath="${root}/player/getRank/#search.agentRanks#.html"  listKey="id" listValue="username" value=""/>
                                <soul:button target="updateAgentLine" text="${views.common['save']}" opType="function" cssClass="btn btn-link co-blue btn-save-agent hide" confirm="${messages.content['confirm.update.agent']}"></soul:button>
                                <soul:button target="cancelEditAgentLine" text="${views.common['cancel']}" opType="function" cssClass="btn btn-link co-blue"></soul:button>
                                <div style="font-size: 12px;color: #9c9c9c; display: inline-block; padding-right: 30px;">${messages.content['prompt.update.agent']}</div>
                            </div>
                        </li>

                        <li class="detail-list-cow">
                            <span class="title">${views.player_auto['玩家层级']}</span>
                            <div class="content" id="player-rank-detail">
                                <a href="/vPlayerRankStatistics/view.html?id=${command.result.rankId}" nav-target="mainFrame">
                                    <span class="label label-info">${command.result.rankName}</span>
                                </a>
                                <input type="hidden" name="current-rank" id="current-rank" value="${command.result.rankId}">
                                <soul:button target="editPlayerRank" text="${views.player_auto['修改层级']}" opType="function" cssClass="btn btn-link co-blue ${option_btn_disabled?'hide':''}"></soul:button>
                                <c:if test="${command.result.riskMarker == true}"><span class="co-gray">${views.player_auto['该层级是危险层级']}</span></c:if>
                            </div>
                            <div class="content hide" id="player-rank-edit">
                                <gb:select name="result.rankId" list="${command.playerRankList}" callback="changeRank"
                                           prompt="${views.common['pleaseSelect']}" value="${command.result.rankId}"
                                           listValue="rankName" cssClass="btn-group chosen-select-no-single input-sm"
                                           listKey="id"></gb:select>
                                <soul:button target="updatePlayerRank" text="${views.common['save']}" opType="function" cssClass="btn btn-link co-blue btn-save-rank hide"></soul:button>
                                <soul:button target="cancelEditPlayerRank" text="${views.common['cancel']}" opType="function" cssClass="btn btn-link co-blue"></soul:button>
                            </div>
                        </li>
                        <li class="detail-list-cow detail-list-info">
                            <div class="content">
                                ${views.player_auto['共返水']}
                                ${dicts.common.currency_symbol[command.result.defaultCurrency]}
                                    <a href="/report/vPlayerFundsRecord/fundsLog.html?search.outer=-1&search.userTypes=username&search.usernames=${command.result.username}&search.transactionWays=<%=TransactionWayEnum.BACK_WATER.getCode()%>&search.manualSaves=<%=TransactionWayEnum.MANUAL_RAKEBACK.getCode()%>" nav-target="mainFrame">
                                        ${soulFn:formatInteger(command.result.rakeback)}${soulFn:formatDecimals(command.result.rakeback)}
                                    </a>，
                                    ${views.player_auto['返水方案为']}
                                    <c:if test="${not empty command.result.rakebackId}">
                                        <a href="/setting/vRakebackSet/view.html?id=${command.result.rakebackId}" nav-target="mainFrame">
                                            <span class="label label-info">
                                                    ${command.result.rakebackName}
                                            </span>
                                        </a>
                                    </c:if>
                                    <c:if test="${empty command.result.rakebackId}">${views.player_auto['空']}</c:if>
                            </div>
                        </li>
                        <input type="hidden" id="isDetection" value="false">
                        <li class="detail-list-cow" id="personal-data-view">
                            <span class="title">${views.player_auto['真实姓名']}</span>
                            <div class="content" id="real-name-detail">
                                <span id="show-real-name">${command.result.realName}</span>
                                <c:if test="${empty option_btn_disabled}">
                                    <soul:button permission="role:player_editusername" target="editRealName" text="${views.player_auto['修改真实姓名']}" opType="function" cssClass="btn btn-link update-real-name-btn co-blue ${option_btn_disabled?'hide':''}"></soul:button>
                                </c:if>
                                <soul:button target="showPersonalDetail" text="${views.player_auto['查看完整个人信息']}" opType="function" cssClass="btn btn-link show-detail-btn co-blue"></soul:button>
                                <c:if test="${empty option_btn_disabled}">
                                    <%--<soul:button target="toPlayerEdit" text="${views.player_auto['修改资料']}" opType="function" cssClass="btn btn-link co-blue player-edit-btn hide" callback="toPlayerEdit"></soul:button>--%>
                                    <a href="/player/getVUserPlayer.html?comeFrom=detail&search.id=${command.result.id}" nav-target="mainFrame"
                                       class="btn btn-link co-blue player-edit-btn hide">${views.player_auto['修改资料']}</a>
                                </c:if>
                                <a href="/fund/playerDetect/userPlayView.html?search.username=${command.result.username}" nav-target="mainFrame" class="btn btn-link co-blue">${views.player_auto['检测']}</a>
                                <soul:button target="hidePersonalDetail" text="${views.player_auto['返回']}" opType="function" fromShowBtn="true" cssClass="btn btn-link co-blue hide hide-personaldata-btn"></soul:button>
                            </div>
                            <div class="content hide" id="real-name-edit">
                                <div class="table-desc-right-t">
                                    <input type="text" class="form-control" name="result.realName" value="${command.result.realName}">
                                </div>
                                <soul:button target="updateRealName" text="${views.common['save']}" opType="function" cssClass="btn btn-link co-blue update-realname-btn"></soul:button>
                                <soul:button target="cancelEditRealName" text="${views.common['cancel']}" opType="function" cssClass="btn btn-link co-blue"></soul:button>
                            </div>
                            <div class="p-b-sm hide" id="player-personal-detail">
                                <table class="table table-bordered table-desc-list width-response" style="background: #fff;">
                                    <tbody>
                                    <shiro:hasPermission name="role:player_personal_detail">
                                    <tr>
                                        <th scope="row" class="text-center active" style="width: 15%">${views.player_auto['手机']}</th>
                                        <td style="width: 35%">
                                            <c:if test="${empty command.result.mobilePhone}">
                                                <span class="co-grayc2">${views.player_auto['未填写']}</span>
                                            </c:if>
                                            <c:if test="${not empty command.result.mobilePhone}">
                                                <c:choose>
                                                    <c:when test="${command.result.mobilePhoneWayStatus==22}">
                                                        <span class="co-grayc2">${views.role['player.view.clearcontact']}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:if test="${unencryption}">
                                                            ${command.result.mobilePhone}
                                                        </c:if>
                                                        <c:if test="${!unencryption}">
                                                            ${soulFn:overlayTel(command.result.mobilePhone)}&nbsp;
                                                            <c:if test="${not empty command.result.mobilePhone}">
                                                                <soul:button target="${root}/player/playerViewDetail.html?search.id=${command.result.id}" text="${views.common['view']}"
                                                                             callback="setPersonalData"   opType="ajax" permission="role:player_personal_detail"></soul:button>
                                                            </c:if>
                                                        </c:if>
                                                    </c:otherwise>
                                                </c:choose>
                                                <soul:button target="callPlayer" text="${messages.player_auto['拔打电话']}" opType="function" playerId="${command.result.id}">
                                                    <img src="${resRoot}/images/call.png" width="15" height="15">
                                                </soul:button>
                                                <c:if test="${command.result.mobilePhoneWayStatus!=22}">
                                                    <span class="btn btn-xs btn-danger btn-stroke m-l-sm pull-right">
                                                            ${dicts.notice.contact_way_status[command.result.mobilePhoneWayStatus]}
                                                    </span>
                                                </c:if>

                                            </c:if>
                                        </td>
                                        <th scope="row" class="text-center active">QQ</th>
                                        <td>
                                            <c:if test="${empty command.result.qq}">
                                                <span class="co-grayc2">${views.player_auto['未填写']}</span>
                                            </c:if>
                                            <c:if test="${not empty command.result.qq}">
                                                <c:choose>
                                                    <c:when test="${command.result.qqWayStatus==22}">
                                                        <span class="co-grayc2">${views.role['player.view.clearcontact']}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:if test="${unencryption}">
                                                            ${command.result.qq}
                                                        </c:if>
                                                        <c:if test="${!unencryption}">
                                                            ${soulFn:overlayString(command.result.qq)}&nbsp;
                                                            <c:if test="${empty command.result.mobilePhone && not empty command.result.qq}">
                                                                <soul:button target="${root}/player/playerViewDetail.html?search.id=${command.result.id}" text="${views.common['view']}"
                                                                             callback="setPersonalData"   opType="ajax" permission="role:player_personal_detail"></soul:button>
                                                            </c:if>
                                                        </c:if>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row" class="text-center active">${views.player_auto['邮箱']}</th>
                                        <td>
                                            <c:if test="${empty command.result.mail}">
                                                <span class="co-grayc2">${views.player_auto['未填写']}</span>
                                            </c:if>
                                            <c:if test="${not empty command.result.mail}">
                                                <c:choose>
                                                    <c:when test="${command.result.mailWayStatus==22}">
                                                        <span class="co-grayc2">${views.role['player.view.clearcontact']}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:if test="${unencryption}">
                                                            ${command.result.mail}
                                                        </c:if>
                                                        <c:if test="${!unencryption}">
                                                            ${soulFn:overlayEmaill(command.result.mail)}&nbsp;
                                                            <c:if test="${empty command.result.mobilePhone&&empty command.result.qq && not empty command.result.mail}">
                                                                <soul:button target="${root}/player/playerViewDetail.html?search.id=${command.result.id}" text="${views.common['view']}"
                                                                             callback="setPersonalData"   opType="ajax" permission="role:player_personal_detail"></soul:button>
                                                            </c:if>
                                                        </c:if>
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:if test="${command.result.mailWayStatus!=22}">
                                                    <span class="btn btn-xs btn-danger btn-stroke m-l-sm pull-right">
                                                            ${dicts.notice.contact_way_status[command.result.mailWayStatus]}
                                                    </span>
                                                </c:if>
                                            </c:if>
                                        </td>

                                        <th scope="row" class="text-center active">${views.player_auto['微信']}</th>
                                        <td>
                                            <c:if test="${empty command.result.weixin}">
                                                <span class="co-grayc2">${views.player_auto['未填写']}</span>
                                            </c:if>
                                            <c:if test="${not empty command.result.weixin}">
                                                <c:choose>
                                                    <c:when test="${command.result.weixinWayStatus==22}">
                                                        <span class="co-grayc2">${views.role['player.view.clearcontact']}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:if test="${unencryption}">
                                                            ${command.result.weixin}
                                                        </c:if>
                                                        <c:if test="${!unencryption}">
                                                            ${soulFn:overlayString(command.result.weixin)}&nbsp;
                                                            <c:if test="${empty command.result.mail && empty command.result.mobilePhone && empty command.result.qq && not empty command.result.weixin}">
                                                                <soul:button target="${root}/player/playerViewDetail.html?search.id=${command.result.id}" text="${views.common['view']}"
                                                                             callback="setPersonalData"   opType="ajax" permission="role:player_personal_detail"></soul:button>
                                                            </c:if>
                                                        </c:if>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:if>
                                        </td>

                                    </tr>
                                    </shiro:hasPermission>
                                    <tr>

                                        <th scope="row" class="text-center active" style="width: 15%">${views.player_auto['性别']}</th>
                                        <td style="width: 35%">
                                            <c:if test="${empty command.result.sex}">
                                                <span class="co-grayc2">${views.player_auto['未填写']}</span>
                                            </c:if>
                                            <c:if test="${not empty command.result.sex}">
                                                <span class="co-black">${dicts.common.sex[command.result.sex]}</span>
                                            </c:if>
                                        </td>

                                        <th scope="row" class="text-center active">${views.player_auto['生日']}</th>
                                        <td>
                                            <c:if test="${empty command.result.birthday}">
                                                <span class="co-grayc2">${views.player_auto['未填写']}</span>
                                            </c:if>
                                            <c:if test="${not empty command.result.birthday}">
                                                <span class="co-black">${soulFn:formatDateTz(command.result.birthday, DateFormat.DAY,timeZone)}</span>
                                            </c:if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row" class="text-center active">${views.player_auto['安全问题']}</th>
                                        <td colspan="3">
                                            <c:if test="${empty saferQuestion.result.question1}">
                                                <span class="co-grayc2">${views.player_auto['未填写']}</span>
                                            </c:if>
                                            <c:if test="${not empty saferQuestion.result.question1}">
                                                <span class="co-grayc2">${dicts.setting.master_questions[saferQuestion.result.question1]}</span>&nbsp;&nbsp;&nbsp;
                                                <span class="co-black">${saferQuestion.result.answer1}</span>
                                            </c:if>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </li>

                        <li class="detail-list-cow">
                            <span class="title">${views.player_auto['当前使用']}</span>
                            <c:if test="${fn:length(userbankcards)==0 && cashParam.paramValue=='true'}">
                                <c:if test="${command.result.playerStatus ne '2'}">
                                    <br/>
                                    <div class="content">
                                            ${views.player_auto['尚未设置银行卡']}
                                            <%--<a href="javascript:void(0)" class="btn btn-link co-blue">${views.player_auto['新增银行卡']}</a>--%>
                                                <soul:button target="${root}/player/view/bankEdit.html?search.userId=${command.result.id}"
                                                             userId="${command.result.id}" callback="saveOkQueryView" precall="hasRealName"
                                                             text="${views.player_auto['新增银行卡']}" opType="dialog" cssClass="btn btn-link co-blue add-bank-card-btn"/>
                                    </div>
                                </c:if>
                            </c:if>
                            <c:if test="${fn:length(userbankcards) > 0}">
                                <c:set var="userbankcard" value="${userbankcards.get(0)}"/>
                                <br/>
                                <div class="content">
                                        ${dicts.common.bankname[userbankcard.bankName]}
                                    &nbsp;
                                                ${userbankcard.bankcardNumber}
                                            <soul:button target="showBankcardList" data="bankcard-list" text="${views.player_auto['查看银行卡详细']}" opType="function" cssClass="btn btn-link show-bankcard-btn co-blue"></soul:button>
                                            <c:if test="${command.result.playerStatus ne '2'}">
                                                <soul:button target="${root}/player/view/bankEdit.html?search.userId=${command.result.id}" userId="${command.result.id}" callback="saveOkQueryView"
                                                             text="${views.role['Player.detail.bank.editBankInfo']}" opType="dialog" cssClass="btn btn-link co-blue edit-bank-card-btn hide"/>
                                            </c:if>
                                            <soul:button target="hideBankcardList" data="bankcard-list" text="${views.player_auto['返回']}" opType="function" fromShowBtn="true" cssClass="btn btn-link co-blue hide hide-bankcard-btn"></soul:button>
                                </div>
                                <div id="bankcard-list" class="dataTables_wrapper hide" role="grid">
                                    <div class="table-responsive">
                                        <table class="table table-striped table-bordered table-desc-list" aria-describedby="editable_info" style="width: 700px">
                                            <thead>
                                            <tr>
                                                <th>${views.player_auto['银行']}</th>
                                                <th>${views.player_auto['账户名']}</th>
                                                <th>${views.player_auto['卡号']}</th>
                                                <th>${views.player_auto['开户行']}</th>
                                                <th>${views.player_auto['添加时间']}</th>
                                                <th>${views.player_auto['使用次数']}</th>
                                                <th>${views.player_auto['状态']}</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="bankCard" items="${userbankcards}" varStatus="vs">
                                                <c:set value="${fn:toLowerCase(bankCard.bankName)}" var="bankName"></c:set>
                                                <tr class="gradeA ${vs.index%2==0?'odd':'even'}">
                                                    <td>
                                                        <span class="pay-bank ${bankName}"></span><%--${dicts.common.bankname[bankName]}--%>
                                                    </td>
                                                    <td>${bankCard.bankcardMasterName}</td>
                                                    <td>${soulFn:formatBankCard(bankCard.bankcardNumber)}</td>
                                                    <td>${bankCard.bankDeposit}</td>
                                                    <td>${soulFn:formatDateTz(bankCard.createTime, DateFormat.DAY_SECOND,timeZone)}</td>
                                                    <td class="co-red">${bankCard.useCount}</td>
                                                    <td>
                                                        <c:if test="${bankCard.isDefault}">
                                                            <span class="btn btn-xs btn-danger">${views.common['currentUse']}</span>
                                                        </c:if>
                                                        <c:if test="${!bankCard.isDefault}">
                                                            <span>${views.common['historyUse']}</span>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${fn:length(btnBanks)==0 && bitcoinParam.paramValue=='true'}">
                                <c:if test="${command.result.playerStatus ne '2'}">
                                    <br/>
                                    <div class="content">
                                            ${views.player_auto['尚未设置比特币地址']}
                                        <soul:button target="${root}/player/view/btcEdit.html?search.userId=${command.result.id}" callback="saveOkQueryView" text="${views.player_auto['新增比特币地址']}" opType="dialog" cssClass="btn btn-link co-blue add-bank-card-btn"/>
                                    </div>
                                </c:if>
                            </c:if>
                            <c:if test="${fn:length(btnBanks)>0}">
                                <c:set var="btc" value="${btnBanks.get(0)}"/>
                                <br/>
                                <div class="content">
                                        ${dicts.common.bankname[btc.bankName]}
                                    &nbsp;
                                                ${btc.bankcardNumber}&nbsp;
                                            <soul:button target="showBankcardList" data="btn-list" text="${views.player_auto['查看比特币详细']}" opType="function" cssClass="btn show-bankcard-btn co-blue"></soul:button>
                                            <c:if test="${command.result.playerStatus ne '2'}">
                                                <soul:button target="${root}/player/view/btcEdit.html?search.userId=${command.result.id}" userId="${command.result.id}" callback="saveOkQueryView"
                                                             text="${views.player_auto['修改比特币地址']}" opType="dialog" cssClass="btn btn-link co-blue edit-bank-card-btn hide"/>
                                            </c:if>
                                            <soul:button target="hideBankcardList" data="btn-list" text="${views.player_auto['返回']}" opType="function" fromShowBtn="true" cssClass="btn btn-link co-blue hide hide-bankcard-btn"></soul:button>
                                </div>
                                <div id="btn-list" class="dataTables_wrapper hide" role="grid">
                                    <div class="table-responsive">
                                        <table class="table table-striped table-bordered table-desc-list" aria-describedby="editable_info" style="width: 700px">
                                            <thead>
                                            <tr>
                                                <th></th>
                                                <th>${views.player_auto['钱包地址']}</th>
                                                <th>${views.player_auto['添加时间']}</th>
                                                <th>${views.player_auto['使用次数']}</th>
                                                <th>${views.player_auto['状态']}</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="bankCard" items="${btnBanks}" varStatus="vs">
                                                <c:set value="${fn:toLowerCase(bankCard.bankName)}" var="bankName"></c:set>
                                                <tr class="gradeA ${vs.index%2==0?'odd':'even'}">
                                                    <td>
                                                        <span class="pay-third ${bankName}"></span><%--${dicts.common.bankname[bankName]}--%>
                                                    </td>
                                                    <td>${soulFn:formatBankCard(bankCard.bankcardNumber)}</td>
                                                    <td>${soulFn:formatDateTz(bankCard.createTime, DateFormat.DAY_SECOND,timeZone)}</td>
                                                    <td class="co-red">${bankCard.useCount}</td>
                                                    <td>
                                                        <c:if test="${bankCard.isDefault}">
                                                            <span class="btn btn-xs btn-danger">${views.common['currentUse']}</span>
                                                        </c:if>
                                                        <c:if test="${!bankCard.isDefault}">
                                                            <span>${views.common['historyUse']}</span>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </c:if>
                        </li>
                        <li class="detail-list-cow">
                            <div class="content">
                                <span tabindex="0" class="" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                                      data-html="true" data-content="${views.fund_auto['包含人工存入的“人工存取/派彩/其他”']}<br/>PS:${views.fund_auto['仅统计“免稽核”和“存款稽核”类的“派彩/其他“订单']}">
                                    <i class="fa fa-question-circle" ></i>
                                </span>${views.player_auto['存款']}
                                <a href="/report/vPlayerFundsRecord/fundsLog.html?search.outer=-1&search.transactionType=<%=TransactionTypeEnum.DEPOSIT.getCode()%>&search.hasReturn=true&search.usernames=${command.result.username}&search.userTypes=username" nav-target="mainFrame">
                                    <span class="co-blue" id="rechargeCount">${views.player_auto['计算中']}...</span></a>${views.player_auto['次']}，
                                ${views.player_auto['共计']}${dicts.common.currency_symbol[command.result.defaultCurrency]}
                                <a href="/report/vPlayerFundsRecord/fundsLog.html?search.outer=-1&search.transactionType=<%=TransactionTypeEnum.DEPOSIT.getCode()%>&search.hasReturn=true&search.usernames=${command.result.username}&search.userTypes=username" nav-target="mainFrame">
                                    <span class="co-blue" id="rechargeTotal">${views.player_auto['计算中']}...</span>
                                </a>；
                                <span tabindex="0" class="" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                                      data-html="true" data-content="${views.player_auto['包含人工取出的所有类型']}。">
                                    <i class="fa fa-question-circle" ></i>
                                </span>${views.player_auto['取款']}
                                <a href="/report/vPlayerFundsRecord/fundsLog.html?search.outer=-1&search.hasReturn=true&search.usernames=${command.result.username}&search.userTypes=username&search.transactionType=<%=TransactionTypeEnum.WITHDRAWALS.getCode()%>" nav-target="mainFrame"><span class="co-blue" id="withdrawCountTime">${views.player_auto['计算中']}...</span></a>${views.player_auto['次']}，
                                ${views.player_auto['共计']}
                                ${dicts.common.currency_symbol[command.result.defaultCurrency]}
                                <a href="/report/vPlayerFundsRecord/fundsLog.html?search.outer=-1&search.hasReturn=true&search.usernames=${command.result.username}&search.userTypes=username&search.transactionType=<%=TransactionTypeEnum.WITHDRAWALS.getCode()%>" nav-target="mainFrame"><span class="co-blue" id="withdrawTotalMoney">${views.player_auto['计算中']}...</span></a>；
                                <span tabindex="0" class="" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                                      data-html="true" data-width="500px" data-content="${views.content['annotation.totalProfitLoss']}">
                                    <i class="fa fa-question-circle" ></i>
                                </span>${views.player_auto['存取差额']}
                                ${dicts.common.currency_symbol[command.result.defaultCurrency]}
                                <span id="totalProfitLoss">${views.player_auto['计算中']}...</span>
                                <%--${soulFn:formatInteger(command.result.totalProfitLoss)}${soulFn:formatDecimals(command.result.totalProfitLoss)}--%>；
                                <span tabindex="0" class="" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                                      data-html="true" data-content="${views.content['annotation.favorable']}">
                                    <i class="fa fa-question-circle" ></i>
                                </span>${views.player_auto['获得优惠']}
                                <a href="/report/vPlayerFundsRecord/fundsLog.html?search.usernames=${command.result.username}&search.userTypes=username&search.outer=-1&search.hasReturn=true&search.orderType=playerFavable&search.transactionType=<%=TransactionTypeEnum.FAVORABLE.getCode()%>" nav-target="mainFrame">
                                    <span class="co-blue" id="favCount">${views.player_auto['计算中']}...</span>
                                </a>
                                ${views.player_auto['次']}，
                                ${views.player_auto['共计']}${dicts.common.currency_symbol[command.result.defaultCurrency]}
                                <a href="/report/vPlayerFundsRecord/fundsLog.html?search.usernames=${command.result.username}&search.userTypes=username&search.outer=-1&search.hasReturn=true&search.orderType=playerFavable&search.transactionType=<%=TransactionTypeEnum.FAVORABLE.getCode()%>" nav-target="mainFrame">
                                    <span class="co-blue" id="favMoney">${views.player_auto['计算中']}...</span>
                                </a>；
                                <a href="/fund/deposit/company/list.html?search.username=${command.result.username}&search.playerId=${command.result.id}" class="btn btn-link co-blue" nav-target="mainFrame">${views.player_auto['公司入款记录']}</a>
                                <a href="/fund/deposit/online/list.html?search.username=${command.result.username}&search.playerId=${command.result.id}" class="btn btn-link co-blue" nav-target="mainFrame">${views.player_auto['线上支付记录']}</a>
                                <a href="/fund/withdraw/withdrawList.html?search.username=${command.result.username}&search.playerId=${command.result.id}" class="btn btn-link co-blue" nav-target="mainFrame">${views.player_auto['取款记录']}</a>

                            </div>
                        </li>
                        <li class="detail-list-cow">
                            <div class="content">
                                <span tabindex="0" class="" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                                      data-html="true" data-content="${views.player_auto['当前投注额及有效投注额，仅统计上次清除稽核点（不包含通过即时稽核-稽核点清零）后，到此刻玩家达到的投注额和有效投注额。']}">
                                    <i class="fa fa-question-circle" ></i>
                                </span>${views.player_auto['当前投注额']}
                                ${dicts.common.currency_symbol[command.result.defaultCurrency]}
                                <a href="/report/gameTransaction/init.html?isLink=true&search.username=${command.result.username}&searchKey=search.username" nav-target="mainFrame">
                                    <span class="co-blue" id="singleamount">${views.player_auto['计算中']}...</span>
                                </a>，
                                ${views.player_auto['有效投注额']}${dicts.common.currency_symbol[command.result.defaultCurrency]}
                                <a href="/report/gameTransaction/init.html?isLink=true&search.username=${command.result.username}&searchKey=search.username" nav-target="mainFrame">
                                    <span class="co-blue" id="effectivetradeamount">${views.player_auto['计算中']}...</span>
                                </a>
                                ，
                                <%--<span tabindex="0" class="" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                                  data-html="true" data-content="${views.player_auto['仅统计近40天（含今日）的派彩总和。']}">
                                <i class="fa fa-question-circle" ></i>
                            </span>--%>${views.player_auto['近期损益']}
                                ${dicts.common.currency_symbol[command.result.defaultCurrency]}
                                <span class="co-blue" id="recentProfitAmout">${views.player_auto['计算中']}...</span>
                                <a href="/report/gameTransaction/init.html?isLink=true&search.username=${command.result.username}&searchKey=search.username" nav-target="mainFrame" class="btn btn-link co-blue">${views.player_auto['投注记录']}</a>
                                <soul:button target="${root}/fund/withdraw/immediateAudit.html?search.playerId=${command.result.id}" size="open-dialog-1000"
                                             callback="gotoGameOrder" text="${views.player_auto['即时稽核']}" title="${views.player_auto['即时稽核详细']}" opType="dialog" cssClass="btn btn-link co-blue"></soul:button>
                            </div>
                        </li>
                        <li class="detail-list-cow">
                            <div class="content">${views.player_auto['该玩家推广码']}${command.result.registCode}、
                                ${views.player_auto['已成功推荐']}<a href="/player/list.html?search.hasReturn=true&search.recommendUserId=${command.result.id}" nav-target="mainFrame">${playerRecomd.count}</a>${views.player_auto['位玩家注册']}、
                                ${views.player_auto['获得']}${dicts.common.currency_symbol[command.result.defaultCurrency]}
                                <a href="/report/vPlayerFundsRecord/fundsLog.html?search.hasReturn=true&search.userTypes=username&search.usernames=${command.result.username}&search.outer=-1&search.transactionWays=<%=TransactionWayEnum.SINGLE_REWARD.getCode()%>" nav-target="mainFrame">
                                    ${soulFn:formatInteger(playerRecomd.amount)}${soulFn:formatDecimals(playerRecomd.amount)}
                                </a>
                                ${views.player_auto['推荐单次奖励']}、
                                ${dicts.common.currency_symbol[command.result.defaultCurrency]}
                                <a href="/report/vPlayerFundsRecord/fundsLog.html?search.hasReturn=true&search.userTypes=username&search.usernames=${command.result.username}&search.outer=-1&search.transactionWays=<%=TransactionWayEnum.BONUS_AWARDS.getCode()%>" nav-target="mainFrame">
                                    ${soulFn:formatInteger(playerRecomd.rebate)}${soulFn:formatDecimals(playerRecomd.rebate)}
                                </a>
                                ${views.player_auto['推荐红利']}
                            </div>
                        </li>
                        <li class="detail-list-cow">
                            <span class="title">${views.player_auto['标签']}</span>
                            <div class="content">
                                <c:set var="tagcount" value="${fn:length(vPlayerTagAllListVo.result)}"></c:set>
                                <c:forEach items="${vPlayerTagAllListVo.result}" var="l" varStatus="vs">
                                    <span class="label-del">${l.tagName}</span>
                                    <c:if test="${(vs.index+1)<tagcount}">、</c:if>
                                </c:forEach>
                                <c:if test="${command.result.playerStatus!='2'}">
                                    <soul:button target="${root}/player/editLabel.html?search.id=${command.result.id}"  callback="queryView"
                                                 text="${dicts.log.op_type['create']}" opType="dialog" cssClass="btn btn-link co-blue"/>
                                </c:if>
                                <soul:button target="${root}/vPlayerTag/list.html" callback="playerTag.playerTagSaveCallBack" size="open-dialog-95p"
                                             cssClass="btn btn-link co-blue" tag="a" opType="dialog" text="${views.role['Player.list.tagManager']}">
                                    ${views.common['manage']}
                                </soul:button>
                            </div>
                        </li>
                        <li class="detail-list-cow">
                            <span class="title">${views.player_auto['风控标识']}</span>
                            <div class="content">
                                <c:set var="riskCount" value="${fn:length(riskSet)}"></c:set>
                                <c:forEach items="${riskSet}" var="risk" varStatus="vs">
                                    <span class="label-del">${dicts.player.risk_data_type[risk]}</span>
                                    <c:if test="${(vs.index+1)<riskCount}">、</c:if>
                                </c:forEach>

                                    <soul:button target="${root}/player/editRiskLabel.html?search.id=${command.result.id}" callback="queryView" precall="hasBankcard"
                                                 text="${dicts.log.op_type['update']}" opType="dialog" cssClass="btn btn-link co-blue"/>
                                <c:if test="${command.result.riskDataType.length() == 8 && command.result.riskDataType.contains('2')}">
                                    ${views.player_auto['由系统风控大数据识别']}:
                                    <c:if test="${command.result.riskDataType.substring(5,6) eq '2'}">
                                        ${views.common['MALICIOUS']},
                                    </c:if>
                                    <c:if test="${command.result.riskDataType.substring(6,7) eq '2'}">
                                        ${views.common['MONEY_LAUNDERING']},
                                    </c:if>
                                    <c:if test="${command.result.riskDataType.substring(7,8) eq '2'}">
                                        ${views.common['INTEREST_ARBITRAGE']}
                                    </c:if>
                                </c:if>

                            </div>
                            <c:if test="${not empty riskLog}">
                                &nbsp;&nbsp;
                                    <span data-content="<div>${views.common['content.editUser']}：${riskLog.operator}</div>
                                <div>${views.common['content.editTime']}：${soulFn:formatDateTz(riskLog.operateTime, DateFormat.DAY_SECOND,timeZone)}-${soulFn:formatTimeMemo(riskLog.operateTime, locale)}</div>"
                                          data-placement="bottom" data-trigger="focus" data-toggle="popover" data-container="body" data-html="true"
                                          role="button" class="ico-lock" tabindex="0"
                                          data-original-title="" title="" style="font-size: 14px;color: #9c9c9c; display: inline-block;">
                                          ${views.player_auto['由']}${riskLog.operator}${views.player_auto['于']}
                                          ${soulFn:formatDateTz(riskLog.operateTime, DateFormat.DAY_SECOND,timeZone)}-${soulFn:formatTimeMemo(riskLog.operateTime, locale)}&nbsp;
                                            ${soulFn:formatLogDesc(riskLog)}</span>
                            </c:if>
                        </li>
                        <li class="detail-list-cow">
                            <div class="content">${views.player_auto['最后一次登入IP为']}
                                <a href="/report/log/logList.html?hasReturn=true&search.roleType=player&keys=search.ip&search.ip=${soulFn:formatIp(command.result.loginIp)}" nav-target="mainFrame">${soulFn:formatIp(command.result.loginIp)}</a>
                                <c:if test="${not empty command.result.loginIpDictCode}">
                                    [ ${gbFn:getShortIpRegion(command.result.loginIpDictCode)}]
                                </c:if>
                                ${views.player_auto['于']} <span class="co-gray">
                                    ${soulFn:formatDateTz(command.result.loginTime, DateFormat.DAY_SECOND,timeZone)} - ${soulFn:formatTimeMemo(command.result.loginTime,locale )}
                                </span>
                                <span tabindex="0" role="button" data-container="body" data-toggle="popover" data-trigger="focus"
                                      data-placement="top" data-html="true" data-content="${command.result.useLine}"
                                      class="btn btn-link co-blue"><a href="http://${command.result.useLine}" target="_blank">${views.player_auto['查看来源URL']}</a></span>
                                <a href="/report/log/logList.html?hasReturn=true&search.roleType=player&search.operator=${command.result.username}&search.moduleTypes=1,2" class="btn btn-link co-blue" nav-target="mainFrame">${views.player_auto['查看该玩家登入记录']}</a>
                                <a href="/report/log/logList.html?hasReturn=true&search.roleType=player&keys=search.ip&search.ip=${soulFn:formatIp(command.result.loginIp)}&search.moduleTypes=1,2" class="btn btn-link co-blue" nav-target="mainFrame">${views.player_auto['查看此IP登入记录']}</a>
                                <a href="/report/log/logList.html?hasReturn=true&search.roleType=player&search.operator=${command.result.username}" class="btn btn-link co-blue" nav-target="mainFrame"> ${views.player_auto['操作日志']}</a>
                            </div>
                        </li>
                        <li class="detail-list-cow">
                            <div class="content">${views.player_auto['两个月内站内信共']}
                                <a href="/operation/massInformation/queryPlayerSiteMsg.html?search.receiverId=${command.result.id}" nav-target="mainFrame">${msgCount}</a>${views.player_auto['封']}，
                                ${views.player_auto['未读为']}<a href="/operation/massInformation/queryPlayerSiteMsg.html?search.receiverId=${command.result.id}&search.receiveStatus=01" nav-target="mainFrame">${msgLength}</a>${views.player_auto['封']}，
                                ${views.player_auto['玩家主动咨询']}<a href="/operation/announcementMessage/advisoryList.html?hasReturn=yes&search.playerId=${command.result.id}" nav-target="mainFrame">${playerAdvisoryCount}</a> ${views.player_auto['条']}
                                <a href="/operation/massInformation/editContent.html?hasReturn=yes&sendType=siteMsg&targetUser=player&group=appoint&pushMode=only&appointPlayer=${command.result.username}" nav-target="mainFrame" class="btn btn-link co-blue">${views.player_auto['发送站内信']}</a>
                                <a href="/operation/massInformation/history.html?search.receiverGroupId=${command.result.id}" nav-target="mainFrame" class="btn btn-link co-blue">${views.player_auto['查看站内信记录']}</a>
                                <a href="/operation/announcementMessage/advisoryList.html?hasReturn=yes&search.playerId=${command.result.id}" nav-target="mainFrame" class="btn btn-link co-blue"> ${views.player_auto['查看咨询记录']}</a>
                            </div>
                        </li>
                        <li class="detail-list-cow">
                            <div class="content">${views.player_auto['备注']}：
                                <soul:button target="${root}/playerRemark/editPlayerRemark.html?search.id=${remark.id}&search.entityUserId=${command.result.id}&search.model=player&search.remarkType=remark" cssClass="btn btn-link co-blue"
                                             callback="queryView" text="${views.player_auto['添加备注']}" opType="dialog">${views.player_auto['添加备注']}</soul:button>
                                <%--<soul:button target="loadRemarkByType" text="${views.player_auto['查看手动添加的备注']}" remarkType="remark" opType="function" cssClass="btn btn-link co-blue show-part-remark"></soul:button>
                            <soul:button target="loadRemarkByType" text="${views.player_auto['查看全部']}" opType="function" cssClass="btn btn-link co-blue show-all-remark hide"></soul:button>--%>
                            </div>
                            <div style="padding-left: 25px;width: 800px">
                                <textarea maxlength="5000" name="result.memo" class="form-control width-response" ${empty command.result.memo?'':'readonly'}
                                          style="width: 100%;" rows="4">${command.result.memo}</textarea>
                                <input type="hidden" name="old_memo" id="old_memo" value="${command.result.memo}">
                                <div class="btn-groups text-left pull-left p-t-xs width-response">
                                    <soul:button target="editRemark" opType="function" cssClass="btn btn-link co-blue edit-btn-css ${empty command.result.memo?'hide':''}" text="${views.common['edit']}">
                                        <span class="fa fa-edit"></span> ${views.common['edit']}
                                    </soul:button>
                                    <soul:button target="${root}/player/saveRemark.html" opType="ajax" callback="afterSaveRemark" post="getCurrentFormData"
                                                 cssClass="btn btn-link co-blue save-btn-css ${not empty command.result.memo?'hide':''}" text="${views.common['save']}">
                                        <span class="fa fa-save"></span> ${views.common['save']}
                                    </soul:button>
                                    <soul:button target="cancelEdit" opType="function" cssClass="btn btn-link co-blue cancel-btn-css hide" text="${views.common['cancel']}">
                                        <span class="fa fa-undo"></span> ${views.common['cancel']}
                                    </soul:button>
                                </div>
                                <div class="text-right pull-right">
                                    <c:if test="${not empty command.result.memo}">
                                        [${command.result.updateUsername}]
                                        ${soulFn:formatDateTz(command.result.updateTime, DateFormat.DAY_SECOND,timeZone)} - <span class="co-grayc2">${soulFn:formatTimeMemo(command.result.updateTime, locale)}</span>
                                    </c:if>
                                    <c:if test="${empty command.result.memo}">&nbsp;</c:if>
                                </div>
                            </div>
                            <ul class="detail-remark-list" id="detail-remark-list" style="padding-bottom: 15px;padding-top: 50px">

                                <c:forEach var="remark" items="${remarkListVo.result}" varStatus="idx">
                                    <li class="remark-list-li">
                                        <span class="co-gray m-r-sm">
                                                ${idx.index+1}:${dicts.common.remark_type[remark.remarkType]}
                                                    [${remark.operator}]
                                                        ${soulFn:formatDateTz(remark.remarkTime, DateFormat.DAY_SECOND,timeZone)} - ${soulFn:formatTimeMemo(remark.remarkTime, locale)}
                                        </span>
                                            ${remark.remarkContent}
                                        <div class="operate-district">
                                            <soul:button target="${root}/playerRemark/editPlayerRemark.html?search.id=${remark.id}"
                                                         callback="queryView" text="${views.player_auto['编辑']}" opType="dialog"><i class="fa fa-pencil-square-o m-l"></i></soul:button>
                                            <soul:button target="${root}/playerRemark/deletePlayerRemark.html?search.id=${remark.id}"
                                                         callback="delRemarkCallback" text="${views.player_auto['删除']}" opType="ajax"><i class="fa fa-trash-o m-l"></i></soul:button>
                                        </div>
                                    </li>
                                </c:forEach>

                                <%--<li><span class="co-gray m-r-sm">余额冻结  [ lushe]  2016-07-22 14:47:44 - 43天前</span>  该玩家8月4日下午连续刷水150笔，账号存在被盗风险，冻结3小时；该玩家8月4日下午连续刷水150笔，账号存在被盗风险，冻结3小时；该玩家8月4日下午连续刷水150笔，账号存在被盗风险，冻结3小时；该玩家8月4日下午连续刷水150笔，账号存在被盗风险，冻结3小时；<div class="operate-district"> <a href="#"><i class="fa fa-pencil-square-o m-l"></i></a><a href="#"><i class="fa fa-trash-o m-l"></i></a></div></li>--%>
                            </ul>
                            <div class="text-center co-gray9 ${remarkListVo.paging.totalCount>10?'':'hide'}" id="remark-add-more">
                                <soul:button target="loadMoreRemark" text="${views.player_auto['加载更多']}" opType="function"></soul:button>
                            </div>
                            <div class="text-center co-gray9 hide" id="loading-remark-data"><span class="fa fa-spinner fa-pulse"></span>${views.player_auto['数据加载中…']}</div>

                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</form>
<form id="remarkForm">
    <input type="hidden" name="search.entityUserId" value="${command.result.id}">
    <input type="hidden" name="search.remarkType" value="">
    <input type="hidden" name="search.fromCount" value="${fn:length(remarkListVo.result)}">
    <input type="hidden" name="paging.totalCount" value="${remarkListVo.paging.totalCount}">

</form>
<soul:import res="site/player/view.include/PlayerDetail"/>
