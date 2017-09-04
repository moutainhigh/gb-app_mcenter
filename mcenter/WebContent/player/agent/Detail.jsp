<%--
  Created by IntelliJ IDEA.
  User: cj
  Date: 15-9-7
  Time: 下午3:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form>
<div id="agentDetail" class="row">
<div class="position-wrap clearfix">
  <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
  <span>${views.sysResource['角色']}</span><span>/</span><span>${views.sysResource['代理管理']}</span>
  <soul:button target="goToLastPage" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
    <em class="fa fa-caret-left"></em>${views.common['return']}
  </soul:button>
  <%--<a href="role/role.html" class="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn"><em class="fa fa-caret-left"></em>${views.player_auto['返回']}</a>--%>
</div>
<div class="col-lg-12">
        <div class="wrapper white-bg clearfix shadow">
          <div class="sys_tab_wrap clearfix line-hi34 p-xs m-b-sm">
            <h3 class="pull-left">${views.role['Agent.detail.title']}</h3><!--qzx98749756467-->
            <div class="pull-right m-l">
              <a href="" id="tot" nav-target="mainFrame" style="display: none"></a>

              <a nav-target="mainFrame" style="display:none" id="reloadView" href="/userAgent/agent/detail.html?search.id=${command.result.id}"><span></span></a>
              <c:if test="${command.result.status eq '2'}">
                <c:set value="true" var="option_btn_disabled"></c:set>
              </c:if>
              <c:set var="accountfreeze" value="${now < command.result.freezeEndTime}"></c:set>
              <c:if test="${!command.result.builtIn}">
              <c:choose>
                <c:when test="${accountfreeze}">
                  <soul:button target="${root}/share/account/toCancelAccountFreeze.html?search.id=${command.result.id}&sign=agent"
                               text="${views.role['Agent.detail.cancelAccountFreeze']}" opType="dialog" callback="returnPage"
                               cssClass="btn btn-outline btn-filter btn-sm${option_btn_disabled ?' disabled':''}" >
                    ${views.role['Agent.detail.cancelAccountFreeze']}
                  </soul:button>
                </c:when>
                <c:otherwise>
                  <soul:button target="${root}/share/account/freezeAccount.html?result.id=${command.result.id}&type=agent"
                               text="${views.role['Agent.detail.freezeAccount']}"
                               opType="dialog" callback="returnPage"
                               cssClass="btn btn-outline btn-filter btn-sm${option_btn_disabled ?' disabled':''}" >
                    ${views.role['Agent.detail.freezeAccount']}
                  </soul:button>
                </c:otherwise>
              </c:choose>

              <c:choose>
                <c:when test="${command.result.status == '2'}">
                  <soul:button
                          target=""
                          cssClass="btn btn-outline btn-filter btn-sm${option_btn_disabled ?' disabled':''} "
                          text="${views.role['Agent.detail.accountDisabled']}"
                          name="accountDisabled"
                          opType=""
                          confirm="">
                    ${views.role['Agent.detail.accountDisabled']}
                  </soul:button>
                </c:when>
                <c:otherwise>
                  <soul:button permission="role:player_disabledaccount"
                          target="${root}/share/account/disabledAccount.html?result.id=${command.result.id}&type=agent"
                          callback="toTmpl"
                          text="${messages['playerTag']['accountDisabled']}"
                          opType="dialog"
                          cssClass="btn btn-outline btn-filter btn-sm${option_btn_disabled ?' disabled':''} ">
                    ${messages['playerTag']['accountDisabled']}
                  </soul:button>
                </c:otherwise>
              </c:choose>
              </c:if>
              <soul:button title="${views.role['Agent.detail.resetLoginPwd']}" target="${root}/player/resetPwd/goRestUserPwd.html?resetType=loginPwd&result.id=${command.result.id}" cssClass="${option_btn_disabled ?'disabled':''} btn btn-outline btn-filter btn-sm" text="" opType="dialog" tag="button">
                ${views.role['Agent.detail.resetLoginPwd']}
              </soul:button>

              <soul:button title="${views.role['Agent.detail.resetPermissionPwd']}" target="${root}/player/resetPwd/goRestUserPwd.html?resetType=permissionPwd&result.id=${command.result.id}" cssClass="${option_btn_disabled ?'disabled':''} ${accountfreeze?'disabled':''} btn btn-outline btn-filter btn-sm" text="" opType="dialog" tag="button">
                ${views.role['Agent.detail.resetPermissionPwd']}
              </soul:button>
              <a href="/report/vPlayerFundsRecord/fundsLog.html?search.userTypes=agentname&search.usernames=${command.result.username}&search.outer=-1" class="btn btn-outline btn-filter btn-sm" nav-target="mainFrame">${views.role['Agent.detail.fundsLog']}</a>
            </div>
          </div>
          <div class="panel blank-panel">
            <div class="">
              <div class="panel-options">
                <ul class="nav nav-tabs p-l-sm p-r-sm">
                  <li class="active">
                    <a data-toggle="tab" href="#detail${map.id}" aria-expanded="false" data-load="1">${views.role['Agent.detail.agentInfo']}</a>
                  </li>
                  <li class="">
                    <a data-toggle="tab" href="#funds${map.id}" aria-expanded="false" id="funds" data-href="${root}/userAgent/agent/funds.html?search.agentId=${map.id}" data-link="${extendedLinks}">${views.column['userAgent.funds']}</a>
                  </li>
                  <li>
                  <c:choose>
                    <c:when test="${bitcoin!=true}">
                      <a data-toggle="tab" href="#bankCard${map.id}" aria-expanded="false" data-href="${root}/userAgent/agent/bankCard.html?search.userId=${map.id}">${views.role['agent.detail.bankcard']}</a>
                    </c:when>
                    <c:otherwise>
                      <a data-toggle="tab" href="#bankCard${map.id}" aria-expanded="false" data-href="${root}/userAgent/agent/bankCard.html?search.userId=${map.id}">${views.player_auto['比特币']}</a>
                    </c:otherwise>
                  </c:choose>
                  </li>
                  <li>
                    <a data-toggle="tab" href="#remark${map.id}" aria-expanded="false" data-href="${root}/playerRemark/agentRemark.html?search.entityUserId=${map.id}&search.operatorId=${map.id}">${views.role['agent.detail.remark']}</a>
                  </li>
                  <li>
                    <a data-toggle="tab" href="#log${map.id}" aria-expanded="false" data-href="${root}/userAgent/agent/log.html?search.operatorId=${map.id}">${views.role['agent.detail.log']}</a>
                  </li>
                </ul>
              </div>
            </div>
            <div class="panel-body">
              <div class="tab-content">
                <div id="detail${map.id}" class="tab-pane active">
                  <%@include file="/player/agent/detail.include/AgentDetail.jsp" %>
                </div>
                <div id="funds${map.id}" class="tab-pane"></div>
                <div id="bankCard${map.id}" class="tab-pane"></div>
                <div id="remark${map.id}" class="tab-pane"></div>
                <div id="log${map.id}" class="tab-pane"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
</div></form>
<soul:import res="site/player/agent/Detail"/>