<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-8-5
  Time: 下午1:54
--%>

<%--@elvariable id="vCttCarouselListVo" type="so.wwb.gamebox.model.master.content.vo.VCttCarouselListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
    <form>
        <div class="modal-body">
            <c:set value="${vCttCarouselListVo.types.get('carousel_type_phone').dictCode}" var="firstCode"></c:set>
            <input type="hidden" value="${firstCode}" id="firstCode">
            <div class="form-group clearfix">
                <label class="pull-left line-hi34">${views.content['carousel.type']}</label>
                <div class="col-xs-3">
                    <gb:select name="search.useStatus" prompt="" value="${firstCode}" callback="typesChange" list="${vCttCarouselListVo.types}"></gb:select>
                </div>
            </div>
            <c:forEach items="${vCttCarouselListVo.intervalTimes}" var="its" varStatus="status">
                <div class="form-group times clearfix it_${its.paramCode}${its.paramCode eq firstCode ? '':' hide'}">
                    <label class="pull-left line-hi34">${views.content['carousel.playTimesInterval']}</label>
                    <div class="col-xs-9">
                        <%--得到当前的间隔时间--%>
                        <input type="hidden" value="${its.id}" name="id" class="params_data">
                        <select  class="chosen-select-no-single params_data" name="paramValue" data-value="${its.paramValue}">
                            <c:forEach items="${intervalTime}" var="it">
                                <option <c:if test="${it.time eq its.paramValue}"> selected </c:if> value="${it.time}">${it.content}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </c:forEach>
            <div class="form-group co-yellow">
                ${views.content['carousel.orderTips']}
            </div>
            <table class="dragdd" style="" id="typeListTable">
                <tbody>
                <c:forEach items="${vCttCarouselListVo.result}" var="p" varStatus="st">
                    <tr class="tab-detail dd-item1 dd-item2 " data-id="${p.id}" data-type="${type.value.dictCode}">
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
            </table>
        </div>
        <div class="modal-footer">
            <soul:button target="updateCarouselSort" cssClass="btn btn-filter" tag="button" text="${views.common['OK']}" opType="function"></soul:button>
            <soul:button target="closePage" cssClass="btn btn-outline btn-filter" tag="button" text="${views.common['cancel']}" opType="function"></soul:button>
        </div>
    </form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/content/carousel/Setting"/>
</html>
