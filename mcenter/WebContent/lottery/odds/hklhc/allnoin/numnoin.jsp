<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div  class="dataTables_wrapper" role="grid">
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
                        <th>号码</th>
                        <th>当前赔率</th>
                        <th>号码</th>
                        <th>当前赔率</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <th><span>五不中</span></th>
                        <c:forEach items="${command.lhc_five_no_in}" var="p" >
                            <td>
                                <div class="input-group content-width-limit-10">
                                    <c:set var="odd" value="${p}"/>
                                    <input type="hidden" value="${odd.id}" name="lotteryOdds[${status.index}].id">
                                    <input type="hidden" value="${odd.code}" name="lotteryOdds[${status.index}].code">
                                    <input type="hidden" value="${odd.betCode}" name="lotteryOdds[${status.index}].betCode">
                                    <input type="hidden" value="${odd.siteId}" name="lotteryOdds[${status.index}].siteId">
                                    <input type="hidden" value="${odd.betNum}" name="lotteryOdds[${status.index}].betNum">
                                    <input type="text" class="form-control input-sm" placeholder="<=${odd.oddLimit}" name="lotteryOdds[${status.index}].odd" data-limit="${odd.oddLimit}" data-value="${odd.odd}" value="${odd.odd}">
                                </div>
                            </td>
                        </c:forEach>
                        <th><span>六不中</span></th>
                        <c:forEach items="${command.lhc_six_no_in}" var="p" >
                            <td>
                                <div class="input-group content-width-limit-10">
                                    <c:set var="odd" value="${p}"/>
                                    <input type="hidden" value="${odd.id}" name="lotteryOdds[${status.index}].id">
                                    <input type="hidden" value="${odd.code}" name="lotteryOdds[${status.index}].code">
                                    <input type="hidden" value="${odd.betCode}" name="lotteryOdds[${status.index}].betCode">
                                    <input type="hidden" value="${odd.siteId}" name="lotteryOdds[${status.index}].siteId">
                                    <input type="hidden" value="${odd.betNum}" name="lotteryOdds[${status.index}].betNum">
                                    <input type="text" class="form-control input-sm" placeholder="<=${odd.oddLimit}" name="lotteryOdds[${status.index}].odd" data-limit="${odd.oddLimit}" data-value="${odd.odd}" value="${odd.odd}">
                                </div>
                            </td>
                        </c:forEach>
                        <th><span>七不中</span></th>
                        <c:forEach items="${command.lhc_seven_no_in}" var="p" >
                            <td>
                                <div class="input-group content-width-limit-10">
                                    <c:set var="odd" value="${p}"/>
                                    <input type="hidden" value="${odd.id}" name="lotteryOdds[${status.index}].id">
                                    <input type="hidden" value="${odd.code}" name="lotteryOdds[${status.index}].code">
                                    <input type="hidden" value="${odd.betCode}" name="lotteryOdds[${status.index}].betCode">
                                    <input type="hidden" value="${odd.siteId}" name="lotteryOdds[${status.index}].siteId">
                                    <input type="hidden" value="${odd.betNum}" name="lotteryOdds[${status.index}].betNum">
                                    <input type="text" class="form-control input-sm" placeholder="<=${odd.oddLimit}" name="lotteryOdds[${status.index}].odd" data-limit="${odd.oddLimit}" data-value="${odd.odd}" value="${odd.odd}">
                                </div>
                            </td>
                        </c:forEach>
                        <th><span>八不中</span></th>
                        <c:forEach items="${command.lhc_eight_no_in}" var="p" >
                            <td>
                                <div class="input-group content-width-limit-10">
                                    <c:set var="odd" value="${p}"/>
                                    <input type="hidden" value="${odd.id}" name="lotteryOdds[${status.index}].id">
                                    <input type="hidden" value="${odd.code}" name="lotteryOdds[${status.index}].code">
                                    <input type="hidden" value="${odd.betCode}" name="lotteryOdds[${status.index}].betCode">
                                    <input type="hidden" value="${odd.siteId}" name="lotteryOdds[${status.index}].siteId">
                                    <input type="hidden" value="${odd.betNum}" name="lotteryOdds[${status.index}].betNum">
                                    <input type="text" class="form-control input-sm" placeholder="<=${odd.oddLimit}" name="lotteryOdds[${status.index}].odd" data-limit="${odd.oddLimit}" data-value="${odd.odd}" value="${odd.odd}">
                                </div>
                            </td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th><span>九不中</span></th>
                        <c:forEach items="${command.lhc_nine_no_in}" var="p" >
                            <td>
                                <div class="input-group content-width-limit-10">
                                    <c:set var="odd" value="${p}"/>
                                    <input type="hidden" value="${odd.id}" name="lotteryOdds[${status.index}].id">
                                    <input type="hidden" value="${odd.code}" name="lotteryOdds[${status.index}].code">
                                    <input type="hidden" value="${odd.betCode}" name="lotteryOdds[${status.index}].betCode">
                                    <input type="hidden" value="${odd.siteId}" name="lotteryOdds[${status.index}].siteId">
                                    <input type="hidden" value="${odd.betNum}" name="lotteryOdds[${status.index}].betNum">
                                    <input type="text" class="form-control input-sm" placeholder="<=${odd.oddLimit}" name="lotteryOdds[${status.index}].odd" data-limit="${odd.oddLimit}" data-value="${odd.odd}" value="${odd.odd}">
                                </div>
                            </td>
                        </c:forEach>
                        <th><span>十不中</span></th>
                        <c:forEach items="${command.lhc_ten_no_in}" var="p" >
                            <td>
                                <div class="input-group content-width-limit-10">
                                    <c:set var="odd" value="${p}"/>
                                    <input type="hidden" value="${odd.id}" name="lotteryOdds[${status.index}].id">
                                    <input type="hidden" value="${odd.code}" name="lotteryOdds[${status.index}].code">
                                    <input type="hidden" value="${odd.betCode}" name="lotteryOdds[${status.index}].betCode">
                                    <input type="hidden" value="${odd.siteId}" name="lotteryOdds[${status.index}].siteId">
                                    <input type="hidden" value="${odd.betNum}" name="lotteryOdds[${status.index}].betNum">
                                    <input type="text" class="form-control input-sm" placeholder="<=${odd.oddLimit}" name="lotteryOdds[${status.index}].odd" data-limit="${odd.oddLimit}" data-value="${odd.odd}" value="${odd.odd}">
                                </div>
                            </td>
                        </c:forEach>
                        <th><span>十一不中</span></th>
                        <c:forEach items="${command.lhc_eleven_no_in}" var="p" >
                            <td>
                                <div class="input-group content-width-limit-10">
                                    <c:set var="odd" value="${p}"/>
                                    <input type="hidden" value="${odd.id}" name="lotteryOdds[${status.index}].id">
                                    <input type="hidden" value="${odd.code}" name="lotteryOdds[${status.index}].code">
                                    <input type="hidden" value="${odd.betCode}" name="lotteryOdds[${status.index}].betCode">
                                    <input type="hidden" value="${odd.siteId}" name="lotteryOdds[${status.index}].siteId">
                                    <input type="hidden" value="${odd.betNum}" name="lotteryOdds[${status.index}].betNum">
                                    <input type="text" class="form-control input-sm" placeholder="<=${odd.oddLimit}" name="lotteryOdds[${status.index}].odd" data-limit="${odd.oddLimit}" data-value="${odd.odd}" value="${odd.odd}">
                                </div>
                            </td>
                        </c:forEach>
                        <th><span>十二不中</span></th>
                        <c:forEach items="${command.lhc_twelve_no_in}" var="p" >
                            <td>
                                <div class="input-group content-width-limit-10">
                                    <c:set var="odd" value="${p}"/>
                                    <input type="hidden" value="${odd.id}" name="lotteryOdds[${status.index}].id">
                                    <input type="hidden" value="${odd.code}" name="lotteryOdds[${status.index}].code">
                                    <input type="hidden" value="${odd.betCode}" name="lotteryOdds[${status.index}].betCode">
                                    <input type="hidden" value="${odd.siteId}" name="lotteryOdds[${status.index}].siteId">
                                    <input type="hidden" value="${odd.betNum}" name="lotteryOdds[${status.index}].betNum">
                                    <input type="text" class="form-control input-sm" placeholder="<=${odd.oddLimit}" name="lotteryOdds[${status.index}].odd" data-limit="${odd.oddLimit}" data-value="${odd.odd}" value="${odd.odd}">
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

