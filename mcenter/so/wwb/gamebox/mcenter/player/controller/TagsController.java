package so.wwb.gamebox.mcenter.player.controller;

import org.soul.commons.lang.string.StringTool;
import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.master.player.ITagsService;
import so.wwb.gamebox.mcenter.player.form.TagsForm;
import so.wwb.gamebox.mcenter.player.form.TagsSearchForm;
import so.wwb.gamebox.model.master.player.po.Tags;
import so.wwb.gamebox.model.master.player.vo.TagsListVo;
import so.wwb.gamebox.model.master.player.vo.TagsVo;

import javax.servlet.http.HttpServletRequest;
import java.util.List;


/**
 * 控制器
 *
 * Created by jeff using soul-code-generator on 2015-6-29 14:26:35
 */
@Controller
//region your codes 1
@RequestMapping("/tags")
public class TagsController extends BaseCrudController<ITagsService, TagsListVo, TagsVo, TagsSearchForm, TagsForm, Tags, Integer> {


        private static final Long MAX_TAG = 50L;
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/player/tag/";
        //endregion your codes 2
    }

    //region your codes 3
    @RequestMapping(value = "/getAllTag",method = RequestMethod.GET)
    @ResponseBody
    public List getAllTag(TagsListVo listVo,HttpServletRequest request){
       String tagName= request.getParameter("tagName");
        listVo.getSearch().setTagName(tagName);
        return this.getService().search(listVo).getResult();
    }

    /**
     * 检查tagName是否重复
     * @param tagName
     * @return
     */
    @RequestMapping(value = "/checkTagName")
    @ResponseBody
    public String checkTagName(@RequestParam("result.tagName") String tagName,@RequestParam("result.id") String id){
        TagsListVo tagsListVo = new TagsListVo();
        tagsListVo.getSearch().setTagName(tagName);
        tagsListVo.getSearch().setNeId(StringTool.isBlank(id) ? null : Integer.valueOf(id));
        long count = getService().count(tagsListVo);
        return count > 0 ? "false" : "true";
    }
    @RequestMapping(value = "/checkMax50Tag")
    @ResponseBody
    public boolean  checkMax50Tag(@RequestParam("result.tagType") Integer tagType,@RequestParam("result.id") Integer id){
        if(tagType == null){
            return false;
        }
        TagsListVo tagsListVo = new TagsListVo();
        tagsListVo.getSearch().setTagType(Integer.valueOf(tagType));
        tagsListVo.getSearch().setNeId(id);
        long count = getService().count(tagsListVo);

        return (count < MAX_TAG);
    }

    @Override
    protected TagsVo doPersist(TagsVo objectVo) {
        objectVo.getResult().setBuiltIn(false);
        return super.doPersist(objectVo);
    }

    //endregion your codes 3

}