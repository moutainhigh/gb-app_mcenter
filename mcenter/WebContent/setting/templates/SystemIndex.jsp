<%-- @elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.NoticeTmplListVo" --%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="position-wrap clearfix">
    <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
    <span>${views.sysResource['系统设置']}</span><span>/</span><span>${views.sysResource['信息模板']}</span>
    <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
</div>
<form:form action="${root}/noticeTmpl/tmpIndex.html?tmplType=auto" method="post">
      <div class="row">
          <div class="col-lg-12">
              <div class="wrapper white-bg shadow">
                  <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
                      <ul class="clearfix sys_tab_wrap">
                          <li><a href="/noticeTmpl/tmpIndex.html" nav-target="mainFrame">${views.setting['NoticeTmp.sys.artificalMsgTmp']}</a></li>
                          <li class="active"><a href="/noticeTmpl/tmpIndex.html?tmplType=auto" nav-target="mainFrame">${views.setting['NoticeTmp.sys.systemMsgTmp']}</a></li>
                      </ul>
                      <div class="clearfix filter-wraper border-b-1">
                          <div class="pull-left">
                              <input type="hidden" id="tmplType" value="${tmplType}">
                              <soul:button target="resetActive" cssClass="btn btn-primary-hide" text="${views.setting['NoticeTmp.resetDefaultSetting']}" opType="function" confirm="${views.setting['NoticeTmp.confirmSystemResetDefaultDocumet']}">${views.setting['NoticeTmp.resetDefaultSetting']}</soul:button>
                              <soul:button target="saveActive" cssClass="btn btn-blueshow" text="${views.setting['NoticeTmp.saveSetting']}" opType="function">${views.setting['NoticeTmp.saveSetting']}</soul:button>
                          </div>
                          <div class="pull-right" style="padding-top: 7px"><i class="fa fa-exclamation-circle"></i><span class="select-records">${views.setting['NoticeTmp.sys.selectNoticeWay']}</span></div>
                      </div>
                      <div class="table-responsive">
                          <table class="table table-striped table-hover dataTable m-b-sm" aria-describedby="editable_info">
                              <thead>
                                  <tr class="bg-gray">
                                      <th>${views.setting['NoticeTmp.sys.sendTarget']}</th>
                                      <th>${views.setting['NoticeTmp.sys.siteMsg']}</th>
                                      <th>${views.setting['NoticeTmp.sys.email']}</th>
                                      <th>${views.setting['NoticeTmp.sys.phoneMsg']}</th>
                                  </tr>
                              </thead>
                              <tbody>
                                  <c:forEach var="map" items="${command}" varStatus="status">
                                      <c:set var="list" value="${map.value}"/>
                                      <c:forEach items="${list}" var="infos" varStatus="listStatus">
                                          <%--BALANCE_AUTO_FREEZON ／RESET_PERMISSION_PWD_SUCCESS ／RESET_LOGIN_PASSWORD_SUCCESS为固定文案，不做展现，保留模板--%>
                                          <c:if test="${listStatus.index==0 && empty infos.isDisplay}">
                                              <tr>
                                                  <input type="hidden" value="${infos.groupCode}" name="groupCode">
                                                  <td>
                                                      <c:forEach items="${reasonType}" var="item">
                                                          <c:if test="${item.key eq infos.eventType}">
                                                              ${dicts[item.value.module][item.value.dictType][item.value.dictCode]}
                                                          </c:if>
                                                      </c:forEach>
                                                  </td>
                                                  <td>
                                                      <input type="checkbox" class="i-checks" name="siteMsg" ${infos.sysSiteMsgActiveNum>0?'checked':''} ${infos.sysSiteMsgContentNum>0?'':'disabled'}>
                                                      <soul:button tag="a" cssClass="co-blue3" callback="callBackQuery"
                                                                   target="${root}/noticeTmpl/editNoticeTmpl.html?active=${infos.active}&tmplType=auto&publishMethod=siteMsg&groupCode=${infos.groupCode}&eventType=${infos.eventType}&builtIn=${infos.builtIn}"
                                                                   text="${views.setting['NoticeTmp.manual.siteMsgTmpEdit']}-${dicts.notice.auto_event_type[infos.eventType]}"
                                                                   opType="dialog">${views.setting['NoticeTmp.sys.notice']}
                                                      </soul:button>
                                                  </td>
                                                  <td>
                                                      <input type="checkbox" class="i-checks" name="email" ${infos.sysEmailActiveNum>0?'checked':''} ${infos.sysEmailContentNum>0?'':'disabled'}>
                                                      <soul:button tag="a" cssClass="co-blue3" callback="callBackQuery"
                                                                   target="${root}/noticeTmpl/editNoticeTmpl.html?active=${infos.active}&tmplType=auto&publishMethod=email&groupCode=${infos.groupCode}&eventType=${infos.eventType}&builtIn=${infos.builtIn}"
                                                                   text="${views.setting['NoticeTmp.manual.emailTmpEdit']}-${dicts.notice.auto_event_type[infos.eventType]}"
                                                                   opType="dialog">${views.setting['NoticeTmp.sys.notice']}
                                                      </soul:button>
                                                  </td>
                                                  <td>
                                                      <input type="checkbox" class="i-checks" name="sms" ${infos.sysSmsActiveNum>0?'checked':''} ${infos.sysSmsContentNum>0?'':'disabled'}>
                                                      <soul:button tag="a" cssClass="co-blue3" callback="callBackQuery"
                                                                   target="${root}/noticeTmpl/editNoticeTmpl.html?active=${infos.active}&tmplType=auto&publishMethod=sms&groupCode=${infos.groupCode}&eventType=${infos.eventType}&builtIn=${infos.builtIn}"
                                                                   text="${views.setting['NoticeTmp.manual.phoneMsgTmpEdit']}-${dicts.notice.auto_event_type[infos.eventType]}"
                                                                   opType="dialog">${views.setting['NoticeTmp.sys.notice']}
                                                      </soul:button>
                                                  </td>
                                              </tr>
                                          </c:if>
                                      </c:forEach>
                                  </c:forEach>
                              </tbody>
                          </table>
                      </div>
                  </div>
              </div>
          </div>
      </div>
</form:form>
<soul:import res="site/setting/noticetmpl/NoticeTmplIndex"/>

