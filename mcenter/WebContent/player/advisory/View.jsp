<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<html lang="zh-CN">
<head>
    <title>${views.role['player.advisory.advisoryContent']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>

<!--咨询查看弹窗-->

<div class="modal-body">
    <div class="add-players">
        <div class="m-t-sm consult-mod">
            <form method="post">
                <div id="validateRule" style="display: none">${validate}</div>
                <c:forEach items="${command}" var="ad">
                    <span class="label label-orange">${ad.questionType eq '2'? views.role['Player.detail.advisory.detail.inquiry']:""}</span>
                    <table class="table table-bordered">
                        <tbody>
                        <tr class="consult-q-t">
                            <th class="content-width-limit-5">${views.column['VPlayerAdvisory.advisoryTime']}</th>
                            <td class="al-left">${soulFn:formatDateTz(ad.advisoryTime, DateFormat.DAY_SECOND,timeZone)}</td>
                            <th>${views.column['VPlayerAdvisory.username']}</th>
                            <td class="al-left">${ad.username}</td>
                        </tr>
                        <tr>
                            <th>${views.column['VPlayerAdvisory.advisoryTitle']}</th>
                            <td class="al-left" colspan="3">
                            ${ad.questionType eq '2'?views.role['Player.detail.advisory.question']:""}
                                <c:out value=" ${ad.advisoryTitle}" escapeXml="true" />
                            </td>
                        </tr>
                        <tr>
                            <th>${views.column['VPlayerAdvisory.advisoryContent']}</th>
                            <td class="al-left" colspan="3">
                                <dd>
                                    <c:out value="${ad.advisoryContent}" escapeXml="true" />
                                </dd>
                                <button type="button" class="btn btn-outline btn-filter btn-xs pull-right show-a-menu">
                                    ${views.role['Player.detail.advisory.Reply']}
                                </button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <div class="zxhf-warp hfsj-wrap hid-menu" id="${ad.id}" playerId="${ad.playerId}"></div>

                    <table class="table table-bordered">
                        <tbody>
                        <c:forEach items="${map}" var="s">
                            <c:if test="${s.key==ad.id}">
                                <c:forEach items="${s.value.result}" var="ss">

                                    <tr class="consult-a-t">
                                        <th class="content-width-limit-5">${views.column['PlayerAdvisoryReply.replyTime']}</th>
                                        <td class="al-left">${soulFn:formatDateTz(ss.replyTime, DateFormat.DAY_SECOND,timeZone)}</td>
                                        <th>${views.role['Player.detail.advisory.detail.replyUser']}</th>
                                        <td class="al-left">${ss.username}</td>
                                    </tr>
                                    <tr>
                                        <th>${views.column['VPlayerAdvisory.advisoryReplyTitle']}</th>
                                        <td class="al-left"
                                            colspan="3">${ss.replyTitle}</td>
                                    </tr>
                                    <tr>
                                        <th>${views.column['VPlayerAdvisory.advisoryReplyContent']}</th>
                                        <td class="al-left" colspan="3">
                                            <dd>
                                                <c:out value="${ss.replyContent}" escapeXml="true" />
                                            </dd>
                                        </td>
                                    </tr>

                                </c:forEach>
                            </c:if>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:forEach>
            </form>

            <div style="display:none;" id="reply">
                <div class="replyDivs">
                    <label>${views.column['VPlayerAdvisory.advisoryReplyTitle']}</label>



                    <input type="hidden" name="playerAdvisoryId_s" class="form-control m-b">
                    <input type="text" name="replyTitle_s" maxlength="100" class="form-control m-b">
                    <label>${views.column['VPlayerAdvisory.advisoryReplyContent']}</label>
                    <textarea class="form-control m-b" maxlength="20000" name="replyContent_s"></textarea>

                    <soul:button precall="validateForm" cssClass="m-r-xs btn btn-filter"
                                 text="${views.common['reply']}" opType="function"
                                 target="checkReplyCount" callback="saveCallbak"/>

                    <soul:button target="closePage" text="${views.common['cancel']}"
                                 cssClass="btn btn-outline btn-filter" opType="function"/>
                </div>

            </div>


        </div>
    </div>
</div>


</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/advisory/LoadAdvisoryReplyMax"/>
</html>
