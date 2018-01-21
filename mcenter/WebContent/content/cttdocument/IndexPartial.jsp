<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div id="editable_wrapper" class="dataTables_wrapper" role="grid">
    <input type="hidden" value="${command.openId}" name="openId" id="openId">
    <div class="table-responsive table-min-h">
        <table class="table table-striped table-hover dataTable" aria-describedby="editable_info">
            <thead>
            <tr role="row" class="bg-gray">
                <th width="60">${views.column['VCttDocument.orderNum']}</th>
                <th>${views.column['VCttDocument.code']}</th>
                <th>${views.content['document.projectName']}</th>
                <%--<th>${views.column['VCttDocument.checkStatus']}</th>--%>
                <th>${views.column['VCttDocument.status']}</th>
                <th>${views.content['document.languageVersion']}</th>
                <th>${views.column['VCttDocument.publishTime']}</th>
                <th>${views.column['VCttDocument.childCount']}</th>
                <th>${views.content['isEnable']}</th>
                <th>${views.common['operate']}</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${command.result}" var="p" varStatus="status">
                <tr class="tab-detail">
                    <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                    <td>${p.code}</td>
                    <td>
                        <soul:button target="${root}/cttDocument/showDocumentDetail.html?search.id=${p.id}"
                                     opType="dialog" text="${cacheMap[p.id.toString()].title}" size="size-wide"
                                     title="${cacheMap[p.id.toString()].title}-${views.common['detail']}"></soul:button>

                    </td>
                    <%--<td>
                        <c:if test="${p.checkStatus!='2'}">
                            ${dicts.content.check_status[p.checkStatus]}
                        </c:if>
                        <c:if test="${p.checkStatus=='2'}">
                            <span class="co-red">${dicts.content.check_status[p.checkStatus]}</span>

                        </c:if>
                        <c:if test="${empty p.checkStatus}">
                            －－
                        </c:if>
                    </td>--%>
                    <td>
                        <c:if test="${p.isRemove}">
                            <span class="co-red">${views.content['已下架']}</span>
                        </c:if>
                        <c:if test="${!p.isRemove}">
                            <c:if test="${empty p.checkStatus}">
                                <span class="co-orange">${views.content['未发布']}</span>
                            </c:if>
                            <c:if test="${not empty p.checkStatus}">
                                <c:if test="${p.status=='on'}">
                                    <span class="">${dicts.content.draft_status[p.status]}</span>
                                </c:if>
                                <c:if test="${p.status=='off'}">
                                    <span class="co-gray9">${dicts.content.draft_status[p.status]}</span>
                                </c:if>
                            </c:if>

                        </c:if>

                    </td>
                    <td>
                        <div class="btn-group">
                            <button data-toggle="dropdown" class="btn btn-warning dropdown-toggle btn-xs">${p.languageCount}/${languageCount}</button>
                        </div>
                    </td>
                    <td>${soulFn:formatDateTz(p.publishTime, DateFormat.DAY_SECOND,timeZone)}</td>
                    <%--<td>${views.content[p.buildIn.toString()]}</td>--%>
                    <td><a href="javascript:void(0)" class="over" childCount="${p.childCount}" docId="${p.id}">${p.childCount}${views.content['document.item']}<i></i></a></td>
                    <td>
                        <c:if test="${p.checkStatus==null||p.checkStatus!='0'}">
                            <c:if test="${!p.isRemove}">
                                <input type="checkbox" name="my-checkbox" data-size="mini" ${p.status=='on'?'checked':''} documentId="${p.id}">
                            </c:if>
                            <c:if test="${p.isRemove}">
                                <input type="checkbox" name="my-checkbox" data-size="mini" disabled="disabled">
                            </c:if>
                        </c:if>
                        <c:if test="${p.checkStatus!=null&&p.checkStatus=='0'}">－－</c:if>
                    </td>
                    <td>
                        <c:set var="subSize" value="${command.subitemMap[p.id.toString()].size()}"></c:set>
                        <%--<c:if test="${p.checkStatus!=null&&p.checkStatus=='0'}">
                            <span class="co-grayd">
                                ${views.common['edit']}
                            </span>
                            <c:if test="${!p.buildIn}">
                            <span class="dividing-line m-r-xs m-l-xs">|</span>
                            </c:if>
                        </c:if>--%>
                        <%--<c:if test="${p.checkStatus==null||p.checkStatus!='0'}">--%>
                            <c:if test="${p.buildIn}">
                                <a href="/cttDocumentI18n/editContent.html?id=${p.id}&search.documentId=${p.id}" nav-target="mainFrame">${views.common['edit']}</a>
                            </c:if>
                            <c:if test="${!p.buildIn}">
                                <soul:button callback="goNext" target="${root}/cttDocumentI18n/edit.html?id=${p.id}&search.documentId=${p.id}"
                                             data-toggle="modal" data-target="#add-pages" opType="dialog" text="${views.common['edit']}"
                                             title="${views.content['document.editParent']}－${cacheMap[p.id.toString()].title}"></soul:button>
                                <span class="dividing-line m-r-xs m-l-xs">|</span>
                                <soul:button target="deleteDocument" text="${views.common['delete']}" opType="function" subSize="${subSize}" checkStatus="${p.checkStatus}"
                                             documentId="${p.id}" status="${p.status}" isParent="${p.parentId==null?'true':'false'}"></soul:button>
                            </c:if>

                    </td>
