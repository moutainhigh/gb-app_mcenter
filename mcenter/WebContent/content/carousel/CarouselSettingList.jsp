<%--@elvariable id="vCttCarouselListVo" type="so.wwb.gamebox.model.master.content.vo.VCttCarouselListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<tbody>
<c:forEach items="${vCttCarouselListVo.result}" var="p" varStatus="st">
    <tr class="tab-detail dd-item1 dd-item2 " data-id="${p.id}" data-type="">
        <td class="td-handle1" width="40"><span class="label label-blue carousel-number">${st.index+1}</span></td>
        <td class="td-handle1" width="180" title="${vCttCarouselListVo.currentLang.get(p.id).name}">
            ${fn:substring(vCttCarouselListVo.currentLang.get(p.id).name,0 ,10 )}
            <c:if test="${fn:length(vCttCarouselListVo.currentLang.get(p.id).name)>10}">...</c:if>
        </td>
        <td class="td-handle1" width="60">
            <soul:button target="previewImg" text="" opType="function" tag="a">
                <img data-src="${soulFn:getImagePath(domain,vCttCarouselListVo.currentLang.get(p.id).cover)}"
                    src="${soulFn:getThumbPath(domain,vCttCarouselListVo.currentLang.get(p.id).cover,32,20)}" alt="" class="logo-size-h30">
            </soul:button>
        </td>
        <td class="td-handle1">
                ${soulFn:formatDateTz(p.startTime, DateFormat.DAY_SECOND,timeZone)} ${views.content['logo.zhi']} ${soulFn:formatDateTz(p.endTime, DateFormat.DAY_SECOND,timeZone)}
        </td>
        <td class="td-handle1" width="50">${dicts.content.carousel_state[p.useStatus]}</td>
    </tr>
</c:forEach>
</tbody>
