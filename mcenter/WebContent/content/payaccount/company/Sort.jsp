<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form name="cashFlowOrderForm">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['运营']}</span><span>/</span>
            <span>${views.sysResource['公司入款']}</span>
            <soul:button target="goToLastPage" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow clearfix">
                <div class="form-group clearfix">
                        <span tabindex="0" class="m-l m-r help-popover" role="button" data-container="body" data-toggle="popover"  data-trigger="focus" data-placement="right" data-content="当某支付方式/渠道下有多个账号时，存款将按照设置的账号顺序依次入账。降低因短时间内大量入款，导致被第三方平台或银行视为违规，被停用账号的风险。">
                            <i class="fa fa-question-circle"></i>
                        </span>
                    <b class="co-yellow">${views.content['payAccount.suggest.enable']}</b>
                    <label class="m-l-sm"><input type="checkbox" class="i-checks" name="takeTurns" value="true" ${takeTurns.paramValue eq 'true'?'checked':''}>开启金流顺序</label>
                </div>
                <div class="line-hi34 col-sm-12 bg-gray m-b">
                    <span class="co-yellow m-r-sm"><i class="fa fa-exclamation-circle"></i></span>
                    可拖动账号在该支付方式下进行排序。使用时，系统将自动跳过已停用和被冻结账户。重新开启或解冻后，可继续按设置的顺序使用
                </div>
                <hr class="m-t m-b-sm">
                    <%--线上支付--%>
                <div id="online" class="table-responsive">
                    <table class="table table-striped table-hover dataTable m-b-sm dragdd">
                        <tbody class="dd-list1">
                        <c:forEach items="${command.result}" var="i" varStatus="vs">
                            <tr data-id="${empty i.sort?vs.index:i.sort}" class="dd-item1">
                                <input type="hidden" name="result.id" value="${i.id}" />
                                <td class="td-handle1" width="80"><i class="fa fa-arrows"></i></td>
                                <td  width="50" >${i.sort}</td>
                                <td  width="80" style="text-align: left" class="td-handle1">
                                    <span>${dicts.common.bankname[i.bankCode]}</span>
                                </td>
                                <td  width="80" style="text-align: left">${i.payName}</td>
                                <td class="co-yellow"  width="250" style="text-align: left">${i.account}</td>
                                <td  width="180" style="text-align: left">停用金额：<fmt:formatNumber value="${empty i.disableAmount?0:i.disableAmount}" pattern="#,####.##"/></td>
                                <td  width="80">
                                    <c:choose>
                                        <c:when test="${i.status=='1'}">
                                            <span class="label label-success">${views.content['payAccount.status.1']}</span>
                                        </c:when>
                                        <c:when test="${i.status=='2'}">
                                            <span class="label label-danger">${views.content['payAccount.status.2']}</span>
                                        </c:when>
                                        <c:when test="${i.status == '3'}">
                                            <span class="label label-info">${views.content['payAccount.status.3']}</span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                        </c:forEach>
                        <c:if test="${fn:length(command.result)<1}">
                            <tr>
                                <td colspan="7" class="no-content_wrap">
                                    <div>
                                        <i class="fa fa-exclamation-circle"></i> 暂无账号，请先添加设置
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
                <div class="operate-btn">
                    <soul:button target="applyCashFlowOrder" precall="validateCondition" text="${views.common['save']}" opType="function" cssClass="btn btn-filter btn-lg m-r"/>
                    <soul:button target="goToLastPage" cssClass="btn btn-outline btn-default btn-lg m-r" text="${views.common['return']}" opType="function"/>
                </div>
            </div>
        </div>
    </div>
</form:form>