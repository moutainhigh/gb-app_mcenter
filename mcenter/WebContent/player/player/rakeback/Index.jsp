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
<c:forEach items="${userPlayerVo.rakebackSet}" var="rs">
  <li class="player_rakeback_li">
    <label title="${rs.name}" >
      <input type="radio" name="rakebackId" value="${rs.id}" data-toggle="checkbox-x"  data-size="xs" />
      ${rs.name}
    </label>
  </li>
</c:forEach>
  <li class="player_rakeback_li">
  <label title="${views.role['Player.list.rakabeck.useTop']}" >
    <input type="radio" name="rakebackId" value="0" data-toggle="checkbox-x"  data-size="xs" />
      ${views.role['Player.list.rakabeck.useTop']}
  </label>
</li>