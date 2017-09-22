<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="dataTables_wrapper" role="grid">
    <div class="panel-body">
        <div class="tab-content">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover dataTable m-b-none text-center" aria-describedby="editable_info">
                    <thead>
                    <tr class="bg-gray">
                       
                        <th>北京快乐8</th>
                        <th>单项（号）限额</th>
                        <th>单注限额</th>
                        <th>单类别单项（号）限额</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                       
                        <td>选一</td>
                        <input type="hidden" value="${command['keno_selection_one'].id}" name="quotaList[0].id">
                        <input type="hidden" value="${command['keno_selection_one'].siteId}" name="quotaList[0].siteId">
                        <input type="hidden" value="${command['keno_selection_one'].code}" name="quotaList[0].code">
                        <input type="hidden" value="${command['keno_selection_one'].playCode}" name="quotaList[0].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_selection_one'].numQuota}"  data-value="${command['keno_selection_one'].numQuota}" name="quotaList[0].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_selection_one'].betQuota}"  data-value="${command['keno_selection_one'].betQuota}" name="quotaList[0].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_selection_one'].playQuota}" data-value="${command['keno_selection_one'].playQuota}" name="quotaList[0].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                       
                        <td>选二</td>
                        <input type="hidden" value="${command['keno_selection_two'].id}" name="quotaList[1].id">
                        <input type="hidden" value="${command['keno_selection_two'].siteId}" name="quotaList[1].siteId">
                        <input type="hidden" value="${command['keno_selection_two'].code}" name="quotaList[1].code">
                        <input type="hidden" value="${command['keno_selection_two'].playCode}" name="quotaList[1].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_selection_two'].numQuota}"  data-value="${command['keno_selection_two'].numQuota}" name="quotaList[1].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_selection_two'].betQuota}"  data-value="${command['keno_selection_two'].betQuota}" name="quotaList[1].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_selection_two'].playQuota}" data-value="${command['keno_selection_two'].playQuota}" name="quotaList[1].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>
                       
                        <td>选三</td>
                        <input type="hidden" value="${command['keno_selection_three'].id}" name="quotaList[2].id">
                        <input type="hidden" value="${command['keno_selection_three'].siteId}" name="quotaList[2].siteId">
                        <input type="hidden" value="${command['keno_selection_three'].code}" name="quotaList[2].code">
                        <input type="hidden" value="${command['keno_selection_three'].playCode}" name="quotaList[2].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_selection_three'].numQuota}"  data-value="${command['keno_selection_three'].numQuota}" name="quotaList[2].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_selection_three'].betQuota}"  data-value="${command['keno_selection_three'].betQuota}" name="quotaList[2].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_selection_three'].playQuota}" data-value="${command['keno_selection_three'].playQuota}" name="quotaList[2].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>
                       
                        <td>选四</td>
                        <input type="hidden" value="${command['keno_selection_four'].id}" name="quotaList[3].id">
                        <input type="hidden" value="${command['keno_selection_four'].siteId}" name="quotaList[3].siteId">
                        <input type="hidden" value="${command['keno_selection_four'].code}" name="quotaList[3].code">
                        <input type="hidden" value="${command['keno_selection_four'].playCode}" name="quotaList[3].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_selection_four'].numQuota}"  data-value="${command['keno_selection_four'].numQuota}" name="quotaList[3].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_selection_four'].betQuota}"  data-value="${command['keno_selection_four'].betQuota}" name="quotaList[3].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_selection_four'].playQuota}" data-value="${command['keno_selection_four'].playQuota}" name="quotaList[3].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                       
                        <td>选五</td>
                        <input type="hidden" value="${command['keno_selection_five'].id}" name="quotaList[4].id">
                        <input type="hidden" value="${command['keno_selection_five'].siteId}" name="quotaList[4].siteId">
                        <input type="hidden" value="${command['keno_selection_five'].code}" name="quotaList[4].code">
                        <input type="hidden" value="${command['keno_selection_five'].playCode}" name="quotaList[4].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_selection_five'].numQuota}"  data-value="${command['keno_selection_five'].numQuota}" name="quotaList[4].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_selection_five'].betQuota}"  data-value="${command['keno_selection_five'].betQuota}" name="quotaList[4].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_selection_five'].playQuota}" data-value="${command['keno_selection_five'].playQuota}" name="quotaList[4].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                       
                        <td>和值大小</td>
                        <input type="hidden" value="${command['keno_sum20_big_small'].id}" name="quotaList[5].id">
                        <input type="hidden" value="${command['keno_sum20_big_small'].siteId}" name="quotaList[5].siteId">
                        <input type="hidden" value="${command['keno_sum20_big_small'].code}" name="quotaList[5].code">
                        <input type="hidden" value="${command['keno_sum20_big_small'].playCode}" name="quotaList[5].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_sum20_big_small'].numQuota}"  data-value="${command['keno_sum20_big_small'].numQuota}" name="quotaList[5].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_sum20_big_small'].betQuota}"  data-value="${command['keno_sum20_big_small'].betQuota}" name="quotaList[5].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_sum20_big_small'].playQuota}" data-value="${command['keno_sum20_big_small'].playQuota}" name="quotaList[5].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>
                       
                        <td>和值单双</td>
                        <input type="hidden" value="${command['keno_sum20_single_double'].id}" name="quotaList[13].id">
                        <input type="hidden" value="${command['keno_sum20_single_double'].siteId}" name="quotaList[13].siteId">
                        <input type="hidden" value="${command['keno_sum20_single_double'].code}" name="quotaList[13].code">
                        <input type="hidden" value="${command['keno_sum20_single_double'].playCode}" name="quotaList[13].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_sum20_single_double'].numQuota}"  data-value="${command['keno_sum20_single_double'].numQuota}" name="quotaList[13].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_sum20_single_double'].betQuota}"  data-value="${command['keno_sum20_single_double'].betQuota}" name="quotaList[13].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_sum20_single_double'].playQuota}" data-value="${command['keno_sum20_single_double'].playQuota}" name="quotaList[13].playQuota">
                            </div>
                        </td>

                    </tr>

                    <tr>
                       
                        <td>五行</td>
                        <input type="hidden" value="${command['keno_sum20_elements'].id}" name="quotaList[6].id">
                        <input type="hidden" value="${command['keno_sum20_elements'].siteId}" name="quotaList[6].siteId">
                        <input type="hidden" value="${command['keno_sum20_elements'].code}" name="quotaList[6].code">
                        <input type="hidden" value="${command['keno_sum20_elements'].playCode}" name="quotaList[6].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_sum20_elements'].numQuota}"  data-value="${command['keno_sum20_elements'].numQuota}" name="quotaList[6].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_sum20_elements'].betQuota}"  data-value="${command['keno_sum20_elements'].betQuota}" name="quotaList[6].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_sum20_elements'].playQuota}" data-value="${command['keno_sum20_elements'].playQuota}" name="quotaList[6].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>
                       
                        <td>上中下</td>
                        <input type="hidden" value="${command['keno_up_down'].id}" name="quotaList[7].id">
                        <input type="hidden" value="${command['keno_up_down'].siteId}" name="quotaList[7].siteId">
                        <input type="hidden" value="${command['keno_up_down'].code}" name="quotaList[7].code">
                        <input type="hidden" value="${command['keno_up_down'].playCode}" name="quotaList[7].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_up_down'].numQuota}"  data-value="${command['keno_up_down'].numQuota}" name="quotaList[7].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_up_down'].betQuota}"  data-value="${command['keno_up_down'].betQuota}" name="quotaList[7].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_up_down'].playQuota}" data-value="${command['keno_up_down'].playQuota}" name="quotaList[7].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                       
                        <td>奇偶和</td>
                        <input type="hidden" value="${command['keno_odd_even'].id}" name="quotaList[8].id">
                        <input type="hidden" value="${command['keno_odd_even'].siteId}" name="quotaList[8].siteId">
                        <input type="hidden" value="${command['keno_odd_even'].code}" name="quotaList[8].code">
                        <input type="hidden" value="${command['keno_odd_even'].playCode}" name="quotaList[8].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_odd_even'].numQuota}"  data-value="${command['keno_odd_even'].numQuota}" name="quotaList[8].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_odd_even'].betQuota}"  data-value="${command['keno_odd_even'].betQuota}" name="quotaList[8].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['keno_odd_even'].playQuota}" data-value="${command['keno_odd_even'].playQuota}" name="quotaList[8].playQuota">
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
