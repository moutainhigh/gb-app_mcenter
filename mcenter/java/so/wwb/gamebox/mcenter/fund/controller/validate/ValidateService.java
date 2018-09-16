package so.wwb.gamebox.mcenter.fund.controller.validate;

import com.alibaba.druid.pool.DruidDataSource;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.data.datasource.DatasourceTool;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.ui.Model;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.master.player.so.PlayerTransactionSo;
import so.wwb.gamebox.model.master.player.vo.PlayerTransactionVo;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 此处不走rcp
 */
public class ValidateService {

    private static final Log LOG = LogFactory.getLog(ValidateService.class);
    private static ValidateService instance;

    private ValidateService() {

    }

    public static ValidateService getInstance() {
        return new ValidateService();
    }

    public void validateDraw(Integer playerId, Model model) {
        model.addAttribute("funds_error", "0");
        //1 find valid log
        List<ValidateVo> vlateVos = loadValidateVo(playerId);
        //2 get jy from jytable and asctoamd5
        for (ValidateVo trvo : vlateVos) {
            PlayerTransactionVo trRecord = getTrRecord(trvo.getTid());//获取库的记录
            if (trRecord.getResult() == null) {
                LOG.warn("发现存在未正常的交易信息！疑似交易记录被删除！！！trNo=" + trvo.getTid());
                model.addAttribute("funds_error", "1");
                break;
            } else {
                ValidateVo vvo = new ValidateVo(trRecord.getResult());//转换成秘钥对应vo
                String keyStr = vvo.genKey();//生成密钥
                if (!keyStr.equals(trvo.getKeyStr())) {//与之前存储匹配，如果有不正确则。。。
                    LOG.warn("发现存在未正常的交易信息！trNo=" + trvo.getTid());
                    model.addAttribute("funds_error", "1");
                    break;
                }
            }
        }
    }

    private List<ValidateVo> loadValidateVo(Integer playerId) {
        List<ValidateVo> result = new ArrayList<>();
        try {
            PlayerTransactionVo ptvo = new PlayerTransactionVo();
            ptvo.setPlayerId(playerId);
            ptvo._setDataSourceId(SessionManager.getSiteId());
            List<Map<String, Object>> mapList = ServiceSiteTool.getPlayerTransactionService().queryTranLog(ptvo);
            for (Map<String, Object> map : mapList) {
                ValidateVo vo = new ValidateVo();
                vo.setKeyStr(map.get("store_text") == null ? "" : map.get("store_text").toString());
                vo.setPlid(map.get("plid") == null ? null : Integer.parseInt(map.get("plid").toString()));
                vo.setTid(map.get("trno") == null ? "" : map.get("trno").toString());
                result.add(vo);
            }
        } catch (Exception e) {
            LOG.warn("查询表失败，疑似未创建表结构。无法校验资金合法性");
        }
        return result;
    }

    public void validateDraw(String trNo, Model model) {
        PlayerTransactionVo vo = getTrRecord(trNo);
        //检查资金异常与否
        validateDraw(vo.getResult().getPlayerId(), model);
    }

    private PlayerTransactionVo getTrRecord(String trNo) {
        PlayerTransactionVo vo = new PlayerTransactionVo();
        PlayerTransactionSo ps = new PlayerTransactionSo();
        ps.setTransactionNo(trNo);
        vo.setSearch(ps);
        vo = ServiceSiteTool.getPlayerTransactionService().search(vo);
        return vo;
    }
}
