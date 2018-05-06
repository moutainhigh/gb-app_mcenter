package so.wwb.gamebox.mcenter.controller;

import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.tree.TreeNode;
import org.soul.model.security.privilege.po.VSysUserResource;
import org.soul.model.security.privilege.vo.SysResourceVo;
import org.soul.web.controller.BaseIndexController;
import org.soul.web.security.privilege.controller.SysResourceController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.enums.UserTypeEnum;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * @author martin
 * @time 2018-4-10 20:28:52
 */
@Controller
public class IndexController extends BaseIndexController {

    private static final String INDEX_URI = "index";

    private static final String INDEX_CONTENT_URI = "index.include/content";

    private static final Log LOG = LogFactory.getLog(IndexController.class);

    @RequestMapping(value = "index")
    protected String index(HttpServletRequest request, Model model) {
        model.addAttribute("siteName", SessionManager.getSiteName(request));
        return INDEX_URI;
    }

    @Override
    protected String content(Integer parentId, HttpServletRequest request, HttpServletResponse response, Model model) {
        SysResourceVo o = new SysResourceVo();
        UserTypeEnum userTypeEnum = UserTypeEnum.enumOf(SessionManager.getUser().getUserType());
        switch (userTypeEnum) {
            case MASTER_SUB:
                o.getSearch().setUserId(SessionManager.getUserId());
                break;
            default:
                break;
        }

        o.getSearch().setSubsysCode(SessionManager.getSubSysCode());
        o.getSearch().setParentId(11);
        List<TreeNode<VSysUserResource>> menuNodeList = ServiceTool.sysResourceService().getSubMenus(o);
        SysResourceController.loadLocal(menuNodeList);
        model.addAttribute("command", menuNodeList);
        return INDEX_CONTENT_URI;
    }
}
