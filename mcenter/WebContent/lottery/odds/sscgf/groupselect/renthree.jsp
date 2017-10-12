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
                        <th><span>任选三组三复式</span></th>
                        <c:forEach items="${command.ssc_renxuan3_z3fs}" var="p" >
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
                        <th><span>任选三组三单式</span></th>
                        <c:forEach items="${command.ssc_renxuan3_z3ds}" var="p" >
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
                        <th><span>任选三组六复式</span></th>
                        <c:forEach items="${command.ssc_renxuan3_z6fs}" var="p" >
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
                        <th><span>任选三组六单式</span></th>
                        <c:forEach items="${command.ssc_renxuan3_z6ds}" var="p" >
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
                        <c:forEach items="${command.ssc_renxuan3_hhzx}" var="p" >
                            <c:if test="${p.betNum eq '组三'}">
                            <th><span>任选三混合组选(组三)</span></th>
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
                            </c:if>
                            <c:if test="${p.betNum eq '组六'}">
                                <th><span>任选三混合组选(组六)</span></th>
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
                            </c:if>
                        </c:forEach>
                    </tr>
                    <tr>
                        <c:forEach items="${command.ssc_renxuan3_zuxhz}" var="p" >
                            <c:if test="${p.betNum eq '组三'}">
                                <th><span>任选三组选和值(组三)</span></th>
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
                            </c:if>
                            <c:if test="${p.betNum eq '组六'}">
                                <th><span>任选三组选和值(组六)</span></th>
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
                            </c:if>
                        </c:forEach>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
