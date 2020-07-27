package cn.ebuy.controller;

import cn.ebuy.domain.EBuyNews;
import cn.ebuy.service.IEBuyNewsService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * @author ：微笑
 * @date ：Created in 2020/6/25 1:01
 * @modified By：
 */

@Controller
@RequestMapping("/news")
public class NewsController {

    @Autowired
    private IEBuyNewsService newsService;


    /**
     * 修改新闻
     * @param eBuyNews
     * @return
     */
    @RequestMapping("/updateNews.do")
    public String updateNews(EBuyNews eBuyNews){
        System.out.println(eBuyNews);
        int i = newsService.updateNews(eBuyNews);
        return "redirect:/news/findNewList.do";
    }

    /**
     * 删除新闻
     * @param newsId
     * @return
     */
    @RequestMapping("/delNews.do")
    public String delNews(@RequestParam("newsId")Integer newsId){
        int i = newsService.delNews(newsId);
        return "redirect:/news/findNewList.do";
    }


    /**
     * 新增新闻信息
     *
     * @param eBuyNews
     * @return
     */
    @RequestMapping("/saveNews.do")
    public String saveNews(EBuyNews eBuyNews) throws Exception {
        ModelAndView modelAndView = new ModelAndView();

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String date = dateFormat.format(new Date());
        Date newDate = dateFormat.parse(date);
        eBuyNews.setCreateTime(newDate);
        int i = newsService.saveNews(eBuyNews);

        return "redirect:/news/findNewList.do";
    }

    /**
     * 查询所有新闻资讯并分页
     *
     * @param page
     * @param size
     * @return
     * @throws Exception
     */
    @RequestMapping("/findNewList.do")
    public ModelAndView findNewList(@RequestParam(name = "page", required = true, defaultValue = "1") Integer page, @RequestParam(name = "size", required = true, defaultValue = "10") Integer size, HttpServletRequest request) throws Exception {

        ModelAndView modelAndView = new ModelAndView();
        List<EBuyNews> news = newsService.findNewsPage(page, size);

        PageInfo<EBuyNews> pageInfo = new PageInfo<EBuyNews>(news);

        modelAndView.addObject("pageInfo", pageInfo);
        modelAndView.addObject("url", "news/findNewList.do");
        modelAndView.addObject("menu", "7");
//        modelAndView.addObject("isOne",1);
        HttpSession session = request.getSession();
        session.setAttribute("isOne",1);
        modelAndView.setViewName("backend/news/newsList");
        return modelAndView;
    }

    /**
     * 查询单条新闻信息
     *
     * @param id
     * @return
     */
    @RequestMapping("/findNewsById.do")
    public ModelAndView findByNewsId(@RequestParam(name = "id", required = true) Integer id) {
        ModelAndView modelAndView = new ModelAndView();

        EBuyNews eBuyNews = newsService.findByNewsId(id);
        modelAndView.addObject("news", eBuyNews);
        modelAndView.setViewName("backend/news/newsDetail");

        return modelAndView;
    }

}
