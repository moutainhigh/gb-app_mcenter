<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="dataTables_wrapper" role="grid">
    <div class="panel-body">
        <div class="tab-content">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover dataTable m-b-none text-center" aria-describedby="editable_info">
                    <thead>
                    <tr class="bg-gray">
                       
                        <th>北京PK10</th>
                        <th>单项（号）限额</th>
                        <th>单注限额</th>
                        <th>单类别单项（号）限额</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                       
                        <td>定位</td>
                        <input type="hidden" value="${command['pk10_digital'].id}" name="quotaList[0].id">
                        <input type="hidden" value="${command['pk10_digital'].siteId}" name="quotaList[0].siteId">
                        <input type="hidden" value="${command['pk10_digital'].code}" name="quotaList[0].code">
                        <input type="hidden" value="${command['pk10_digital'].playCode}" name="quotaList[0].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pk10_digital'].numQuota}" data-value="${command['pk10_digital'].numQuota}" name="quotaList[0].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pk10_digital'].betQuota}"  data-value="${command['pk10_digital'].betQuota}" name="quotaList[0].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pk10_digital'].playQuota}" data-value="${command['pk10_digital'].playQuota}" name="quotaList[0].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                       
                        <td>大小</td>
                        <input type="hidden" value="${command['pk10_big_small'].id}" name="quotaList[1].id">
                        <input type="hidden" value="${command['pk10_big_small'].siteId}" name="quotaList[1].siteId">
                        <input type="hidden" value="${command['pk10_big_small'].code}" name="quotaList[1].code">
                        <input type="hidden" value="${command['pk10_big_small'].playCode}" name="quotaList[1].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pk10_big_small'].numQuota}" data-value="${command['pk10_big_small'].numQuota}" name="quotaList[1].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pk10_big_small'].betQuota}"  data-value="${command['pk10_big_small'].betQuota}" name="quotaList[1].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pk10_big_small'].playQuota}" data-value="${command['pk10_big_small'].playQuota}" name="quotaList[1].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>
                       
                        <td>单双</td>
                        <input type="hidden" value="${command['pk10_single_double'].id}" name="quotaList[2].id">
                        <input type="hidden" value="${command['pk10_single_double'].siteId}" name="quotaList[2].siteId">
                        <input type="hidden" value="${command['pk10_single_double'].code}" name="quotaList[2].code">
                        <input type="hidden" value="${command['pk10_single_double'].playCode}" name="quotaList[2].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pk10_single_double'].numQuota}" data-value="${command['pk10_single_double'].numQuota}" name="quotaList[2].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pk10_single_double'].betQuota}"  data-value="${command['pk10_single_double'].betQuota}" name="quotaList[2].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pk10_single_double'].playQuota}" data-value="${command['pk10_single_double'].playQuota}" name="quotaList[2].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>
                       
                        <td>龙虎</td>
                        <input type="hidden" value="${command['pk10_dragon_tiger'].id}" name="quotaList[3].id">
                        <input type="hidden" value="${command['pk10_dragon_tiger'].siteId}" name="quotaList[3].siteId">
                        <input type="hidden" value="${command['pk10_dragon_tiger'].code}" name="quotaList[3].code">
                        <input type="hidden" value="${command['pk10_dragon_tiger'].playCode}" name="quotaList[3].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pk10_dragon_tiger'].numQuota}" data-value="${command['pk10_dragon_tiger'].numQuota}" name="quotaList[3].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pk10_dragon_tiger'].betQuota}"  data-value="${command['pk10_dragon_tiger'].betQuota}" name="quotaList[3].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pk10_dragon_tiger'].playQuota}" data-value="${command['pk10_dragon_tiger'].playQuota}" name="quotaList[3].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                       
                        <td>冠亚军和[3,4,18,19]</td>
                        <input type="hidden" value="${command['champion_up_34'].id}" name="quotaList[4].id">
                        <input type="hidden" value="${command['champion_up_34'].siteId}" name="quotaList[4].siteId">
                        <input type="hidden" value="${command['champion_up_34'].code}" name="quotaList[4].code">
                        <input type="hidden" value="${command['champion_up_34'].playCode}" name="quotaList[4].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_34'].numQuota}" data-value="${command['champion_up_34'].numQuota}" name="quotaList[4].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_34'].betQuota}"  data-value="${command['champion_up_34'].betQuota}" name="quotaList[4].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_34'].playQuota}" data-value="${command['champion_up_34'].playQuota}" name="quotaList[4].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                       
                        <td>冠亚军和[5,6,16,17]</td>
                        <input type="hidden" value="${command['champion_up_56'].id}" name="quotaList[5].id">
                        <input type="hidden" value="${command['champion_up_56'].siteId}" name="quotaList[5].siteId">
                        <input type="hidden" value="${command['champion_up_56'].code}" name="quotaList[5].code">
                        <input type="hidden" value="${command['champion_up_56'].playCode}" name="quotaList[5].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_56'].numQuota}" data-value="${command['champion_up_56'].numQuota}" name="quotaList[5].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_56'].betQuota}"  data-value="${command['champion_up_56'].betQuota}" name="quotaList[5].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_56'].playQuota}" data-value="${command['champion_up_56'].playQuota}" name="quotaList[5].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                       
                        <td>冠亚军和[7,8,14,15]</td>
                        <input type="hidden" value="${command['champion_up_78'].id}" name="quotaList[6].id">
                        <input type="hidden" value="${command['champion_up_78'].siteId}" name="quotaList[6].siteId">
                        <input type="hidden" value="${command['champion_up_78'].code}" name="quotaList[6].code">
                        <input type="hidden" value="${command['champion_up_78'].playCode}" name="quotaList[6].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_78'].numQuota}" data-value="${command['champion_up_78'].numQuota}" name="quotaList[6].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_78'].betQuota}"  data-value="${command['champion_up_78'].betQuota}" name="quotaList[6].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_78'].playQuota}" data-value="${command['champion_up_78'].playQuota}" name="quotaList[6].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                       
                        <td>冠亚军和[9,10,12,13]</td>
                        <input type="hidden" value="${command['champion_up_910'].id}" name="quotaList[7].id">
                        <input type="hidden" value="${command['champion_up_910'].siteId}" name="quotaList[7].siteId">
                        <input type="hidden" value="${command['champion_up_910'].code}" name="quotaList[7].code">
                        <input type="hidden" value="${command['champion_up_910'].playCode}" name="quotaList[7].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_910'].numQuota}" data-value="${command['champion_up_910'].numQuota}" name="quotaList[7].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_910'].betQuota}"  data-value="${command['champion_up_910'].betQuota}" name="quotaList[7].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_910'].playQuota}" data-value="${command['champion_up_910'].playQuota}" name="quotaList[7].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                       
                        <td>独立冠亚军和[11]</td>
                        <input type="hidden" value="${command['champion_up_alone_11'].id}" name="quotaList[8].id">
                        <input type="hidden" value="${command['champion_up_alone_11'].siteId}" name="quotaList[8].siteId">
                        <input type="hidden" value="${command['champion_up_alone_11'].code}" name="quotaList[8].code">
                        <input type="hidden" value="${command['champion_up_alone_11'].playCode}" name="quotaList[8].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_alone_11'].numQuota}" data-value="${command['champion_up_alone_11'].numQuota}" name="quotaList[8].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_alone_11'].betQuota}"  data-value="${command['champion_up_alone_11'].betQuota}" name="quotaList[8].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_alone_11'].playQuota}" data-value="${command['champion_up_alone_11'].playQuota}" name="quotaList[8].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                       
                        <td>独立冠亚军和[3,4,18,19]</td>
                        <input type="hidden" value="${command['champion_up_alone_34'].id}" name="quotaList[9].id">
                        <input type="hidden" value="${command['champion_up_alone_34'].siteId}" name="quotaList[9].siteId">
                        <input type="hidden" value="${command['champion_up_alone_34'].code}" name="quotaList[9].code">
                        <input type="hidden" value="${command['champion_up_alone_34'].playCode}" name="quotaList[9].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_alone_34'].numQuota}" data-value="${command['champion_up_alone_34'].numQuota}" name="quotaList[9].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_alone_34'].betQuota}"  data-value="${command['champion_up_alone_34'].betQuota}" name="quotaList[9].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_alone_34'].playQuota}" data-value="${command['champion_up_alone_34'].playQuota}" name="quotaList[9].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                       
                        <td>独立冠亚军和[5,6,16,17]</td>
                        <input type="hidden" value="${command['champion_up_alone_56'].id}" name="quotaList[10].id">
                        <input type="hidden" value="${command['champion_up_alone_56'].siteId}" name="quotaList[10].siteId">
                        <input type="hidden" value="${command['champion_up_alone_56'].code}" name="quotaList[10].code">
                        <input type="hidden" value="${command['champion_up_alone_56'].playCode}" name="quotaList[10].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_alone_56'].numQuota}" data-value="${command['champion_up_alone_56'].numQuota}" name="quotaList[10].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_alone_56'].betQuota}"  data-value="${command['champion_up_alone_56'].betQuota}" name="quotaList[10].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_alone_56'].playQuota}" data-value="${command['champion_up_alone_56'].playQuota}" name="quotaList[10].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                       
                        <td>独立冠亚军和[7,8,14,15]</td>
                        <input type="hidden" value="${command['champion_up_alone_78'].id}" name="quotaList[11].id">
                        <input type="hidden" value="${command['champion_up_alone_78'].siteId}" name="quotaList[11].siteId">
                        <input type="hidden" value="${command['champion_up_alone_78'].code}" name="quotaList[11].code">
                        <input type="hidden" value="${command['champion_up_alone_78'].playCode}" name="quotaList[11].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_alone_78'].numQuota}" data-value="${command['champion_up_alone_78'].numQuota}" name="quotaList[11].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_alone_78'].betQuota}"  data-value="${command['champion_up_alone_78'].betQuota}" name="quotaList[11].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_alone_78'].playQuota}" data-value="${command['champion_up_alone_78'].playQuota}" name="quotaList[11].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                       
                        <td>独立冠亚军和[9,10,12,13]</td>
                        <input type="hidden" value="${command['champion_up_alone_910'].id}" name="quotaList[12].id">
                        <input type="hidden" value="${command['champion_up_alone_910'].siteId}" name="quotaList[12].siteId">
                        <input type="hidden" value="${command['champion_up_alone_910'].code}" name="quotaList[12].code">
                        <input type="hidden" value="${command['champion_up_alone_910'].playCode}" name="quotaList[12].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_alone_910'].numQuota}" data-value="${command['champion_up_alone_910'].numQuota}" name="quotaList[12].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_alone_910'].betQuota}"  data-value="${command['champion_up_alone_910'].betQuota}" name="quotaList[12].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_alone_910'].playQuota}" data-value="${command['champion_up_alone_910'].playQuota}" name="quotaList[12].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                       
                        <td>冠亚军和大小</td>
                        <input type="hidden" value="${command['champion_up_big_small'].id}" name="quotaList[13].id">
                        <input type="hidden" value="${command['champion_up_big_small'].siteId}" name="quotaList[13].siteId">
                        <input type="hidden" value="${command['champion_up_big_small'].code}" name="quotaList[13].code">
                        <input type="hidden" value="${command['champion_up_big_small'].playCode}" name="quotaList[13].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_big_small'].numQuota}" data-value="${command['champion_up_big_small'].numQuota}" name="quotaList[13].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_big_small'].betQuota}"  data-value="${command['champion_up_big_small'].betQuota}" name="quotaList[13].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_big_small'].playQuota}" data-value="${command['champion_up_big_small'].playQuota}" name="quotaList[13].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                       
                        <td>冠亚军和单双</td>
                        <input type="hidden" value="${command['champion_up_single_double'].id}" name="quotaList[14].id">
                        <input type="hidden" value="${command['champion_up_single_double'].siteId}" name="quotaList[14].siteId">
                        <input type="hidden" value="${command['champion_up_single_double'].code}" name="quotaList[14].code">
                        <input type="hidden" value="${command['champion_up_single_double'].playCode}" name="quotaList[14].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_single_double'].numQuota}" data-value="${command['champion_up_single_double'].numQuota}" name="quotaList[14].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_single_double'].betQuota}"  data-value="${command['champion_up_single_double'].betQuota}" name="quotaList[14].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_single_double'].playQuota}" data-value="${command['champion_up_single_double'].playQuota}" name="quotaList[14].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>

                        <td>冠亚军和半特</td>
                        <input type="hidden" value="${command['champion_up_half'].id}" name="quotaList[15].id">
                        <input type="hidden" value="${command['champion_up_half'].siteId}" name="quotaList[15].siteId">
                        <input type="hidden" value="${command['champion_up_half'].code}" name="quotaList[15].code">
                        <input type="hidden" value="${command['champion_up_half'].playCode}" name="quotaList[15].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_half'].numQuota}" data-value="${command['champion_up_half'].numQuota}" name="quotaList[15].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_half'].betQuota}"  data-value="${command['champion_up_half'].betQuota}" name="quotaList[15].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['champion_up_half'].playQuota}" data-value="${command['champion_up_half'].playQuota}" name="quotaList[15].playQuota">
                            </div>
                        </td>
                    </tr>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
