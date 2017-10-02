<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div  id="editable_wrapper" class="dataTables_wrapper" role="grid">
    <div class="panel-body">
        <div class="tab-content">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover dataTable m-b-none text-center" aria-describedby="editable_info">
                    <thead>
                    <tr class="bg-gray">
                        <th>号码</th>
                        <th>当前赔率</th>
                        <th>号码</th>
                        <th>当前赔率</th>
                    </tr>
                    </thead>
                    <tbody>

                    <tr>
                        <th>二中特之中二</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['中2'].id}" name="lotteryOdds[49].id">
                                <input type="hidden" value="${command['中2'].code}" name="lotteryOdds[49].code">
                                <input type="hidden" value="${command['中2'].betCode}" name="lotteryOdds[49].betCode">
                                <input type="hidden" value="${command['中2'].siteId}" name="lotteryOdds[49].siteId">
                                <input type="hidden" value="${command['中2'].betNum}" name="lotteryOdds[49].betNum">
                                <input type="text" class="form-control input-sm" placeholder="<=${command['中2'].oddLimit}" data-limit="${command['中2'].oddLimit}" data-value="${command['中2'].odd}" name="lotteryOdds[49].odd" value="${command['中2'].odd}">
                            </div>
                        </td>
                        <th>二中特之中特</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['中特'].id}" name="lotteryOdds[49].id">
                                <input type="hidden" value="${command['中特'].code}" name="lotteryOdds[49].code">
                                <input type="hidden" value="${command['中特'].betCode}" name="lotteryOdds[49].betCode">
                                <input type="hidden" value="${command['中特'].siteId}" name="lotteryOdds[49].siteId">
                                <input type="hidden" value="${command['中特'].betNum}" name="lotteryOdds[49].betNum">
                                <input type="text" class="form-control input-sm" placeholder="<=${command['中特'].oddLimit}" data-limit="${command['中特'].oddLimit}" data-value="${command['中特'].odd}" name="lotteryOdds[49].odd" value="${command['中特'].odd}">
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
