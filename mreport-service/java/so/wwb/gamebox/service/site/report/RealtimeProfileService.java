package so.wwb.gamebox.service.site.report;

import org.soul.service.support.BaseService;
import so.wwb.gamebox.data.site.report.RealtimeProfileMapper;
import so.wwb.gamebox.iservice.site.report.IRealtimeProfileService;
import so.wwb.gamebox.model.site.report.po.RealtimeProfile;
import so.wwb.gamebox.model.site.report.vo.RealtimeProfileListVo;
import so.wwb.gamebox.model.site.report.vo.RealtimeProfileVo;
import java.util.Date;
import java.util.List;

/**
 * 实时概况服务
 *
 * @author martin
 * @time 2018-4-10 20:28:52
 */
public class RealtimeProfileService extends BaseService<RealtimeProfileMapper, RealtimeProfileListVo, RealtimeProfileVo, RealtimeProfile, Integer> implements IRealtimeProfileService {

    @Override
    public List<RealtimeProfile> queryRealtimeCartogram(RealtimeProfileVo condition) {
        RealtimeProfile realtimeProfile = new RealtimeProfile();
        realtimeProfile.setCreateTime(new Date());
        List<RealtimeProfile> profiles = this.mapper.queryRealtimeCartogram(condition);

        /*Calendar createDate = Calendar.getInstance();
        createDate.set(Calendar.HOUR,0);
        createDate.set(Calendar.MINUTE,0);
        createDate.set(Calendar.SECOND,0);
        createDate.set(Calendar.MILLISECOND,0);
        //昨日此时的实时数据
        RealtimeProfile yesterdayRealtimeProfile = null ;
        Iterator<RealtimeProfile> iterator = profiles.iterator();
        while(iterator.hasNext()){
            RealtimeProfile next = iterator.next();
            if(next.getCreateTime().getTime() < createDate.getTime().getTime()){
                yesterdayRealtimeProfile = next;
                profiles.remove(next);
            }
        }*/

        return profiles;
    }

    @Override
    public List<RealtimeProfileVo> queryHistoryReportForm(RealtimeProfileVo condition) {
        RealtimeProfile realtimeProfile = new RealtimeProfile();
        realtimeProfile.setCreateTime(new Date());
        List<RealtimeProfileVo> profileVos = this.mapper.queryHistoryReportForm(condition);
        return profileVos;

    }

    @Override
    public List<RealtimeProfile> queryNowAndYesterdayData(RealtimeProfileVo condition) {
        return this.mapper.queryNowAndYesterdayData(condition);
    }
}