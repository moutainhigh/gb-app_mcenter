<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.VCttDraftListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div id="editable_wrapper" class="dataTables_wrapper" role="grid">
    <div class="table-responsive">
        <table class="table table-striped table-hover dataTable m-b-sm" aria-describedby="editable_info">
            <thead>
            <tr role="row" class="bg-gray">
                <th>${views.content['项目名称']}</th>
                <th>${views.content['状态']}</th>
                <th>${views.content['语言版本']}</th>
                <th>${views.content['发布时间']}</th>
                <th>${views.content['子项目']}</th>
                <th>${views.content['是否启用']}</th>
                <th>${views.setting['common.operate']}</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${command.result}" var="p" varStatus="status">
                <tr class="tab-detail">
                    <td>${p.title}</td>
                    <td class="${p.status=='on'?'':'co-gray9'}">${dicts.content.draft_status[p.status]}</td>
                    <td>
                        <div class="btn-group">
                            <button data-toggle="dropdown" class="btn btn-warning dropdown-toggle btn-xs">${p.languageCount}/3</button>
                            <%--<ul class="dropdown-menu lang">--%>
                                <%--<li class="current"><a href="javascript:void(0)">${views.content_auto['简体中文']}</a></li> <!--已编辑样式-->--%>
                                <%--<li class="current"><a href="javascript:void(0)">English</a></li> <!--已编辑样式-->--%>
                                <%--<li><a href="javascript:void(0)">${views.content_auto['繁體中文']}</a></li>--%>
                            <%--</ul>--%>
                        </div>
                    </td>
                    <td>${soulFn:formatDateTz(p.publishTime, DateFormat.DAY_SECOND,timeZone)}</td>
                    <td><a href="javascript:void(0)" class="over">${p.childCount}${views.content['项']}<i></i></a></td>
                    <td><input type="checkbox" name="my-checkbox" data-size="mini" tt="${p.childId}"  ${p.status=='on'?'checked':''}></td>
                    <td>
                        <soul:button callback="goNext" target="${root}/cttDraft/create.html?search.childId=${p.childId}"
                                     data-toggle="modal" data-target="#add-pages" opType="dialog" text="${views.content_auto['编辑']}" title="${views.content_auto['编辑']}"></soul:button>
                    </td>
<%--                    <td><a href="/cttDraft/editContent.html?search.childId=${p.childId}" nav-target="mainFrame"> ${views.content_auto['编辑']}</a></td>--%>
                </tr>
                <tbody class="ng-hide" style="display:none">
                    <c:forEach items="${command.listDraft}" var="d" varStatus="st">
                        <c:if test="${p.childId eq d.parentId}">
                        <tr>
                            <td>${d.title}</td>
                            <td class="${d.status=='on'?'':'co-gray9'}">${dicts.content.draft_status[d.status]}</td>
                            <td>
                                <div class="btn-group">
                                    <button data-toggle="dropdown" class="btn btn-warning dropdown-toggle btn-xs">${d.languageCount}/3</button>
                                </div>
                            </td>
                            <td>${soulFn:formatDateTz(d.publishTime, DateFormat.DAY_SECOND,timeZone)}</td>
                            <td></td>
                            <td><input type="checkbox" name="my-checkbox" tt="${d.childId}" data-size="mini" ${d.status=='on'?'checked':''}></td>
                            <td>
                                <soul:button callback="goNext" target="${root}/cttDraft/create.html?search.childId=${d.childId}&search.parentId=${d.parentId}"
                                             data-toggle="modal" data-target="#add-pages" opType="dialog" text="${views.content_auto['编辑']}" title="${views.content_auto['编辑']}"></soul:button>
                            </td>
                        </tr>
                        </c:if>
                    </c:forEach>
                <tr>
                    <td>
                        <soul:button callback="query" target="${root}/cttDraft/create.html?search.parentId=${p.childId}"
                                     data-toggle="modal" data-target="#add-pages" opType="dialog" text="+${views.content_auto['新增子项']}" title="${views.content_auto['新增子项']}—${p.title}"></soul:button>
                    </td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                </tbody>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
