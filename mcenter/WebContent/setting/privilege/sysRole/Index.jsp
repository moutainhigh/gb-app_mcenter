<%--@elvariable id="command" type="org.soul.model.security.privilege.vo.SysRoleListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="position-wrap clearfix">
    <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
    <span>${views.sysResource['系统设置']}</span><span>/</span><span>${views.sysResource['角色管理']}</span>
</div>
<form:form action="${root}/msysRole/list.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <div class="panel panel-default">
        <div class="panel-body">
            <div class="row">
                <label class="col-md-1 control-label" for="search.name">${views.role['page.role.name']}</label>
                <div class="col-md-2">
                    <form:input class="form-control" path="search.name" placeholder="${views.role['page.role.input']}"/>
                </div>
                <div class="col-md-1">
                    <soul:button tag="button" target="query" cssClass="btn btn-primary-hide" text="${views.common['query']}" opType="function">
                        <span class="hd">${views.common['query']}</span>
                    </soul:button>
                    <%--<soul:button target="query" opType="function" text="${views.setting_auto['查询']}" cssClass="btn btn-default" />--%>
                </div>
                <div class="col-md-1">
                    <soul:button tag="button" target="${root}/msysRole/create.html" opType="dialog" text="${views.common['create']}" cssClass="btn btn-outline btn-filter" callback="query"/>
                </div>
                <%--<div class="col-md-1">
                    <soul:button tag="button" target="${root}/share/colSelector/index.html" opType="dialog" text="${views.setting_auto['字段']}" size="size-wide" cssClass="btn btn-outline btn-filter" />
                </div>
                <div class="col-md-1">
                    <form:select path="selectFields.id" class="selectpicker">
                        <c:forEach items="${command.allFieldLists}" var="f" varStatus="status">
                            <option value='${f.value["id"]}'>${f.value.id}</option>
                        </c:forEach>
                    </form:select>
                </div>--%>

            </div>

            <br/>
            <div class="search-list-container">
                <%@ include file="IndexPartial.jsp" %>
            </div>
        </div>
    </div>
</form:form>
<soul:import type="list"/>