<%--                    <td><a href="/cttDraft/editContent.html?search.childId=${p.childId}" nav-target="mainFrame"> ${views.common['edit']}</a></td>--%>
                </tr>
                <tbody class="ng-hide" style="display:none">
                    <c:forEach items="${command.subitemMap[p.id.toString()]}" var="sub" varStatus="st">
                        <tr>
                            <td style="padding-left: 40px;">${st.index+1}</td>
                            <td>${sub.code}</td>
                            <td>
                                <soul:button target="${root}/cttDocument/showDocumentDetail.html?search.id=${sub.id}"
                                             opType="dialog" text="${cacheMap[sub.id.toString()].title}"
                                             title="${cacheMap[sub.id.toString()].title}--${views.common['detail']}"></soul:button>
                            </td>
                            <td>
                                <c:if test="${p.isRemove}">
                                    <span class="co-red">${views.content['已下架']}</span>
                                </c:if>
                                <c:if test="${!p.isRemove}">
                                    <c:if test="${empty sub.checkStatus}">
                                        <span class="co-orange">${views.content['未发布']}</span>
                                    </c:if>
                                    <c:if test="${not empty sub.checkStatus}">
                                        <c:if test="${p.status!='off'}">
                                            <span class="">${dicts.content.draft_status[sub.status]}</span>
                                        </c:if>
                                        <c:if test="${p.status=='off'}">
                                            <span class="co-gray9">${dicts.content.draft_status['off']}</span>
                                        </c:if>
                                    </c:if>
                                </c:if>

                            </td>
                            <td>
                                <div class="btn-group">
                                    <button data-toggle="dropdown" class="btn btn-warning dropdown-toggle btn-xs">${sub.languageCount}/${languageCount}</button>
                                </div>
                            </td>
                            <td>${soulFn:formatDateTz(sub.publishTime, DateFormat.DAY_SECOND,timeZone)}</td>

                            <%--<td>
                                ${views.content[sub.buildIn.toString()]}
                            </td>--%>
                            <td>&nbsp;</td>
                            <td>
                                <c:if test="${!sub.isRemove}">
                                    <%--<c:if test="${sub.checkStatus=='1'&&p.status!='off'}">
                                        <input type="checkbox" name="my-checkbox" data-size="mini" ${sub.status=='on'?'checked':''} documentId="${sub.id}">
                                    </c:if>--%>
                                    <c:if test="${p.isRemove}">
                                        <input type="checkbox" name="my-checkbox" data-size="mini"  disabled="disabled">
                                    </c:if>
                                    <c:if test="${not empty sub.checkStatus}">
                                        <c:if test="${!p.isRemove&&p.status=='off'}">
                                                <input type="checkbox" name="my-checkbox" data-size="mini"  disabled="disabled">
                                        </c:if>
                                        <c:if test="${!p.isRemove&&p.status=='on'}">
                                            <input type="checkbox" name="my-checkbox" data-size="mini" ${sub.status=='on'?'checked':''} documentId="${sub.id}">
                                        </c:if>
                                    </c:if>
                                    <c:if test="${empty sub.checkStatus}">
                                        <input type="checkbox" name="my-checkbox" data-size="mini"  disabled="disabled">
                                    </c:if>

                                </c:if>
                                <c:if test="${sub.isRemove}"><input type="checkbox" name="my-checkbox" data-size="mini"  disabled="disabled"></c:if>
                            </td>
                            <td>
                                <%--<c:if test="${sub.checkStatus!=null&&sub.checkStatus=='0'}">
                                    <span class="co-grayd">
                                            ${views.common['edit']}
                                    </span>
                                    <c:if test="${!sub.buildIn}">
                                        <span class="dividing-line m-r-xs m-l-xs">|</span>
                                    </c:if>
                                </c:if>--%>
                                    <soul:button callback="goNext" target="${root}/cttDocumentI18n/edit.html?id=${sub.id}&search.documentId=${sub.id}&parentVo.result.id=${p.id}"
                                        data-toggle="modal" opType="dialog" text="${views.common['edit']}" title="${views.content['document.editChild']}－${cacheMap[sub.id.toString()].title}"></soul:button>
                                    <c:if test="${!sub.buildIn}">
                                        <span class="dividing-line m-r-xs m-l-xs">|</span>
                                        <soul:button target="deleteDocument" text="${views.common['delete']}" opType="function" documentId="${sub.id}" status="${sub.status}" checkStatus="${sub.checkStatus}" isParent="${empty sub.parentId?'true':'false'}"></soul:button>
                                    </c:if>
                                <%--<soul:button target="${root}/vCttDocument/deleteCttDocument.html?search.id=${sub.id}"
                                             confirm="${views.content_auto['确认删除吗']}？" text="${views.common['delete']}" opType="ajax" callback="query" >${views.common['delete']}</soul:button>--%>
                            </td>
                        </tr>
                    </c:forEach>
                    <tr>
                        <td colspan="9">
                            <soul:button callback="goNext" target="${root}/cttDocumentI18n/create.html?search.documentId=${p.id}"
                                         data-toggle="modal" data-target="#add-pages" opType="dialog" text="+${views.content['document.addChild']}"
                                         title="${views.content['document.addChild']}—${cacheMap[p.id.toString()].title}"></soul:button>
                        </td>
                    </tr>
                </tbody>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
