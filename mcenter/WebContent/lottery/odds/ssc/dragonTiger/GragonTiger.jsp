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
                        <th>定位</th>
                        <th>龙</th>
                        <th>虎</th>
                        <th>和</th>

                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <th><span>万千</span></th>
                        <c:forEach items="${command.ten_thousand_thousand}" var="p" >
                            <c:if test="${p.betNum eq '龙'||p.betNum eq '虎'||p.betNum eq '和'}">

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
                            </c:if>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th><span>万百</span></th>
                        <c:forEach items="${command.ten_thousand_hundred}" var="p" >
                            <c:if test="${p.betNum eq '龙'||p.betNum eq '虎'||p.betNum eq '和'}">

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
                            </c:if>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th><span>万十</span></th>
                        <c:forEach items="${command.ten_thousand_ten}" var="p" >
                            <c:if test="${p.betNum eq '龙'||p.betNum eq '虎'||p.betNum eq '和'}">

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
                            </c:if>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th><span>万个</span></th>
                        <c:forEach items="${command.ten_thousand_one}" var="p" >
                            <c:if test="${p.betNum eq '龙'||p.betNum eq '虎'||p.betNum eq '和'}">

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
                            </c:if>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th><span>千百</span></th>
                        <c:forEach items="${command.thousand_hundred}" var="p" >
                            <c:if test="${p.betNum eq '龙'||p.betNum eq '虎'||p.betNum eq '和'}">

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
                            </c:if>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th><span>千十</span></th>
                        <c:forEach items="${command.thousand_ten}" var="p" >
                            <c:if test="${p.betNum eq '龙'||p.betNum eq '虎'||p.betNum eq '和'}">

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
                            </c:if>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th><span>千个</span></th>
                        <c:forEach items="${command.thousand_one}" var="p" >
                            <c:if test="${p.betNum eq '龙'||p.betNum eq '虎'||p.betNum eq '和'}">

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
                            </c:if>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th><span>百十</span></th>
                        <c:forEach items="${command.hundred_ten}" var="p" >
                            <c:if test="${p.betNum eq '龙'||p.betNum eq '虎'||p.betNum eq '和'}">

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
                            </c:if>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th><span>百个</span></th>
                        <c:forEach items="${command.hundred_one}" var="p" >
                            <c:if test="${p.betNum eq '龙'||p.betNum eq '虎'||p.betNum eq '和'}">

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
                            </c:if>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th><span>十个</span></th>
                        <c:forEach items="${command.ten_one}" var="p" >
                            <c:if test="${p.betNum eq '龙'||p.betNum eq '虎'||p.betNum eq '和'}">

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
                            </c:if>
                        </c:forEach>
                    </tr>




                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>