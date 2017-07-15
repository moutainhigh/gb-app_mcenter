<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="lot_two_menu">
    <a href="javascript:void(0)" type="one">${views.lottery_auto['一字']}</a>
    <a href="javascript:void(0)" type="two">${views.lottery_auto['二字']}</a>
    <a href="javascript:void(0)" type="three">${views.lottery_auto['三字']}</a>
    <a href="javascript:void(0)" type="lhh">${views.lottery_auto['总合/龙虎和']}</a>
   <%-- <a href="javascript:void(0)" type="group">${views.lottery_auto['组选']}</a>--%>
    <%--<a href="javascript:void(0)" code="sum">${views.lottery_auto['和数']}</a>--%>
</div>


<script>
    $(function () {
        $(".lot_two_menu a").click(function (e) {
            $(this).addClass('active');
            $(this).siblings().removeClass('active');
            var type = $(this).attr("type");
            //获取时时彩类别列表
            $("#lot_three_menu").load(root+'/lottery/odds/${code}/'+type+'/categoryIndex.html');
            $("#lot_three_menu").show();
        });

        if(!$(".lot_two_menu a").hasClass('active')){
            $(".lot_two_menu a").eq(0).trigger("click");
        }
    });
</script>