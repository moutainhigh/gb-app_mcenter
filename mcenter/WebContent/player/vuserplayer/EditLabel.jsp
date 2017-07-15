<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VUserPlayerVo"--%>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${views.common['edit']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<!--编辑弹窗-->
<form:form action="${root}/player/playerView.html?search.id=${command.search.id}&ajax=true" method="post">
    <div id="validateRule" style="display: none">${validateRule}</div>
    <div class="modal-body">
        <div class="form-group status">
            <label>${views.column['VUserPlayer.label']}：</label>
            <!--已选择标签显示区域-->
                <span id="playerSelectTag">
                    <c:forEach var="item" items="${command.vPlayerTagAlls}">
                        <c:if test="${item.id>0}">
                            <span class="fa fa-check" playercount="${item.playerCount}" builtin="${item.builtIn}"
                                  quantity="${item.quantity}" tagId=${item.tagId} id=tag_${item.tagId}>
                                  ${item.tagName}
                            </span>
                        </c:if>
                    </c:forEach>
                </span>
        </div>

        <!--所有标签，玩家已有标签高亮显示-->
        <div class="li-tag clearfix m-t-n-xs m-l-n-xs">
            <c:forEach var="item" items="${command.vPlayerTagAlls}">
                <c:choose>
                    <c:when test="${item.id>0}">
                        <a class="selected" href="javascript:void(0)" playercount="${item.playerCount}" builtin="${item.builtIn}"
                           quantity="${item.quantity}" tagId="${item.tagId}" tagSelected="tagSelected">${item.tagName}
                            <i class="fa fa-check"></i></a>
                    </c:when>
                    <c:otherwise>
                        <a href="javascript:void(0)" playercount="${item.playerCount}" builtin="${item.builtIn}"
                           quantity="${item.quantity}" tagId="${item.tagId}">${item.tagName}<i
                                class="fa fa-check"></i></a>
                    </c:otherwise>
                </c:choose>


            </c:forEach>
        </div>
        <input id="playerTag" name="tagsIdStr" value="${command.tagId}" type="hidden"/>
        <input id="vip" type="hidden" name="vip" value="false"/>
        <form:hidden path="search.id" value="${command.search.id}"/>
    </div>
    </div>

    <div class="modal-footer">
        <%--<soul:button cssClass="btn btn-outline btn-filter" text="${views.common['save']}" opType="ajax" dataType="json"
                     target="${root}/player/saveLabel.html" precall="savePlayer"
                     post="getCurrentFormData" callback="saveCallbak"/>--%>
            <soul:button cssClass="btn btn-outline btn-filter" text="${views.common['save']}" opType="function"
                         target="saveLabel" precall="savePlayer"/>
        <soul:button cssClass="btn btn-outline btn-filter" text="${views.common['cancel']}" opType="function"
                     target="closePage"/>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/vuserplayer/userPlayer"/>
</html>