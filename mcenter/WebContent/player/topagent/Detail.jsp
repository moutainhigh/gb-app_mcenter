<%--
  Created by IntelliJ IDEA.
  User: cj
  Date: 15-9-7
  Time: 下午3:21
  To change this template use File | Settings | File Templates.
--%>
<%--@elvariable id="command" type="org.soul.model.security.privilege.vo.SysUserVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form id="agentDetail">
  <div class="row">
    <div id="mainFrame">
      <div class="position-wrap clearfix">
        <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
        <span>${views.sysResource['角色']}</span><span>/</span><span>${views.sysResource['总代管理']}</span>
        <soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
          <em class="fa fa-caret-left"></em>${views.common['return']}
        </soul:button>
      </div>
      <div class="col-lg-12">
        <div class="wrapper white-bg clearfix shadow">
          <div class="sys_tab_wrap clearfix line-hi34 p-xs m-b-sm">
            <h3 class="pull-left">${views.role['agent.top.agentData']}</h3><!--qzx98749756467-->
            <div class="pull-right m-l">
              <a href="" id="tot" nav-target="mainFrame" style="display: none"></a>

              <a nav-target="mainFrame" style="display:none" id="reloadView" href="/userAgent/topagent/detail.html?search.id=${command.result.id}"><span></span></a>
              <a nav-target="mainFrame" style="display:none" name="editTmpl" href="/noticeTmpl/tmpIndex.html?lastPage=t"><span></span></a>
                <%--账户停用--%>
              <c:if test="${command.result.status eq '2'}">
                <c:set value="true" var="option_btn_disabled"></c:set>
              </c:if>
              <c:set var="accountfreeze" value="${now < command.result.freezeEndTime}"></c:set>
              <c:if test="${!command.result.builtIn}">
              <c:choose>
                <c:when test="${accountfreeze}">
                  <soul:button target="${root}/share/account/toCancelAccountFreeze.html?search.id=${command.result.id}&sign=topAgent"
                               text="${views.role['TopAgent.detail.cancelAccountFreeze']}"
                               opType="dialog" callback="returnPage"
                               cssClass="btn btn-outline btn-filter btn-sm${option_btn_disabled ?' disabled':''}" >
                    ${views.role['TopAgent.detail.cancelAccountFreeze']}
                  </soul:button>
                </c:when>
                <c:otherwise>
                  <soul:button target="${root}/share/account/freezeAccount.html?result.id=${command.result.id}&type=topagent"
                               text="${views.role['TopAgent.detail.freezeAccount']}"
                               opType="dialog" callback="returnPage"
                               cssClass="btn btn-outline btn-filter btn-sm${option_btn_disabled ?' disabled':''}" >
                    ${views.role['TopAgent.detail.freezeAccount']}
                  </soul:button>
                </c:otherwise>
              </c:choose>

              <c:choose>
                <c:when test="${command.result.status == '2'}">
                  <soul:button
                          target=""
                          cssClass="btn btn-outline btn-filter btn-sm${option_btn_disabled ?' disabled':''} "
                          text="${views.role['TopAgent.detail.accountDisabled']}"
                          name="accountDisabled"
                          opType=""
                          confirm="">
                    ${views.role['TopAgent.detail.accountDisabled']}
                  </soul:button>
                </c:when>
                <c:otherwise>
                  <soul:button
                          target="${root}/share/account/disabledAccount.html?result.id=${command.result.id}&type=topagent"
                          callback="toTmpl"
                          text="${messages['playerTag']['accountDisabled']}"
                          opType="dialog"
                          cssClass="btn btn-outline btn-filter btn-sm${option_btn_disabled ?' disabled':''} ">
                    ${messages['playerTag']['accountDisabled']}
                  </soul:button>
                </c:otherwise>
              </c:choose>
              </c:if>
              <soul:button title="${views.role['TopAgent.detail.resetLoginPwd']}" target="${root}/player/resetPwd/goRestUserPwd.html?resetType=loginPwd&result.id=${command.result.id}" cssClass="${option_btn_disabled ?'disabled':''} btn btn-outline btn-filter btn-sm" text="" opType="dialog" tag="button">
                ${views.role['TopAgent.detail.resetLoginPwd']}
              </soul:button>

              <soul:button title="${views.role['TopAgent.detail.resetPermissionPwd']}" target="${root}/player/resetPwd/goRestUserPwd.html?resetType=permissionPwd&result.id=${command.result.id}" cssClass="${option_btn_disabled ?'disabled':''} ${accountfreeze?'disabled':''} btn btn-outline btn-filter btn-sm" text="" opType="dialog" tag="button">
                ${views.role['TopAgent.detail.resetPermissionPwd']}
              </soul:button>
              <a href="/report/vPlayerFundsRecord/fundsLog.html?search.userTypes=topagentname&search.usernames=${command.result.username}&search.outer=-1" class="btn btn-outline btn-filter btn-sm" nav-target="mainFrame">${views.role['TopAgent.detail.fundsLog']}</a>
              <%----%>
            </div>
          </div>
            <div class="panel blank-panel">
              <div class="">
                <div class="panel-options">
                  <ul class="nav nav-tabs p-l-sm p-r-sm">
                    <li class="active">
                      <a data-toggle="tab" href="#detail${map.id}" aria-expanded="false" data-load="1">${views.role['agent.top.agentMessage']}</a>
                    </li>
                    <li class="">
                      <a data-toggle="tab" href="#ratio${map.id}" aria-expanded="false" data-href="${root}/userAgent/topagent/ratio.html?search.userId=${map.id}">${views.role['TopAgent.detail.ratio']}</a>
                    </li>
                    <%--<li>--%>
                      <%--<a data-toggle="tab" href="#bankCard${map.id}" aria-expanded="false" data-href="${root}/userAgent/topagent/bankCard.html?search.userId=${map.id}">${views.player_auto['银行卡']}</a>--%>
                    <%--</li>--%>
                    <li>
                      <a data-toggle="tab" href="#remark${map.id}" aria-expanded="false" data-href="${root}/playerRemark/topagentRemark.html?search.entityUserId=${map.id}&search.operatorId=${map.id}">${views.role['TopAgent.detail.remark']}</a>
                    </li>
                    <li>
                      <a data-toggle="tab" href="#log${map.id}" aria-expanded="false" data-href="${root}/userAgent/agent/log.html?&roleType=top_agent&search.operatorId=${map.id}">${views.role['TopAgent.detail.log']}</a>
                    </li>
                  </ul>
                </div>
              </div>
              <div class="panel-body">
                <div class="tab-content">
                  <div id="detail${map.id}" class="tab-pane active">
                    <%@include file="/player/topagent/detail.include/AgentDetail.jsp" %>
                  </div>
                  <div id="ratio${map.id}" class="tab-pane"></div>
                  <%--<div id="bankCard${map.id}" class="tab-pane"></div>--%>
                  <div id="remark${map.id}" class="tab-pane"></div>
                  <div id="log${map.id}" class="tab-pane"></div>
                </div>
              </div>
            </div>
        </div>
      </div>
    </div>
  </div>
</form:form>
<soul:import res="site/player/agent/Detail"/>