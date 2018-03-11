<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>

<div class="row">
    <form:form action="${root}/vPlayerOnline/list.html" method="post" name="playerOnlineForm">
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
                    <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                        <div class="input-group">
                            <span class="bg-gray input-group-addon bdn">
                                <gb:selectPure name="command.search.username" list="${userType}"
                                               listKey="key"
                                               value="${command.search.username}" listValue="value"
                                               callback="changeKey"
                                               prompt="" cssClass="chosen-select-no-single"/>
                            </span>
                            <c:if test="${not empty conmand.search.username||empty command.search.username&&empty command.search.ip}">
                                <input type="text" class="form-control account_input list-search-input-text"
                                       name="search.username" id="searchtext" value="${command.search.username}"
                                       placeholder="">
                            </c:if>
                            <c:if test="${not empty command.search.ip}">
                                <input type="text" class="form-control account_input list-search-input-text"
                                       name="search.ip" id="searchtext" value="${command.search.ip}"
                                       placeholder="">
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
                                        <span class="rankText" prompt="prompt">${views.player_auto['请选择']}</span>
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
                                                                <input type="checkbox" name="search.playerRanks"
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
                        <%--注册URL--%>
                    <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                        <div class="input-group">
                            <span class="input-group-addon bg-gray">${views.player_auto['登录URL']}</span>
                            <input type="text" class="form-control" name="search.useLine"
                                   value="">
                        </div>
                    </div>
                        <%--来源终端ok--%>
                    <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm h-line-a">
                        <div class="input-group">
                            <span class="input-group-addon bg-gray">${views.player_auto['来源终端']}</span>
                            <input type="hidden" id="channelTerminal" value="${command.search.channelTerminal}">
                            <span class=" input-group-addon bdn  right-btn-down">
                                <div class="btn-group table-desc-right-t-dropdown">
                                            <label><input type="radio" name="search.channelTerminal"
                                                          value="" ${empty command.search.channelTerminal?'checked':''}>
                                                    ${views.player_auto['全部']}</label>
                                            <label><input type="radio"
                                                          name="search.channelTerminal" ${command.search.channelTerminal=='PC'?'checked':''}
                                                          value="PC">${views.player_auto['PC端']}</label>
                                            <label><input type="radio"
                                                          name="search.channelTerminal" ${command.search.channelTerminal=='App'?'checked':''}
                                                          value="App">${views.player_auto['手机端APP']}</label>
                                                <label><input type="radio"
                                                              name="search.channelTerminal" ${command.search.channelTerminal=='Mobile'?'checked':''}
                                                              value="Mobile">${views.player_auto['手机端Web']}</label>
                                </div>
                            </span>
                        </div>
                    </div>
                    <span class="input-group-btn">
                        <soul:button target="query" precall="" opType="function" cssClass="btn btn-filter btn-query-css enter-submit" tag="button" text="">
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
