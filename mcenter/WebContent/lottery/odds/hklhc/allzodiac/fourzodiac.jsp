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
                    </tr>
                    </thead>
                    <tbody>

                    <tr>
                        <th>四肖</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['四肖'].id}" name="lotteryOdds[49].id">
                                <input type="hidden" value="${command['四肖'].code}" name="lotteryOdds[49].code">
                                <input type="hidden" value="${command['四肖'].betCode}" name="lotteryOdds[49].betCode">
                                <input type="hidden" value="${command['四肖'].siteId}" name="lotteryOdds[49].siteId">
                                <input type="hidden" value="${command['四肖'].betNum}" name="lotteryOdds[49].betNum">
                                <input type="text" class="form-control input-sm" placeholder="<=${command['四肖'].oddLimit}" data-limit="${command['四肖'].oddLimit}" data-value="${command['四肖'].odd}" name="lotteryOdds[49].odd" value="${command['四肖'].odd}">
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
