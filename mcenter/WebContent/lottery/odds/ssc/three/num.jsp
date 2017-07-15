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
                        <th>${views.lottery_auto['号码']}</th>
                        <th>${views.lottery_auto['当前赔率']}</th>
                        <th>${views.lottery_auto['号码']}</th>
                        <th>${views.lottery_auto['当前赔率']}</th>
                        <th>${views.lottery_auto['号码']}</th>
                        <th>${views.lottery_auto['当前赔率']}</th>
                        <th>${views.lottery_auto['号码']}</th>
                        <th>${views.lottery_auto['当前赔率']}</th>
                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach var="i" begin="0" end="999">
                        <c:if test="${i%5==0}">
                            <tr>
                        </c:if>
                        <c:set var="num">${i}</c:set>
                        <c:if test="${num.length()==1}">
                            <c:set var="num" value="00${i}" />
                        </c:if>
                        <c:if test="${num.length()==2}">
                            <c:set var="num" value="0${i}" />
                        </c:if>
                        <th><span>${num}</span></th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command[num].id}" name="lotteryOdds[${i}].id">
                                <input type="hidden" value="${command[num].code}" name="lotteryOdds[${i}].code">
                                <input type="hidden" value="${command[num].betCode}" name="lotteryOdds[${i}].betCode">
                                <input type="hidden" value="${command[num].siteId}" name="lotteryOdds[${i}].siteId">
                                <input type="hidden" value="${command[num].betNum}" name="lotteryOdds[${i}].betNum">
                                <input type="text" class="form-control input-sm" placeholder="<=${command[num].oddLimit}" data-limit="${command[num].oddLimit}" data-value="${command[num].odd}" name="lotteryOdds[${i}].odd" data-value="${command[num].odd}" value="${command[num].odd}">
                            </div>
                        </td>
                        <c:if test="${i%5==4}">
                            </tr>
                        </c:if>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>