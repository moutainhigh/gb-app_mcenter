<%--@elvariable id="command" type="so.wwb.gamebox.model.company.operator.vo.SystemAnnouncementListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="table-responsive table-min-h">
    <c:forEach items="${command.result}" var="s">
        <c:forEach items="${apiMap}" var="apis">
            <c:if test="${apis.value.apiId==s.apiId}">
                <ul class="game-announcement-list warningRecord-wrap">
                    <li class="clearfix warningRecord-list">
                        <div class="img warningRecord-addon"></div>
                        <div class="con warningRecord-square">
                            <span class="co-orange">${gbFn:getSiteApiName((s.apiId).toString())}
                                <c:if test="${s.gameId!=null}">——${gbFn:getSiteGameName((s.gameId).toString())}</c:if>
                            </span>
                            <p>
                                <a href="/operation/announcementMessage/messageDetail.html?search.id=${s.id}"
                                   nav-target="mainFrame"
                                   class="co-gray6">${s.shortContentText50}</a>
                                <span class="co-gray pull-right">${soulFn:formatDateTz(s.publishTime, DateFormat.DAY_SECOND,timeZone)}</span>
                            </p>
                        </div>
                    </li>
                </ul>
            </c:if>
        </c:forEach>
    </c:forEach>
</div>
<soul:pagination/>


