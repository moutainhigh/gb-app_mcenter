<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="lot_two_menu">
    <%@ include file="/include/include.inc.jsp" %>
    <a href="javascript:void(0)" type="special" betCode="special" page="special">特码/波色/生肖</a>&nbsp;&nbsp;-&nbsp;&nbsp;
    <a href="javascript:void(0)" type="positiveNum" betCode="positive_first" page="positiveNum">正码一</a>&nbsp;&nbsp;-&nbsp;&nbsp;
    <a href="javascript:void(0)" type="positiveNum" betCode="positive_second" page="positiveNum">正码二</a>&nbsp;&nbsp;-&nbsp;&nbsp;
    <a href="javascript:void(0)" type="positiveNum" betCode="positive_third" page="positiveNum">正码三</a>&nbsp;&nbsp;-&nbsp;&nbsp;
    <a href="javascript:void(0)" type="positiveNum" betCode="positive_fourth" page="positiveNum">正码四</a>&nbsp;&nbsp;-&nbsp;&nbsp;
    <a href="javascript:void(0)" type="positiveNum" betCode="positive_fifth" page="positiveNum">正码五</a>&nbsp;&nbsp;-&nbsp;&nbsp;
    <a href="javascript:void(0)" type="positiveNum" betCode="positive_sixth" page="positiveNum">正码六</a>&nbsp;&nbsp;-&nbsp;&nbsp;
    <a href="javascript:void(0)" type="positiveB" betCode="positive" page="positiveB">正码</a>&nbsp;&nbsp;-&nbsp;&nbsp;
    <a href="javascript:void(0)" type="sevensum" betCode="seven_sum" page="sevensum">总和</a>&nbsp;&nbsp;-&nbsp;&nbsp;
    <a href="javascript:void(0)" type="halfcolour" betCode="lhc_half_colour" page="halfcolour">半波</a>&nbsp;&nbsp;-&nbsp;&nbsp;
    <a href="javascript:void(0)" type="onezodiac" betCode="lhc_one_zodiac" page="onezodiac">一肖</a>&nbsp;&nbsp;-&nbsp;&nbsp;
    <a href="javascript:void(0)" type="linkcode" betCode="lhc_link_code" page="linkcode">连码</a>&nbsp;&nbsp;-&nbsp;&nbsp;
    <a href="javascript:void(0)" type="linkzodiac" betCode="lhc_link_zodiac" page="linkzodiac">连肖</a>&nbsp;&nbsp;-&nbsp;&nbsp;
    <a href="javascript:void(0)" type="allzodiac" betCode="lhc_all_zodiac" page="allzodiac">合肖</a>&nbsp;&nbsp;-&nbsp;&nbsp;
    <a href="javascript:void(0)" type="linkmantissa" betCode="lhc_link_mantissa" page="linkmantissa">连尾</a>&nbsp;&nbsp;-&nbsp;&nbsp;
    <a href="javascript:void(0)" type="allnoin" betCode="lhc_all_no_in" page="allnoin">全不中</a>&nbsp;&nbsp;
</div>
<script>
    $(function () {
        $(".lot_two_menu a").click(function (e) {
            $(this).addClass('active');
            $(this).siblings().removeClass('active');
            var type = $(this).attr("type");
            //获取时时彩类别列表
            if("special"==type||"positiveNum"==type||"positiveB"==type
                ||"sevensum"==type||"halfcolour"==type ||"onezodiac"==type){
                var siteId=$("#search_id").val();
                var page = $(this).attr("page");
                var betCode = $(this).attr("betCode");
                $("#editable_wrapper").load(root+'/lottery/odds/${code}/'+betCode+'/Index.html?page='+page+"&siteId="+siteId);
                $("#lot_three_menu").hide();
            }else{
                $("#lot_three_menu").load(root+'/lottery/odds/${code}/'+type+'/categoryIndex.html');
                $("#lot_three_menu").show();
            }
        });

        if(!$(".lot_two_menu a").hasClass('active')){
            $(".lot_two_menu a").eq(0).trigger("click");
        }
    });
</script>