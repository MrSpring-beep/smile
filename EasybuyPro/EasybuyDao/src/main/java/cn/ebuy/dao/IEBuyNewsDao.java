package cn.ebuy.dao;

import cn.ebuy.domain.EBuyNews;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * 首页新闻资讯
 * @author weiixao
 */
public interface IEBuyNewsDao {


    /**
     * 删除新闻
     * @param newsId
     * @return
     */
    @Delete("delete from easybuy_news where id=#{newsId}")
    public int delNews(Integer newsId);


    /**
     * 修改新闻
     * @param eBuyNews
     * @return
     */
    @Update("update easybuy_news set title=#{title},content=#{content} where id=#{id}")
    public int updateNews(EBuyNews eBuyNews);

    /**
     * 保存新闻信息
     * @param eBuyNews
     * @return
     * @throws Exception
     */
    @Insert("insert into easybuy_news values (null,#{title},#{content},#{createTime})")
    public int saveNews(EBuyNews eBuyNews) throws Exception;

    /***
     * 查询所有新闻
     * @return
     * @throws Exception
     */
    @Select("select * from easybuy_news")
    @Results({
        @Result(id = true,property = "id",column = "id"),
        @Result(property = "title",column = "title"),
        @Result(property = "content",column = "content"),
        @Result(property = "createTime",column = "createTime")
    })
    public List<EBuyNews> findAllNews() throws Exception;

    /**
     * 查询单条新闻
     * @param id
     * @return
     */
    @Select("select * from easybuy_news where id=#{id}")
    public EBuyNews findByNewsId(Integer id);
}
