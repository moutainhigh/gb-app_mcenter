<%-- @elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.NoticeTmplListVo" --%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form action="${root}/noticeTmpl/tmpIndex.html" method="post">
<div class="position-wrap clearfix">
    <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
    <span>${views.sysResource['系统设置']}</span><span>/</span><span>${views.sysResource['信息模板']}</span>
</div>
<div class="panel panel-default">
    <div class="panel-body">
      <div class="row">
          <div class="col-lg-12">
              <div class="wrapper white-bg shadow">
                  <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
                      <ul class="clearfix sys_tab_wrap">
                          <li class="active"><a href="/noticeTmpl/tmpIndex.html" nav-target="mainFrame">${views.setting['NoticeTmp.sys.artificalMsgTmp']}</a></li>
                          <li><a href="/noticeTmpl/tmpIndex.html?tmplType=auto" nav-target="mainFrame">${views.setting['NoticeTmp.sys.systemMsgTmp']}</a></li>
                      </ul>
                      <div class="clearfix filter-wraper border-b-1">
                          <input type="hidden" id="tmplType" value="${tmplType}">
                          <soul:button tag="a" cssClass="co-blue3 hide" title="${views.setting['NoticeTmp.manual.emailTmpAdd']}" target="${root}/noticeTmpl/editNoticeTmpl.html?publishMethod=email&groupCode={groupCode}&eventType={eventType}&builtIn=false" text="" opType="dialog" id="goToEmail" callback="query">${views.setting['NoticeTmp.manual.editTmp']}</soul:button>
                          <soul:button tag="button" cssClass="btn btn-info btn-addon" text="${views.setting['NoticeTmp.manual.addTmp']}" target="${root}/noticeTmpl/createNoticeTmpl.html"  opType="dialog" callback="callBackQuery">${views.setting['NoticeTmp.manual.addTmp']}</soul:button>
                          <soul:button target="resetActive" cssClass="btn btn-primary-hide" text="${views.setting['NoticeTmp.resetDefaultSetting']}" opType="function" confirm="${views.setting['NoticeTmp.confirmResetDefaultDocumet']}">${views.setting['NoticeTmp.resetDefaultSetting']}</soul:button>
                          <soul:button target="saveActive" cssClass="btn btn-blueshow" text="${views.setting['NoticeTmp.saveSetting']}" opType="function">${views.setting['NoticeTmp.saveSetting']}</soul:button>
                      </div>
                      <div class="table-responsive">
                          <table class="table table-striped table-hover" aria-describedby="editable_info">
                              <thead>
                              <tr class="bg-gray">
                                  <th>${views.setting['NoticeTmp.manual.type']}</th>
                                  <th>${views.setting['NoticeTmp.sys.siteMsg']}</th>
                                  <th>${views.setting['NoticeTmp.sys.email']}</th>
                                  <th>${views.setting['NoticeTmp.sys.phoneMsg']}</th>
                                  <th>${views.setting['NoticeTmp.manual.subProject']}</th>
                              </tr>
                              </thead>
                              <tr class="bd-none">
                                  <th colspan="10"><div class="select-records"><i class="fa fa-exclamation-circle"></i>${views.setting['NoticeTmp.manual.clickToEdit']}</div></th>
                              </tr>

                                  <c:forEach var="noticeTmplSo" items="${command.noticeTmplSoList}" varStatus="status">
                                      <c:set var="sysEmailActiveNum" value="${noticeTmplSo.sysEmailActiveNum}"/>
                                      <c:set var="sysSmsActiveNum" value="${noticeTmplSo.sysSmsActiveNum}"/>
                                      <c:set var="sysSiteMsgContentNum" value="${noticeTmplSo.sysSiteMsgContentNum}"/>
                                      <c:set var="sysEmailContentNum" value="${noticeTmplSo.sysEmailContentNum}"/>
                                      <c:set var="sysSmsContentNum" value="${noticeTmplSo.sysSmsContentNum}"/>
                                      <tbody class="sysAuto">
                                          <tr>
                                              <input type="hidden" value="${noticeTmplSo.groupCode}" name="groupCode">
                                              <input type="hidden" value="${noticeTmplSo.eventType}" name="eventType">
                                              <th>
                                                  <c:forEach items="${reasonType}" var="item">
                                                      <c:if test="${item.key eq noticeTmplSo.eventType}">
                                                          ${dicts[item.value.module][item.value.dictType][item.value.dictCode]}
                                                      </c:if>
                                                  </c:forEach>
                                              </th>
                                              <td>
                                                  <input type="checkbox" class="i-checks" name="siteMsg" disabled checked>
                                                  <soul:button tag="a" cssClass="co-blue3" callback="callBackQuery" target="${root}/noticeTmpl/editNoticeTmpl.html?active=${infos.active}&publishMethod=siteMsg&groupCode=${noticeTmplSo.groupCode}&eventType=${noticeTmplSo.eventType}&builtIn=${noticeTmplSo.builtIn}" text="${views.setting['NoticeTmp.manual.siteMsgTmpEdit']}-${dicts.notice.manual_event_type[noticeTmplSo.eventType]}" opType="dialog">${views.setting['NoticeTmp.manual.default']}</soul:button>
                                                  <c:if test="${sysSiteMsgContentNum==0}">
                                                      <span class="m-l-xs co-grayc2">(${views.setting['NoticeTmp.manual.noContent']})</span>
                                                  </c:if>
                                              </td>
                                              <td>
                                                  <input type="checkbox" class="i-checks" name="email" ${sysEmailActiveNum>0?'checked':''} ${sysEmailContentNum>0?'':'disabled'}>
                                                  <soul:button tag="a" cssClass="co-blue3" callback="callBackQuery" target="${root}/noticeTmpl/editNoticeTmpl.html?active=${infos.active}&publishMethod=email&groupCode=${noticeTmplSo.groupCode}&eventType=${noticeTmplSo.eventType}&builtIn=${noticeTmplSo.builtIn}" text="${views.setting['NoticeTmp.manual.emailTmpEdit']}-${dicts.notice.manual_event_type[noticeTmplSo.eventType]}" opType="dialog">${views.setting['NoticeTmp.manual.default']}</soul:button>
                                                  <c:if test="${sysEmailContentNum==0}">
                                                      <span class="m-l-xs co-grayc2">(${views.setting['NoticeTmp.manual.noContent']})</span>
                                                  </c:if>
                                              </td>
                                              <td>
                                                  <input type="checkbox" class="i-checks" name="sms" ${sysSmsActiveNum>0?'checked':''} ${sysSmsContentNum>0?'':'disabled'}>
                                                  <soul:button tag="a" cssClass="co-blue3" callback="callBackQuery" target="${root}/noticeTmpl/editNoticeTmpl.html?active=${infos.active}&publishMethod=sms&groupCode=${noticeTmplSo.groupCode}&eventType=${noticeTmplSo.eventType}&builtIn=${noticeTmplSo.builtIn}" text="${views.setting['NoticeTmp.manual.phoneMsgTmpEdit']}-${dicts.notice.manual_event_type[noticeTmplSo.eventType]}" opType="dialog">${views.setting['NoticeTmp.manual.default']}</soul:button>
                                                  <c:if test="${sysSmsContentNum==0}">
                                                      <span class="m-l-xs co-grayc2">(${views.setting['NoticeTmp.manual.noContent']})</span>
                                                  </c:if>
                                              </td>
                                              <td>
                                                  <a href="javascript:void(0)" class="over">${noticeTmplSo.noBuiltInNum}(${views.setting['NoticeTmp.manual.item']})
                                                      <c:if test="${noticeTmplSo.noBuiltInNum>0}">
                                                          <i></i>
                                                      </c:if>
                                                  </a>
                                              </td>
                                          </tr>
                                      </tbody>
                                      <c:if test="${noticeTmplSo.noBuiltInNum>0}">
                                          <tbody class="ng-hide" style="display:none">
                                          </tbody>
                                      </c:if>
                                  </c:forEach>
                          </table>
                      </div>
                  </div>
              </div>
          </div>
      </div>
    </div>
