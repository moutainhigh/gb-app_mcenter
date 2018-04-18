package so.wwb.gamebox.service.site.report;

import org.soul.service.support.BaseService;
import so.wwb.gamebox.data.site.report.RealtimeProfileMapper;
import so.wwb.gamebox.iservice.site.report.IRealtimeProfileService;
import so.wwb.gamebox.model.site.report.po.RealtimeProfile;
import so.wwb.gamebox.model.site.report.vo.RealtimeProfileListVo;
import so.wwb.gamebox.model.site.report.vo.RealtimeProfileVo;

/**
 * 实时概况服务
 * @author martin
 * @time 2018-4-10 20:28:52
 */
public class RealtimeProfileService extends BaseService<RealtimeProfileMapper, RealtimeProfileListVo, RealtimeProfileVo, RealtimeProfile, Integer> implements IRealtimeProfileService {

}