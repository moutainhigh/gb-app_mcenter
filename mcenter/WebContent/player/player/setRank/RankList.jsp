<%--
  Created by IntelliJ IDEA.
  User: snekey
  Date: 15-7-23
  Time: 下午4:30
  To change this template use File | Settings | File Templates.
--%>

<%--@elvariable id="userPlayerVo" type="so.wwb.gamebox.model.master.player.vo.UserPlayerVo"--%>
<%@ page contentType="charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:forEach items="${rankList}" var="rk">
  <li class="player_rank_li" data-search="${rk.id}">
    <label title="${rk.rankName}" >
      <input type="radio" name="rankId" ${userPlayerVo.result.rankId eq rk.id ? 'checked':''} data-value="${rk.id}"  value="${rk.id}" data-toggle="checkbox-x"  data-size="xs" />
        ${rk.rankName}</label>
  </li>
</c:forEach>
