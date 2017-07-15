<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div  class="dataTables_wrapper" role="grid">
    <div class="panel-body">
        <div class="tab-content">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover dataTable m-b-none text-center" aria-describedby="editable_info">
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
                    <%@include file="../include/Digist.jsp"%>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>