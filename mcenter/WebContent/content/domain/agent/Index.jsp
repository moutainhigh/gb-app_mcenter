<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-8-13
  Time: 下午8:04
--%>
<%--@elvariable id="command" type="so.wwb.gamebox.model.company.sys.vo.UserExtendListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form action="${root}/content/sysDomain/agentDomainList.html">
    <div class="row">
        <div class="position-wrap clearfix">
            <div id="validateRule" style="display: none">${command.validateRule}</div>
            <h2>
                <a class="navbar-minimalize" href="javascript:void(0)">
                    <i class="fa fa-bars"></i>
                </a>
            </h2>
            <span>${views.sysResource['系统设置']}</span><span>/</span><span>${views.sysResource['域名管理']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <ul class="clearfix sys_tab_wrap">
                    <li id="li_top_1"><a href="/content/sysDomain/list.html?random=${random}" nav-target="mainFrame">${views.content['domain.site']}</a></li>
                    <li id="li_top_2" class="active"><a href="/content/sysDomain/agentDomainList.html?random=${random}" nav-target="mainFrame">${views.content['domain.agent']}</a></li>
                </ul>
                <div class="clearfix filter-wraper border-b-1">

                    <soul:button permission="content:domain:agentadd" target="${root}/content/sysDomain/agentCreate.html" title="${views.content['sysDoamin.createTitle']}" callback="query" cssClass="btn btn-info btn-addon" tag="button" text="${views.common['create']}" opType="dialog">
                        <i class="fa fa-plus"></i><span class="hd">${views.common['create']}</span>
                    </soul:button>
                    <div class="function-menu-show hide">

                    </div>

                    <div class="search-wrapper btn-group pull-right m-r-n-xs">
                        <div class="input-group">
                                <%--<input type="text" name="search.domain" value="${command.search.domain}" class="form-control">--%>
                            <div class="input-group-btn">
                                <select name="searchType" id="searchType" style="display: none;" class="bg-gray bdn input-group-addon chosen-select-no-single valid" aria-invalid="false">
                                    <option value="search.agentUserName">${views.content['domain.agent.account']}</option>
                                    <option value="search.domain">${views.column['CttDomain.domainLinkAddress']}</option>
                                </select>
                            </div>
                            <input class="form-control" id="searchInput" type="text" name="search.agentUserName">
                            <span class="input-group-btn">
                                <soul:button cssClass="btn btn-filter _enter_submit" tag="button" target="query" text="${views.common['search']}" opType="function">
                                    <i class="fa fa-search"></i>
                                    <span class="hd">&nbsp;${views.common['search']}</span>
                                </soul:button>
                            </span>
                        </div>
                    </div>

                </div>
                <div class="line-hi34 col-sm-12 bg-gray  border-b-1">
                    <span class="co-yellow"><i class="fa fa-exclamation-circle"></i></span>
                        ${views.content['通过绑定域名注册的玩家，将归属于该代理。']}
                </div>
                <!--表格内容-->
                <div id="editable_wrapper" class="dataTables_wrapper search-list-container" role="grid">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
            </div>
        </div>
    </div>
</form:form>
<soul:import res="site/content/domain/agent/Index"/>