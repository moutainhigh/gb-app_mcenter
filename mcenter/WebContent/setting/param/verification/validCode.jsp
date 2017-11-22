<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<div class="form-group clearfix m-t-lg">
    <div style="width: 100px;float: left;text-align: right"><label class="al-right line-hi34 ft-bold">${views.setting['SiteParam.verification.style']}：</label></div>
    <%--<label class="col-xs-3 al-right line-hi34 ft-bold">${views.setting['SiteParam.verification.style']}：</label>--%>
    <div class="col-xs-5">
        <div class="btn-group" style="margin-top: -34px;">
            <button type="button" class="btn btn-default verification-btn" style="z-index: 9">
                <img id="captchaStyleImg"
                     src="${resComRoot}/images/captcha/${empty captchaStyleParam.paramValue ? captchaStyleParam.defaultValue : captchaStyleParam.paramValue}.jpg" height="32"></button>
            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="caret"></span>
                <span class="sr-only">Toggle Dropdown</span>
            </button>
            <ul class="dropdown-menu verification-menu">
                <c:forEach items="${captchaStyleParams}" var="p" varStatus="status">
                    <li class="yzmSelect"><a href="javascript:void(0)"><img tt="${p.paramCode}" height="34" width="93" src="${resComRoot}/${p.defaultValue}"></a></li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
<div class="form-group clearfix">
    <div style="width: 100px;float: left;text-align: right">
        <label class="al-right line-hi34 ft-bold">${views.setting['SiteParam.verification.excludeContent']}：</label>
    </div>
    <div class="col-xs-5">
        <input type="text" name="captchaExclusions" value="${captchaExclusionsParam.paramValue}" class="form-control">
    </div>
</div>
<div class="form-group clearfix">
    <div style="width: 100px;float: left;text-align: right">
        <label class="al-right line-hi34 ft-bold">${views.setting['SiteParam.verification.gimpy']}：</label>
    </div>
    <div class="col-xs-5">
        <input
                type="checkbox"
                data-size="mini"
                name="captchaGimpy"
                value="NoGimpy"
                ${captchaGimpyParam.paramValue == "NoGimpy" ? "checked" : ""}>
        <%--<span class="pull_right">--%>
            <%--<img id="captchaStyleNoGimpyImg"--%>
                     <%--src="${resComRoot}/images/captcha/nogimpy_${empty captchaStyleParam.paramValue ? captchaStyleParam.defaultValue : captchaStyleParam.paramValue}.jpg" height="32"></button>--%>

        <%--</span>--%>
    </div>
</div>
<div class="modal-footer">
    <input type="hidden" value="${captchaStyleParam.id}" name="captchaStyleId" id="captchaStyleId">
    <input type="hidden" value="${captchaStyleParam.paramValue}" name="captchaStyle" id="captchaStyle">
    <input type="hidden" value="${captchaExclusionsParam.id}" name="captchaExclusionsId">
    <input type="hidden" value="${captchaGimpyParam.id}" name="captchaGimpyId">
    <soul:button cssClass="btn btn-filter" text="${views.common['save']}" opType="ajax" dataType="json"
                 target="${root}/param/saveCaptcha.html" precall="validateForm"  post="getValidCodeFormData" callback="saveCallbak" />
</div>