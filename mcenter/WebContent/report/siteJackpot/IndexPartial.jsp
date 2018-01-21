<%--@elvariable id="command" type="so.wwb.gamebox.model.report.operate.vo.SiteJackpotListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<input type="hidden" name="queryParamsJson" value='${queryParamsJson}'>
<div class="dataTables_wrapper" role="grid">
    <div class="clearfix m-t-xs">
        <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
            <div class="input-group">
                <span class="input-group-addon bg-gray">API名称</span>
                <input class="form-control search" type="text" name="search.jackpotName" value="${command.search.jackpotName}">
            </div>
        </div>
        <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm" style="margin-right: 10px">
            <div class="input-group">
                <span class="input-group-addon bg-gray">月份</span>
                <input class="form-control search" type="text" name="search.staticMonth"  value="${command.search.staticMonth}" placeholder="格式示例：2018-01">
            </div>
        </div>
            <soul:button target="query" opType="function" text="" cssClass="btn btn-filter ">
                <span class="hd">${views.common['search']}</span>
            </soul:button>
            <soul:button tag="button" cssClass="btn btn-export-btn btn-primary-hide"
                         text="${views.common['export']}" callback="gotoExportHistory"
                         precall="validExportCount" post="getCurrentFormData" title="${views.role['player.dataExport']}"
                         target="${root}/siteJackpot/exportRecords.html?exportType=site" opType="ajax">
                <i class="fa fa-sign-out"></i><span class="hd">${views.common['export']}</span>
            </soul:button>
    </div>
        <div class="panel-body">
            <div class="tab-content">
                <div class="table-responsive table-min-h">
                    <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
                        <thead>
                            <tr role="row" class="bg-gray">
                                <th style="width: 50px;">序号</th>
                                <th>API名称</th>
                                <th>月份</th>
                                <th>彩池贡献金</th>
                                <th>中奖金额</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:set var="idx" value="0"></c:set>
                        <c:forEach items="${command.result}" var="item" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${item.jackpotName}</td>
                                <td>${item.staticMonth}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${empty item.contributionAmount}">0.0</c:when>
                                        <c:otherwise>${item.contributionAmount}</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${empty item.winningAmount}">0.0</c:when>
                                        <c:otherwise>${item.winningAmount}</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
       </div>
</div>

<soul:pagination/>