<%--
  Created by IntelliJ IDEA.
  User: snekey
  Date: 15-9-7
  Time: 上午11:57
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<form id="step1Form">
<div id="step1">

  <div id="validateRule" style="display: none">${validateRule}</div>
  <input type="hidden" name="sendType" value="${massInformationVo.sendType}">
  <input type="hidden" name="pushMode" value="${massInformationVo.pushMode}">
  <input type="hidden" name="targetUser" value="${massInformationVo.targetUser}">
  <input type="hidden" name="group" value="${massInformationVo.group}">
  <input type="hidden" name="appointPlayer" value="${massInformationVo.appointPlayer}">
  <input type="hidden" name="rank" value="${massInformationVo.joinRank}">
  <input type="hidden" name="tags" value="${massInformationVo.joinTags}">
  <input type="hidden" name="master" value="${massInformationVo.joinMaster}">
  <input type="hidden" name="agent" value="${massInformationVo.joinAgent}">
  <input type="hidden" name="masterAndAgent" value="${massInformationVo.joinMasterAndAgent}">
  <input type="hidden" name="timingFlag" value="${massInformationVo.timingFlag}">
  <input type="hidden" name="timing" value="${soulFn:formatDateTz(massInformationVo.timing, DateFormat.DAY_SECOND,timeZone)}">
  <div class="row">
    <div class="position-wrap clearfix">
      <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
      <span>${views.sysResource['内容']}</span>
      <span>/</span><span>${views.sysResource['信息群发']}</span>
      <c:if test="${hasReturn}">
        <soul:button target="goToLastPage" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
          <em class="fa fa-caret-left"></em>${views.common['return']}
        </soul:button>
      </c:if>
    </div>
    <div class="col-lg-12 sectionData">
      <div class="wrapper white-bg shadow">
        <ul class="artificial-tab clearfix">
          <li class="col-sm-2 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">1</span><span
                  class="con">${views.operation['MassInformation.sendMethod']}</span></a></li>
          <li class="col-sm-2 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">2</span><span
                  class="con">${views.operation['MassInformation.chooseUser']}</span></a></li>
          <li class="col-sm-2 col-xs-12 p-x"><a class="current" href="javascript:void(0)"><span class="no">3</span><span
                  class="con">${views.operation['MassInformation.sendContent']}</span></a></li>
          <li class="col-sm-2 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">4</span><span
                  class="con">${views.operation['MassInformation.preview']}</span></a></li>
          <li class="col-sm-2 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">5</span><span
                  class="con">${views.operation['MassInformation.finish']}</span></a></li>
        </ul>
        <ul class="artificial-tab clearfix bg-gray _language">
          <li class="col-sm-3"></li>
          <c:forEach var="siteLang" items="${languageList}" varStatus="index">
            <li class="tab_edit_status">
              <a data-toggle="tab" id="a_${index.index}" href="#tab${index.index}" data-index="${index.index}" data-lang="${fn:substringBefore(dicts.common.language[siteLang.language], '#')}" aria-expanded="${index.index==0?'true':'false'}" class="${index.index==0?'current':''} _editLanguage" language="${siteLang.language}" >
                  ${fn:substringBefore(dicts.common.language[siteLang.language], '#')}
                <span id="span_${index.index}" class="con">${views.common['unedited']}</span>
              </a>
            </li>
            <input type="hidden" name="language[${index.index}]" value="${siteLang.language}">
          </c:forEach>
          <li class="pull-right m-t-md">
            <div class="btn-group">
              <button class="btn btn-link dropdown-toggle fzyx" data-toggle="dropdown">${views.setting['serviceTrems.copy']}&nbsp;&nbsp;<span class="caret"></span></button>
              <ul class="dropdown-menu pull-right">
                <c:forEach items="${languageList}" var="p" varStatus="status">
                  <li hidden  id="fzyx_${status.index}" class="temp"><a class="co-gray copy" href="javascript:void(0)" index="${status.index}">${dicts.common.local[p.language]}</a></li>
                </c:forEach>
              </ul>
            </div>
          </li>
        </ul>
        <div class="panel-body">
          <div class="tab-content">
            <c:forEach begin="0" end="${fn:length(languageList)}" var="siteLang" items="${languageList}" varStatus="index">
              <div id="tab${index.index}" class="tab-pane ${index.index==0?'active':''}">
                <div class="clearfix m-l-lg m-t-md">
                  <label class="ft-bold col-sm-3 al-right">${views.operation['MassInformation.step3.title']}：</label>
                  <div class="col-sm-5">
                    <input placeholder="${views.operation['MassInformation.step3.enterTitle']}" language="${siteLang.language}" type="text" placeholder="" id="title${index.index}" index="${index.index}" class="form-control m-b _title" name="title[${index.index}]" value="${massInformationVo.title[index.index]}">
                  </div>
                </div>
                <div class="clearfix m-l-lg m-t-md">
                  <label class="ft-bold col-sm-3 al-right">${views.operation['MassInformation.step3.content']}：</label>
                  <div class="col-sm-5">
                    <c:choose>
                      <c:when test="${massInformationVo.sendType eq 'email'}">
                        <textarea id="editContent${index.index}"  class="_editContent${index.index} _editContent"  value="${massInformationVo.contentUnEscape[index.index]}"  index="${index.index}" name="content[${index.index}]">${massInformationVo.content[index.index]}</textarea>
                      </c:when>
                      <c:otherwise>
                        <%--id="editContent${siteLang.language}" 用于复制语系识别值 需要换成另外一个标识--%>
                        <textarea placeholder="${views.operation['MassInformation.step3.enterContent']}" id="editContent${index.index}" class="form-control m-b  _editContent" index="${index.index}" value="${massInformationVo.content[index.index]}"  name="content[${index.index}]">${massInformationVo.content[index.index]}</textarea>
                      </c:otherwise>
                    </c:choose>

                  </div>
                </div>
                <div class="clearfix m-l-lg m-t-md">
                  <label class="ft-bold col-sm-3 al-right line-hi34">${views.operation['MassInformation.step3.variable']}：</label>
                  <div class="col-sm-9 variable_wrap bdn _editTags" id="content[${index.index}]" data-ue-key="editContent${index.index}">
                    <a href="javascript:void(0)" class="variable">${views.operation['MassInformation.step3.userName']} &lt;<span>{user}</span>&gt;</a>
                    <a href="javascript:void(0)" class="variable">${views.operation['MassInformation.step3.sitename']} &lt;<span>{sitename}</span>&gt;</a>
                    <a href="javascript:void(0)" class="variable">${views.operation['MassInformation.step3.customer']} &lt;<span>{customer}</span>&gt;</a>
                    <a href="javascript:void(0)" class="variable">${views.operation['MassInformation.step3.website']} &lt;<span>{website}</span>&gt;</a>
                    <a href="javascript:void(0)" class="variable">${views.operation['MassInformation.step3.year']} &lt;<span>{year}</span>&gt;</a>
                    <a href="javascript:void(0)" class="variable">${views.operation['MassInformation.step3.month']} &lt;<span>{month}</span>&gt;</a>
                    <a href="javascript:void(0)" class="variable">${views.operation['MassInformation.step3.day']} &lt;<span>{day}</span>&gt;</a>
                  </div>
                </div>
              </div>
            </c:forEach>
          </div>
        </div>


        <div class="operate-btn">
          <soul:button target="chooseUser" text="${views.common['previous']}" opType="function" cssClass="btn btn-filter btn-lg" confirm="${messages.common['confirm.leave']}?"></soul:button>
          <soul:button target="sendPreview" precall="validateForm" text="${views.common['previewAndSend']}" opType="function" cssClass="btn btn-filter btn-lg"></soul:button>
        </div>
      </div>
    </div>
  </div>
</div>
</form>
    <%@include file="sendPreview.jsp"%>
    <%@include file="finish.jsp"%>




<script>
  var languageCounts = ${fn:length(languageList)};
</script>
<soul:import res="site/operation/mass.information/editContent"/>
