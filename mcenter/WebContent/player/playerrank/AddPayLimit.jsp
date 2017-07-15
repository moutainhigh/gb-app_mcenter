<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.PlayerRankVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form method="post">
<div id="wrapper">
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['角色']}</span><span>/</span>
            <span>${views.sysResource['层级设置']}</span>
            <soul:button target="goToLastPage" refresh="true"
                         cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text=""
                         opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <ul class="artificial-tab clearfix">
                    <li><a class="current" href="javascript:void(0)"><span class="no">1</span><span
                            class="con">${views.role['PlayerRank.common.addAccount']}</span></a></li>
                    <li><a href="javascript:void(0)" tt="payLimit"><span class="no">2</span><span
                            class="con">${views.role['PlayerRank.common.settings']}</span></a></li>
                    <input type="hidden" id="rankId" value="${rankId}">
                </ul>
                <div class="rechargeCon">

                    <c:forEach items="${list}" var="p" varStatus="status">
                    <c:choose>
                        <c:when test="${empty list[status.index-1].type}">
                            <div class="clearfix m-b-xs limit_title_wrap">
                                <h3 class="limit_title cur">
                                    <c:choose>
                                        <c:when test="${p.type=='1' && p.accountType=='1'}">
                                            ${views.role['company_bank']}
                                        </c:when>
                                        <c:when test="${p.type=='1' && p.accountType=='2'}">
                                            ${views.role['company_third']}
                                        </c:when>
                                        <c:otherwise>
                                            ${views.role['online_payment']}
                                        </c:otherwise>
                                    </c:choose>
                                </h3>
                                <!--                        <a class="co-blue m-l">+添加更多账号</a>-->
                            </div>
                            <dl class="list clearfix">
                                <dt>
                                    <span class="${p.accountType=='1'?'pay-bank ':'pay-third '} ${banks[p.bankCode].bankName}"></span>
                                    <%--<img src="${resComRoot}/${banks[p.bankCode].bankIcon}"/>--%>
                                <div>${dicts.common.bankname[p.bankCode]}</div>
                                </dt>
                                <dd class="col-xs-10">
                        </c:when>
                        <c:when test="${list[status.index-1].type!=null && list[status.index-1].type!=p.type}">
                                </dd>
                            </dl>
                            <div class="clearfix m-b-xs limit_title_wrap">
                                <h3 class="limit_title cur">
                                    <c:choose>
                                        <c:when test="${p.type=='1' && p.accountType=='1'}">
                                            ${views.role['company_bank']}
                                        </c:when>
                                        <c:when test="${p.type=='1' && p.accountType=='2'}">
                                            ${views.role['company_third']}
                                        </c:when>
                                        <c:otherwise>
                                            ${views.role['online_payment']}
                                        </c:otherwise>
                                    </c:choose>
                                </h3>
                            </div>
                            <dl class="list clearfix">
                                <dt>
                                    <%--<img src="${resComRoot}/${banks[p.bankCode].bankIcon}"/>--%>
                                        <span class="${p.accountType=='1'?'pay-bank ':'pay-third '} ${banks[p.bankCode].bankName}"></span>
                                <div>${dicts.common.bankname[p.bankCode]}</div>
                                </dt>
                                <dd class="col-xs-10">
                        </c:when>
                        <c:when test="${list[status.index-1].type!=null && list[status.index-1].type==p.type && list[status.index-1].accountType!=p.accountType}">
                                    </dd>
                                </dl>
                            <div class="clearfix m-b-xs limit_title_wrap">
                                <h3 class="limit_title cur">
                                    <c:choose>
                                        <c:when test="${p.type=='1' && p.accountType=='1'}">
                                            ${views.role['company_bank']}
                                        </c:when>
                                        <c:when test="${p.type=='1' && p.accountType=='2'}">
                                            ${views.role['company_third']}
                                        </c:when>
                                        <c:otherwise>
                                            ${views.role['online_payment']}
                                        </c:otherwise>
                                    </c:choose>
                                </h3>
                            </div>
                            <dl class="list clearfix">
                                <dt>
                                    <%--<img src="${resComRoot}/${banks[p.bankCode].bankIcon}"/>--%>
                                        <span class="${p.accountType=='1'?'pay-bank ':'pay-third '} ${banks[p.bankCode].bankName}"></span>
                                <div>${dicts.common.bankname[p.bankCode]}</div>
                                </dt>
                                <dd class="col-xs-10">
                        </c:when>
                        <c:when test="${list[status.index-1].bankCode!=null && list[status.index-1].bankCode!=p.bankCode}">
                                </dd>
                            </dl>
                            <hr class="m-t-sm m-b-sm dashed">
                            <dl class="list clearfix">
                                <dt>
                                    <%--<img src="${resComRoot}/${banks[p.bankCode].bankIcon}"/>--%>
                                        <span class="${p.accountType=='1'?'pay-bank ':'pay-third '} ${banks[p.bankCode].bankName}"></span>
                                <div>${dicts.common.bankname[p.bankCode]}</div>
                                </dt>
                                <dd class="col-xs-10">
                        </c:when>
                    </c:choose>
                            <div class="clearfix">
                                <div class="wh-110"><label><input type="checkbox" name="accountId"
                                                                  value="${p.payAccountId}" class="i-checks"
                                                                  checked="checked"></label><b
                                        class="m-l-xs co-yellow">${p.payName}</b></div>
                                <div class="wh-110 al-center"><span class="m-l-md co-gray9">${p.account}</span></div>
                                <div class="wh-100"><span class="m-l-md co-gray9 fs12">${views.role['disableAmount']}：<span
                                        class="co-black fs13">${p.disableAmount}${views.common['yuan']}</span></span></div>
                                <c:if test="${'1'==p.status}">
                                    <span class="m-l-lg">${views.role['normal']}</span>
                                </c:if>
                                <c:if test="${'2'==p.status}">
                                    <span class="co-gray m-l-lg">${views.role['stop']}</span>
                                </c:if>
                                <c:if test="${'4'==p.status}">
                                    <span class="co-red m-l-lg">${views.role['frozen']}</span>
                                </c:if>
                            </div>
                    </c:forEach>
                        </dd>
                    </dl>
                    <hr class="m-t-sm m-b-sm dashed">
                    <div class="clearfix m-b-xs">
                        <a href="javascript:void(0)" class="co-blue m-l payLimit" tt="addMoreAccount">+${views.role['PlayerRank.common.addAccount']}</a>
                    </div>
                    <hr class="m-t-sm m-b-sm">
                    <div style="text-align: right;padding-right: 20px">
                        <button class="btn btn-outline btn-filter btn-lg payLimit" tt="payLimit">${views.role['PlayerRank.common.next']}</button>
                        <a href="" id="tot" nav-target="mainFrame" style="display: none">${views.role['PlayerRank.common.settings']}</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
    </form:form>
<soul:import res="site/player/playerrank/AddPayLimit"/>
<!--//region your codes 4-->
<!--//endregion your codes 4-->