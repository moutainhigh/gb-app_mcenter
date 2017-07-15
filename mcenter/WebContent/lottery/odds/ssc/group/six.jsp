<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div id="editable_wrapper" class="dataTables_wrapper" role="grid">
    <div class="panel-body">
        <div class="tab-content">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover dataTable m-b-none text-center"
                       aria-describedby="editable_info">
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

                    <tr>
                        <th><span>${fn:replace(views.lottery_auto['号码'],"[0]",4)}</span></th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['4个号码'].id}" name="lotteryOdds[4].id">
                                <input type="hidden" value="${command['4个号码'].code}" name="lotteryOdds[4].code">
                                <input type="hidden" value="${command['4个号码'].betCode}" name="lotteryOdds[4].betCode">
                                <input type="hidden" value="${command['4个号码'].siteId}" name="lotteryOdds[4].siteId">
                                <input type="hidden" value="${command['4个号码'].betNum}" name="lotteryOdds[4].betNum">
                                <input type="text" class="form-control input-sm" name="lotteryOdds[4].odd"
                                       value="${command['4个号码'].odd}">
                            </div>
                        </td>

                        <th><span>${fn:replace(views.lottery_auto['号码'],"[0]",5)}</span></th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['5个号码'].id}" name="lotteryOdds[0].id">
                                <input type="hidden" value="${command['5个号码'].code}" name="lotteryOdds[0].code">
                                <input type="hidden" value="${command['5个号码'].betCode}" name="lotteryOdds[0].betCode">
                                <input type="hidden" value="${command['5个号码'].siteId}" name="lotteryOdds[0].siteId">
                                <input type="hidden" value="${command['5个号码'].betNum}" name="lotteryOdds[0].betNum">
                                <input type="text" class="form-control input-sm" name="lotteryOdds[0].odd"
                                       value="${command['5个号码'].odd}">
                            </div>
                        </td>
                        <th><span>${fn:replace(views.lottery_auto['号码'],"[0]",6)}</span></th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['6个号码'].id}" name="lotteryOdds[1].id">
                                <input type="hidden" value="${command['6个号码'].code}" name="lotteryOdds[1].code">
                                <input type="hidden" value="${command['6个号码'].betCode}" name="lotteryOdds[1].betCode">
                                <input type="hidden" value="${command['6个号码'].siteId}" name="lotteryOdds[1].siteId">
                                <input type="hidden" value="${command['6个号码'].betNum}" name="lotteryOdds[1].betNum">
                                <input type="text" class="form-control input-sm" name="lotteryOdds[1].odd"
                                       value="${command['6个号码'].odd}">
                            </div>
                        </td>
                        <th><span>${fn:replace(views.lottery_auto['号码'],"[0]",7)}</span></th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['7个号码'].id}" name="lotteryOdds[2].id">
                                <input type="hidden" value="${command['7个号码'].code}" name="lotteryOdds[2].code">
                                <input type="hidden" value="${command['7个号码'].betCode}" name="lotteryOdds[2].betCode">
                                <input type="hidden" value="${command['7个号码'].siteId}" name="lotteryOdds[2].siteId">
                                <input type="hidden" value="${command['7个号码'].betNum}" name="lotteryOdds[2].betNum">
                                <input type="text" class="form-control input-sm" name="lotteryOdds[2].odd"
                                       value="${command['7个号码'].odd}">
                            </div>
                        </td>


                        <th><span>${fn:replace(views.lottery_auto['号码'],"[0]",8)}</span></th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['8个号码'].id}" name="lotteryOdds[3].id">
                                <input type="hidden" value="${command['8个号码'].code}" name="lotteryOdds[3].code">
                                <input type="hidden" value="${command['8个号码'].betCode}" name="lotteryOdds[3].betCode">
                                <input type="hidden" value="${command['8个号码'].siteId}" name="lotteryOdds[3].siteId">
                                <input type="hidden" value="${command['8个号码'].betNum}" name="lotteryOdds[3].betNum">
                                <input type="text" class="form-control input-sm" name="lotteryOdds[3].odd"
                                       value="${command['8个号码'].odd}">
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>