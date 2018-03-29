<%--@elvariable id="command" type="so.wwb.gamebox.model.mcenter.content.vo.VCttFloatPicListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div class="table-responsive  table-min-h">
    <table class="table table-striped table-hover dataTable" aria-describedby="editable_info">
        <thead>
        <tr class="bg-gray" role="row">
            <th width="40" class="user_checkbox"><label><input type="checkbox" class="i-checks"></label></th>
            <th width="60">${views.content['float.orderNum']}</th>
            <th>${views.column['CttFloatPic.title']}</th>
            <th>${views.column['CttFloatPic.preview']}</th>
            <th>${views.column['CttFloatPic.type']}</th>
            <th>
                <select id="float_pic_language_select" data-placeholder="${views.column['CttFloatPic.allLanguage']}" name="search.language" class="btn-group chosen-select-no-single btn-us" callback="query">
                    <option value="">${views.column['CttFloatPic.allLanguage']}</option>
                    <c:forEach items="${langs}" var="lang">
                        <option value="${lang.language}" ${(command.search.language == lang.language) ? 'selected' : ''}>${views.common[lang.language]}</option>
                    </c:forEach>
                </select>
            </th>
            <th>${views.column['CttFloatPic.displayInPages']}</th>
            <th>${views.column['CttFloatPic.publishTime']}</th>
            <th class="inline">
                <select data-placeholder="${views.column['CttFloatPic.allStatus']}" class="btn-group chosen-select-no-single" name="search.status" callback="query">
                    <option value="" ${(empty command.search.status) ? 'selected' : ''}>${views.column['CttFloatPic.allStatus']}</option>
                    <option value="true" ${(not empty command.search.status && command.search.status) ? 'selected' : ''}>${views.content['floatPic.status.true']}</option>
                    <option value="false" ${(not empty command.search.status && !command.search.status) ? 'selected' : ''}>${views.content['floatPic.status.false']}</option>
                </select>
            </th>
            <th>${views.column['CttFloatPic.switch']}</th>
            <th width="70px">${views.column['SysExport.operate']}</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <tr class="tab-detail">
                <th><input type="checkbox" value="${p.id}" ></th>
                <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                <td>${p.title}</td>
                <td>
                    <c:if test="${not empty command.floatItemMap[p.id]}">
                        <c:forEach var="pic" items="${command.floatItemMap[p.id]}">
                            <%--<c:if test="${p.singleMode}">
                                <img src="${resRoot}/${pic.normalEffect}" alt="${p.title}" class="singleModeTemplateImageType" style="width: 50px;height: 51px">
                            </c:if>
                            <c:if test="${!p.singleMode}">--%>
                                <img src="${soulFn:getThumbPathWithDefault(domain, pic.normalEffect, 50, 51,resComRoot.concat('/images/def.png'))}"
                                     alt="${p.title}" class="listModeTemplateImageType"><br>
                            <%--</c:if>--%>
                        </c:forEach>
                    </c:if>
                    <%--<c:if test="${not empty p.images}">
                        <c:forEach items="${p.images}" var="img">
                            <img data-src="${soulFn:getImagePathWithDefault(domain, img,resComRoot.concat('/images/def.png'))}"
                                 src="${soulFn:getThumbPathWithDefault(domain, img, 66, 24,resComRoot.concat('/images/def.png'))}"
                                 alt="${p.title}" class="logo-size-h24"><br>
                        </c:forEach>
                    </c:if>--%>
                </td>
                <td>${dicts.setting.float_pic_type[p.picType]}</td>
                <td>${views.common[p.language]}</td>
                <td>
                    <c:forEach items="${fn:split(p.displayInPages, ',')}" var="v" varStatus="list">
                        ${views.content['floatPic.displayIn.'.concat(v)]}<c:if test="${fn:length(fn:split(p.displayInPages, ',')) != (list.index + 1)}">,</c:if>
                    </c:forEach>
                </td>
                <td>${soulFn:formatDateTz(p.publishTime, DateFormat.DAY_SECOND, timeZone)}</td>
                <td><span class="label label-${(not empty p.status && p.status) ? 'success' : 'danger'}">${views.content['floatPic.status.'.concat(p.status)]}</span></td>
                <td><input type="checkbox" name="my-checkbox" data-size="mini" ${p.status ? 'checked' : ''} st="${p.status}" picType="${p.picType}"></td>
                <td>
                    <div class="joy-list-row-operations">
                        <a href="/cttFloatPic/edit.html?id=${p.id}&editType=2&floatType=${floatType}" nav-target="mainFrame">${views.common['edit']}</a>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
