<%--@elvariable id="accountMap" type="java.util.Map<java.lang.String,so.wwb.gamebox.model.company.credit.po.CreditAccount>"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form name="creditPayForm">
    <gb:token/>
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont"></i> </a></h2>
            <span>${views.setting_auto['系统设置']}</span><span>/</span><span>${views.setting_auto['额度充值']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
                    <c:set var="rate" value="${useProfit<=0?0:useProfit*100/profit}"/>
                    <c:set var="transferRate" value="${0}"/>
                    <c:if test="${!empty currentTransferLimit && currentTransferLimit!=0}">
                        <c:set var="transferRate" value="${transferLimit<=0?0:transferLimit*100/currentTransferLimit}"/>
                    </c:if>
                    <c:choose>
                        <c:when test="${!empty leftTime && leftTime>0 && !disableTransfer}">
                            <div class="sys_tab_wrap p-xs">
                                <b class="fs16">${views.setting_auto['离后台维护还剩']}：</b><span class="fs20 ft-bold co-red" id="leftTime" data-time="${leftTime}"><span id="hour">00</span>:<span id="minute">00</span>:<span id="second"></span></span>
                            </div>
                        </c:when>
                        <c:when test="${(!empty leftTime && leftTime<=0) || disableTransfer}">
                            <div class="sys_tab_wrap p-xs">
                                <b class="fs16 co-red">${views.setting_auto['系统已关闭转账']}</b>
                            </div>
                        </c:when>
                    </c:choose>
                    <div class="filter-wraper limit-rec clearfix p-xs">
                        <div class="m-b-none col-xs-6 col-sm-7-1">
                            <div class="limit-price-wrap al-center clearfix">
                                <div class="bold-fs16 p-sm co-gray6" title="${views.setting_auto['当前额度上限']}">${views.setting_auto['当前额度上限']}</div>
                                <div class="fs20 p-b-sm al-center" title="${views.setting_auto['授信额度']}${creditLine}">${soulFn:formatCurrency(profit)}</div>
                            </div>
                        </div>
                        <div class="m-b-none col-xs-6 col-sm-7-1">
                            <div class="limit-price-wrap al-center clearfix">
                                <div class="bold-fs16 p-sm co-gray6" title="${views.setting_auto['已使用额度']}">${views.setting_auto['已使用额度']}
                                    <span tabindex="0" class="" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                                          data-html="true" data-content="${views.setting_auto['站点玩家累计转入API的总额度']}">
                                        <i class="fa fa-question-circle"></i>
                                    </span>
                                </div>
                                <div class="fs20 p-b-sm al-center co-blue">${soulFn:formatCurrency(useProfit)}</div>
                            </div>
                        </div>
                        <div class="m-b-none col-xs-6 col-sm-7-1">
                            <div class="limit-price-wrap al-center clearfix">
                                <div class="bold-fs16 p-sm co-gray6" title="${views.setting_auto['已使用']}">${views.setting_auto['已使用']}</div>
                                <div class="fs20 p-b-sm al-center co-red">${soulFn:formatInteger(rate)}%</div>
                            </div>
                        </div>
                        <c:if test="${!empty currentTransferLimit}">
                            <div class="m-b-none col-xs-6 col-sm-7-1">
                                <div class="limit-price-wrap al-center clearfix">
                                    <div class="bold-fs16 p-sm co-gray6" title="${views.setting_auto['转账上限']}">${views.setting_auto['转账上限']}
                                        <span tabindex="0" class="" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                                              data-html="true" data-content="${views.setting_auto['站点玩家累计转入API的额度上限']}">
                                            <i class="fa fa-question-circle"></i>
                                        </span>
                                    </div>
                                    <div class="fs20 p-b-sm al-center">${soulFn:formatCurrency(currentTransferLimit)}</div>
                                </div>
                            </div>
                            <div class="m-b-none col-xs-6 col-sm-7-1">
                                <div class="limit-price-wrap al-center clearfix">
                                    <div class="bold-fs16 p-sm co-gray6" title="${views.setting_auto['已使用额度']}">${views.setting_auto['已使用额度']}
                                        <span tabindex="0" class="" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                                              data-html="true" data-content="${views.setting_auto['当玩家将额度从APi转回至钱包时']}">
                                            <i class="fa fa-question-circle"></i>
                                        </span>
                                    </div>
                                    <div class="fs20 p-b-sm al-center co-blue">${soulFn:formatCurrency(transferLimit)}</div>
                                </div>
                            </div>
                            <div class="m-b-none col-xs-6 col-sm-7-1">
                                <div class="limit-price-wrap al-center clearfix">
                                    <div class="bold-fs16 p-sm co-gray6" title="${views.setting_auto['兑换已使用的百分比比例']}">${views.setting_auto['已使用的百分比']}</div>
                                    <div class="fs20 p-b-sm al-center co-red">${soulFn:formatInteger(transferRate)}%</div>
                                </div>
                            </div>
                        </c:if>
                        <div class="m-b-none col-xs-6 col-sm-7-1">
                            <div class="limit-price-wrap al-center clearfix">
                                <div class="bold-fs16 p-sm co-gray6" title="${views.setting_auto['兑换比例']}">${views.setting_auto['兑换比例']}</div>
                                <div class="fs20 p-b-sm al-center">1:${empty scaleParam.paramValue?'10':scaleParam.paramValue}</div>
                            </div>
                        </div>
                    </div>
                    <hr class="m-t-xxs m-b-sm">
                    <div class="clearfix">
                        <div class="panel-body col-xs-12 col-sm-10 col-md-8 col-lg-6 p-sm">
                            <div style="display:none" id="validateRule">${validateRule}</div>
                            <table class="no-border table-desc-list" style="width: 100%;">
                                <tbody>
                                <tr>
                                    <th scope="row" class="text-right" style="width: 150px;">${views.setting_auto['存款渠道']}：</th>
                                    <td>
                                        <div class="table-desc-right-t m-t-n-sm" style="width: 100%;min-width: 340px; max-width: 510px;">
                                            <c:choose>
                                                <c:when test="${not empty accountMap}">
                                                    <c:set var="banknames" value="${dicts.common.bankname}"/>
                                                    <c:forEach items="${accountMap}" var="i" varStatus="vs">
                                                        <label class="bank ${vs.index==0?'select':''}">
                                                            <span class="radio"><input name="result.bankName" type="radio" value="${i.key}" ${vs.index==0?'checked':''}/></span>
                                                            <span class="radio-bank" title="${banknames[i.key]}"><i class="pay-bank ${i.key}"></i></span>
                                                            <span class="bank-logo-name">${banknames[i.key]}</span>
                                                            <input name="min" type="hidden" value="${empty i.value.singleDepositMin?1:i.value.singleDepositMin}"/>
                                                            <input name="max" type="hidden" value="${empty i.value.singleDepositMax?99999999:i.value.singleDepositMax}"/>
                                                        </label>
                                                        <c:if test="${vs.index==0}">
                                                            <c:set var="singleMin" value="${empty i.value.singleDepositMin?1:i.value.singleDepositMin}"/>
                                                            <c:set var="singleMax" value="${empty i.value.singleDepositMax?99999999:i.value.singleDepositMax}"/>
                                                        </c:if>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <input name="result.bankName" type="hidden"/>
                                                </c:otherwise>
                                            </c:choose>

                                        </div>
                                        <%--  <div class="m-t-xs"><a href="javascript:void(0)"> ${views.setting_auto['展开更多']}</a></div>--%>
                                    </td>
                                </tr>

                                <tr>
                                    <th scope="row" class="text-right" style="width: 150px;" for="result.payAmount">${views.setting_auto['充值金额']}：</th>
                                    <td>
                                        <div class="table-desc-right-t">
                                            <input type="text" name="result.payAmount" id="result.payAmount" class="form-control"/>
                                            <div class="co-grayc2 m-t-sm">
                                                <c:if test="${not empty singleMin && not empty singleMax}">
                                                    ${fn:replace(fn:replace(views.setting_auto['请输入'],"{0}" ,singleMin),"{1}" , singleMax)}
                                                </c:if>
                                            </div>
                                            <div class="m-t-sm">
                                                <c:if test="${singleMax>=50000}">
                                                    <soul:button target="quickAmount" data="50000" cssClass="btn btn-info dropdown-toggle m-r-sm" text="5万" opType="function"/>
                                                </c:if>
                                                <c:if test="${singleMax>=100000}">
                                                    <soul:button target="quickAmount" data="100000" cssClass="btn btn-info-hide dropdown-toggle m-r-sm" text="10万" opType="function"/>
                                                </c:if>
                                            </div>
                                            <%-- <div class="m-t-md fs16">${views.setting_auto['您将获得']} <span class="co-green">50万</span> ${views.setting_auto['额度']}</div>--%>
                                            <div class="m-t-md">
                                                <c:choose>
                                                    <c:when test="${rate < 80 && authorizeStatus!=true}">
                                                        <soul:button target="submit" precall="validateForm" text="${views.setting_auto['确认']}" cssClass="btn btn-filter btn-lg btn-block" opType="function"/>
                                                    </c:when>
                                                    <c:when test="${rate >= 80}">
                                                        <soul:button target="submit" precall="validateForm" text="${views.setting_auto['确认']}" cssClass="btn btn-filter btn-lg btn-block" opType="function"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span tabindex="0" class="" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                                                              data-html="true" data-content="${views.setting_auto['站点当前已使用的额度上限未达到80']}">
                                                            <soul:button target="submit" precall="validateForm" text="${views.setting_auto['确认']}" cssClass="btn btn-filter btn-lg btn-block disabled" opType="function"/>
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="col-lg-6 col-md-4 col-sm-12 col-xs-12 limit-tips">
                            ${views.setting['credit.creditPay.help']}
                            <%--<ul>
                            <li>1、系统默认每月赠送50万额度；</li>
                            <li>2、当系统提示额度已使用完时，请在本页面自助充值，即可提升额度；</li>
                            <li>3、充值过程中若出现任何问题，请及时联系本平台24小时在线技术支持；</li>
                            <li>4、超额时，若24小时后仍未处理，则站点玩家将无法向API转账游戏；</li>
                            <li>5、本页面充值仅用于提高额度上限，不支持缴纳月结账单；</li>
                            <li>6、财务正常工作时间：09:00-21:00（北京时间）。</li>
                        </ul>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
<soul:import res="site/setting/credit/Pay"/>
