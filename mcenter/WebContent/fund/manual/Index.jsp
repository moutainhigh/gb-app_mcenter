<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<link href="${resComRoot}/themes/${curTheme}/chosen/chosen.css" rel="stylesheet">
<div class="row" name="manual">
    <div class="position-wrap clearfix">
        <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont"></i> </a></h2>
        <span>${views.fund['资金管理']}</span>
        <span>/</span><span>${views.fund['人工存取']}</span>
        <c:if test="${! empty hasReturn}">
            <c:if test="${fromPlayerDetail=='playerList'}">
                <a href="/player/list.html" nav-target="mainFrame" class="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn">
                    <em class="fa fa-caret-left"></em>${views.common['return']}
                </a>
            </c:if>
            <c:if test="${fromPlayerDetail!='playerList'}">
                <soul:button target="goToLastPage" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                    <em class="fa fa-caret-left"></em>${views.common['return']}
                </soul:button>
            </c:if>
        </c:if>
    </div>
    <input type="hidden" name="hasRetrun" value="${hasReturn}">
    <input type="hidden" name="fromPlayerDetail" value="${fromPlayerDetail}">
    <input type="hidden" name="playerId" value="${playerId}">

    <div class="col-lg-12">
        <div class="white-bg shadow">
            <ul class="clearfix sys_tab_wrap">
                <li class="${empty type?'active':''}">
                    <soul:button target="manualDeposit" text="${views.fund_auto['人工存入']}" opType="function"/>
                </li>
                <li class="${empty type?'':'active'}">
                    <soul:button target="manualWithdraw" text="${views.fund_auto['人工取出']}" opType="function"/>
                </li>
            </ul>
            <div id="manual">
                <!--人工存入-->
                <c:if test="${empty type}">
                    <%@include file="Deposit.jsp" %>
                </c:if>
                <!--人工取出-->
                <c:if test="${!empty type}">
                    <%@include file="Withdraw.jsp" %>
                </c:if>
            </div>
        </div>
    </div>
</div>
<soul:import res="site/fund/manual/Index"/>