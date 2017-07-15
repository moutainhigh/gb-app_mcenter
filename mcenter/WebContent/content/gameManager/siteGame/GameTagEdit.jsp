<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${views.common['edit']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form>
<div class="modal-body">
    <div id="validateRule" style="display: none">${validate}</div>
    <div class="add-players">

            <c:forEach items="${command.gameTagMap}" var="gameTag" varStatus="status">
                <div class="category-list-wrap clearfix" data-key="${gameTag.key}">
                    <div class="clearfix">
                        <soul:button target="deleteGameTag" text="" opType="function" confirm="${views.content['game.tag.deleteTagConfirm']}"
                                     tag="button" cssClass="close" data="${gameTag.key}" buildIn="${gameTag.value.get(0).builtIn}">
                            <c:if test="${!gameTag.value.get(0).builtIn}">
                            <span aria-hidden="true">×</span>
                            <span class="sr-only">${views.common['close']}</span>
                            </c:if>
                        </soul:button>
                    </div>
                    <c:forEach items="${gameTag.value}" var="i18n" varStatus="vs">
                        <c:forEach items="${siteLang}" var="lang">
                        <c:if test="${lang.value.language==i18n.locale}">
                            <div class="form-group clearfix m-b-sm">
                                <label class="col-xs-3 al-right line-hi34">${fn:substringBefore(dicts.common.language[i18n.locale], '#')}：</label>
                                <div class="col-xs-8 p-x">
                                    <%--<input type="hidden" name="gruop[${status.index}].id[${vs.index}]" value="${i18n.id}">
                                    <input type="hidden" name="gruop[${status.index}].key[${vs.index}]" value="${i18n.key}">--%>
                                    <input type="text" class="form-control" name="gruop[${status.index}].locale[${vs.index}]" <c:if test="${i18n.builtIn}">readonly</c:if>
                                           data-name="gruop[{n}].locale[${vs.index}]" data-locale="${i18n.locale}" data-id="${i18n.id}" value="${i18n.value}">
                                </div>
                            </div>
                        </c:if>
                        </c:forEach>
                    </c:forEach>
                </div>
            </c:forEach>

        <soul:button target="addGameTag" text="" opType="function">
            <i class="fa fa-plus"></i>&nbsp;&nbsp;${views.content['game.tag.addTag']}
        </soul:button>
    </div>
</div>
<div class="modal-footer">
    <soul:button precall="myValidateForm" cssClass="btn btn-filter" callback="saveMyCallbak" text="${views.common['OK']}"
                 opType="ajax" dataType="json" target="${root}/siteGameTag/saveGameTagI18n.html" post="saveGameTagData"/>
    <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
</div>
</form>
<div style="display: none" id="addGameTag">
    <div class="category-list-wrap clearfix">
        <div class="clearfix">
            <soul:button target="deleteGameTag" text="" opType="function" tag="button" cssClass="close" confirm="${views.content['game.tag.deleteTagConfirm']}">
                <span aria-hidden="true">×</span>
                <span class="sr-only">${views.common['close']}</span>
            </soul:button>
        </div>
        <c:forEach items="${siteLang}" var="i" varStatus="vs">
            <div class="form-group clearfix m-b-sm">
                <label class="col-xs-3 al-right line-hi34">${fn:substringBefore(dicts.common.language[i.value.language], '#')}：</label>
                <div class="col-xs-8 p-x">
                    <%--<input type="hidden" name="gruop[0].id[${vs.index}]" value="">
                    <input type="hidden" name="gruop[0].key[${vs.index}]" value="">--%>
                    <input type="text" class="form-control" name="gruop[0].locale[${vs.index}]" data-name="gruop[{n}].locale[${vs.index}]" data-locale="${i.value.language}"/>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/content/gameManage/siteGame/GameTagEdit"/>
</html>