package so.wwb.gamebox.mcenter.operation.controller;

import org.soul.commons.bean.IEntity;
import org.soul.commons.lang.string.StringTool;
import org.soul.iservice.support.IBaseService;
import org.soul.model.common.BaseListVo;
import org.soul.model.common.BaseObjectVo;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.support.IForm;
import org.springframework.ui.Model;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.master.operation.po.VActivityMessage;
import so.wwb.gamebox.model.master.operation.vo.VActivityMessageVo;
import so.wwb.gamebox.model.master.player.po.PlayerRank;
import so.wwb.gamebox.model.master.player.vo.PlayerRankVo;

import java.util.*;

/**
 * Created by bruce on 16-4-16.
 */
public abstract class ActivityController<S extends IBaseService, L extends BaseListVo, O extends BaseObjectVo,
        QF extends IForm, SF extends IForm, E extends IEntity<PK>, PK> extends BaseCrudController<S,L,O,QF,SF,E,PK> {

    /**
     * 是否有可用层级
     * true:表示可以编辑和创建活动
     * @return
     */
    protected boolean hasUseRank(String code) {
        boolean flag = true;
        List<VActivityMessage> activityMessages = loadActivityMessageByActivityType(code);
        if (activityMessages == null || activityMessages.size()==0) {
            return flag;
        }
        if (hasAllRanksOfActivities(activityMessages)) {
            flag = false;
        } else {
            Map<String, Object> map = filterCombinedRanks(getCombinedRanks(activityMessages));
            if (!(boolean)map.get("isAllRank")) {
                flag = false;
            }
        }
        return flag;
    }

    protected List<VActivityMessage> loadActivityMessageByActivityType(String code,Integer... activityMessageIds) {
       return ServiceTool.vActivityMessageService().searchActivityMessageByActivityType(new VActivityMessageVo(), code,
               SessionManager.getLocale().toString(),activityMessageIds);
    }

    /**
     * 是否已经有全部层级的活动
     *
     * @param vActivityMessages
     * @return
     */
    protected boolean hasAllRanksOfActivities(List<VActivityMessage> vActivityMessages) {
        boolean hasActivities = false;
        for (VActivityMessage vActivityMessage : vActivityMessages) {
            boolean isAllRank = (vActivityMessage.getIsAllRank()==null
                    || !vActivityMessage.getIsAllRank()) ? Boolean.FALSE : vActivityMessage.getIsAllRank();
            if (isAllRank) {
                hasActivities = true;
                break;
            }
        }
        return hasActivities;
    }

    /**
     * 如果没有全部层级的活动，合并活动层级
     *
     * @param vActivityMessages
     * @return
     */
    protected String getCombinedRanks(List<VActivityMessage> vActivityMessages) {
        StringBuilder stringBuilder = new StringBuilder();
//        if (!hasAllRanksOfActivities(vActivityMessages)) {
            for (int i = 0; i < vActivityMessages.size(); i++) {
               /* if (i == 0) {
                    combinedRanks = vActivityMessages.get(i).getRankid();
                    stringBuilder = new StringBuilder(combinedRanks);
                    continue;
                }*/
                String tempRanks = StringTool.substring(vActivityMessages.get(i).getRankid(), 0,
                        vActivityMessages.get(i).getRankid().length() - 1);
                String ranks[] = tempRanks.split(",");
                for (String rank : ranks) {
                    String tempRank = rank + ",";
                    if (!StringTool.contains(stringBuilder.toString(), tempRank)) {
                        stringBuilder.append(tempRank);
                    }
                }
            }
//        }
        return stringBuilder.toString();
    }

    /**
     * 剔除combinedRanks层级数据
     *
     * @param combinedRanks
     * @return
     */
    private Map<String, Object> filterCombinedRanks(String combinedRanks) {
        boolean flag = true;
        Map<String, Object> map = new HashMap<>();
        List<PlayerRank> playerRanks = getNormalPlayRanks();
        String tempRanks = StringTool.substring(combinedRanks, 0, combinedRanks.length() - 1);
        String ranks[] = tempRanks.split(",");
        for (Iterator<PlayerRank> iterator = playerRanks.iterator(); iterator.hasNext(); ) {
            String rankId = String.valueOf(iterator.next().getId());
            for (String rank : ranks) {
                if (rankId.equals(rank)) {
                    iterator.remove();
                    flag = false;
                }
            }
        }
        map.put("isAllRank", flag);//标识是否是全部层级
//        map.put("playerRanks", playerRanks);
        return map;
    }

    /**
     * 剔除层级数据并转换为名称
     *
     * @param vActivityMessages
     * @return
     */
    protected Map<String, Object> filterRanksAndConvertRankIdToName(List<VActivityMessage> vActivityMessages) {
//        Boolean isAllRank = true;
        Map<String, Object> map = new HashMap<>();
        List<PlayerRank> playerRanks = null;
        StringBuilder stringBuilder = null;
//        if (!hasAllRanksOfActivities(vActivityMessages)) {
            playerRanks = getNormalPlayRanks();
            for (int i = 0; i < vActivityMessages.size(); i++) {
                stringBuilder = new StringBuilder();
                String tempRanks = StringTool.substring(vActivityMessages.get(i).getRankid(), 0,
                        vActivityMessages.get(i).getRankid().length() - 1);
                String ranks[] = tempRanks.split(",");
                for (String rankId : ranks) {
                    for (Iterator<PlayerRank> iterator = playerRanks.iterator(); iterator.hasNext(); ) {
                        PlayerRank playerRank = iterator.next();
                        if (String.valueOf(playerRank.getId()).equals(rankId)) {
                            stringBuilder.append(playerRank.getRankName()).append("、");
//                            iterator.remove();
//                            isAllRank = false;
                        }
                    }
                }
                vActivityMessages.get(i).setRankName(StringTool.substring(stringBuilder.toString(), 0,
                        stringBuilder.toString().length() - 1));
            }
//        }
//        map.put("isAllRank", isAllRank);
        map.put("playerRanks", playerRanks);
        return map;
    }

    /**
     * 获取玩家正常层级
     */
    protected List<PlayerRank> getNormalPlayRanks() {
        return ServiceTool.playerRankService().queryUsableList(new PlayerRankVo());
    }

    protected Map<String, Object> isAllRank(String combinedRanks) {
        return filterCombinedRanks(combinedRanks);
    }

    public void buildActivityMoneyData(Model model){
        Map<String,Object> hourList = new LinkedHashMap<>();
        Map<String,Object> minutesList = new LinkedHashMap<>();
        for(int i=0;i<24;i++){
            String value = i+"";
            if(i<10){
                value = "0"+i;
            }
            hourList.put(i+"",value);
        }

        for(int i=0;i<60;i++){
            String value = i+"";
            if(i<10){
                value = "0"+i;
            }
            minutesList.put(i+"",value);
        }
        model.addAttribute("hourList",hourList);
        model.addAttribute("minutesList",minutesList);
    }
}
