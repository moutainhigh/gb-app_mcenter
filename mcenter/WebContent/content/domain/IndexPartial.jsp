<%--@elvariable id="command" type="so.wwb.gamebox.model.company.sys.vo.SysDomainListVo"--%>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <%--<form:hidden path="search.type"/>--%>
    <table class="table table-striped table-hover dataTable m-b-sm" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th><input type="checkbox" class="i-checks"></th>
            <th>${views.common['number']}</th>
            <th>${views.content['domain.name']}</th>
            <%--<th>${views.content['domain.zxym']}</th>--%>
            <th class="inline">
                <select btnStyle="width: 100%" ulStyle="width: 100%" class="chosen-select-no-single btn-group days" callback="query" name="search.pageUrl">
                    <option value="">${views.content['全部']}</option>
                    <c:forEach items="${command.domainTypes}" var="type" >
                        <option value="${type.paramValue}" ${type.paramValue eq command.search.pageUrl?'selected':''}>${views.content[type.resourceKey]}</option>
                    </c:forEach>
                </select >
            </th>
            <th>${views.content['domain.xlym']}</th>
            <th>${views.content['用该域名生成总代及代理推广链接']}</th>
            <th>${views.content['domain.bd']}</th>
            <th>${views.content['domain.status']}</th>
            <%--<th>${views.content['isEnable']}</th>--%>
            <th>${views.common['operate']}</th>
        </tr>
        <tr class="bd-none hide">
            <th colspan="6">
                <div class="select-records"><i
                        class="fa fa-exclamation-circle"></i>${views.role['player.cancelSelectAll.prefix']}&nbsp;<span
                        id="page_selected_total_record"></span>${views.role['player.cancelSelectAll.middlefix']}
                    <soul:button target="cancelSelectAll" opType="function"
                                 text="${views.role['player.cancelSelectAll']}"/>${views.role['player.cancelSelectAll.suffix']}
                </div>
            </th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${empty command.result}">
            <td colspan="7" class="no-content_wrap" style="margin-right: 48px">

                <div>
                    <i class="fa fa-exclamation-circle"></i> ${views.common['noResult']}
                </div>
            </td>
        </c:if>
        <c:forEach items="${command.result}" varStatus="status" var="s">
            <tr>
                <td>
                    <c:if test="${s.isDefault==false&&'/mcenter/index.html' ne s.pageUrl}">
                        <input type="checkbox" value="${s.id}" class="i-checks${s.isEnable ? ' domain_enable':''}"></td>
                    </c:if>
                <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                <td>
                        ${s.name}
                </td>
                <td>
                    <c:forEach items="${command.domainTypes}" var="type">
                        <c:if test="${type.defaultValue eq s.pageUrl}">
                            ${views.content[type.resourceKey]}
                        </c:if>
                    </c:forEach>
                        ${s.isDefault?"<span class='badge badge-blue m-l-xs'>".concat(views.content_auto['默认']).concat("</span>"):""}

                </td>
                <td>${s.domain}</td>
                <td>${s.forAgent? views.content_auto['是']:views.content_auto['否']}</td>
                <td class="resolve" style="color: ${s.resolveStatus=='6'?'red':''};">${dicts.content.resolveStatus[s.resolveStatus]}</td>
                <c:choose>
                    <%--绑定中，解绑中，失败的域名状态显示为“--”；--%>
                    <c:when test="${s.resolveStatus=='5'}">
                        <td class="_enable${s.isEnable ? '':' hide'}">
                            <span class="label label-green">${views.content['domain.enable']}</span>
                        </td>
                        <td class="co-grayc2 _disabled${not s.isEnable ? '':' hide'}">
                            <span class="label">${views.content['domain.disallow']}</span>
                        </td>
                    </c:when>
                    <c:otherwise>
                        <td>
                            <span>---</span>
                        </td>
                    </c:otherwise>
                </c:choose>


                <%--<td>
                        <c:choose>
                            <c:when test="${s.resolveStatus eq '5'&&!s.isDefault}">
                                <input  type="checkbox" name="my-checkbox" value="${s.id}" data-size="mini"  ${s.isEnable?'checked':''} >
                            </c:when>
                            <c:otherwise>
                                ---
                            </c:otherwise>
                        </c:choose>
                </td>--%>
                <td>
                        <%--待绑定，绑定中，待解绑，解绑中和失败的域名不支持编辑和开关，隐藏编辑按钮和开关--%>
                        <c:if test="${s.resolveStatus=='5'}">
                            <c:choose>
                                <c:when test="${(s.pageUrl == '/' || s.pageUrl == '/netLine/findLines.html') && !s.isDefault}">
                                    <soul:button permission="content:domain_defaultedit" target="${root}/content/sysDomain/domainEdit.html?id=${s.id}"
                                                 text="${views.common['edit']}" tag="a" opType="dialog"
                                                 callback="query">${views.common['edit']}</soul:button>
                                </c:when>
                                <c:otherwise>
                                    <soul:button permission="content:domain_defaultedit" target="${root}/content/sysDomain/editName.html?search.id=${s.id}"
                                                          text="${views.common['edit']}" tag="a" opType="dialog"
                                                          callback="query">${views.common['edit']}</soul:button>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                        <%--删除--%>
                    <c:choose>
                        <c:when test="${s.resolveStatus=='1'||s.resolveStatus=='6'}">
                            <soul:button target="${root}/content/sysDomain/delDomain.html?result.id=${s.id}&result.code=${s.code}"
                                         precall="deleteMessage" callback="query" text="${views.common['delete']}"
                                         opType="ajax" cssClass="co-blue"/>
                            <%--<soul:button target="${root}/content/sysDomain/mainManagerEdit.html?search.id=${s.id}" text="${views.common['delete']}" tag="a" opType="dialog" callback="query"></soul:button>--%>
                        </c:when>
                        <c:otherwise>
                            <%--解绑--%>
                            <c:if test="${s.resolveStatus=='5'&& (!s.isDefault || (s.isDefault && s.pageUrl eq '/index/cname.html'))}">
                                <soul:button
                                        target="${root}/content/sysDomain/changeResolveStatus.html?result.id=${s.id}&result.resolveStatus=3&result.domain=${s.domain}&domainPlatform=site&result.code=${s.code}"
                                        text="${views.content['sysdomain.unbundling']}"
                                        precall="resolveConfirmMessage" callback="query" opType="ajax"
                                        cssClass="co-blue"/>
                            </c:if>
                            <%--取消--%>
                            <c:if test="${s.resolveStatus=='3'}">
                                <soul:button
                                        target="${root}/content/sysDomain/changeResolveStatus.html?result.code=${s.code}&result.resolveStatus=5&result.id=${s.id}"
                                        precall="cancelMessage" callback="query" text="${views.common['cancel']}"
                                        opType="ajax" cssClass="co-blue"/>
                            </c:if>
                            <c:if test="${s.resolveStatus=='2'||s.resolveStatus=='4'}">
                                      ---
                            </c:if>
                        </c:otherwise>
                    </c:choose>

                        <%--<soul:button target="${root}/content/sysDomain/deleteDomain.html?ids=${s.id}" text="${views.common['edit']}" tag="a" confirm="${s.isEnable ? message.content['domain.deleteEnable']:message.content['domain.delete']}" opType="ajax" callback="query">${views.common['delete']}</soul:button>--%>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination cssClass="bdtop3"/>
<!--//endregion your codes 1-->
