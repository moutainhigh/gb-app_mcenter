<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-7-22
  Time: 上午10:35
--%>
<%--@elvariable id="userPlayerVo" type="so.wwb.gamebox.model.master.player.vo.UserPlayerVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<div style="display: none" id="noticeLocaleTmplJson">${userPlayerVo.noticeLocaleTmplJson}</div>
<form:form>
    <c:set value="${userPlayerVo.groupSendPlayers}" var="players"></c:set>
    <c:set value="${userPlayerVo.sendType}" var="sendType"></c:set>
    <div class="modal-body">
        <%--TODO 国际化 接口--%>
        <div class="form-group">
            <label>${views.role['Player.list.groupsend.player']}</label>
            <ul class="clearfix input">
                <%--没有 邮箱/短信 的玩家--%>
                <c:set var="no_send_to_count" value="0"></c:set>
                <%--没有接口的--%>
                <c:set var="no_interface_count" value="0"></c:set>
                <%--循环收件人--%>
                <c:forEach items="${players}" var="player">
                    <c:set var="sendPlayerClass" value=""></c:set>
                    <%--如果邮件／短信为空　计数并且设置s--%>
                    <c:if test="${player[sendType] eq '' || player[sendType] eq null}">
                        <c:set var="no_send_to_count" value="${no_send_to_count+1}"></c:set>
                        <c:set var="sendPlayerClass" value="no_send_to"></c:set>
                    </c:if>
                    <c:if test="${player[address] eq '' || player[address] eq null}">
                        <c:set var="no_interface_count" value="${no_interface_count+1}"></c:set>
                        <c:set var="no_interface_count_class" value="no_interface"></c:set>
                    </c:if>
                    <li class="${sendPlayerClass} sendPlayer ${no_interface_count_class}" data-id="${player['id']}">
                        @${player['username']}
                        <c:if test="${sendType ne 'stationLetter'}">
                                 <c:out value="<"></c:out> ${player[sendType]}<c:out value=">"></c:out>
                        </c:if>
                        <c:out value=";"></c:out>
                        <soul:button target="removeThisPlayer" tag="a" opType="function" text="x"></soul:button>
                    </li>

                    <li class="none hide" id="none_send_player">${views.role['Player.list.groupsend.chooseUser']}</li>
                </c:forEach>
            </ul>
        </div>
        <%--发送站内信--%>
        <c:if test="${userPlayerVo.sendType ne 'stationLetter'}">
            <c:if test="${no_send_to_count > 0}">
                <div class="no-mail" data-delete="no_send_to">
                    <div>${fn:replace(views.role['Player.list.groupsend.noEmail'],'{0}' , no_send_to_count)}</div>
                    <c:forEach items="${players}" var="player">
                        <c:if test="${player[sendType] eq '' || player[sendType] eq null}">
                            <span>${player['username']}</span>
                        </c:if>
                    </c:forEach>
                    <soul:button target="eliminatePlayer" tag="a" cssClass="co-red" opType="function" text="${views.role['Player.list.groupsend.clearPlayer']}"></soul:button>
                </div>
            </c:if>

            <%--<c:if test="${no_interface_count > 0}">
                <div class="no-mail" data-delete="no_interface">
                    <div>${fn:replace(views.role['Player.list.groupsend.noInterface'],'{0}' ,no_interface_count )}</div>
                    <c:forEach items="${players}" var="player">
                        <c:if test="${player[address] eq '' or player[address] eq null}">
                           <span>@${player['username']}</span>
                        </c:if>
                    </c:forEach>
                    <soul:button target="eliminatePlayer" tag="a" cssClass="co-red" opType="function" text="${views.role['Player.list.groupsend.clearPlayer']}"></soul:button>
                </div>
            </c:if>--%>
        </c:if>

        <div class="clearfix save lgg-version lang_label">
            <%--站长语言个数--%>
            <c:set value="0" var="langLen"></c:set>

            <c:forEach var="siteLang" items="${userPlayerVo.siteLanguages}" varStatus="index">
                <c:set value="${langLen + 1}" var="langLen"></c:set>
                <c:set value="language.${siteLang.language}" var="siteLangCode"></c:set>
                <soul:button target="changeLang" tag="a" opType="function"
                             dataType="${fn:substringBefore(dicts.common.language[siteLang.language], '#')}"
                             text="${fn:substringBefore(dicts.common.language[siteLang.language], '#')}"
                             post="${siteLang.language}" cssClass="lang ${index.index eq 0 ?'current':''} ${index.index+1 > maxLang ? 'hide':''} ${((index.index+1)%3 eq 0) ?'fenge':''  }">
                    ${fn:substringBefore(dicts.common.language[siteLang.language], '#')}<span class="unedited" data-edited-title="${views.role['Player.list.groupsend.edited']}" data-editting-title="${views.role['Player.list.groupsend.editting']}">${views.role['Player.list.groupsend.unedit']}</span>
                </soul:button>
            </c:forEach>

            <span class="more">
                <soul:button target="changeCurrentLang" tag="a" opType="function" cssClass="next_lang" text=""><i class="fa fa-angle-double-right"></i></soul:button>
                <%--<a href="javascript:void(0)"><i class="fa fa-angle-double-right"></i></a>--%>
            </span>

                <%--<div class="pull-right">
                    <div class="btn-group">
                        <button data-toggle="dropdown" class="btn btn-filter btn-outline dropdown-toggle" aria-expanded="true">模板&nbsp;&nbsp;<span class="caret"></span></button>
                        <ul class="dropdown-menu pull-right">
                            <div class="label-menu-o">
                                <c:forEach items="${userPlayerVo.noticeLocaleTmpls}" var="noticeLocaleTmpl">
                                    <li class="temp"><soul:button target="changeTmpl" text="" opType="function" tag="a" code="${noticeLocaleTmpl.groupCode}" cssClass="co-gray">${noticeLocaleTmpl.title}</soul:button></li>
                                </c:forEach>
                            </div>
                            <li class="divider m-t-none"></li>
                            <li class="m-b-sm bt m-t-xs">
                                <button type="button" class="btn btn-filter btn-sm btn-xs">${views.player_auto['管理']}</button>
                            </li>
                        </ul>
                    </div>
                </div>--%>
        </div>

        <%--编辑--%>
        <div class="hfsj-wrap _edit">
            <div class="form-group">
                <div class="clearfix">
                    <label>${views.role['Player.list.groupsend.title']}</label>
                    <div class="pull-right inline bg-gray">
                        <div class="btn-group">
                            <button data-toggle="dropdown" class="btn btn-link dropdown-toggle fzyx">${views.role['Player.list.groupsend.cpLang']}&nbsp;&nbsp;<span class="caret"></span></button>
                            <ul class="dropdown-menu pull-right" id="copy_lang">
                  <%--              <li class="temp" lang-code="fanti"><a href="javascript:void(0)" class="co-gray">${views.player_auto['复制语系']}</a></li>
                                <li class="temp"><a href="javascript:void(0)" class="co-gray">${views.player_auto['复制语系']}</a></li>--%>
                            </ul>
                        </div>
                    </div>
                </div>
                <input type="text" placeholder="" id="title" class="form-control m-b">
            </div>
            <div class="form-group"><label>${views.role['Player.list.groupsend.content']}</label><textarea <c:if test="${sendType ne 'mail'}">class="form-control m-b" </c:if>id="editContent"></textarea></div>
            <div class="variable_wrap hide">
                ${views.role['Player.list.groupsend.tag']}
                <soul:button target="insertVarTag" text="" opType="function" tag="a" cssClass="variable" value="{$uname}">
                    ${views.role['Player.list.groupsend.userName']} <{$uname}>
                </soul:button>
                <soul:button target="insertVarTag" text="" opType="function" tag="a" cssClass="variable" value="{$upwd}">
                    ${views.role['Player.list.groupsend.pwd']} <{$upwd}>
                </soul:button>
                <a href="javascript:void(0)" class="more">${views.common['viewMore']} <i class="fa fa-angle-double-right"></i></a>
            </div>
            <div class="clearfix form-group m-b-xxs">
                <div class="dsfb"><label><input type="checkbox" class="i-checks" name="byTime">${views.role['Player.list.groupsend.sendByTime']}</label></div>
                <div class="dsfb-data">
                    <div class="input-group date">
                        <%--<span class="input-group-addon"><i class="fa fa-calendar"></i></span>--%>
                        <%--<input type="text" class="form-control" value="2015-05-01 16:51:01" disabled>--%>
                        <gb:dateRange format="${DateFormat.DAY_SECOND}" style="width:160px" position="up"
                                      name="time" id="birthday"></gb:dateRange>

                        <%--<gb:dateField dateFielsType="date" position="up" format="${DateFormat.DAY_SECOND}"  name="result.birthday" id="birthday" cssClass="form-control"/>--%>
                    </div>
                </div>
            </div>
        </div>
        <%--预览--%>
        <div class="hfsj-wrap m-t-sm hfsj-wrap-con _preview hide _preview_content">
            <label class="_previre_title"></label>


            <div class="form-group m-t-xs _previre_content"></div>


        </div>
    </div>
    <div class="modal-footer">
        <%--<button type="button" class="btn btn-filter">${views.player_auto['确认']}</button>--%>

        <%--站长语言  大于1时 有下一步--%>
        <c:if test="${langLen > 1}">
            <%--上一步--%>
            <soul:button target="changeCurrentLang" opType="function" cssClass="btn btn-filter previous_lang hide _edit" text="${views.common['previous']}"></soul:button>

            <%--下一步--%>
            <soul:button target="changeCurrentLang" opType="function" cssClass="btn btn-filter next_step next_lang _edit" text="${views.common['next']}"></soul:button>
        </c:if>
        <soul:button target="backEdit" cssClass="btn btn-filter ${langLen > 1 ? 'hide':''} backEdit" opType="function" text="${views.player_auto['返回修改']}"></soul:button>
        <soul:button target="toPreview" cssClass="_edit btn btn-filter ${langLen > 1 ? 'hide':''} preview" opType="function" text="${views.common['previewAndSave']}"></soul:button>
        <soul:button target="send" cssClass="_edit btn btn-filter ${langLen > 1 ? 'hide':''} _preview hide" opType="function" text="${views.common['OK']}"></soul:button>

        <%--<button type="button" class="btn btn-outline btn-filter">${views.common_report['取消']}</button>--%>
        <soul:button target="closePage" opType="function" cssClass="btn btn-outline btn-filter" text="${views.common['cancel']}"></soul:button>
    </div>
    <%--隐藏域--%>
    <input type="hidden" value="${maxLang}" id="maxLang">
    <input type="hidden" value="${langLen}" id="langLen">
    <input type="hidden" value="${sendType}" id="sendType">
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/player/groupsend/EditContent"/>
</html>
