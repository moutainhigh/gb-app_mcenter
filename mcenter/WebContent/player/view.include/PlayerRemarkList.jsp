<%@ page import="org.soul.web.session.SessionManagerBase" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/include/include.inc.jsp" %>
<c:forEach var="remark" items="${remarkListVo.result}" varStatus="vs">
    <li class="remark-list-li">
        <span class="co-gray m-r-sm">
        ${remarkListVo.search.fromCount+vs.index+1}:${dicts.common.remark_type[remark.remarkType]}
            [${remark.operator}]
        ${soulFn:formatDateTz(remark.remarkTime, DateFormat.DAY_SECOND,timeZone)} - ${soulFn:formatTimeMemo(remark.remarkTime, locale)}
        </span>
            ${remark.remarkContent}
        <div class="operate-district">
            <soul:button target="${root}/playerRemark/editPlayerRemark.html?search.id=${remark.id}" callback="queryView" text="${views.player_auto['编辑']}" opType="dialog"><i class="fa fa-pencil-square-o m-l"></i></soul:button>
            <soul:button target="${root}/playerRemark/deletePlayerRemark.html?search.id=${remark.id}"
                         callback="delRemarkCallback" text="${views.player_auto['删除']}" opType="ajax"><i class="fa fa-trash-o m-l"></i></soul:button>
        </div>
    </li>
</c:forEach>
<input type="hidden" name="newTotalCount" value="${remarkListVo.paging.totalCount}">