<%--@elvariable id="ranks" type="java.util.List<so.wwb.gamebox.model.master.player.po.PlayerRank>"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form name="companySortForm">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['运营']}</span><span>/</span>
            <span>${views.sysResource['公司入款账户']}</span>
            <soul:button target="goToLastPage" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <%@ include file="/include/include.inc.jsp" %>
            <div class="wrapper white-bg shadow clearfix">
                <div class="present_wrap"><b>${views.content['payAccount.cash.order']}</b></div>
                <div class="line-hi34 col-sm-12 bg-gray m-b">
                    <input type="checkbox" name="openMoreAccount" data-size="mini" ${openAccounts?'checked':''} value="true"/>是否开启多个账号
                    <span tabindex="0" class="m-l m-r help-popover" role="button" data-container="body" data-toggle="popover"  data-trigger="focus" data-placement="right" data-content="如果开启将在前台展示全部已使用账户">
                        <i class="fa fa-question-circle"></i>
                    </span>
                </div>
                <div class="select-level clearfix">
                    <c:forEach items="${ranks}" var="i" varStatus="status">
                        <soul:button text="${i.rankName}" opType="function" url="${root}/vPayAccount/companyAccountByRank.html?rankId=${i.id}" target="rankAccount" cssClass="${i.payAccountNum>0?'':'disabled'} ${rankId eq i.id?'current':''}"/>
                    </c:forEach>
                </div>
                <div class="line-hi34 col-sm-12 bg-gray m-b">
                    <span class="co-yellow m-r-sm"><i class="fa fa-exclamation-circle"></i></span>
                    ${views.content['payAccount.drag.tip']}
                </div>
                <div id="companySort">
                    <%@include file="SortPartial.jsp"%>
                </div>
            </div>
        </div>
    </div>
</form>
<soul:import res="site/content/payaccount/company/Sort"/>