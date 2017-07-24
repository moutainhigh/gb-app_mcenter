<%@ page import="java.util.Date" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VUserTopAgentManageListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>

<div class="row">
    <form:form action="${root}/vUserTopAgentManage/list.html" method="post">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['角色']}</span><span>/</span><span>${views.sysResource['总代管理']}</span>
            <c:if test="${command.search.hasReturn=='true'}">
                <soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                    <em class="fa fa-caret-left"></em>${views.common['return']}
                </soul:button>
            </c:if>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <div class="clearfix filter-wraper border-b-1">
                    <shiro:hasPermission name="role:topagent_add">
                        <a href="/userAgent/editTopAgent.html" nav-target="mainFrame" class="btn btn-info btn-addon">
                            <i class="fa fa-plus"></i><span class="hd">${views.role['topAgent.edit.createAgent']}</span>
                        </a>
                    </shiro:hasPermission>
                    <a nav-target="mainFrame" href="/vUserTopAgentManage/list.html" class="btn btn-primary-hide" ><i class="fa fa-refresh"></i><span class="hd">${views.common['refresh']}</span></a>
                    <soul:button tag="button" cssClass="btn btn-warning-hide" text="${views.common['filter']}" target="${root}/vUserTopAgentManage/filters.html" opType="dialog" callback="showFiltersCallBack">
                        <i class="fa fa-filter"></i>
                        <span class="hd">${views.common['filter']}</span>
                    </soul:button>
                    <div class="search-wrapper btn-group pull-right">
                        <div class="input-group">
                            <div class="input-group-btn">
                                <select tabindex="-1" class="btn-group chosen-select-no-single" id="searchlist" data-placeholder="${views.common['pleaseSelect']}" style="display: none;">
                                    <option value="">${views.common['pleaseSelect']}</option>
                                    <c:forEach items="${command.searchList()}" var="item">
                                        <option value="${item.key}" ${item.key=='search.username'?'selected':''}>${item.value}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <input type="text" class="form-control list-search-input-text" id="searchtext" name="search.username">
                            <span class="input-group-btn">
                                <soul:button cssClass="btn btn-filter" precall="checksearch" tag="button" opType="function" text="${views.common['search']}" target="query">
                                    <i class="fa fa-search"></i><span class="hd">&nbsp;${views.common['search']}</span>
                                </soul:button>
                            </span>
                        </div>
                    </div>
                </div>
                <!--表格内容-->
                <dl class="clearfix filter-conditions p-xxs p-b-xs m-b-none border-b-1 hide">
                    <dt>${views.common['filterCondition']}（<a href="javascript:void(0)">${views.common['clear']}</a>）</dt>
                </dl>
                <div class="row p-l-sm p-r-sm m-t-xs">
                    <div class="col-6 form-inline pull-left m-b-xs m-l-sm">
                        <div>
                            <gb:select callback="query" cssStyle="float:left" name="selectFields" list="${list}" listValue="description" listKey="id" value="${command.selectFields}" notUseDefaultPrompt="${list.size()==0?'false':'true'}" ></gb:select>
                        </div>
                    </div>
                    <div class="col-6 more-wrapper m-b-none clearfix pull-right">
                        <a class="pull-right more-data" href="javascript:void(0)" data-href="${root}/vUserTopAgentManage/columns.html?t=${random}" slide="0"><img src="${resComRoot}/images/icon_data.gif">&nbsp;&nbsp;${views.common['moreData']}</a>
                        <div class="col-sm-12 more-data-wrapper">
                        </div>
                    </div>
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
<soul:import res="site/player/agent/UserAgentList"/>
