<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<head>
    <%--<title>${views.share_auto['筛选管理']}</title>--%>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form:form>
    <div id="validateRule" style="display: none">${validateRule}</div>
    <div class="modal-body">
        <div class="condition-wraper m-b-sm">
            <span id="condition">${views.common['filter.condition']}</span>
            <a href="javascript:void(0)" class="add pull-right">${views.common['filter.create']}</a>
            <a href="javascript:void(0)" class="cancel-create pull-right" style="display: none;">${views.common['filter.cancel']}</a>
        </div>
        <div class="condition-options-wraper sx" style="display: none" id="template">
            <div class="clearfix condition-chunk" >
                <span class="con-title">${views.common['filter.condition']}：</span>
                <c:set value="${filterList[0]}" var="fistFilterCondition"/>
                <div class="wjcj">
                    <select name="property" class="btn-group chosen-select-no-single1" callback="selectChange">
                        <option value="">${views.common['pleaseSelect']}</option>
                        <c:forEach items="${filterList}" var="fl">
                            <option value="${fl.property}">${fl.propertyName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="wjcj">
                    <select name="operator" class="btn-group chosen-select-no-single1" callback="reFillDescription">
                        <option value="">${views.common['pleaseSelect']}</option>
                        <c:forEach items="${fistFilterCondition.compare}" var="map">
                            <option value="${map.key}">${map.value}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="wjcj">
                </div>

                <a href="javascript:void(0)" class="recover"><i class="fa fa-trash-o"></i></a>
                <input type="hidden" name="tabType" value="${fistFilterCondition.tabType}"/>
            </div>
        </div>
        <div class="condition-options-wraper sx" id="columnOp" style="display:none">
            <div class="clearfix">
                <a href="javascript:void(0)" id="cloneCondition" style="visibility: visible">+${views.common['filter.add']}</a>
                <span class="zd" style="display: none;"><i class="fa fa-warning m-r-xs"></i>${fn:replace(views.common['filter.more'], "{count}", "10")}</span>
            </div>
            <div class="clearfix save">
                <label class="mc">
                    <input type="checkbox" class="i-checks" id="saveCk">
                    <span class="co-blue m-r">${views.common['filter.save']}</span>${views.common['filter.name']}：
                    <input type="text" placeholder="" name="description" class="form-control" style="width: 300px;"/>
                </label>
            </div>
            <div class="clearfix">
                <input type="hidden" name="id">
                <soul:button tag="button" target="createNewFilter" cssClass="btn btn-filter hide" opType="function" precall="_validateForm" text="${views.common['filter.submit']}"></soul:button>
                <button type="button" class="btn btn-outline btn-filter hide" id="resetElement">${views.common['filter.quit']}</button>

            </div>
        </div>
        <div class="edit" style="display: none;">
            <a href="javascript:void(0)"><i class="fa fa-edit"></i></a>
            <a href="javascript:void(0)"><i class="fa fa-trash-o"></i></a>
            <a href="javascript:void(0)"><i class="fa fa-check"></i></a>
        </div>
        <div class="condition-wraper m-b-sm" style="padding-top: 10px;">
            <span >${views.common['filterUseTmp']}</span>
        </div>
            <ul class="condition condition-scroll ${fn:length(filters)<1?'no-content_wrap':''}">
                <c:forEach items="${filters}" var="filterItem">
                    <li filterId="${filterItem.id}">
                        <div class="pull-left template-name" style="width: 84%;">
                            <c:if test="${fn:length(filterItem.description)>20}">
                                <label title="${filterItem.description}"><c:out value="${fn:substring(filterItem.description,0,20)}"/>...</label>
                            </c:if>
                            <c:if test="${fn:length(filterItem.description)<=20}">
                                <label><c:out value="${filterItem.description}"/></label>
                            </c:if>
                            <input type="hidden" name="isSelect" value="0" id="hidden_row_${filterItem.id}"/>
                        </div>
                        <div class="edit pull-right" id="id${filterItem.id}"  style="width: 15%;">
                            <a href="javascript:void(0)"><i class="fa fa-edit"></i></a>
                            <a href="javascript:void(0)"><i class="fa fa-trash-o"></i></a>
                        </div>

                        <input type="hidden" value="<c:out value='${filterItem.id}'/>"/>
                    </li>
                </c:forEach>
                <div id="nofilters" style="display: ${fn:length(filters)<1?'block':'none'}">${views.common['filter.have.no.filters']}</div>
            </ul>

    </div>
    <div class="modal-footer">
        <input type="hidden" name="keyClassName" value="${keyClassName}" >
        <input type="hidden" value="${goFilterUrl}" id ="goFilterUrl"/>
        <soul:button tag="button" causeValidate="false" target="goFilter" precall="_validateForm" cssClass="btn btn-filter" opType="function" text="${views.common['filter.query']}"></soul:button>
    </div>
    <gb:dateRange format="${DateFormat.DAY_SECOND}" style="display:none;width:190px" useToday="true"
                  name="value" id="dateTemp" callback="reFillDescription" ></gb:dateRange>

</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="gb/share/ListFiltersPage"/>
<script type="application/javascript">
    var jsonList = '${jsonFilterList}';
    var _locale = "<%=SessionManager.getLocale()%>";
</script>
</html>
