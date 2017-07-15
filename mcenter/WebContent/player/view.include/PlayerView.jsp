<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VUserPlayerVo"--%>
<div class="row" name="playerViewDiv">
    <div class="position-wrap clearfix">
        <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont"></i> </a></h2>
        <span>${views.sysResource['角色']}</span><span>/</span><span>${views.sysResource['玩家管理']}</span>
        <soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
            <em class="fa fa-caret-left"></em>${views.common['return']}
        </soul:button>
    </div>
    <div class="col-lg-12">
        <div class="wrapper white-bg clearfix shadow">
            <div class="sys_tab_wrap clearfix line-hi34 p-xs m-b-sm">
                <div class="pull-left">
                    <h3 class="pull-left m-r-sm">${views.role['Player.detail.title']}</h3>
                </div>
                <div class="pull-right m-l" data_id="${command.result.id}" id="btns">
                    <a href="/player/playerView.html?search.id=${command.result.id}" name="returnMain" nav-target="mainFrame" style="display: none"/>
                    <a href="" id="tot" nav-target="mainFrame" style="display: none"></a>
                    <input type="hidden" name="userStatus" value="${command.result.status}"/>
                    <input type="hidden" name="accountStatus" value="${accountStatus}"/>
                    <a nav-target="mainFrame" style="display: none" name="editTmpl" href="/noticeTmpl/tmpIndex.html?lastPage=t"><span></span></a>
                    <a nav-target="mainFrame" style="display: none" id="reloadView" href="/player/playerView.html?search.id=${command.result.id}"><span></span></a>

                    <%--账户停用--%>
                    <c:if test="${command.result.status eq '2'}">
                        <c:set value="true" var="option_btn_disabled"></c:set>
                    </c:if>
                    <shiro:hasPermission name="role:player_edit">
                        <a href="/player/getVUserPlayer.html?search.id=${command.result.id}" nav-target="mainFrame"
                           class="btn btn-outline btn-filter btn-sm${option_btn_disabled ?' disabled':''}">${views.common['editInfo']}</a>
                    </shiro:hasPermission>
                    <c:choose>
                        <c:when test="${command.result.accountfreeze}">
                            <soul:button permission="role:player_cancelfreezeaccount" target="${root}/share/account/toCancelAccountFreeze.html?search.id=${command.result.id}&sign=player"
                                         text="${views.role['Player.detail.cancelAccountFreeze']}"
                                         opType="dialog"
                                         cssClass="btn btn-outline btn-filter btn-sm${option_btn_disabled ?' disabled':''}"
                                         callback="reloadViewWithoutReturnValue" confirm="${views.role['Player.detail.cancelAccountFreezeOk']}">
                                ${views.role['Player.detail.cancelAccountFreeze']}
                            </soul:button>
                        </c:when>
                        <c:otherwise>
                            <soul:button target="${root}/share/account/freezeAccount.html?result.id=${command.result.id}"
                                        text="${views.role['Player.detail.freezeAccount']}"
                                        opType="dialog"
                                        cssClass="btn btn-outline btn-filter btn-sm${option_btn_disabled ?' disabled':''}"
                                        callback="reloadView" permission="role:player_freezeaccout">
                                ${views.role['Player.detail.freezeAccount']}
                            </soul:button>
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${command.result.balanceFreeze}">
                            <soul:button permission="role:player_cancelfreezebalance"
                                    target="${root}/share/account/toCancelBalanceFreeze.html?search.id=${command.result.id}"
                                    text="${views.role['Player.detail.cancelBalanceFreeze']}"
                                    name="accountFrozen"
                                    opType="dialog"
                                    returnValue="true"
                                    cssClass="btn btn-outline btn-filter btn-sm${option_btn_disabled ?' disabled':''} ${command.result.accountfreeze?'disabled':''}"
                                    callback="reloadViewWithoutReturnValue" confirm="${views.role['Player.detail.cancelBalanceFreezeOk']}">
                                ${views.role['Player.detail.cancelBalanceFreeze']}
                            </soul:button>
                        </c:when>
                        <c:otherwise>
                            <soul:button
                                    target="${root}/share/account/freezeBalance.html?result.id=${command.result.id}"
                                    text="${views.role['Player.detail.freezeBalance']}"
                                    name="accountFrozen"
                                    opType="dialog"
                                    cssClass="btn btn-outline btn-filter btn-sm${option_btn_disabled ?' disabled':''} ${command.result.accountfreeze?'disabled':''}"
                                    callback="reloadView" permission="role:player_freezebalance">
                                ${views.role['Player.detail.freezeBalance']}
                            </soul:button>
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${command.result.status == '2'}">
                            <soul:button
                                    target="${root}/player/view/cancelDisabled.html?userId=${command.result.id}"
                                    cssClass="btn btn-outline btn-filter btn-sm disabled"
                                    text="${views.role['Player.detail.disabled']}"
                                    name="accountDisabled"
                                    opType="ajax"
                                    confirm="${views.role['player.confirm.cancelstop']}"
                                    callback="reloadViewWithoutReturnValue">
                                ${views.role['Player.detail.disabled']}
                            </soul:button>
                        </c:when>
                        <c:otherwise>
                            <soul:button
                                    target="${root}/share/account/disabledAccount.html?result.id=${command.result.id}"
                                    text="${messages['playerTag']['accountDisabled']}"
                                    opType="dialog"
                                    cssClass="btn btn-outline btn-filter btn-sm"
                                    callback="reloadView">
                                ${messages['playerTag']['accountDisabled']}
                            </soul:button>
                        </c:otherwise>
                    </c:choose>

                    <soul:button title="${views.role['Player.detail.resetLoginPwd']}" target="${root}/player/resetPwd/index.html?resetType=loginPwd&userId=${command.result.id}" cssClass="${option_btn_disabled ?'disabled':''} btn btn-outline btn-filter btn-sm" text="" opType="dialog" tag="button">
                        ${views.role['Player.detail.resetLoginPwd']}
                    </soul:button>

                    <soul:button title="${views.role['Player.detail.resetpayPwd']}" target="${root}/player/resetPwd/index.html?resetType=payPwd&userId=${command.result.id}" cssClass="${option_btn_disabled ?'disabled':''} ${command.result.accountfreeze?'disabled':''} btn btn-outline btn-filter btn-sm" text="" opType="dialog" tag="button">
                        ${views.role['Player.detail.resetpayPwd']}
                    </soul:button>

                    <a href="/report/vPlayerFundsRecord/fundsLog.html?search.userTypes=username&search.usernames=${command.result.username}&search.outer=-1" class="btn btn-outline btn-filter btn-sm areport" nav-target="mainFrame">${views.role['Player.detail.fundsLog']}</a>
                </div>
            </div>
            <div class="">
                <div class="panel blank-panel">
                    <div class="">
                        <div class="panel-options">
                            <ul class="nav nav-tabs p-l-sm p-r-sm">
                                <li class="active">
                                    <a data-toggle="tab" href="#playerInfo${command.result.id}" aria-expanded="true" data-load="1">${views.role['Player.detail.playerInfo']}</a>
                                </li>
                                <li><%--修改为查询VPlayerTransaction视图，否则状态和玩家中心不统一--%>
                                    <a data-toggle="tab" href="#funds${command.result.id}" aria-expanded="false" data-href="${root}/playerFunds/queryListByView.html?playerId=${command.result.id}">${views.role['Player.detail.funds']}</a>
                                </li>
                                <li>
                                    <a data-toggle="tab" href="#singleRecord${command.result.id}" aria-expanded="false" data-href="${root}/playerSingleRecord/singleRecord.html?playerId=${command.result.id}">${views.role['Player.detail.singleRecord']}</a>
                                </li>
