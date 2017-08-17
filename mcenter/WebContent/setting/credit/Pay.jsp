<%--@elvariable id="accountMap" type="java.util.Map<java.lang.String,so.wwb.gamebox.model.company.credit.po.CreditAccount>"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<div class="row">
    <div class="position-wrap clearfix">
        <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont"></i> </a></h2>
        <span>系统设置</span><span>/</span><span>额度充值</span>
        <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
    </div>
    <div class="col-lg-12">
        <div class="wrapper white-bg shadow">
            <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
                <div class="sys_tab_wrap p-xs">
                    <b class="fs16">离后台维护还剩：</b><span class="fs20 ft-bold co-red">0小时21分</span>
                </div>
                <div class="filter-wraper limit-rec clearfix p-xs">
                    <div class="m-b-none col-xs-6 col-sm-3">
                        <div class="limit-price-wrap al-center clearfix">
                            <div class="bold-fs16 p-sm co-gray6" title="当前额度上限">当前额度上限</div>
                            <div class="fs30 p-b-sm al-center">1,936,499</div>
                        </div>
                    </div>
                    <div class="m-b-none col-xs-6 col-sm-3">
                        <div class="limit-price-wrap al-center clearfix">
                            <div class="bold-fs16 p-sm co-gray6" title="已使用额度">已使用额度<span tabindex="0" class=" help-popover m-l-sm" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top" data-content="用于接入第三方流量统计平台"><i class="fa fa-question-circle"></i></span></div>
                            <div class="fs30 p-b-sm al-center co-blue">1,936,499</div>
                        </div>
                    </div>
                    <div class="m-b-none col-xs-6 col-sm-3">
                        <div class="limit-price-wrap al-center clearfix">
                            <div class="bold-fs16 p-sm co-gray6" title="已使用">已使用</div>
                            <div class="fs30 p-b-sm al-center co-red">100%</div>
                        </div>
                    </div>
                    <div class="m-b-none col-xs-6 col-sm-3">
                        <div class="limit-price-wrap al-center clearfix">
                            <div class="bold-fs16 p-sm co-gray6" title="兑换比例">兑换比例</div>
                            <div class="fs30 p-b-sm al-center">1:10</div>
                        </div>
                    </div>
                </div>
                <hr class="m-t-xxs m-b-sm">
                <div class="clearfix">
                    <div class="panel-body col-xs-12 col-sm-10 col-md-8 col-lg-6 p-sm">
                        <table class="no-border table-desc-list" style="width: 100%;">
                            <tbody>

                            <tr>
                                <th scope="row" class="text-right" style="width: 150px;">存款渠道：</th>
                                <td>
                                    <div class="table-desc-right-t m-t-n-sm" style="width: 100%;min-width: 340px; max-width: 510px;">
                                        <c:set var="banknames" value="${dicts.common.bankname}"/>
                                        <c:forEach items="${accountMap}" var="i" varStatus="vs">
                                            <label class="bank ${vs.index==0?'select':''}">
                                                <span class="radio"><input name="bankCode" type="radio"></span>
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
                                    </div>
                                    <div class="m-t-xs"><a href="javascript:void(0)"> 展开更多</a></div>
                                </td>
                            </tr>

                            <tr>
                                <th scope="row" class="text-right" style="width: 150px;">充值金额：</th>
                                <td>
                                    <div class="table-desc-right-t">
                                        <input type="text" class="form-control">
                                        <div class="co-grayc2 m-t-sm">请输入（${singleMin}~${singleMax}）之间的整数</div>
                                        <div class="m-t-sm">
                                            <soul:button target="" text="1万" opType=""/>
                                            <soul:button target="" text="5万" opType=""/>
                                            <soul:button target="" text="10万" opType=""/>
                                        </div>
                                        <div class="m-t-md fs16">您将获得 <span class="co-green">50万</span> 额度</div>
                                        <div class="m-t-md"><a href="javascript:void(0)" class="btn btn-filter btn-lg btn-block">确认</a></div>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-lg-6 col-md-4 col-sm-12 col-xs-12 limit-tips">
                        <ul>
                            <li>本系统默认可用额度${defaultProfit},当系统提示额度超时,请在本页面自助充值即可增加额度上限</li>
                            <li>如果充值出现问题,请及时联系我们技术支持</li>
                            <li>本页面充值仅用于提高额度上限，不支持缴纳月结账单；</li>
                        </ul>
                    </div>

                </div>

            </div>
        </div>
    </div>
</div>
