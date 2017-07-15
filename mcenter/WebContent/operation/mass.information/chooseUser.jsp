<%--
  Created by IntelliJ IDEA.
  User: snekey
  Date: 15-9-7
  Time: 上午11:12
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form>
  <%--玩家部分--%>

  <div id="validateRule" style="display: none">${validateRule}</div>
  <input type="hidden" name="sendType" value="${massInformationVo.sendType}">
  <div class="row">
    <div class="position-wrap clearfix">
      <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
      <span>${views.sysResource['内容']}</span>
      <span>/</span><span>${views.sysResource['信息群发']}</span>
      <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
    </div>
    <div class="col-lg-12">
      <div class="wrapper white-bg shadow">
        <ul class="artificial-tab clearfix">
          <li class="col-sm-2 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">1</span><span class="con">${views.operation['MassInformation.sendMethod']}</span></a></li>
          <li class="col-sm-2 col-xs-12 p-x"><a class="current" href="javascript:void(0)"><span class="no">2</span><span class="con">${views.operation['MassInformation.chooseUser']}</span></a></li>
          <li class="col-sm-2 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">3</span><span class="con">${views.operation['MassInformation.sendContent']}</span></a></li>
          <li class="col-sm-2 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">4</span><span class="con">${views.operation['MassInformation.preview']}</span></a></li>
          <li class="col-sm-2 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">5</span><span class="con">${views.operation['MassInformation.finish']}</span></a></li>
        </ul>
        <div class="clearfix m-l-lg line-hi34">
          <label class="ft-bold col-sm-3 al-right">${views.operation['MassInformation.sendMethod']}：</label>
          <div class="col-sm-5">${dicts.notice.publish_method[massInformationVo.sendType]}</div>
        </div>
        <div class="clearfix m-l-lg line-hi34">
          <label class="ft-bold col-sm-3 al-right">${views.operation['MassInformation.step4.sendToUser']}：</label>
          <div class="col-sm-5">
              <%--代理商和玩家单选框--%>
            <label><input id="playerTag" type="radio" name="targetUser" class="i-checks" <c:if test="${massInformationVo.targetUser=='player'}">checked</c:if> value="player">${views.operation['MassInformation.step4.player']}</label>
            <label><input id="agentTag" type="radio" name="targetUser" class="i-checks" <c:if test="${massInformationVo.targetUser=='agent'}">checked</c:if> value="agent">${views.operation['MassInformation.step4.agents']}</label>
              <%--玩家下拉框和提示语--%>
            <div id="playerSelect" class=" <c:if test="${massInformationVo.targetUser!='player'}">hide</c:if>">
            <span>
              <select name="group" id="choosePlayer" <c:if test="${massInformationVo.targetUser!='player'}">disabled</c:if>>
                <option value="allPlayer" <c:if test="${massInformationVo.group=='allPlayer'}">selected</c:if>>${views.operation['MassInformation.step2.globalPlayers']}</option>
                <option value="appoint" <c:if test="${massInformationVo.group=='appoint'}">selected</c:if>>${views.operation['MassInformation.step2.designatedPlayer']}</option>
                <option value="condition" <c:if test="${massInformationVo.group=='condition'}">selected</c:if>>${views.operation['MassInformation.step2.choicePlayers']}</option>
              </select>
            </span>
              <span class="co-grayc2 m-l-sm _playerTips">${views.operation['MassInformation.step2.message1']}${dicts.notice.publish_method[massInformationVo.sendType]}</span>
              <span class="co-yellow _rank <c:if test="${massInformationVo.group!='condition'}">hide</c:if>">0${views.operation['MassInformation.step2.hierarchy']}</span>
              <span class="co-yellow _tags <c:if test="${massInformationVo.group!='condition'}">hide</c:if>">0${views.operation['MassInformation.step2.labels']}</span>
                <%--指定玩家页面--%>
              <div id="appoint" class="<c:if test="${massInformationVo.group!='appoint'}">hide</c:if>" >
                <input type="hidden" name="effectPlayer" id="effectPlayer">
                <textarea name="appointPlayer" id="appointPlayer" class="form-control m-b resize-vertical">${massInformationVo.appointPlayer}</textarea>
                <div class="_appointTip hide">
                  <span class="co-yellow"></span>
                  <soul:button target="clearInvalidPlayer" text="${views.common['clean']}" opType="function"></soul:button>
                </div>
              </div>
            </div>

              <%--代理下拉框和提示语--%>
            <div id="agentSelect" class="<c:if test="${massInformationVo.targetUser!='agent'}">hide</c:if>">
            <span>
              <select name="group" id="chooseAgent" <c:if test="${massInformationVo.targetUser!='agent'}">disabled</c:if>>
                <option value="all" <c:if test="${massInformationVo.group=='all'}">selected</c:if> >${views.operation['MassInformation.step2.globalAgents']}</option>
                <option value="appointAgent" <c:if test="${massInformationVo.group=='appointAgent'}">selected</c:if> >${views.operation['MassInformation.step2.designatedAgents']}</option>
                <option value="master"<c:if test="${massInformationVo.group=='master'}">selected</c:if> >${views.operation['MassInformation.step2.topAgentsAndagents']}</option>
              </select>
            </span>
              <span class="co-grayc2 m-l-sm _agentTips">${views.operation['MassInformation.step2.message2']}${dicts.notice.publish_method[massInformationVo.sendType]}</span>
              <span class="co-yellow _master_count <c:if test="${massInformationVo.group!='appointAgent'}">hide</c:if>"></span>&nbsp;&nbsp;
            <span class="co-yellow _agent_count <c:if test="${massInformationVo.group!='appointAgent'}">hide</c:if>"></span
                    ><span class="co-yellow all_count <c:if test="${massInformationVo.group!='master'}">hide</c:if>"></span>
            </div>
          </div>
        </div>
        <div id="player">
            <%--条件玩家页面--%>
          <div id="condition" class="clearfix m-t-sm line-hi34 bg-gray level <c:if test="${massInformationVo.group!='condition'}">hide</c:if>">
            <input id="rank" type="hidden" name="rank" value="${massInformationVo.joinRank}">
            <input id="tags" type="hidden" name="tags" value="${massInformationVo.joinTags}">
            <input id="_selected" type="hidden" name="selected" value="">
            <label class="ft-bold col-sm-3 al-right"></label>
            <div class="col-sm-5 m-l-md">
                <%--层级部分--%>
              <b class="fs16 m-r-lg">${views.operation['MassInformation.step2.chooseLevel']}</b><span class="co-grayc2">${views.operation['MassInformation.step2.message3']}</span>
              <hr class="m-t-xxs m-b-sm">
              <ul class="li-rank clearfix m-b-sm options-list">
                <c:forEach var="i" items="${rankList}">
                  <c:set var="showRankId" value="${','}${i.id}${','}"></c:set>
                  <li class="_rk <c:if test="${fn:contains(massInformationVo.joinRank,showRankId)}">current</c:if>" value="${i.id}">${i.rankName}</li>
                </c:forEach>
              </ul>
                <%--标签部分--%>
              <b class="fs16 m-r-lg">${views.operation['MassInformation.step2.chooseTab']}</b><span class="co-grayc2">${views.operation['MassInformation.step2.message4']}</span>
              <hr class="m-t-xxs m-b-sm">
              <ul class="li-tag clearfix m-b-sm options-list">
                <c:forEach var="i" items="${vPlayerTags}">
                  <c:set var="showId" value="${','}${i.id}${','}"></c:set>
                  <li class="_tg <c:if test="${fn:contains(massInformationVo.joinTags,showId)}">current</c:if>" value="${i.id}">${i.tagName}</li>
                </c:forEach>
              </ul>
            </div>
          </div>
        </div>

          <%--代理部分--%>
        <div id="agent">
            <%--指定代理商页面--%>
          <div id="appointAgent" class="clearfix m-t-sm line-hi34 bg-gray level <c:if test="${massInformationVo.group!='appointAgent'}">hide</c:if>">
            <input id="_master" type="hidden" name="master" value="${massInformationVo.joinMaster}">
            <input id="_agent" type="hidden" name="agent" value="${massInformationVo.joinAgent}">
            <label class="ft-bold col-sm-3 al-right"></label>
            <div class="col-sm-9">
              <div class="clearfix addAgents">
                <div class="pleft">
                  <div class="input-group m-t-xs m-b-xs">
                    <input type="search" class="form-control _agentName" placeholder="${views.operation['MassInformation.step2.searchContacts']}">
                    <span class="input-group-delete">×</span>
                    <span class="input-group-addon btnSearch"><i class="fa fa-search "></i></span>
                  </div>
                  <ul class="agentTab nav nav-tabs">
                      <%--总代选项卡--%>
                    <li class="active">
                      <a data-toggle="tab" href="#tab1" aria-expanded="true">${views.operation['MassInformation.step2.topAgents']}</a>
                    </li>
                      <%--代理选项卡--%>
                    <li>
                      <a data-toggle="tab" href="#tab2" aria-expanded="false">${views.operation['MassInformation.step2.agents']}</a>
                    </li>
                  </ul>
                  <div class="panel-body">
                    <div class="tab-content">
                        <%--总代列表--%>
                            <div id="tab1" class="tab-pane active">
                                <select multiple class="form-control _master" style="height: 300px;">
                                    <c:forEach var="i" items="${master}">
                                        <option data-search="${i.username}" value="${i.id}">
                                                ${i.username}&nbsp;&nbsp;&nbsp;&nbsp;
                                            <c:if test="${massInformationVo.sendType == 'email'}">
                                                ${i.mail}${soulFn:overlayEmaill(i.mail)}
                                            </c:if>
                                            <c:if test="${massInformationVo.sendType == 'siteMsg'}">
                                                ${i.realName}&nbsp;&nbsp;
                                            </c:if>
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        <%--代理列表--%>
                      <div id="tab2" class="tab-pane">
                        <select multiple class="form-control _agent" style="height: 300px;">
                          <c:forEach var="i" items="${agent}">
                              <option data-search="${i.username}" value="${i.id}">
                                      ${i.username}&nbsp;&nbsp;&nbsp;&nbsp;
                                  <c:if test="${massInformationVo.sendType == 'email'}">
                                      ${soulFn:overlayEmaill(i.mail)}
                                  </c:if>
                                  <c:if test="${massInformationVo.sendType == 'siteMsg'}">
                                      ${i.realName}&nbsp;&nbsp;
                                  </c:if>
                              </option>
                          </c:forEach>
                        </select>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="pcenter">
                  <div>
                    <soul:button target="addMaster" text="" opType="function"><i class="fa fa-arrow-right"></i></soul:button>
                    <soul:button target="removeMaster" text="" opType="function"><i class="fa fa-arrow-left"></i></soul:button>
                  </div>
                  <div>
                    <soul:button target="addAgent" text="" opType="function"><i class="fa fa-arrow-right"></i></soul:button>
                    <soul:button target="removeAgent" text="" opType="function"><i class="fa fa-arrow-left"></i></soul:button>
                  </div>
                </div>
                <div class="pright" style="padding-top:60px; ">
                    <%--被选择的总代列表--%>
                  <div class="col-xs-4">${views.operation['MassInformation.step2.topAgents']}</div>
                  <select multiple class="form-control _master_added" style="height: 120px;">
                    <c:forEach var="i" items="${selectedMaster}">
                      <option data-search="${i.username}" value="${i.id}">
                      ${i.username}</option>
                    </c:forEach>
                  </select>
                    <%--被选择的代理列表--%>
                  <div class="col-xs-4">${views.operation['MassInformation.step2.agents']}</div>
                  <select multiple class="form-control _agent_added" style="height: 120px;">
                    <c:forEach var="i" items="${selectedAgent}">
                      <option data-search="${i.username}" value="${i.id}">${i.username}</option>
                    </c:forEach>
                  </select>
                </div>
              </div>
            </div>
          </div>
            <%--总代以及总代的代理--%>
          <div id="master" class="clearfix m-t-sm line-hi34 bg-gray level <c:if test="${massInformationVo.group!='master'}">hide</c:if>">
            <input id="masterAndAgent" type="hidden" name="masterAndAgent" value="${massInformationVo.joinMasterAndAgent}">
            <label class="ft-bold col-sm-3 al-right"></label>
            <div class="col-sm-9">
              <div class="clearfix addAgents">
                <div class="pleft">
                  <%-- 总代及代理不需搜索 --%>
                 <%-- <div class="input-group m-t-xs m-b-xs">
                    <input type="search" class="form-control _agentNameAll" placeholder="${views.operation_auto['搜索联系人']}">
                    <span class="input-group-addon"><i class="fa fa-search"></i></span>
                  </div>--%>
                  <dl class="clearfix">
                    <dt class="clearfix">
                        <%--总代及其代理别表--%>
                    <div class="col-xs-12">${views.operation['MassInformation.step2.topAgents']}</div>
                    </dt>
                    <select multiple class="form-control _masterAndAgent" style="height: 300px;">
                      <c:forEach var="i" items="${master}">
                          <option data-search="${i.username}" value="${i.id}">
                                  ${i.username}&nbsp;&nbsp;&nbsp;&nbsp;
                              <c:if test="${massInformationVo.sendType == 'mail'}">
                                  ${soulFn:overlayEmaill(i.mail)}
                              </c:if>
                              <c:if test="${massInformationVo.sendType == 'siteMsg'}">
                                  ${i.realName}&nbsp;&nbsp;
                              </c:if>
                          </option>
                      </c:forEach>
                    </select>
                  </dl>
                </div>
                <div class="pcenter">
                  <div>
                    <soul:button target="addMasterAndAgent" text="" opType="function"><i class="fa fa-arrow-right"></i></soul:button>
                    <soul:button target="removeMasterAndAgent" text="" opType="function"><i class="fa fa-arrow-left"></i></soul:button>
                  </div>
                </div>
                <div class="pright">
                  <dl class="clearfix">
                    <dt class="clearfix">
                        <%--被选择的总代及其代理列表--%>
                    <div class="col-xs-4">${views.operation['MassInformation.step2.topAgentsAndAgents']}</div>
                    </dt>
                    <select multiple class="form-control _master_and_agent" style="height: 300px;">
                      <c:forEach var="i" items="${selectedMaster}">
                        <option data-search="${i.username}" value="${i.id}">${i.username}</option>
                      </c:forEach>
                    </select>
                  </dl>
                </div>
              </div>
            </div>
          </div>
        </div>

          <%--推送方式--%>
        <c:if test="${massInformationVo.sendType eq 'siteMsg'}" >
        <div class="clearfix m-l-lg line-hi34">
          <label class="ft-bold col-sm-3 al-right">${views.operation['MassInformation.step4.pushMode']}：</label>
          <div class="col-sm-5">

            <label><input type="radio" name="pushMode" class="i-checks" value="only" <c:if test="${massInformationVo.pushMode=='only'}">checked</c:if> >${views.operation['MassInformation.step4.only']}${messages.common['msg']}</label>
            <label><input type="radio" name="pushMode" class="i-checks" value="window" <c:if test="${massInformationVo.pushMode=='window'}">checked</c:if> >${messages.common['msg']}${views.operation['MassInformation.step4.pop']}</label>
            <span class="pushTip co-grayc2 m-l-sm" style="display:none;">${views.operation['MassInformation.step2.messages5']}</span>
          </div>
        </div>
        </c:if>

          <%--定时发送--%>
        <div class="clearfix m-l-lg line-hi34">
          <label class="ft-bold col-sm-3 al-right"><span class=""><input id="timingFlag" name="timingFlag" type="checkbox" <c:if test="${massInformationVo.timingFlag}">checked</c:if> class="i-checks">&nbsp;</span>${views.operation['MassInformation.step2.regularlySend']}：</label>
          <div id="timingDate" class="col-sm-3 input-group <c:if test="${!massInformationVo.timingFlag}">hide</c:if>">
            <gb:dateRange format="${DateFormat.DAY_SECOND}" style="width:160px"
                          name="timing" value="${massInformationVo.timing}" minDate="${dateQPicker.now}" id="timing"></gb:dateRange>
          </div>
        </div>

        <div class="operate-btn">
          <a href="/operation/massInformation/chooseType.html?sendType=${massInformationVo.sendType}" nav-target="mainFrame" class="btn btn-filter btn-lg">${views.common['previous']}</a>
          <soul:button target="editContent" text="${views.common['next']}" opType="function" cssClass="nextStep btn btn-filter btn-lg"></soul:button>
        </div>
      </div>
    </div>
  </div>
</form:form>
<soul:import res="site/operation/mass.information/chooseUser"/>