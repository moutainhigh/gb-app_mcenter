package so.wwb.gamebox.mcenter.player.controller;

import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.net.IpTool;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.session.RedisSessionDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.player.IVPlayerOnlineService;
import so.wwb.gamebox.mcenter.player.form.VPlayerOnlineForm;
import so.wwb.gamebox.mcenter.player.form.VPlayerOnlineSearchForm;
import so.wwb.gamebox.model.enums.UserTypeEnum;
import so.wwb.gamebox.model.master.player.po.VPlayerOnline;
import so.wwb.gamebox.model.master.player.vo.VPlayerOnlineListVo;
import so.wwb.gamebox.model.master.player.vo.VPlayerOnlineVo;

import java.util.List;


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
        List<String> strings= redisSessionDao.getUserTypeActiveSessions(UserTypeEnum.PLAYER.getCode());
        for(String key:strings){
            String[] str = key.split(",");

            if(str.length==3 && !listVo.getSearch().getUserIds().contains(Integer.valueOf(str[1]))) {
                listVo.getSearch().getUserIds().add(Integer.valueOf(str[1]));
                //listVo.getSearch().getSessionKeys().add(str[2]);
            }
        }

        if(strings.size()>0) {
            //调用接口的getplayersOnline方法
            String ip = listVo.getSearch().getIp();
            if (StringTool.isNotBlank(ip)) {
                listVo.getSearch().setLoginIp(IpTool.ipv4StringToLong(ip));
            }
            listVo = this.getService().search(listVo);
            // 查询总资产
            listVo = this.getService().queryApiBalance(listVo);

            List<VPlayerOnline> list = listVo.getResult();

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
        }
        return listVo;
    }
    //endregion your codes 3

}