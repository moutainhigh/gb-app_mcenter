<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="lot_two_menu">
    <%@ include file="/include/include.inc.jsp" %>
    <a href="javascript:void(0)" betCode="special" page="special">${views.lottery_auto['特码/波色/生肖']}</a>&nbsp;&nbsp;-&nbsp;&nbsp;
    <a href="javascript:void(0)" betCode="positive_first" page="positiveNum">${views.lottery_auto['正码一']}</a>&nbsp;&nbsp;-&nbsp;&nbsp;
    <a href="javascript:void(0)" betCode="positive_second" page="positiveNum">${views.lottery_auto['正码二']}</a>&nbsp;&nbsp;-&nbsp;&nbsp;
    <a href="javascript:void(0)" betCode="positive_third" page="positiveNum">${views.lottery_auto['正码三']}</a>&nbsp;&nbsp;-&nbsp;&nbsp;
    <a href="javascript:void(0)" betCode="positive_fourth" page="positiveNum">${views.lottery_auto['正码四']}</a>&nbsp;&nbsp;-&nbsp;&nbsp;
    <a href="javascript:void(0)" betCode="positive_fifth" page="positiveNum">${views.lottery_auto['正码五']}</a>&nbsp;&nbsp;-&nbsp;&nbsp;
    <a href="javascript:void(0)" betCode="positive_sixth" page="positiveNum">${views.lottery_auto['正码六']}</a>&nbsp;&nbsp;-&nbsp;&nbsp;
    <a href="javascript:void(0)" betCode="positive" page="positiveB">${views.lottery_auto['正码']}</a>&nbsp;&nbsp;-&nbsp;&nbsp;
    <a href="javascript:void(0)" betCode="seven_sum" page="sevensum">${views.lottery_auto['总和']}</a>&nbsp;&nbsp;-&nbsp;&nbsp;
    <a href="javascript:void(0)" betCode="lhc_half_colour" page="halfcolour">半波</a>&nbsp;&nbsp;-&nbsp;&nbsp;
    <a href="javascript:void(0)" betCode="lhc_one_zodiac" page="onezodiac">一肖</a>&nbsp;&nbsp;-&nbsp;&nbsp;
</div>
<script>
    $(function () {
        $(".lot_two_menu a").click(function (e) {
            $(this).addClass('active');
            $(this).siblings().removeClass('active');
            var betCode = $(this).attr("betCode");
            var page = $(this).attr("page");
            $("#lot_three_menu").hide();
            $("#editable_wrapper").load(root+'/lottery/odds/hklhc/'+betCode+'/Index.html?page='+page);
        });

        if(!$(".lot_two_menu a").hasClass('active')){
            $(".lot_two_menu a").eq(0).trigger("click");
        }
    });
</script>