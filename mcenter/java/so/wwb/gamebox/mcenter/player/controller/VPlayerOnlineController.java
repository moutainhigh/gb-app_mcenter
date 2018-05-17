package so.wwb.gamebox.mcenter.player.controller;

import org.soul.commons.dict.DictTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.net.IpTool;
import org.soul.model.sys.po.SysParam;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.session.RedisSessionDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.iservice.master.player.IVPlayerOnlineService;
import so.wwb.gamebox.mcenter.player.form.VPlayerOnlineForm;
import so.wwb.gamebox.mcenter.player.form.VPlayerOnlineSearchForm;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.SiteParamEnum;
import so.wwb.gamebox.model.master.player.po.VPlayerOnline;
import so.wwb.gamebox.model.master.player.vo.PlayerRankVo;
import so.wwb.gamebox.model.master.player.vo.VPlayerOnlineListVo;
import so.wwb.gamebox.model.master.player.vo.VPlayerOnlineVo;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 控制器
 *
 * @author chai
 * @time 2015-9-2 11:08:56
 */
@Controller
//region your codes 1
@RequestMapping("/vPlayerOnline")
public class VPlayerOnlineController extends BaseCrudController<IVPlayerOnlineService, VPlayerOnlineListVo, VPlayerOnlineVo, VPlayerOnlineSearchForm, VPlayerOnlineForm, VPlayerOnline, Integer> {
//endregion your codes 1
    @Autowired
    private RedisSessionDao redisSessionDao;
    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/player/playerOnline/";
        //endregion your codes 2
    }

    //region your codes 3
    @Override
    protected VPlayerOnlineListVo doList(VPlayerOnlineListVo listVo, VPlayerOnlineSearchForm form, BindingResult result, Model model) {
        //调用接口的getplayersOnline方法
        Map map = new HashMap(2,1f);
        String ip = listVo.getSearch().getIp();
        if (StringTool.isNotBlank(ip)) {
            listVo.getSearch().setLoginIp(IpTool.ipv4StringToLong(ip));
        }
        listVo = this.getService().queryOnlineUser(listVo);
        // 查询总资产
        listVo = this.getService().queryApiBalance(listVo);

        List<VPlayerOnline> list = listVo.getResult();

        Map<String, Serializable> terminal = DictTool.get(DictEnum.PLAYER_CHANNEL_TERMINAL);
        map.put("search.username","账号");
        map.put("search.ip","IP");
        model.addAttribute("userType",map);
        model.addAttribute("channelTerminal", terminal);
        model.addAttribute("playerRanks", ServiceSiteTool.playerRankService().queryUsableList(new PlayerRankVo()));
        SysParam telemarketing = ParamTool.getSysParam(SiteParamEnum.ELECTRIC_PIN_SWITCH);
        model.addAttribute("electric_pin",telemarketing);
        for (int i = 0; i < list.size(); i++) {
            Long hours = DateTool.hoursBetween(list.get(i).getLastActiveTime(), list.get(i).getLoginTime());
            Long minutes = DateTool.minutesBetween(list.get(i).getLastActiveTime(), list.get(i).getLoginTime()) - hours * 60;
            Long seconds = DateTool.secondsBetween(list.get(i).getLastActiveTime(), list.get(i).getLoginTime()) - hours * 3600 - minutes * 60;

            list.get(i).setHours(hours);
            list.get(i).setMinutes(minutes);
            list.get(i).setSeconds(seconds);
            if (list.get(i).getTotalOnlineTime() != null && list.get(i).getTotalOnlineTime() > 0) {
                Long time_total = list.get(i).getTotalOnlineTime();
                list.get(i).setDays_total(time_total / (3600 * 24));
                list.get(i).setHours_total((time_total % (3600 * 24)) / 3600);
                list.get(i).setMinutes_total((time_total % (3600)) / 60);
                list.get(i).setSeconds_total(time_total % 60);
            } else {
                list.get(i).setDays_total(0L);
                list.get(i).setHours_total(0L);
                list.get(i).setMinutes_total(0L);
                list.get(i).setSeconds_total(0L);
            }
        }
        return listVo;
    }
    //endregion your codes 3

}