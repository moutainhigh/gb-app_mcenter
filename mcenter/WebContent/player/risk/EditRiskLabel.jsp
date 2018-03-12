<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VUserPlayerVo"--%>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${views.common['edit']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<!--编辑弹窗-->
<form:form action="${root}/player/saveRiskLabel.html?search.id=${command.search.id}&ajax=true" method="post">
    <div id="validateRule" style="display: none">${validateRule}</div>
    <div class="modal-body">
        <div class="form-group status">
            <label>${views.column['VUserPlayer.label']}：</label>
            <!--已选择标签显示区域-->
                <span id="playerSelectTag">
                    <c:forEach var="risk" items="${command.result.riskSet}">
                            <span class="fa fa-check"  tagid="${risk}" id="tag_${risk}">
                                  ${dicts.player.risk_data_type[risk]}
                            </span>
                    </c:forEach>
                </span>
        </div>

        <!--所有标签，玩家已有标签高亮显示-->
        <div class="li-tag clearfix m-t-n-xs m-l-n-xs">
             <c:forEach var="risk" items="${riskDicts}">
                    <a class="${command.result.riskSet.contains(risk.value.dictCode)?'selected':''}" href="javascript:void(0)"
                       tagSelected="tagSelected" tagid="${risk.value.dictCode}">${dicts.player.risk_data_type[risk.value.dictCode]}
                        <i class="fa fa-check"></i></a>
                </c:forEach>
        </div>
        <input id="riskDataType" name="result.riskDataType" value="" type="hidden"/>
        <input name="result.oldRiskDataType" value="${result.riskDataType}" type="hidden"/>
        <form:hidden path="result.id" value="${command.search.id}"/>

    </div>
    </div>

    <div class="modal-footer">
            <soul:button cssClass="btn btn-outline btn-filter" text="${views.common['save']}" opType="function"
                         target="saveRiskLabel" />
        <soul:button cssClass="btn btn-outline btn-filter" text="${views.common['cancel']}" opType="function"
                     target="closePage"/>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/vuserplayer/userPlayer"/>
</html>