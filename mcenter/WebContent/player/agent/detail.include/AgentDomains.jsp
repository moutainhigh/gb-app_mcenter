<%--
  Created by IntelliJ IDEA.
  User: cogo
  Date: 16-01-13
  Time: 下午4:30
--%>
<%--@elvariable id="resetPwdVo" type="so.wwb.gamebox.model.master.agent.vo.ResetSysUserPwdVoo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
    <form>
        <div class="modal-body">
            <c:if test="${not empty domains}">
                <div class="form-group">
                    <label>${views.player_auto['推广网址']}</label>
                    <br>
                    <ul>
                        <c:forEach var="item" items="${domains}" varStatus="vs">
                            <li style="padding: 5px 0px">
                            http://${item.domain}/?c=${invitationCode}
                            <a data-clipboard-target="p${vs.index}" data-clipboard-text="http://${item.domain}/?c=${invitationCode}" name="copy">
                                    ${views.common['copy']}
                            </a>
                            </li>
                        </c:forEach>
                    </ul>

                </div>

            </c:if>
            <c:if test="${not empty indexDomains}">
                <div class="form-group">
                    <label>${views.player_auto['独立网址']}</label>
                    <br>
                    <ul>
                        <c:forEach var="item" items="${indexDomains}" varStatus="vs">
                            <li  style="padding: 5px 0px">
                            http://${item.domain}
                            <a data-clipboard-target="p${vs.index}" data-clipboard-text="http://${item.domain}" name="copy">
                                    ${views.common['copy']}
                            </a>
                            </li>
                        </c:forEach>
                    </ul>

                </div>

            </c:if>

        </div>

        <div class="modal-footer">
            <soul:button target="closePage" cssClass="btn btn-outline btn-filter" opType="function" text="${views.common['cancel']}"></soul:button>
        </div>
    </form>
</body>
<%@ include file="/include/include.js.jsp" %>
</html>
<soul:import res="site/player/agent/Detail"/>
