<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.VPayAccountListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/vPayAccount/list.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
        <form:hidden path="search.type"/>
            <!--//region your codes 2-->
            <div class="row">
                <div class="position-wrap clearfix">
                    <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
                    <span>${views.sysResource['运营']}</span><span>/</span>
                    <span>
                        <c:if test="${command.search.type eq '1'}">
                            ${views.sysResource['公司入款账户']}
                        </c:if>
                        <c:if test="${command.search.type eq '2'}">
                            ${views.sysResource['线上支付账户']}
                        </c:if>
                    </span>
                    <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
                </div>
                <div class="col-lg-12">
                    <div class="wrapper white-bg shadow">
                        <a href="/vPlayerRankStatistics/list.html" id="rankList" nav-target="mainFrame" class="fil" hidden/>
                        <!--筛选条件-->
                        <div class="clearfix filter-wraper border-b-1">
                            <a href="${command.search.type=="1"?"/payAccount/companyCreate.html":"/payAccount/onLineCreate.html"}" class="btn btn-info btn-addon pull-left m-r-sm" nav-target="mainFrame"><i class="fa fa-plus"></i><span class="hd">${views.common['create']}</span></a>
                            <soul:button tag="button" precall="refreshPage" target="query" opType="function" cssClass="btn btn-primary-hide" text="${views.common['refresh']}"><i class="fa fa-refresh"></i><span class="hd">${views.common['refresh']}</span></soul:button>
                            <%--<soul:button tag="button" target="${root}/vPayAccount/filters.html" opType="dialog" cssClass="btn btn-warning-hide" callback="showFiltersCallBack" text="${views.common['filter']}"><i class="fa fa-filter"></i><span class="hd">${views.common['filter']}</span></soul:button>--%>
                            <c:if test="${command.search.type eq '2'}">
                                <a href="/vPayAccount/cashFlowOrder.html" nav-target="mainFrame" class="btn btn-primary-hide pull-left m-r-sm"><i class="fa fa-exchange"></i><span class="hd">${views.content['payAccount.cash.order']}</span></a>
                                <soul:button target="${root}/payAccount/digiccyAccount.html" cssClass="btn btn-primary-hide pull-left m-r-sm" text="${views.content_auto['数字货币']}" opType="dialog" permission="content:onlineaccount_digiccy"/>
                            </c:if>
                            <%--<soul:button cssClass="pull-left btn btn-warning-hide m-r-sm" target="${root}/payAccount/warningSettings/${command.search.type}.html" text="" opType="dialog"><i class="fa fa-warning"></i><span class="hd">${views.content['payAccount.warm.setting']}</span></soul:button>--%>
                            <%--<a href="/payAccount/warningSettings/${command.search.type}.html" nav-target="mainFrame" class="pull-left btn btn-warning-hide m-r-sm"><i class="fa fa-warning"></i><span class="hd">${views.content['payAccount.warm.setting']}</span></a>--%>
                            <%--<button type="button" class="btn btn-primary-hide" data-toggle="modal" data-target="#hideSet"><i class="fa fa-eye-slash"></i><span class="hd">${views.content_auto['隐藏设置']}</span></button>--%>
                            <c:if test="${command.search.type eq '1'}">
                                <soul:button target="${root}/vPayAccount/hideSetting.html" callback="hideSettingCallback" cssClass="btn btn-primary-hide" text="${views.content['payAccount.hideSet']}" opType="dialog" tag="button"><i class="fa fa-eye-slash"></i><span class="hd">${views.content['payAccount.hideSet']}</span></soul:button>
                 <%--               <span tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover"  data-trigger="focus" data-placement="top" data-content="开启后，前端存款界面将只展示收款银行和姓名，不展示账号。避免账号被恶意举报">
                                    <i class="fa fa-question-circle"></i>
                                </span>--%>
                                <a nav-target="mainFrame" href="/param/basicSettingIndex.html" style="display: none">
                                </a>
                            </c:if>
                            <soul:button target="${root}/cttAnnouncement/addAnnouncement.html?announcementType=2" title="${views.content_auto['公告']}" tag="button" opType="dialog"
                                         text="${views.common['create']}" cssClass="btn btn-primary-hide">
                                <i class="fa fa-edit"></i><span class="hd">${views.content['公告']}</span>
                            </soul:button>
                            <c:if test="${command.search.type eq '1'}">
                                <soul:button target="${root}/payAccount/rechargeUrl.html" text="" opType="dialog" title="${views.content_auto['充值中心']}" cssClass="btn btn-primary-hide pull-left m-r-sm"><i class="iconfont icon-xianshangzhifujilu"></i><span class="hd">${views.content_auto['充值中心']}</span></soul:button>
                                <%--<soul:button target="${root}/payAccount/acbSetting.html" title="${views.content_auto['上分设置']}" tag="button" opType="dialog" text="${views.content_auto['上分设置']}" cssClass="btn btn-primary-hide"><i class="iconfont icon-fanshuishezhi"></i><span class="hd">${views.content_auto['上分设置']}</span></soul:button>--%>
                                <a href="/vPayAccount/companySort.html" nav-target="mainFrame" class="btn btn-primary-hide pull-left m-r-sm"><i class="fa fa-exchange"></i><span class="hd">${views.content['payAccount.cash.order']}</span></a>
                                <%--<soul:button target="${root}/payAccount/digiccyAccount.html" cssClass="btn btn-primary-hide pull-left m-r-sm" text="${views.content_auto['数字货币']}" opType="dialog" permission="content:onlineaccount_digiccy"/>--%>
                            </c:if>
                            <div class="search-wrapper btn-group pull-right m-r-n-xs">
                                <div class="input-group">
                                    <div class="input-group-btn">
                                        <select id="searchlist" data-placeholder="${views.column['VPayAccount.accountName']}" class="btn-group chosen-select-no-single" tabindex="-1">
                                            <c:forEach items="${command.searchList()}" var="item" varStatus="status">
                                                <option value="${item.key}" ${status.index==0?'selected':''}>${item.value}</option>
                                                <c:if test="${status.index==0}">
                                                    <c:set value="${item.key}" var="firstSelectKey"/>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <input type="text" class="form-control list-search-input-text" id="searchtext" name="${firstSelectKey}">
                                    <span class="input-group-btn">
                                        <soul:button cssClass="btn btn-filter btn-query-css" precall="checksearch" tag="button" opType="function" text="${views.common['search']}" target="query">
                                            <i class="fa fa-search"></i><span class="hd">&nbsp;${views.common['search']}</span>
                                        </soul:button>
                                        <%--<button type="button" class="btn btn-filter"><i class="fa fa-search"></i><span class="hd">&nbsp;${views.column['search']}</span></button>--%>
                                    </span>
                                </div>
                            </div>
                            <div class="function-menu-show hide">
                                    <div class="btn-group" id="player_tag">
                                        <input type="hidden" value="true" id="hasLoadTag" >
                                        <button data-toggle="dropdown" type="button" id="player_tag_btn" data-has-load="true" class="btn btn-primary-hide dropdown-toggle player_tag_dropdown_btn">
                                            <i class="fa fa-tags"></i>
                                            <span class="hd">${views.content['domain.rankTitle']}</span>
                                            &nbsp;&nbsp;
                                            <span class="caret"></span>
                                        </button>

                                        <ul class="dropdown-menu dropdown-menu-stop">
                                            <div class="input-group label-search tag_stop_propagation">
                                                <input type="text" class="form-control tag_search_input" >
                                                <span class="input-group-addon cancel_search hide">×</span>
                                    <span class="input-group-addon go_search">
                                        <a href="javascript:void(0)">${views.common['search']}</a>
                                    </span>
                                            </div>
                                            <div class="label-menu-o tag_stop_propagation" id="player_tag_div">

                                            </div>
                                            <li class="divider m-t-none"></li>
                                            <li class="m-b-xs bt m-t-n-xs" id="player_tag_btn_li">
                                                <soul:button target="${root}/payAccount/saveRank.html" opType="ajax" precall="validateData"
                                                             post="rankTag.playerTagGetData" tag="button" cssClass="btn btn-filter btn-sm m-r-sm pay-rank-confirm-css" text="${views.common['confirm']}" callback="playerTagSaveCallBack"></soul:button>
                                                <%--<soul:button target="${root}/vPlayerRankStatistics/list.html" callback="playerTag.playerTagSaveCallBack" cssClass="fil" tag="a" opType="dialog" text="${views.content_auto['标签管理']}">${views.roleTag['page.playerTag.managerButtonTitle']}</soul:button>--%>
                                                <soul:button target="toRankList" text="${views.role['playerrank.manager']}" opType="function" cssClass="fil"/>
                                                <%--<a href="/vPlayerRankStatistics/list.html" nav-target="mainFrame" class="fil">${views.role['playerrank.manager']}</a>--%>
                                            </li>

                                        </ul>
                                    </div>
                                <div class="btn-group" style="padding-left: 10px">
                                    <soul:button tag="button" permission="content:companyaccount:delete" text="${views.common['delete']}" precall="confirmDel" target="${root}/payAccount/deleteAccount.html" post="getSelectIds" opType="ajax" cssClass="btn btn-danger-hide" callback="deleteCallbak"><i class="fa fa-trash-o"></i><span class="hd">${views.common['delete']}</span></soul:button>
                                </div>

                            </div>
                        </div>
                        <!--表格内容-->
                        <dl class="clearfix filter-conditions p-xxs p-b-xs m-b-none border-b-1 hide">
                            <dt>${views.common['filterCondition']}（<a href="javascript:void(0)">${views.common['clear']}</a>）</dt>
                        </dl>
                        <div id="editable_wrapper" class="dataTables_wrapper search-list-container" role="grid">
                            <%@ include file="IndexPartial.jsp" %>
                        </div>
                    </div>
                </div>
            <!--//endregion your codes 2-->
        </div>
</form:form>
<soul:import res="site/content/payaccount/PayAccount"/>
<!--//region your codes 3-->

<!--//endregion your codes 3-->