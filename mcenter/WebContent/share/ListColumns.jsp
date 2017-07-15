<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<link rel="stylesheet" type="text/css" href="${resRoot}/themes/operator.css"/>
<!--更多数据：排序-->

    <div class="clearfix">
        <div class="pull-left zszd">
			<div class="zszd-title">
            <span>${views.common["DynamicLie.showField"]}

            </span>
                <a  id="defaultOperator" cleanMsg="${views.common["DynamicLie.cleanMsg"]}" default-table-msg="${views.common["DynamicLie.defaultTable"]}" href="javascript:void(0)">${views.common["DynamicLie.defaultSetting"]}</a>
            </div>
            <ul class="clearfix">
                <c:forEach items="${defaultFeilds}" var="p" varStatus="status">
                    <%--<c:if test="${p.value.showColumn==true}">
                        <li><label><input data-val="${p.value.feildName}" name="content" checked="checked" disabled="disabled" type="checkbox"> ${views.column[p.value.displayName]}</label></li>
                    </c:if>
                    <c:if test="${p.value.showColumn != true}">
                        <li><label><input data-val="${p.value.feildName}" name="content" <c:if test="${hasFeilds[p.value.feildName] == true ? true:false }">checked="checked"</c:if> type="checkbox"> ${views.column[p.value.displayName]}</label></li>
                    </c:if>--%>

                    <c:if test="${lists.size()==0}">
                        <c:if test="${(p.value.feildType < 2) && (p.value.showColumn == true)}">
                            <li><label><input data-val="${p.value.feildName}" name="content" checked="checked" disabled="disabled" type="checkbox"> ${views.column[p.value.displayName]}</label></li>
                        </c:if>
                        <c:if test="${(p.value.feildType >= 2) && (p.value.showColumn == true)}">
                            <li><label><input data-val="${p.value.feildName}" name="content" checked="checked" type="checkbox"> ${views.column[p.value.displayName]}</label></li>
                        </c:if>
                        <c:if test="${(p.value.feildType >= 2) && (p.value.showColumn != true)}">
                            <li><label><input data-val="${p.value.feildName}" name="content" type="checkbox"> ${views.column[p.value.displayName]}</label></li>
                        </c:if>
                    </c:if>

                    <c:if test="${lists.size()>0}">
                        <c:choose>
                            <c:when test="${p.value.feildType<2}">
                                <li><label><input data-val="${p.value.feildName}" name="content" checked="checked" disabled="disabled" type="checkbox"> ${views.column[p.value.displayName]}</label></li>
                            </c:when>
                            <c:otherwise>
                                <li><label><input data-val="${p.value.feildName}" name="content" <c:if test="${hasFeilds[p.value.feildName] == true ? true:false }">checked="checked"</c:if> type="checkbox"> ${views.column[p.value.displayName]}</label></li>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </c:forEach>
            </ul>
        </div>
        <c:choose>
            <c:when test="${lists.size()==0}">
                <div id="addDefault" >
                    <div class="pull-left dd" id="default1">
                        <label class="font-noraml zs_list_title table_row" list-default="defaults" rel-id="" rel-data="${views.share_auto['默认列表']}">${views.common["DynamicLie.defaultTable"]}</label>
                        <ul id="add0" class="zs_list dd-list ul-list" >
                            <c:forEach items="${defaultFeilds}" var="c" varStatus="status">
                                <%--<c:if test="${(c.value.feildType==0) && (c.value.showColumn==true)}">
                                    <li data-value="${c.value.feildName}" class="dd-item"><a href="javascript:void(0)" class="co-orange dd-nodrag">${views.column[c.value.displayName]}</a></li>
                                </c:if>
                                <c:if test="${(c.value.feildType>0) && (c.value.showColumn==true)}">
                                    <li data-value="${c.value.feildName}" class="dd-item"><a href="javascript:void(0)" class="default dd-handle">${views.column[c.value.displayName]}</a></li>
                                </c:if>--%>

                                <c:if test="${c.value.showColumn == true}">
                                    <c:if test="${c.value.feildType==0}">
                                        <li data-value="${c.value.feildName}" class="dd-item"><a href="javascript:void(0)" class="co-orange dd-nodrag">${views.column[c.value.displayName]}</a></li>
                                    </c:if>
                                    <c:if test="${c.value.feildType==1}">
                                        <li data-value="${c.value.feildName}" class="dd-item"><a href="javascript:void(0)" class="default dd-handle">${views.column[c.value.displayName]}</a></li>
                                    </c:if>
                                    <c:if test="${c.value.feildType==2}">
                                        <li data-value="${c.value.feildName}" class="dd-item"><a href="javascript:void(0)" class="dd-handle">${views.column[c.value.displayName]}</a></li>
                                    </c:if>

                                </c:if>

                            </c:forEach>
                            <li class="dd-item empty-item"></li>
                        </ul>
                    </div>
                    <div class="pull-left dd" id="default2"></div>
                    <div class="pull-left dd" id="default3"></div>
                </div>
            </c:when>
            <c:otherwise>
                <div id="addDefault">
                    <c:forEach items="${lists}" var="s" varStatus="vs">
                        <div class="pull-left dd" id="default${vs.index + 1}">
                            <c:if test="${vs.index==0}">
                                <label class="font-noraml zs_list_title table_row" list-default="defaults" rel-data="${s.value.description}" rel-id="${s.value.id}">${s.value.description}<i id="delete${vs.index + 1}" ></i></label>
                            </c:if>
                            <c:if test="${vs.index!=0}">
                                <label class="font-noraml zs_list_title table_row" rel-data="${s.value.description}" rel-id="${s.value.id}">${s.value.description}<i id="delete${vs.index + 1}" class="fa fa-trash-o" style="cur"></i></label>
                            </c:if>
                            <ul id="add${vs.index}" class="zs_list dd-list ul-list" data-id="${s.value.id}">
                                <c:forEach items="${s.value.mapContent}" var="c" varStatus="status">
                                    <c:choose>
                                        <c:when test="${defaultFeilds[c.name].showColumn==true}">
                                            <%--<c:if test="${(defaultFeilds[c.name].feildType==0)&&(defaultFeilds[c.name].showColumn==true)}">
                                                <li class="dd-item" data-value="${c.name}" order="${c.order}"><a style="background:#f5f5f5 none repeat scroll 0 0;" class="co-orange" href="javascript:void(0)">  ${views.column[defaultFeilds[c.name].displayName]}</a></li>
                                            </c:if>
                                            <c:if test="${(defaultFeilds[c.name].feildType >0)&&(defaultFeilds[c.name].showColumn==true)}">
                                                <li class="dd-item" data-value="${c.name}" order="${c.order}"><a class="default dd-handle"  style="background: -webkit-linear-gradient(top, #fafafa 0%, #eee 100%);  font-weight: bold;" href="javascript:void(0)">  ${views.column[defaultFeilds[c.name].displayName]}</a></li>
                                            </c:if>--%>

                                            <c:if test="${defaultFeilds[c.name].feildType==0}">
                                                <li class="dd-item" data-value="${c.name}" order="${c.order}"><a style="background:#f5f5f5 none repeat scroll 0 0;" class="co-orange" href="javascript:void(0)">  ${views.column[defaultFeilds[c.name].displayName]}</a></li>
                                            </c:if>
                                            <c:if test="${defaultFeilds[c.name].feildType==1}">
                                                <li class="dd-item" data-value="${c.name}" order="${c.order}"><a style="background:#f5f5f5 none repeat scroll 0 0;" class="default" href="javascript:void(0)">  ${views.column[defaultFeilds[c.name].displayName]}</a></li>
                                            </c:if>
                                            <c:if test="${defaultFeilds[c.name].feildType==2}">
                                                <li class="dd-item" data-value="${c.name}" order="${c.order}"><a class="dd-handle" href="javascript:void(0)">  ${views.column[defaultFeilds[c.name].displayName]}</a></li>
                                            </c:if>

                                        </c:when>
                                        <c:otherwise>
                                            <li class="dd-item" data-value="${c.name}" order="${c.order}"><a class="dd-handle" href="javascript:void(0)">  ${views.column[defaultFeilds[c.name].displayName]}</a></li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <li class="dd-item empty-item"></li>
                            </ul>
                        </div>
                    </c:forEach>
                    <c:if test="${lists.size()<3}">
                        <c:forEach begin="0" end="${2-lists.size()}" varStatus="vs">
                            <div class="pull-left dd" id="default${lists.size()+(vs.index+1)}"></div>
                        </c:forEach>
                    </c:if>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    <div class="clearfix complete">
        <input type="hidden" name="keyClassName" value="${keyClassName}" >
        <button type="button" id="submit" class="btn btn-filter">${views.common["DynamicLie.OKSetting"]}</button>
        <div class="pull-right">
            <a href="javascript:void(0)" class="co-orange m-r">${views.common["DynamicLie.draggingSort"]}</a>
            <button type="button" id="add_List" new-Table-msg="${views.common["DynamicLie.newTable"]}" class="btn add-list"><i class="fa fa-plus"></i>&nbsp;&nbsp;${views.common["DynamicLie.addTable"]}</button>
        </div>
    </div>
    <div class="trigger" style="display: none;" >
        <label id="" class="zs_list_title">${views.common["DynamicLie.newTable"]}<i class="fa fa-trash-o"></i></label>
        <ul class="zs_list dd-list">
            <c:forEach items="${defaultFeilds}" var="c" varStatus="status">
                <c:if test="${c.value.showColumn==true}">
                    <c:if test="${c.value.feildType==0}">
                        <li data-value="${c.value.feildName}" class="dd-item"><a style="background:#f5f5f5 none repeat scroll 0 0;" href="javascript:void(0)" class="co-orange">${views.column[c.value.displayName]}</a></li>
                    </c:if>
                    <c:if test="${c.value.feildType==1}">
                        <li data-value="${c.value.feildName}" class="dd-item"><a style="background:#f5f5f5 none repeat scroll 0 0;" href="javascript:void(0)" class="default">${views.column[c.value.displayName]}</a></li>
                    </c:if>
                    <%--<c:if test="${c.value.feildType==2}">
                        <li data-value="${c.value.feildName}" class="dd-item"><a href="javascript:void(0)" class="dd-handle">${views.column[c.value.displayName]}</a></li>
                    </c:if>--%>
                </c:if>
            </c:forEach>
            <li class="dd-item empty-item"></li>
        </ul>
    </div>

<script type="text/javascript">
    curl(['gb/share/ListColumnsPage'], function(ListColumnsPage) {
        listColumnsPage = new ListColumnsPage();
    });
</script>