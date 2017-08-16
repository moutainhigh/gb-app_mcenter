<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div id="editable_wrapper" class="dataTables_wrapper" role="grid">
    <div class="panel-body">
        <div class="tab-content">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover dataTable m-b-none text-center" aria-describedby="editable_info">
                    <thead>
                    <tr class="bg-gray">
                        <th>号码</th>
                        <th>当前赔率</th>

                    </tr>
                    </thead>
                    <tbody>
                    <c:if test="${command['百十'].id !=null}">
                        <tr>
                            <th>百十</th>
                            <td>
                                <div class="input-group content-width-limit-10">
                                    <input type="hidden" value="${command['百十'].id}" name="lotteryOdds[10].id">
                                    <input type="hidden" value="${command['百十'].code}" name="lotteryOdds[10].code">
                                    <input type="hidden" value="${command['百十'].betCode}" name="lotteryOdds[10].betCode">
                                    <input type="hidden" value="${command['百十'].siteId}" name="lotteryOdds[10].siteId">
                                    <input type="hidden" value="${command['百十'].betNum}" name="lotteryOdds[10].betNum">
                                    <input type="text" class="form-control input-sm" placeholder="<=${command['百十'].oddLimit}" data-limit="${command['百十'].oddLimit}" data-value="${command['百十'].odd}" name="lotteryOdds[10].odd" value="${command['百十'].odd}">
                                </div>
                            </td>
                        </tr>
                    </c:if>
                    <c:if test="${command['百个'].id !=null}">
                        <tr>
                            <th>百个</th>
                            <td>
                                <div class="input-group content-width-limit-10">
                                    <input type="hidden" value="${command['百个'].id}" name="lotteryOdds[11].id">
                                    <input type="hidden" value="${command['百个'].code}" name="lotteryOdds[11].code">
                                    <input type="hidden" value="${command['百个'].betCode}" name="lotteryOdds[11].betCode">
                                    <input type="hidden" value="${command['百个'].siteId}" name="lotteryOdds[11].siteId">
                                    <input type="hidden" value="${command['百个'].betNum}" name="lotteryOdds[11].betNum">
                                    <input type="text" class="form-control input-sm" placeholder="<=${command['百个'].oddLimit}" data-limit="${command['百个'].oddLimit}" data-value="${command['百个'].odd}" name="lotteryOdds[11].odd" value="${command['百个'].odd}">
                                </div>
                            </td>
                        </tr>
                    </c:if>
                    <c:if test="${command['十个'].id !=null}">
                        <tr>
                            <th>十个</th>
                            <td>
                                <div class="input-group content-width-limit-10">
                                    <input type="hidden" value="${command['十个'].id}" name="lotteryOdds[12].id">
                                    <input type="hidden" value="${command['十个'].code}" name="lotteryOdds[12].code">
                                    <input type="hidden" value="${command['十个'].betCode}" name="lotteryOdds[12].betCode">
                                    <input type="hidden" value="${command['十个'].siteId}" name="lotteryOdds[12].siteId">
                                    <input type="hidden" value="${command['十个'].betNum}" name="lotteryOdds[12].betNum">
                                    <input type="text" class="form-control input-sm" placeholder="<=${command['十个'].oddLimit}" data-limit="${command['十个'].oddLimit}" data-value="${command['十个'].odd}" name="lotteryOdds[12].odd" value="${command['十个'].odd}">
                                </div>
                            </td>
                        </tr>
                    </c:if>
                    <c:if test="${command['百十个'].id !=null}">
                        <tr>
                            <th>百十个</th>
                            <td>
                                <div class="input-group content-width-limit-10">
                                    <input type="hidden" value="${command['百十个'].id}" name="lotteryOdds[13].id">
                                    <input type="hidden" value="${command['百十个'].code}" name="lotteryOdds[13].code">
                                    <input type="hidden" value="${command['百十个'].betCode}" name="lotteryOdds[13].betCode">
                                    <input type="hidden" value="${command['百十个'].siteId}" name="lotteryOdds[13].siteId">
                                    <input type="hidden" value="${command['百十个'].betNum}" name="lotteryOdds[13].betNum">
                                    <input type="text" class="form-control input-sm" placeholder="<=${command['百十个'].oddLimit}" data-limit="${command['百十个'].oddLimit}" data-value="${command['百十个'].odd}" name="lotteryOdds[13].odd" value="${command['百十个'].odd}">
                                </div>
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>