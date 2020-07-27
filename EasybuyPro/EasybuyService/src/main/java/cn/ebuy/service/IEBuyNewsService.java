package cn.ebuy.service;

import cn.ebuy.domain.EBuyNews;

import java.util.List;

/**
 * 首页新闻资讯
 * @author 微笑
 */
public interface IEBuyNewsService {


    /**
     * 删除新闻
     * @param newsId
     * @return
     */
    public int delNews(Integer newsId);

    /**
     * 修改新闻
     * @param eBuyNews
     * @return
     */
    public int updateNews(EBuyNews eBuyNews);


    /**
     * 保存新闻信息
     * @param eBuyNews
     * @return
     * @throws Exception
     */
    public int saveNews(EBuyNews eBuyNews) throws Exception;

    /**
     * 查询所有新闻
     * @return
     * @throws Exception
     */
    public List<EBuyNews> findAllNews() throws Exception;


    /**
     * 查询所有新闻并分页
     * @param page
     * @param size
     * @return
     * @throws Exception
     */
    public List<EBuyNews> findNewsPage(Integer page,Integer size) throws Exception;


    /**
     * 查询单条新闻信息
     * @param id
     * @return
     */
    public EBuyNews findByNewsId(Integer id);

}
