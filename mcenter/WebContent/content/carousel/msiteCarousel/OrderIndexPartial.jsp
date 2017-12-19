<%@ page import="so.wwb.gamebox.model.master.content.po.VCttCarousel" %>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="poType" value="<%= VCttCarousel.class %>"></c:set>

<!--//region your codes 1-->
<form:form action="${root}/content/vCttCarousel/viewMsiteCarousel.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['内容']}</span><span>/</span><span>${views.sysResource['轮播广告']}</span>
            <soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <%@include file="../CarouselTop.jsp"%>
                <div class="clearfix filter-wraper border-b-1">
                    <div class="col-xs-10">
                        <i class="fa fa-exclamation-circle"></i><span class="co-yellow m-l-sm">${views.common['DynamicLie.draggingSort']}</span>
                    </div>
                    <label class="pull-left line-hi34">${views.content['carousel.playTimesInterval']}：</label>
                    <div class="col-xs-1">
                            <%--得到当前的间隔时间--%>
                        <select  class="chosen-select-no-single params_data" name="paramValue" data-value="${its.paramValue}">
                            <c:forEach items="${intervalTime}" var="it">
                                <option <c:if test="${it.time eq its.paramValue}"> selected </c:if> value="${it.time}">${it.content}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div id="editable_wrapper" class="dataTables_wrapper search-list-container" role="grid">
                    <div class="table-responsive table-min-h">
                        <table class="table table-striped table-hover dataTable dragdd" aria-describedby="editable_info">
                            <thead>
                            <tr role="row" class="bg-gray">
                                <th width="60">${views.common['number']}</th>
                                <th>${views.column['VCttCarousel.name']}</th>
                                <th>${views.content['carousel.previewPicture']}</th>
                                <th>${views.column['VCttCarousel.orderNum']}</th>
                                <th class="sorting">${views.content['carousel.showTime']}</th>
                                <th class="inline">
                                    <gb:select name="search.useStatus" value="${command.search.useStatus}" callback="query"
                                               prompt="${views.role['player.list.title.status']}" list="${command.useStatus}"></gb:select>
                                </th>
                                <th>${views.content['domain.setting']}</th>
                                <th>${views.column['VCttCarousel.publishTime']}</th>
                                    <%--<th>${views.content_auto['是否启用']}</th>--%>
                                <th>${views.common['operate']}</th>
                            </tr>

                            <tr class="bd-none hide">
                                <th colspan="5"><div class="select-records"><i class="fa fa-exclamation-circle"></i>${views.common['cancelSelectAll.prefix']}<span id="page_selected_total_record"></span>${views.common['cancelSelectAll.middlefix']}，
                                    <soul:button target="cancelSelectAll" tag="a" opType="function" text="${views.common['cancelSelectAll']}">${views.common['cancelSelectAll']}</soul:button>
                                        ${views.common['cancelSelectAll.suffix']}</div></th>
                            </tr>

                            </thead>
                            <tbody class="dd-list1">
                            <c:forEach items="${command.result}" var="p" varStatus="status">
                                <tr class="tab-detail  dd-item1">
                                    <td class="td-handle1">${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                                    <td class="td-handle1">
                                            ${command.currentLang.get(p.id).name}
                                    </td>
                                        <%--width, int height--%>
                                    <td class="td-handle1">
                                        <soul:button target="previewImg" text="" opType="function" tag="a">
                                        <img data-src="${soulFn:getImagePath(domain,command.currentLang.get(p.id).cover)}"
                                             src="${soulFn:getThumbPath(domain,command.currentLang.get(p.id).cover,66,24)}"></td>
                                    </soul:button>
                                    <td class="td-handle1">${p.useStatus ne 'using' ? '--':p.orderNum}</td>

                                    <td class="td-handle1">
                                            ${soulFn:formatDateTz(p.startTime, DateFormat.DAY_SECOND, timeZone)} ${views.content_auto['至']} ${soulFn:formatDateTz(p.endTime, DateFormat.DAY_SECOND,timeZone)}
                                    </td>
                                    <td<c:choose>
                                        <c:when test="${now.compareTo(p.endTime)==-1 && now.compareTo(p.startTime)==1}"> class="co-green td-handle1"</c:when>
                                        <c:when test="${now.compareTo(p.endTime)==1}"> class="co-grayc2 td-handle1"</c:when>
                                    </c:choose> data-stop="${dicts.content.carousel_state[p.useStatus]}">
                                        <c:choose>
                                            <c:when test="${now.compareTo(p.endTime)==-1 && now.compareTo(p.startTime)==1}"> ${dicts.content.carousel_state["using"]}</c:when>
                                            <c:when test="${now.compareTo(p.startTime)==-1}">${dicts.content.carousel_state["wait"]}</c:when>
                                            <c:when test="${now.compareTo(p.endTime)==1}">${dicts.content.carousel_state["expired"]}</c:when>
                                        </c:choose>
                                    </td>
                                    <td class="td-handle1">
                                        <c:choose>
                                            <c:when test="${now.compareTo(p.endTime)==-1 && now.compareTo(p.startTime)==1}">
                                                <input type="checkbox" name="my-checkbox" data-size="mini" ${empty p.status ||p.status?'checked':''} value="${p.id}" useStatus="using">
                                            </c:when>
                                            <c:when test="${now.compareTo(p.startTime)==-1}">
                                                <input type="checkbox" name="my-checkbox" data-size="mini" ${empty p.status ||p.status?'checked':''} value="${p.id}" useStatus="wait">
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td class="td-handle1">
                                            ${soulFn:formatDateTz(p.publishTime, DateFormat.DAY_SECOND,timeZone)}
                                    </td>
                                    <td class="td-handle1">
                                        <soul:button target="${root}/content/cttCarousel/msiteCarousel/edit.html?search.id=${p.id}" text="${views.common['edit']}" tag="a" opType="dialog" callback="query">${views.common['edit']}</soul:button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="operate-btn" style="text-align: center">
                    <soul:button target="updateCarouselSort" text="${views.common['OK']}" opType="function"
                                 cssClass="btn btn-filter btn-lg m-r" >${views.common['OK']}</soul:button>
                    <soul:button target="goToLastPage" text="${views.common['cancel']}" opType="function"
                                 cssClass="btn btn-outline btn-filter btn-lg m-r" >${views.common['cancel']}</soul:button>
                </div>
            </div>
        </div>
    </div>
</form:form>
<!--//endregion your codes 1-->
<soul:import res="site/content/carousel/msiteCarousel/OrderIndexPartial"/>