</div>
</form:form>

<table id="template" style="display:none" >
    <tr>
        <input type="hidden" value="" name="groupCode">
        <td></td>
        <td>
            <input type="checkbox" class="i-checks" name="siteMsg" disabled checked>
            <soul:button tag="a" cssClass="co-blue3" callback="callBackQuery" target="${root}/noticeTmpl/editNoticeTmpl.html?publishMethod=siteMsg&groupCode={groupCode}&eventType={eventType}&builtIn=false" text="${views.setting['NoticeTmp.manual.siteMsgTmpEdit']}-{eventType}" opType="dialog">
            </soul:button>
            <span class="m-l-xs co-grayc2" style="display: none;">(${views.setting['NoticeTmp.manual.noContent']})</span>
        </td>
        <td>
            <input type="checkbox" class="i-checks" name="email">
            <soul:button tag="a" cssClass="co-blue3" callback="callBackQuery" target="${root}/noticeTmpl/editNoticeTmpl.html?publishMethod=email&groupCode={groupCode}&eventType={eventType}&builtIn=false" text="${views.setting['NoticeTmp.manual.emailTmpEdit']}-{eventType}" opType="dialog">
            </soul:button>
            <span class="m-l-xs co-grayc2" style="display: none;">(${views.setting['NoticeTmp.manual.noContent']})</span>
        </td>
        <td>
            <input type="checkbox" class="i-checks" name="sms">
            <soul:button tag="a" cssClass="co-blue3" callback="callBackQuery" target="${root}/noticeTmpl/editNoticeTmpl.html?publishMethod=sms&groupCode={groupCode}&eventType={eventType}&builtIn=false" text="${views.setting['NoticeTmp.manual.phoneMsgTmpEdit']}-{eventType}" opType="dialog">
            </soul:button>
            <span class="m-l-xs co-grayc2" style="display: none;">(${views.setting['NoticeTmp.manual.noContent']})</span>
        </td>
        <td>
            <soul:button target="${root}/noticeTmpl/deleteAllNotDefault.html?code={groupCode}" text="${views.common['delete']}" opType="ajax" dataType="json" confirm="${views.setting['NoticeTmp.manual.confirmDelTmpOnTheReason']}" callback="callDelQuery" />
        </td>
    </tr>
</table>
<soul:import res="site/setting/noticetmpl/NoticeTmplIndex_yh"/>

