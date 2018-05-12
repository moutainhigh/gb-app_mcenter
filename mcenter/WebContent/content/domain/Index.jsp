<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-8-13
  Time: 下午8:04
--%>
<%--@elvariable id="command" type="so.wwb.gamebox.model.company.sys.vo.UserExtendListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form action="${root}/content/sysDomain/list.html">
    <style>
        .table th, .table td {
            text-align: center;
        }
    </style>
    <div class="row">
        <div id="validateRule" style="display: none">${command.validateRule}</div>
        <div class="position-wrap clearfix">
            <h2>
                <a class="navbar-minimalize" href="javascript:void(0)">
                    <i class="fa fa-bars"></i>
                </a>
            </h2>
            <span>${views.sysResource['系统设置']}</span><span>/</span><span>${views.sysResource['域名管理']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <a href="/vPlayerRankStatistics/list.html" id="rankList" nav-target="mainFrame" class="fil" hidden/>
            <div class="wrapper white-bg shadow">
                <ul class="clearfix sys_tab_wrap">
                    <li id="li_top_1" class="active"><a href="/content/sysDomain/list.html?random=${random}" nav-target="mainFrame">${views.content['domain.site']}</a></li>
                    <li id="li_top_2"><a href="/content/sysDomain/agentDomainList.html?random=${random}" nav-target="mainFrame">${views.content['domain.agent']}</a></li>
                    <a class="fs13 pull-right" data-toggle="modal" data-target="#sus33a">${views.content['查看总代中心登录地址获取办法']}</a>
                </ul>
                <div class="clearfix filter-wraper border-b-1">

                    <soul:button permission="content:domain:add" target="${root}/content/sysDomain/create.html" title="${views.content['sysDoamin.createTitle']}" callback="query" cssClass="btn btn-info btn-addon" tag="button" text="${views.common['create']}" size="open-dialog-900-jp" opType="dialog">
                        <i class="fa fa-plus"></i><span class="hd">${views.common['create']}</span>
                    </soul:button>


                    <%--<soul:button target="${root}/content/sysDomain/setting.html" callback="query" title="${views.content['sysDomain.setting.title']}" tag="button" cssClass="btn btn-primary-hide" text="${views.content['domain.setting']}" opType="dialog">--%>
                        <%--<i class="fa fa-gear"></i><span class="hd">${views.content['domain.setting']}</span>--%>
                    <%--</soul:button>--%>
                    <%--<div class="function-menu-show hide">--%>
                        <%--<div class="btn-group" id="player_tag">--%>
                            <%--<input type="hidden" value="true" id="hasLoadTag" >--%>
                            <%--<button data-toggle="dropdown" type="button" id="player_tag_btn" data-has-load="true" class="btn btn-primary-hide dropdown-toggle player_tag_dropdown_btn">--%>
                                <%--<i class="fa fa-tags"></i>--%>
                                <%--<span class="hd">${views.content['domain.rankTitle']}</span>--%>
                                <%--&nbsp;&nbsp;--%>
                                <%--<span class="caret"></span>--%>
                            <%--</button>--%>

                            <%--<ul class="dropdown-menu dropdown-menu-stop">--%>
                                <%--<div class="input-group label-search tag_stop_propagation">--%>
                                    <%--<input type="text" class="form-control tag_search_input" >--%>
                                    <%--<span class="input-group-addon cancel_search hide">×</span>--%>
                                    <%--<span class="input-group-addon go_search">--%>
                                        <%--<a href="javascript:void(0)">${views.common['search']}</a>--%>
                                    <%--</span>--%>
                                <%--</div>--%>
                                <%--<div class="label-menu-o tag_stop_propagation" id="player_tag_div">--%>

                                <%--</div>--%>
                                <%--<li class="divider m-t-none"></li>--%>
                                <%--<li class="m-b-xs bt m-t-n-xs" id="player_tag_btn_li">--%>
                                    <%--<soul:button target="${root}/content/cttDomainRank/saveRank.html" opType="ajax" post="rankTag.playerTagGetData" tag="button" cssClass="btn btn-filter btn-sm m-r-sm" text="${views.common['confirm']}" callback="playerTagSaveCallBack"></soul:button>--%>
                                    <%--<soul:button target="toRankList" text="${views.role['playerrank.manager']}" opType="function" cssClass="fil"/>--%>
                                <%--</li>--%>

                            <%--</ul>--%>
                        <%--</div>--%>
                        <%--&lt;%&ndash;<soul:button target="${root}/content/sysDomain/deleteDomain.html?ids={ids}"  cssClass="btn btn-primary-hide" precall="deleteDomain" tag="button" text="${views.common['delete']}" callback="query" opType="ajax">&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<i class="fa fa-trash-o"></i>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<span class="hd">${views.common['delete']}</span>&ndash;%&gt;--%>
                        <%--&lt;%&ndash;</soul:button>&ndash;%&gt;--%>
                    <%--</div>--%>

                    <div class="search-wrapper btn-group pull-right m-r-n-xs">
                        <div class="input-group">
                             <span class="input-group-addon">
                               ${views.column['VCttDomain.domainLinkAddress']}
                             </span>
                                <input type="text" name="search.domain" value="${command.search.domain}" class="form-control">
                            <span class="input-group-btn">
                                <soul:button cssClass="btn btn-filter _enter_submit" tag="button" target="query" text="${views.common['search']}" opType="function">
                                    <i class="fa fa-search"></i>
                                    <span class="hd">&nbsp;${views.common['search']}</span>
                                </soul:button>
                            </span>
                        </div>
                    </div>

                </div>
                <!--表格内容-->
                <div id="editable_wrapper" class="dataTables_wrapper search-list-container" role="grid">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
            </div>
        </div>
    </div>
    <!--提示提示-->
    <div class="modal inmodal" id="sus33a" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content animated bounceInRight unstyled family">
                <div class="modal-header">
                    <span class="filter">${views.content['消息']}</span>
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">${views.content['关闭']}</span> </button>
                </div>
                <div class="modal-body" style="padding: 20px 50px;">
                    <h3 class=" co-blue">${views.content['您体系下的总代']}</h3>
                        <div class="line-hi25">${views.content['在您添加的任意指向域名为']}</div>
                        <div class="line-hi25">${views.content['如']}：${domain}/tcenter</div>
                </div>
                <div class="modal-footer">

                </div>
            </div>
        </div>
    </div>
</form:form>
<soul:import res="site/content/domain/Index"/>