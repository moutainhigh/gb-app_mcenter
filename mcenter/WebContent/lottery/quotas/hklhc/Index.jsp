<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div  class="dataTables_wrapper" role="grid">
    <div class="panel-body">
        <div class="tab-content">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover dataTable m-b-none text-center" aria-describedby="editable_info">
                    <thead>
                    <tr class="bg-gray">
                       
                        <th>香港六合彩</th>
                        <th>单项（号）限额</th>
                        <th>单注限额</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                       
                        <td>特码</td>
                        <input type="hidden" value="${command['special_digital'].id}" name="quotaList[0].id">
                        <input type="hidden" value="${command['special_digital'].siteId}" name="quotaList[0].siteId">
                        <input type="hidden" value="${command['special_digital'].code}" name="quotaList[0].code">
                        <input type="hidden" value="${command['special_digital'].playCode}" name="quotaList[0].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['special_digital'].numQuota}" data-value="${command['special_digital'].numQuota}" name="quotaList[0].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['special_digital'].betQuota}" data-value="${command['special_digital'].betQuota}" name="quotaList[0].betQuota">
                            </div>
                        </td>
                        <input type="hidden" class="form-control input-sm" value="5000" name="quotaList[0].playQuota">
                    </tr>
                    <tr>
                       
                        <td>特码大小</td>
                        <input type="hidden" value="${command['special_big_small'].id}" name="quotaList[1].id">
                        <input type="hidden" value="${command['special_big_small'].siteId}" name="quotaList[1].siteId">
                        <input type="hidden" value="${command['special_big_small'].code}" name="quotaList[1].code">
                        <input type="hidden" value="${command['special_big_small'].playCode}" name="quotaList[1].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['special_big_small'].numQuota}" data-value="${command['special_big_small'].numQuota}" name="quotaList[1].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['special_big_small'].betQuota}" data-value="${command['special_big_small'].betQuota}" name="quotaList[1].betQuota">
                            </div>
                        </td>
                        <input type="hidden" class="form-control input-sm" value="5000" name="quotaList[1].playQuota">

                    </tr>
                    <tr>
                       
                        <td>特码单双</td>
                        <input type="hidden" value="${command['special_single_double'].id}" name="quotaList[2].id">
                        <input type="hidden" value="${command['special_single_double'].siteId}" name="quotaList[2].siteId">
                        <input type="hidden" value="${command['special_single_double'].code}" name="quotaList[2].code">
                        <input type="hidden" value="${command['special_single_double'].playCode}" name="quotaList[2].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['special_single_double'].numQuota}" data-value="${command['special_single_double'].numQuota}" name="quotaList[2].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['special_single_double'].betQuota}" data-value="${command['special_single_double'].betQuota}" name="quotaList[2].betQuota">
                            </div>
                        </td>
                        <input type="hidden" class="form-control input-sm" value="5000" name="quotaList[2].playQuota">
                    </tr>
                    <tr>
                       
                        <td>特码合数单双</td>
                        <input type="hidden" value="${command['special_sum_single_double'].id}" name="quotaList[3].id">
                        <input type="hidden" value="${command['special_sum_single_double'].siteId}" name="quotaList[3].siteId">
                        <input type="hidden" value="${command['special_sum_single_double'].code}" name="quotaList[3].code">
                        <input type="hidden" value="${command['special_sum_single_double'].playCode}" name="quotaList[3].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['special_sum_single_double'].numQuota}" data-value="${command['special_sum_single_double'].numQuota}" name="quotaList[3].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['special_sum_single_double'].betQuota}" data-value="${command['special_sum_single_double'].betQuota}" name="quotaList[3].betQuota">
                            </div>
                        </td>
                        <input type="hidden" class="form-control input-sm" value="5000" name="quotaList[3].playQuota">
                    </tr>

                    <tr>
                       
                        <td>正码</td>
                        <input type="hidden" value="${command['positive_digital'].id}" name="quotaList[4].id">
                        <input type="hidden" value="${command['positive_digital'].siteId}" name="quotaList[4].siteId">
                        <input type="hidden" value="${command['positive_digital'].code}" name="quotaList[4].code">
                        <input type="hidden" value="${command['positive_digital'].playCode}" name="quotaList[4].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['positive_digital'].numQuota}" data-value="${command['positive_digital'].numQuota}" name="quotaList[4].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['positive_digital'].betQuota}" data-value="${command['positive_digital'].betQuota}" name="quotaList[4].betQuota">
                            </div>
                        </td>

                        <input type="hidden" class="form-control input-sm" value="5000" name="quotaList[4].playQuota">
                    </tr>

                    <tr>
                       
                        <td>正码特</td>
                        <input type="hidden" value="${command['positive_special_digital'].id}" name="quotaList[17].id">
                        <input type="hidden" value="${command['positive_special_digital'].siteId}" name="quotaList[17].siteId">
                        <input type="hidden" value="${command['positive_special_digital'].code}" name="quotaList[17].code">
                        <input type="hidden" value="${command['positive_special_digital'].playCode}" name="quotaList[17].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['positive_special_digital'].numQuota}" data-value="${command['positive_special_digital'].numQuota}" name="quotaList[17].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['positive_special_digital'].betQuota}" data-value="${command['positive_special_digital'].betQuota}" name="quotaList[17].betQuota">
                            </div>
                        </td>

                        <input type="hidden" class="form-control input-sm" value="5000" name="quotaList[17].playQuota">
                    </tr>


                    <tr>
                       
                        <td>特码合数单双</td>
                        <input type="hidden" value="${command['special_sum_single_double'].id}" name="quotaList[7].id">
                        <input type="hidden" value="${command['special_sum_single_double'].siteId}" name="quotaList[7].siteId">
                        <input type="hidden" value="${command['special_sum_single_double'].code}" name="quotaList[7].code">
                        <input type="hidden" value="${command['special_sum_single_double'].playCode}" name="quotaList[7].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['special_sum_single_double'].numQuota}" data-value="${command['special_sum_single_double'].numQuota}" name="quotaList[7].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['special_sum_single_double'].betQuota}" data-value="${command['special_sum_single_double'].betQuota}" name="quotaList[7].betQuota">
                            </div>
                        </td>

                        <input type="hidden" class="form-control input-sm" value="5000" name="quotaList[7].playQuota">
                    </tr>

                    <tr>
                       
                        <td>特码尾数大小</td>
                        <input type="hidden" value="${command['special_mantissa_big_small'].id}" name="quotaList[8].id">
                        <input type="hidden" value="${command['special_mantissa_big_small'].siteId}" name="quotaList[8].siteId">
                        <input type="hidden" value="${command['special_mantissa_big_small'].code}" name="quotaList[8].code">
                        <input type="hidden" value="${command['special_mantissa_big_small'].playCode}" name="quotaList[8].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['special_mantissa_big_small'].numQuota}" data-value="${command['special_mantissa_big_small'].numQuota}" name="quotaList[8].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['special_mantissa_big_small'].betQuota}" data-value="${command['special_mantissa_big_small'].betQuota}" name="quotaList[8].betQuota">
                            </div>
                        </td>

                        <input type="hidden" class="form-control input-sm" value="5000" name="quotaList[8].playQuota">
                    </tr>


                    <tr>
                       
                        <td>特码半特</td>
                        <input type="hidden" value="${command['special_half'].id}" name="quotaList[9].id">
                        <input type="hidden" value="${command['special_half'].siteId}" name="quotaList[9].siteId">
                        <input type="hidden" value="${command['special_half'].code}" name="quotaList[9].code">
                        <input type="hidden" value="${command['special_half'].playCode}" name="quotaList[9].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['special_half'].numQuota}" data-value="${command['special_half'].numQuota}" name="quotaList[9].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['special_half'].betQuota}" data-value="${command['special_half'].betQuota}" name="quotaList[9].betQuota">
                            </div>
                        </td>

                        <input type="hidden" class="form-control input-sm" value="5000" name="quotaList[9].playQuota">
                    </tr>


                    <tr>
                       
                        <td>特码色波</td>
                        <input type="hidden" value="${command['special_colour'].id}" name="quotaList[10].id">
                        <input type="hidden" value="${command['special_colour'].siteId}" name="quotaList[10].siteId">
                        <input type="hidden" value="${command['special_colour'].code}" name="quotaList[10].code">
                        <input type="hidden" value="${command['special_colour'].playCode}" name="quotaList[10].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['special_colour'].numQuota}" data-value="${command['special_colour'].numQuota}" name="quotaList[10].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['special_colour'].betQuota}" data-value="${command['special_colour'].betQuota}" name="quotaList[10].betQuota">
                            </div>
                        </td>

                        <input type="hidden" class="form-control input-sm" value="5000" name="quotaList[10].playQuota">
                    </tr>

                    <tr>
                       
                        <td>总和大小</td>
                        <input type="hidden" value="${command['seven_sum_big_small'].id}" name="quotaList[11].id">
                        <input type="hidden" value="${command['seven_sum_big_small'].siteId}" name="quotaList[11].siteId">
                        <input type="hidden" value="${command['seven_sum_big_small'].code}" name="quotaList[11].code">
                        <input type="hidden" value="${command['seven_sum_big_small'].playCode}" name="quotaList[11].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['seven_sum_big_small'].numQuota}" data-value="${command['seven_sum_big_small'].numQuota}" name="quotaList[11].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['seven_sum_big_small'].betQuota}" data-value="${command['seven_sum_big_small'].betQuota}" name="quotaList[11].betQuota">
                            </div>
                        </td>

                        <input type="hidden" class="form-control input-sm" value="5000" name="quotaList[11].playQuota">
                    </tr>

                    <tr>
                       
                        <td>总和单双</td>
                        <input type="hidden" value="${command['seven_sum_single_double'].id}" name="quotaList[12].id">
                        <input type="hidden" value="${command['seven_sum_single_double'].siteId}" name="quotaList[12].siteId">
                        <input type="hidden" value="${command['seven_sum_single_double'].code}" name="quotaList[12].code">
                        <input type="hidden" value="${command['seven_sum_single_double'].playCode}" name="quotaList[12].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['seven_sum_single_double'].numQuota}" data-value="${command['seven_sum_single_double'].numQuota}" name="quotaList[12].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['seven_sum_single_double'].betQuota}" data-value="${command['seven_sum_single_double'].betQuota}" name="quotaList[12].betQuota">
                            </div>
                        </td>

                        <input type="hidden" class="form-control input-sm" value="5000" name="quotaList[12].playQuota">
                    </tr>


                    <tr>
                       
                        <td>正码1-6单双</td>
                        <input type="hidden" value="${command['positive_single_double'].id}" name="quotaList[13].id">
                        <input type="hidden" value="${command['positive_single_double'].siteId}" name="quotaList[13].siteId">
                        <input type="hidden" value="${command['positive_single_double'].code}" name="quotaList[13].code">
                        <input type="hidden" value="${command['positive_single_double'].playCode}" name="quotaList[13].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['positive_single_double'].numQuota}" data-value="${command['positive_single_double'].numQuota}" name="quotaList[13].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['positive_single_double'].betQuota}" data-value="${command['positive_single_double'].betQuota}" name="quotaList[13].betQuota">
                            </div>
                        </td>

                        <input type="hidden" class="form-control input-sm" value="5000" name="quotaList[13].playQuota">
                    </tr>

                    <tr>
                       
                        <td>正码1-6大小</td>
                        <input type="hidden" value="${command['positive_big_small'].id}" name="quotaList[14].id">
                        <input type="hidden" value="${command['positive_big_small'].siteId}" name="quotaList[14].siteId">
                        <input type="hidden" value="${command['positive_big_small'].code}" name="quotaList[14].code">
                        <input type="hidden" value="${command['positive_big_small'].playCode}" name="quotaList[14].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['positive_big_small'].numQuota}" data-value="${command['positive_big_small'].numQuota}" name="quotaList[14].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['positive_big_small'].betQuota}" data-value="${command['positive_big_small'].betQuota}" name="quotaList[14].betQuota">
                            </div>
                        </td>

                        <input type="hidden" class="form-control input-sm" value="5000" name="quotaList[14].playQuota">
                    </tr>

                    <tr>
                       
                        <td>正码1-6合数单双</td>
                        <input type="hidden" value="${command['positive_sum_single_double'].id}" name="quotaList[15].id">
                        <input type="hidden" value="${command['positive_sum_single_double'].siteId}" name="quotaList[15].siteId">
                        <input type="hidden" value="${command['positive_sum_single_double'].code}" name="quotaList[15].code">
                        <input type="hidden" value="${command['positive_sum_single_double'].playCode}" name="quotaList[15].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['positive_sum_single_double'].numQuota}" data-value="${command['positive_sum_single_double'].numQuota}" name="quotaList[15].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['positive_sum_single_double'].betQuota}" data-value="${command['positive_sum_single_double'].betQuota}" name="quotaList[15].betQuota">
                            </div>
                        </td>

                        <input type="hidden" class="form-control input-sm" value="5000" name="quotaList[15].playQuota">
                    </tr>


                    <tr>
                       
                        <td>正码1-6色波</td>
                        <input type="hidden" value="${command['positive_colour'].id}" name="quotaList[16].id">
                        <input type="hidden" value="${command['positive_colour'].siteId}" name="quotaList[16].siteId">
                        <input type="hidden" value="${command['positive_colour'].code}" name="quotaList[16].code">
                        <input type="hidden" value="${command['positive_colour'].playCode}" name="quotaList[16].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['positive_colour'].numQuota}" data-value="${command['positive_colour'].numQuota}" name="quotaList[16].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['positive_colour'].betQuota}" data-value="${command['positive_colour'].betQuota}" name="quotaList[16].betQuota">
                            </div>
                        </td>

                        <input type="hidden" class="form-control input-sm" value="5000" name="quotaList[16].playQuota">
                    </tr>

                    <tr>
                       
                        <td>正码1-6合数大小</td>
                        <input type="hidden" value="${command['positive_sum_big_small'].id}" name="quotaList[18].id">
                        <input type="hidden" value="${command['positive_sum_big_small'].siteId}" name="quotaList[18].siteId">
                        <input type="hidden" value="${command['positive_sum_big_small'].code}" name="quotaList[18].code">
                        <input type="hidden" value="${command['positive_sum_big_small'].playCode}" name="quotaList[18].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['positive_sum_big_small'].numQuota}" data-value="${command['positive_sum_big_small'].numQuota}" name="quotaList[18].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['positive_sum_big_small'].betQuota}" data-value="${command['positive_sum_big_small'].betQuota}" name="quotaList[18].betQuota">
                            </div>
                        </td>

                        <input type="hidden" class="form-control input-sm" value="5000" name="quotaList[18].playQuota">
                    </tr>

                    <tr>
                       
                        <td>正码1-6尾数大小</td>
                        <input type="hidden" value="${command['positive_mantissa_big_small'].id}" name="quotaList[19].id">
                        <input type="hidden" value="${command['positive_mantissa_big_small'].siteId}" name="quotaList[19].siteId">
                        <input type="hidden" value="${command['positive_mantissa_big_small'].code}" name="quotaList[19].code">
                        <input type="hidden" value="${command['positive_mantissa_big_small'].playCode}" name="quotaList[19].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['positive_mantissa_big_small'].numQuota}" data-value="${command['positive_mantissa_big_small'].numQuota}" name="quotaList[19].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['positive_mantissa_big_small'].betQuota}" data-value="${command['positive_mantissa_big_small'].betQuota}" name="quotaList[19].betQuota">
                            </div>
                        </td>

                        <input type="hidden" class="form-control input-sm" value="5000" name="quotaList[19].playQuota">
                    </tr>


                    <tr>
                       
                        <td>特码合数大小</td>
                        <input type="hidden" value="${command['special_sum_big_small'].id}" name="quotaList[20].id">
                        <input type="hidden" value="${command['special_sum_big_small'].siteId}" name="quotaList[20].siteId">
                        <input type="hidden" value="${command['special_sum_big_small'].code}" name="quotaList[20].code">
                        <input type="hidden" value="${command['special_sum_big_small'].playCode}" name="quotaList[20].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['special_sum_big_small'].numQuota}" data-value="${command['special_sum_big_small'].numQuota}" name="quotaList[20].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['special_sum_big_small'].betQuota}" data-value="${command['special_sum_big_small'].betQuota}" name="quotaList[20].betQuota">
                            </div>
                        </td>

                        <input type="hidden" class="form-control input-sm" value="5000" name="quotaList[20].playQuota">
                    </tr>

                    <tr>
                       
                        <td>半波大小</td>
                        <input type="hidden" value="${command['lhc_half_colour_big_small'].id}" name="quotaList[21].id">
                        <input type="hidden" value="${command['lhc_half_colour_big_small'].siteId}" name="quotaList[21].siteId">
                        <input type="hidden" value="${command['lhc_half_colour_big_small'].code}" name="quotaList[21].code">
                        <input type="hidden" value="${command['lhc_half_colour_big_small'].playCode}" name="quotaList[21].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['lhc_half_colour_big_small'].numQuota}" data-value="${command['lhc_half_colour_big_small'].numQuota}" name="quotaList[21].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['lhc_half_colour_big_small'].betQuota}" data-value="${command['lhc_half_colour_big_small'].betQuota}" name="quotaList[21].betQuota">
                            </div>
                        </td>

                        <input type="hidden" class="form-control input-sm" value="5000" name="quotaList[21].playQuota">
                    </tr>

                    <tr>
                       
                        <td>半波单双</td>
                        <input type="hidden" value="${command['lhc_half_colour_single_double'].id}" name="quotaList[22].id">
                        <input type="hidden" value="${command['lhc_half_colour_single_double'].siteId}" name="quotaList[22].siteId">
                        <input type="hidden" value="${command['lhc_half_colour_single_double'].code}" name="quotaList[22].code">
                        <input type="hidden" value="${command['lhc_half_colour_single_double'].playCode}" name="quotaList[22].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['lhc_half_colour_single_double'].numQuota}" data-value="${command['lhc_half_colour_single_double'].numQuota}" name="quotaList[22].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['lhc_half_colour_single_double'].betQuota}" data-value="${command['lhc_half_colour_single_double'].betQuota}" name="quotaList[22].betQuota">
                            </div>
                        </td>

                        <input type="hidden" class="form-control input-sm" value="5000" name="quotaList[22].playQuota">
                    </tr>

                    <tr>
                       
                        <td>特肖</td>
                        <input type="hidden" value="${command['special_zodiac'].id}" name="quotaList[23].id">
                        <input type="hidden" value="${command['special_zodiac'].siteId}" name="quotaList[23].siteId">
                        <input type="hidden" value="${command['special_zodiac'].code}" name="quotaList[23].code">
                        <input type="hidden" value="${command['special_zodiac'].playCode}" name="quotaList[23].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['special_zodiac'].numQuota}" data-value="${command['special_zodiac'].numQuota}" name="quotaList[23].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['special_zodiac'].betQuota}" data-value="${command['special_zodiac'].betQuota}" name="quotaList[23].betQuota">
                            </div>
                        </td>

                        <input type="hidden" class="form-control input-sm" value="5000" name="quotaList[23].playQuota">
                    </tr>

                    <tr>
                       
                        <td>一肖</td>
                        <input type="hidden" value="${command['lhc_one_zodiac'].id}" name="quotaList[24].id">
                        <input type="hidden" value="${command['lhc_one_zodiac'].siteId}" name="quotaList[24].siteId">
                        <input type="hidden" value="${command['lhc_one_zodiac'].code}" name="quotaList[24].code">
                        <input type="hidden" value="${command['lhc_one_zodiac'].playCode}" name="quotaList[24].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['lhc_one_zodiac'].numQuota}" data-value="${command['lhc_one_zodiac'].numQuota}" name="quotaList[24].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['lhc_one_zodiac'].betQuota}" data-value="${command['lhc_one_zodiac'].betQuota}" name="quotaList[24].betQuota">
                            </div>
                        </td>

                        <input type="hidden" class="form-control input-sm" value="5000" name="quotaList[24].playQuota">
                    </tr>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

