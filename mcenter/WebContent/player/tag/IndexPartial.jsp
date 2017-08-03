<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VPlayerTagListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div class="clearfix m-b" style="padding-top: 15px;">
    <soul:button target="${root}/tags/create.html" text="${views.role['Player.list.playerTag.addTagTitle']}" callback="reloadWhenChangeDialog" opType="dialog"></soul:button>
    <a href="javascript:void(0)" data-toggle="modal" data-target="#addTag" class="co-blue"></a>
</div>
<div class="table-responsive">
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>${views.role['Player.list.playerTag.tag']}</th>
            <th>${views.role['Player.list.playerTag.tagDescribe']}</th>
            <th>${views.role['Player.list.playerTag.playerCount']}</th>
            <th>${views.common['operate']}</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="pts" items="${command.result}">
            <tr>
                <td title="${pts.tagName}"><span>${pts.tagName}</span></td>
                <td title="${pts.tagDescribe}"><span>${pts.tagDescribe}</span></td>
                <td><span>
                    <c:choose>
                        <c:when test="${pts.playerCount gt 0}">
                            <%--<a href="${root}/player/list.html?search.tagId=${pts.id}" nav-target="mainFrame">${pts.playerCount}</a>--%>
                            <soul:button target="jump" opType="function" tag="a" tagId="${pts.id}"
                                         cssClass="m-r-sm" text="${pts.playerCount}"/>
                        </c:when>
                        <c:otherwise>
                            ${pts.playerCount}
                        </c:otherwise>
                    </c:choose>
                    <c:if test="${pts.builtIn && pts.quantity gt 0}">(${fn:replace(views.player_auto['限'],"{0}",pts.quantity)})</c:if></span>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${!pts.builtIn}">
                            <soul:button target="${root}/tags/edit.html?id=${pts.id}" opType="dialog" callback="reloadWhenChangeDialog" tag="a" cssClass="m-r-sm" title="${views.common['edit']}" text="${views.common['rename']}"></soul:button>
                            <c:choose>
                                <c:when test="${pts.playerCount>0}">
                                    <soul:button target="${root}/tags/delete.html?id=${pts.id}" callback="reloadWhenChangeDialog" opType="ajax" tag="a" confirm="${fn:replace(views.common['delete'],'{countPlayer}' ,pts.playerCount)}" text="${views.common['delete']}"></soul:button>
                                </c:when>
                                <c:otherwise>
                                    <soul:button target="${root}/tags/delete.html?id=${pts.id}" callback="reloadWhenChangeDialog" opType="ajax" tag="a" confirm="${views.common['confirm.delete']}" text="${views.common['delete']}"></soul:button>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <span class="m-r-sm">---</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="m-r-sm">---</span>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<soul:pagination mode="full"/>
<!--//endregion your codes 1-->
