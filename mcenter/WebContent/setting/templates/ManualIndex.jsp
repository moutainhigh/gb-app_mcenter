<%-- @elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.NoticeTmplListVo" --%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form action="${root}/noticeTmpl/tmpIndex.html" method="post">
<div class="position-wrap clearfix">
    <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
    <span>${views.sysResource['系统设置']}</span><span>/</span><span>${views.sysResource['信息模板']}</span>
</div>
<div class="row">
  <div class="col-lg-12">
      <div class="wrapper white-bg shadow">
          <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
              <ul class="clearfix sys_tab_wrap">
                  <li class="active"><a href="/noticeTmpl/tmpIndex.html" nav-target="mainFrame">${views.setting['NoticeTmp.sys.artificalMsgTmp']}</a></li>
                  <li><a href="/noticeTmpl/tmpIndex.html?tmplType=auto" nav-target="mainFrame">${views.setting['NoticeTmp.sys.systemMsgTmp']}</a></li>
              </ul>
              <div class="clearfix filter-wraper border-b-1">
                  <div class="pull-left">
                      <input type="hidden" id="tmplType" value="${tmplType}">
                      <soul:button tag="a" cssClass="co-blue3 hide" title="${views.setting['NoticeTmp.manual.emailTmpAdd']}" target="${root}/noticeTmpl/editNoticeTmpl.html?publishMethod=email&groupCode={groupCode}&eventType={eventType}&builtIn=false" text="" opType="dialog" id="goToEmail" callback="query">${views.setting['NoticeTmp.manual.editTmp']}</soul:button>
                      <soul:button tag="button" cssClass="btn btn-info btn-addon" text="${views.setting['NoticeTmp.manual.addTmp']}" target="${root}/noticeTmpl/createNoticeTmpl.html"  opType="dialog" callback="callBackQuery">${views.setting['NoticeTmp.manual.addTmp']}</soul:button>
                      <soul:button target="resetActive" cssClass="btn btn-primary-hide" text="${views.setting['NoticeTmp.resetDefaultSetting']}" opType="function" confirm="${views.setting['NoticeTmp.confirmResetDefaultDocumet']}">${views.setting['NoticeTmp.resetDefaultSetting']}</soul:button>
                      <soul:button target="saveActive" cssClass="btn btn-blueshow" text="${views.setting['NoticeTmp.saveSetting']}" opType="function">${views.setting['NoticeTmp.saveSetting']}</soul:button>
                  </div>

                  <div class="pull-right" style="padding-top: 7px"><i class="fa fa-exclamation-circle"></i><span class="select-records">${views.setting['NoticeTmp.manual.clickToEdit']}</span></div>
              </div>

              <div class="table-responsive">
                  <table class="table table-striped table-hover dataTable" aria-describedby="editable_info">
                      <thead>
                      <tr class="bg-gray">
                          <th>${views.setting['NoticeTmp.manual.type']}</th>
                          <th>${views.setting['NoticeTmp.sys.siteMsg']}</th>
                          <th>${views.setting['NoticeTmp.sys.email']}</th>
                          <th>${views.setting['NoticeTmp.sys.phoneMsg']}</th>
                          <th>${views.setting['NoticeTmp.manual.subProject']}</th>
                      </tr>
                      </thead>
                          <c:forEach var="map" items="${command}" varStatus="status">
                              <c:set var="noticeType" value="${map.key}"></c:set>
                              <c:set var="childList" value="${map.value}"/>
                                  <c:forEach items="${childList}" var="infos" varStatus="listStatus">
                                      <c:if test="${listStatus.index==0}">
                                          <c:set var="sysSiteMsgActiveNum" value="${infos.sysSiteMsgActiveNum}"></c:set>
                                          <c:set var="sysEmailActiveNum" value="${infos.sysEmailActiveNum}"/>
                                          <c:set var="sysSmsActiveNum" value="${infos.sysSmsActiveNum}"/>
                                          <c:set var="sysSiteMsgContentNum" value="${infos.sysSiteMsgContentNum}"/>
                                          <c:set var="sysEmailContentNum" value="${infos.sysEmailContentNum}"/>
                                          <c:set var="sysSmsContentNum" value="${infos.sysSmsContentNum}"/>
                                          <tbody class="sysAuto ${status.index % 2 == 0 ? 'even':'odd'}">
                                          <tr>
                                              <input type="hidden" value="${infos.groupCode}" name="groupCode">
                                              <td>
                                                  <c:forEach items="${reasonType}" var="item">
                                                      <c:if test="${item.key eq infos.eventType}">
                                                          <%--<c:set var="object" value="${dicts[item.value.module][item.value.dictType][item.value.dictCode]}"/>--%>
                                                          ${dicts[item.value.module][item.value.dictType][item.value.dictCode]}
                                                      </c:if>
                                                  </c:forEach>
                                              </td>
                                              <td>
                                                  <input type="checkbox" class="i-checks" noticeType="${noticeType}" cktype="parent" name="siteMsg" ${sysSiteMsgActiveNum>0?'checked':''} ${sysSiteMsgContentNum>0?'':'disabled'}>
                                                  <soul:button tag="a" cssClass="co-blue3" callback="callBackQuery" target="${root}/noticeTmpl/editNoticeTmpl.html?active=${infos.active}&publishMethod=siteMsg&groupCode=${infos.groupCode}&eventType=${infos.eventType}&builtIn=${infos.builtIn}" text="${views.setting['NoticeTmp.manual.siteMsgTmpEdit']}-${dicts.notice.manual_event_type[infos.eventType]}" opType="dialog">${views.setting['NoticeTmp.manual.default']}</soul:button>
                                                  <c:if test="${sysSiteMsgContentNum==0}">
                                                      <span class="m-l-xs co-grayc2">(${views.setting['NoticeTmp.manual.noContent']})</span>
                                                  </c:if>
                                              </td>
                                              <td>
                                                  <input type="checkbox" class="i-checks" name="email" ${sysEmailActiveNum>0?'checked':''} ${sysEmailContentNum>0?'':'disabled'}>
                                                  <soul:button tag="a" cssClass="co-blue3" callback="callBackQuery" target="${root}/noticeTmpl/editNoticeTmpl.html?active=${infos.active}&publishMethod=email&groupCode=${infos.groupCode}&eventType=${infos.eventType}&builtIn=${infos.builtIn}" text="${views.setting['NoticeTmp.manual.emailTmpEdit']}-${dicts.notice.manual_event_type[infos.eventType]}" opType="dialog">${views.setting['NoticeTmp.manual.default']}</soul:button>
                                                  <c:if test="${sysEmailContentNum==0}">
                                                      <span class="m-l-xs co-grayc2">(${views.setting['NoticeTmp.manual.noContent']})</span>
                                                  </c:if>
                                              </td>
                                              <td>
                                                  <input type="checkbox" class="i-checks" name="sms" ${sysSmsActiveNum>0?'checked':''} ${sysSmsContentNum>0?'':'disabled'}>
                                                  <soul:button tag="a" cssClass="co-blue3" callback="callBackQuery" target="${root}/noticeTmpl/editNoticeTmpl.html?active=${infos.active}&publishMethod=sms&groupCode=${infos.groupCode}&eventType=${infos.eventType}&builtIn=${infos.builtIn}" text="${views.setting['NoticeTmp.manual.phoneMsgTmpEdit']}-${dicts.notice.manual_event_type[infos.eventType]}" opType="dialog">${views.setting['NoticeTmp.manual.default']}</soul:button>
                                                  <c:if test="${sysSmsContentNum==0}">
                                                      <span class="m-l-xs co-grayc2">(${views.setting['NoticeTmp.manual.noContent']})</span>
                                                  </c:if>
                                              </td>
                                              <td>
                                                  <a href="javascript:void(0)" class="over">${fn:length(childList)-1}(${views.setting['NoticeTmp.manual.item']})
                                                      <c:if test="${fn:length(childList)-1>0}">
                                                          <i></i>
                                                      </c:if>
                                                  </a>
                                              </td>
                                          </tr>
                                          </tbody>
                                      </c:if>
                                  </c:forEach>

                                  <c:if test="${fn:length(childList)>1}">
                                      <tbody class="ng-hide" style="display:none">
                                          <c:forEach items="${childList}" var="infos" varStatus="listStatus">
                                              <c:if test="${listStatus.index>0}">
                                                  <c:set var="siteMsgActiveNum" value="${infos.siteMsgActiveNum}"></c:set>
                                                  <c:set var="emailActiveNum" value="${infos.emailActiveNum}"/>
                                                  <c:set var="smsActiveNum" value="${infos.smsActiveNum}"/>
                                                  <c:set var="siteMsgContentNum" value="${infos.siteMsgContentNum}"/>
                                                  <c:set var="emailContentNum" value="${infos.emailContentNum}"/>
                                                  <c:set var="smsContentNum" value="${infos.smsContentNum}"/>
                                                  <tr>
                                                      <input type="hidden" value="${infos.groupCode}" name="groupCode">
                                                      <td></td>
                                                      <td>
                                                          <input type="checkbox" class="i-checks" parentCode="${noticeType}" cktype="child" name="siteMsg" ${siteMsgActiveNum>0?'checked':''}>
                                                          <soul:button tag="a" cssClass="co-blue3" callback="callBackQuery" target="${root}/noticeTmpl/editNoticeTmpl.html?active=${infos.active}&publishMethod=siteMsg&groupCode=${infos.groupCode}&eventType=${infos.eventType}&builtIn=${infos.builtIn}" text="${views.setting['NoticeTmp.manual.siteMsgTmpEdit']}-${dicts.notice.manual_event_type[infos.eventType]}" opType="dialog">
                                                              <c:choose>
                                                                  <c:when test="${empty infos.siteMsg.title}">
                                                                      ${views.setting['NoticeTmp.manual.editTmp']}
                                                                  </c:when>
                                                                  <c:when test="${fn:length(infos.siteMsg.title)>30}">
                                                                      ${fn:substring(infos.siteMsg.title, 0, 30)}...
                                                                  </c:when>
                                                                  <c:otherwise>
                                                                      ${infos.siteMsg.title}
                                                                  </c:otherwise>
                                                              </c:choose>
                                                          </soul:button>
                                                          <c:if test="${siteMsgContentNum==0}">
                                                              <span class="m-l-xs co-grayc2">(${views.setting['NoticeTmp.manual.noContent']})</span>
                                                          </c:if>
                                                      </td>
                                                      <td>
                                                          <input type="checkbox" class="i-checks" name="email" ${emailActiveNum>0?'checked':''} ${emailContentNum>0?'':'disabled'}>
                                                          <soul:button tag="a" cssClass="co-blue3" callback="callBackQuery" target="${root}/noticeTmpl/editNoticeTmpl.html?active=${infos.active}&publishMethod=email&groupCode=${infos.groupCode}&eventType=${infos.eventType}&builtIn=${infos.builtIn}" text="${views.setting['NoticeTmp.manual.emailTmpEdit']}-${dicts.notice.manual_event_type[infos.eventType]}" opType="dialog">
                                                              <c:choose>
                                                                  <c:when test="${empty infos.email.title}">
                                                                      ${views.setting['NoticeTmp.manual.editTmp']}
                                                                  </c:when>
                                                                  <c:when test="${fn:length(infos.email.title)>30}">
                                                                      ${fn:substring(infos.email.title, 0, 30)}...
                                                                  </c:when>
                                                                  <c:otherwise>
                                                                      ${infos.email.title}
                                                                  </c:otherwise>
                                                              </c:choose>
                                                          </soul:button>
                                                          <c:if test="${emailContentNum==0}">
                                                              <span class="m-l-xs co-grayc2">(${views.setting['NoticeTmp.manual.noContent']})</span>
                                                          </c:if>
                                                      </td>
                                                      <td>
                                                          <input type="checkbox" class="i-checks" name="sms" ${smsActiveNum>0?'checked':''} ${smsContentNum>0?'':'disabled'}>
                                                          <soul:button tag="a" cssClass="co-blue3" callback="callBackQuery" target="${root}/noticeTmpl/editNoticeTmpl.html?active=${infos.active}&publishMethod=sms&groupCode=${infos.groupCode}&eventType=${infos.eventType}&builtIn=${infos.builtIn}" text="${views.setting['NoticeTmp.manual.phoneMsgTmpEdit']}-${dicts.notice.manual_event_type[infos.eventType]}" opType="dialog">
                                                              <c:choose>
                                                                  <c:when test="${empty infos.sms.title}">
                                                                      ${views.setting['NoticeTmp.manual.editTmp']}
                                                                  </c:when>
                                                                  <c:when test="${fn:length(infos.sms.title)>30}">
                                                                      ${fn:substring(infos.sms.title, 0, 30)}...
                                                                  </c:when>
                                                                  <c:otherwise>
                                                                      ${infos.sms.title}
                                                                  </c:otherwise>
                                                              </c:choose>
                                                          </soul:button>
                                                          <c:if test="${smsContentNum==0}">
                                                              <span class="m-l-xs co-grayc2">(${views.setting['NoticeTmp.manual.noContent']})</span>
                                                          </c:if>
                                                      </td>
                                                      <td>
                                                          <soul:button target="${root}/noticeTmpl/deleteAllNotDefault.html?code=${infos.groupCode}" text="${views.common['delete']}" opType="ajax" dataType="json" confirm="${views.setting['NoticeTmp.manual.confirmDelTmpOnTheReason']}" callback="callDelQuery" />
                                                      </td>
                                                  </tr>
                                              </c:if>
                                          </c:forEach>
                                      </tbody>
                                  </c:if>
                          </c:forEach>
                  </table>
              </div>
          </div>
      </div>
  </div>
</div>
</form:form>

<soul:import res="site/setting/noticetmpl/NoticeTmplIndex"/>

