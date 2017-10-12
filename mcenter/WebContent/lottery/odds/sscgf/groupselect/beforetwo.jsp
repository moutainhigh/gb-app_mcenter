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
                        <th>当前奖金</th>
                        <th>返点比例</th>
                        <th>号码</th>
                        <th>当前奖金</th>
                        <th>返点比例</th>
                        <th>号码</th>
                        <th>当前奖金</th>
                        <th>返点比例</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <th><span>前二组选复式</span></th>
                        <c:forEach items="${command.ssc_erxing_zuxuan_qefs}" var="p" >
                            <td>
                                <div class="input-group content-width-limit-10">
                                    <c:set var="odd" value="${p}"/>
                                    <input type="hidden" value="${odd.id}" name="lotteryOdds[${status.index}].id">
                                    <input type="hidden" value="${odd.code}" name="lotteryOdds[${status.index}].code">
                                    <input type="hidden" value="${odd.betCode}" name="lotteryOdds[${status.index}].betCode">
                                    <input type="hidden" value="${odd.siteId}" name="lotteryOdds[${status.index}].siteId">
                                    <input type="hidden" value="${odd.betNum}" name="lotteryOdds[${status.index}].betNum">
                                    <input type="text" class="form-control input-sm odd" placeholder="<=${odd.oddLimit}" name="lotteryOdds[${status.index}].odd" data-limit="${odd.oddLimit}" data-value="${odd.odd}" value="${odd.odd}">
                                </div>
                            </td>
                            <td>
                                <div class="input-group content-width-limit-10">
                                    <input type="text" class="form-control input-sm rebate" placeholder="<=${odd.rebateLimit}" name="lotteryOdds[${status.index}].rebate" data-limit="${odd.rebateLimit}" data-value="${odd.rebate}" value="${odd.rebate}">
                                </div>
                            </td>
                        </c:forEach>
                        <th><span>前二组选单式</span></th>
                        <c:forEach items="${command.ssc_erxing_zuxuan_qeds}" var="p" >
                            <td>
                                <div class="input-group content-width-limit-10">
                                    <c:set var="odd" value="${p}"/>
                                    <input type="hidden" value="${odd.id}" name="lotteryOdds[${status.index}].id">
                                    <input type="hidden" value="${odd.code}" name="lotteryOdds[${status.index}].code">
                                    <input type="hidden" value="${odd.betCode}" name="lotteryOdds[${status.index}].betCode">
                                    <input type="hidden" value="${odd.siteId}" name="lotteryOdds[${status.index}].siteId">
                                    <input type="hidden" value="${odd.betNum}" name="lotteryOdds[${status.index}].betNum">
                                    <input type="text" class="form-control input-sm odd" placeholder="<=${odd.oddLimit}" name="lotteryOdds[${status.index}].odd" data-limit="${odd.oddLimit}" data-value="${odd.odd}" value="${odd.odd}">
                                </div>
                            </td>
                            <td>
                                <div class="input-group content-width-limit-10">
                                    <input type="text" class="form-control input-sm rebate" placeholder="<=${odd.rebateLimit}" name="lotteryOdds[${status.index}].rebate" data-limit="${odd.rebateLimit}" data-value="${odd.rebate}" value="${odd.rebate}">
                                </div>
                            </td>
                        </c:forEach>
                        <th><span>前二组选和值</span></th>
                        <c:forEach items="${command.ssc_erxing_zuxuan_qehz}" var="p" >
                            <td>
                                <div class="input-group content-width-limit-10">
                                    <c:set var="odd" value="${p}"/>
                                    <input type="hidden" value="${odd.id}" name="lotteryOdds[${status.index}].id">
                                    <input type="hidden" value="${odd.code}" name="lotteryOdds[${status.index}].code">
                                    <input type="hidden" value="${odd.betCode}" name="lotteryOdds[${status.index}].betCode">
                                    <input type="hidden" value="${odd.siteId}" name="lotteryOdds[${status.index}].siteId">
                                    <input type="hidden" value="${odd.betNum}" name="lotteryOdds[${status.index}].betNum">
                                    <input type="text" class="form-control input-sm odd" placeholder="<=${odd.oddLimit}" name="lotteryOdds[${status.index}].odd" data-limit="${odd.oddLimit}" data-value="${odd.odd}" value="${odd.odd}">
                                </div>
                            </td>
                            <td>
                                <div class="input-group content-width-limit-10">
                                    <input type="text" class="form-control input-sm rebate" placeholder="<=${odd.rebateLimit}" name="lotteryOdds[${status.index}].rebate" data-limit="${odd.rebateLimit}" data-value="${odd.rebate}" value="${odd.rebate}">
                                </div>
                            </td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th><span>前二组选包胆</span></th>
                        <c:forEach items="${command.ssc_erxing_zuxuan_qebd}" var="p" >
                            <td>
                                <div class="input-group content-width-limit-10">
                                    <c:set var="odd" value="${p}"/>
                                    <input type="hidden" value="${odd.id}" name="lotteryOdds[${status.index}].id">
                                    <input type="hidden" value="${odd.code}" name="lotteryOdds[${status.index}].code">
                                    <input type="hidden" value="${odd.betCode}" name="lotteryOdds[${status.index}].betCode">
                                    <input type="hidden" value="${odd.siteId}" name="lotteryOdds[${status.index}].siteId">
                                    <input type="hidden" value="${odd.betNum}" name="lotteryOdds[${status.index}].betNum">
                                    <input type="text" class="form-control input-sm odd" placeholder="<=${odd.oddLimit}" name="lotteryOdds[${status.index}].odd" data-limit="${odd.oddLimit}" data-value="${odd.odd}" value="${odd.odd}">
                                </div>
                            </td>
                            <td>
                                <div class="input-group content-width-limit-10">
                                    <input type="text" class="form-control input-sm rebate" placeholder="<=${odd.rebateLimit}" name="lotteryOdds[${status.index}].rebate" data-limit="${odd.rebateLimit}" data-value="${odd.rebate}" value="${odd.rebate}">
                                </div>
                            </td>
                        </c:forEach>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
