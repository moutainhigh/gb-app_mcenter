<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div id="editable_wrapper" class="dataTables_wrapper" role="grid">
    <div class="panel-body">
        <div class="tab-content">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover dataTable m-b-none text-center" aria-describedby="editable_info">
                    <thead>
                    <tr class="bg-gray">
                        <th>${views.lottery_auto['号码']}</th>
                        <th>${views.lottery_auto['当前赔率']}</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${command}"  var="i" varStatus="status">
                        <tr>
                            <th><span>${i.key}</span></th>
                            <c:set var="num" value="${i.value}" />
                            <td>
                                <div class="input-group content-width-limit-10">
                                    <input type="hidden" value="${num.id}" name="lotteryOdds[${status.index}].id">
                                    <input type="hidden" value="${num.code}" name="lotteryOdds[${status.index}].code">
                                    <input type="hidden" value="${num.betCode}" name="lotteryOdds[${status.index}].betCode">
                                    <input type="hidden" value="${num.siteId}" name="lotteryOdds[${status.index}].siteId">
                                    <input type="hidden" value="${num.betNum}" name="lotteryOdds[${status.index}].betNum">
                                    <input type="text" class="form-control input-sm" placeholder="<=${num.oddLimit}" data-limit="${num.oddLimit}" data-value="${num.odd}" name="lotteryOdds[${i}].odd" data-value="${num.odd}" value="${num.odd}">
                                </div>
                            </td>

                        </tr>
                    </c:forEach>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>