<%--                              二期  <li>
                                    <a data-toggle="tab" href="#sale${command.result.id}" aria-expanded="false" data-href="${root}/player/view/sale.html?playerId=${command.result.id}">${views.player_auto['优惠']}</a>
                                </li>--%>
                               <%-- <li>
                                    <a data-toggle="tab" href="#integrate${command.result.id}" aria-expanded="false" data-href="${root}/player/view/integrate.html?playerId=${command.result.id}">${views.player_auto['积分']}</a>
                                </li>--%>
                                <li>
                                    <a data-toggle="tab" href="#bankCard${command.result.id}" aria-expanded="false" data-href="${root}/player/view/bankCard.html?search.userId=${command.result.id}">${views.role['Player.detail.bankCard']}</a>
                                </li>
                               <%-- <li>
                                    <a data-toggle="tab" href="#address${command.result.id}" aria-expanded="false" data-href="${root}/player/view/address.html?search.playerId=${command.result.id}">${views.player_auto['地址']}</a>
                                </li>--%>
                <%--              二期  <li>
                                    <a data-toggle="tab" href="#collect${command.result.id}" aria-expanded="false" data-href="${root}/player/view/collect.html?playerId=${command.result.id}">${views.player_auto['收藏']}</a>
                                </li>--%>
                                <li>
                                    <a data-toggle="tab" href="#news${command.result.id}" aria-expanded="false" data-href="${root}/player/view/news.html?search.playerId=${command.result.id}">${views.role['Player.detail.news']}</a>
                                </li>
                                <li>
                                    <a data-toggle="tab" href="#remark${command.result.id}" aria-expanded="false" data-href="${root}/playerRemark/remark.html?search.entityUserId=${command.result.id}&search.operatorId=${command.result.id}" data-link="${extendedLinks}" id="remark">${views.role['Player.detail.remark']}</a>
                                </li>
                                <li>
                                    <a data-toggle="tab" href="#journal${command.result.id}" aria-expanded="false" data-href="${root}/player/view/journal.html?search.entityUserId=${command.result.id}&search.operatorId=${command.result.id}">${views.role['Player.detail.log']}</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="tab-content">
                            <!--玩家信息-->
                            <div id="playerInfo${command.result.id}" class="tab-pane active">
                                <%@include file="/player/view.include/PlayerInfo.jsp" %>
                            </div>
                            <!--资金-->
                            <div id="funds${command.result.id}" class="tab-pane"></div>
                            <!--下单记录-->
                            <div id="singleRecord${command.result.id}" class="tab-pane"></div>
                         <%--   <!--优惠-->
                            <div id="sale${command.result.id}" class="tab-pane"></div>
                            <!--积分-->
                            <div id="integrate${command.result.id}" class="tab-pane"></div>--%>
                            <!--银行卡-->
                            <div id="bankCard${command.result.id}" class="tab-pane">
                            </div>
                           <%-- <!--地址-->
                            <div id="address${command.result.id}" class="tab-pane"></div>--%>
                            <!--收藏-->
                          <%--  <div id="collect${command.result.id}" class="tab-pane"></div>--%>
                            <!--资讯-->
                            <div id="news${command.result.id}" class="tab-pane"></div>
                            <!--备注-->
                            <div id="remark${command.result.id}" class="tab-pane"></div>
                            <!--日志-->
                            <div id="journal${command.result.id}" class="tab-pane"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<soul:import res="site/player/view.include/PlayerView"/>
