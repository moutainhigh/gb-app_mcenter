package so.wwb.gamebox.mcenter.controller;

import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.web.controller.BaseIndexController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * @author martin
 * @time 2018-4-10 20:28:52
 */
@Controller
public class IndexController extends BaseIndexController {

    private static final String INDEX_URI = "index";

    private static final Log LOG = LogFactory.getLog(IndexController.class);

    @RequestMapping(value = "index")
    protected String index(HttpServletRequest request, Model model) {
        return INDEX_URI;
    }
}
