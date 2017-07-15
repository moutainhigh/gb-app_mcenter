
<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-8-27
  Time: 下午2:23
--%>
<%--@elvariable id="vPayAccountListVo" type="so.wwb.gamebox.model.master.content.vo.VPayAccountListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
    <form:form>
    <div class="modal-body">
        <div id="validateRule" style="display: none">${vPayAccountListVo.validateRule}</div>
    <div class="form-group clearfix m-b-xxs">
        <label class="col-xs-3  al-right line-hi34">${views.content['payAccount.hideSetting.title']}</label>
        <div class="col-xs-8 p-x">
            <input type="checkbox" data-size="mini" ${vPayAccountListVo.playerAccountHide.paramValue eq 'true' ? 'checked':''} data-off-text="${views.content['payAccount.hideSetting.switch.off']}" data-on-text="${views.content['payAccount.hideSetting.switch.on']}" name="my-checkbox" class="i-checks">
            <input type="hidden" name="playerAccountHide.id" value="${vPayAccountListVo.playerAccountHide.id}">
            <input type="hidden" value="${vPayAccountListVo.playerAccountHide.paramValue}" name="playerAccountHide.paramValue" class="playerAccountHide"/>
            <input type="hidden" value="${vPayAccountListVo.playerAccountHide.paramValue}" name="isShow" class="playerAccountHide"/>
            <input type="hidden" value="${vPayAccountListVo.playerAccountHide.id}" name="playerAccountHide.id"/>
            <span tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover"  data-trigger="focus" data-placement="right" data-content="${views.content['payAccount.hideSetting.help']}">
                <i class="fa fa-question-circle"></i>
            </span>
        </div>
    </div>
    <div class="form-group clearfix m-b-sm">
        <label class="col-xs-3  al-right line-hi34">${views.content['payAccount.hideSetting.contentTitle']}</label>
        <div class="col-xs-8 p-x">
            <c:forEach items="${vPayAccountListVo.siteLanguages}" var="lang" varStatus="status">
                <c:set var="hasSiteI18n" value="0"></c:set>
                <c:forEach items="${vPayAccountListVo.siteI18ns}" var="i18n">
                    <c:if test="${i18n.locale eq lang.language}">
                        <c:set var="hasSiteI18n" value="1"></c:set>
                        <div class="input-group date${status.last ? '':' m-b-sm'}">
                            <span class="input-group-addon">${fn:substringBefore(dicts.common.language[lang.language], '#')}</span>
                            <input type="text" class="form-control lang" data-lang="${lang.language}" name="siteI18ns[${status.index}].value" value="${i18n.value}">
                        </div>
                    </c:if>
                </c:forEach>
                <c:if test="${hasSiteI18n eq '0'}">
                    <div class="input-group date${status.last ? '':' m-b-sm'}">
                        <span class="input-group-addon">${fn:substringBefore(dicts.common.language[lang.language], '#')}</span>
                        <input type="text" class="form-control lang" data-lang="${lang.language}" name="siteI18ns[${status.index}].value" value="">
                    </div>
                </c:if>
                <input type="hidden" class="form-control" name="siteI18ns[${status.index}].locale" value="${lang.language}">
            </c:forEach>
        </div>
    </div>
    <div class="form-group clearfix m-b-sm">
        <label class="col-xs-3  al-right line-hi34">${views.content['payAccount.hideSetting.previewTitle']}</label>
        <div class="col-xs-8 p-x">
            <div class="input-group date">
                <div class="preview_wrap clearfix shadow">
                    <div class="img p-sm border-b-1"><i class="pay-bank icbc"></i><span class="label label-info m-l">${views.content['payAccount.hideSetting.carType']}</span></div>
                    <div class=" clearfix con p-sm">

                        <span class="co-yellow ft-bold">${views.content['payAccount.hideSetting.exampleCode']}</span>
                        <span class="m-l-sm"><a href="javascript:void(0)" class="preview">${empty vPayAccountListVo.siteI18ns ? '' :vPayAccountListVo.siteI18ns.get(0).value}</a></span>
                        <span class="pull-left m-t-sm">${views.content['payAccount.hideSetting.example']}</span>
                    </div>
                </div>
                <span class="input-group-addon bdn">
                     <soul:button target="changeLang" text="" opType="function" cssClass="btn btn-default">
                         ${views.content['payAccount.hideSetting.changeLang']}
                     </soul:button>
                </span>
            </div>
        </div>
    </div>
    <div class="form-group clearfix m-b-xxs line-hi34">
        <label class="col-xs-3  al-right">
            ${views.content['payAccount.hideSetting.handle']}
        </label>
        <div class="col-xs-8 p-x">
            <span class="pull-left">

                <input type="hidden" value="${vPayAccountListVo.handleCustomerService.id}" name="handleCustomerService.id">
                <select class="btn-group chosen-select-no-single" name="handleCustomerService.paramValue">
                <option value="" ${empty vPayAccountListVo.handleCustomerService.paramValue ? 'selected':''}>
                    ${views.common['pleaseSelect']}
                </option>
                <c:forEach items="${vPayAccountListVo.customerListVo.result}" var="s">

                    <option <c:if test="${vPayAccountListVo.handleCustomerService.paramValue eq s.id}">
                        selected
                    </c:if> value="${s.id}">${s.name}</option>
                </c:forEach>
            </select>
            </span>
            <span>
                <soul:button target="manageService" cssClass="m-l-sm" text="" tag="a" opType="function">
                    ${views.common['manage']}
                </soul:button>
        </div>
    </div>
    <div class="form-group clearfix m-b-xxs">
        <label class="col-xs-3  al-right line-hi34">
                ${views.content['使用账户：']}
        </label>
        <div class="col-xs-8 p-x" style="padding-top: 5px;">
            <c:forEach items="${sysParams}" var="p">
                <label>
                    <input type="checkbox" name="params" class="i-checks" ${p.paramValue == 'true' ? 'checked':''} value="${p.paramValue}" data-id="${p.id}">
                    ${views.content['payAccountHide.'.concat(p.paramCode)]}
                </label>&nbsp;
                <input type="hidden" name="${p.paramCode}.id" value="${p.id}">
                <input type="hidden" name="${p.paramCode}.paramValue" value="${p.paramValue}" id="p_${p.id}"/>
            </c:forEach>
        </div>
    </div></div>

    <div class="modal-footer">
        <soul:button target="${root}/vPayAccount/resetHide.html" post="getCurrentFormData" precall="validateForm" text="" opType="ajax" cssClass="btn btn-filter" tag="button" callback="closePage">${views.content['payAccount.hideSetting.apply']}</soul:button>
        <soul:button target="closePage" text="${views.common['cancel']}" opType="function" cssClass="btn btn-outline btn-filter"></soul:button>
    </div>
    </form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/content/payaccount/HideSetting"/>
</html>
