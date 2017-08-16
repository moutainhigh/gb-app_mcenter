    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div id="editable_wrapper" class="dataTables_wrapper" role="grid">
    <div class="panel-body">
        <div class="tab-content">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover dataTable m-b-none text-center"
                       aria-describedby="editable_info">
                    <thead>
                    <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm" style="padding-left: 0;">
                        <div class="input-group date time-select-a">
                            <span class="input-group-addon bg-gray">赔率</span>

                            <input type="text" class="form-control" placeholder="">



                            <span class="input-group-addon time-select-btn"><a type="button" class="btn btn-filter btn-outline"><span class="hd">批量调整</span></a></span>
                        </div>
                    </div>
                    <tr class="bg-gray">
                        <th>号码</th>
                        <th>当前赔率</th>
                        <th>号码</th>
                        <th>当前赔率</th>

                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${command}" var="i" varStatus="status">
                        <c:if test="${status.index%2==0}">
                            <tr>
                        </c:if>
                        <th><span>${i.betNum}</span></th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <c:set var="odd" value="${i}"/>
                                <input type="hidden" value="${odd.id}" name="lotteryOdds[${status.index}].id">
                                <input type="hidden" value="${odd.code}" name="lotteryOdds[${status.index}].code">
                                <input type="hidden" value="${odd.betCode}" name="lotteryOdds[${status.index}].betCode">
                                <input type="hidden" value="${odd.siteId}" name="lotteryOdds[${status.index}].siteId">
                                <input type="hidden" value="${odd.betNum}" name="lotteryOdds[${status.index}].betNum">
                                <input type="text" class="form-control input-sm" placeholder="<=${odd.oddLimit}" name="lotteryOdds[${status.index}].odd" data-limit="${odd.oddLimit}" data-value="${odd.odd}" value="${odd.odd}">
                            </div>
                        </td>
                        <c:if test="${status.index%2==1}">
                            </tr>
                        </c:if>
                    </c:forEach>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>