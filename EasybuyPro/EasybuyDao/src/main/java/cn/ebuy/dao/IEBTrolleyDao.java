package cn.ebuy.dao;

import java.util.List;

import cn.ebuy.domain.EBProduct;
import cn.ebuy.domain.EBTrolley;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Service;

/**
 * 购物车信息
 * @author 微笑
 */
public interface IEBTrolleyDao {

    /**
     * 用户的购物车
     * @param userId
     * @return
     */
    @Select("select * from easybuy_trolley where userId=#{userId}")
    @Results({
            @Result(id = true,property = "id",column = "id"),
            @Result(property = "userId",column = "userId"),
            @Result(property = "productId",column = "product_id"),
            @Result(property = "count",column = "count")
    })
    public List<EBTrolley> findByTrolley(String userId);

    /**
     * 将商品添加到购物车
     * @param ebTrolley
     * @return
     * @throws Exception
     */
    @Insert("insert into easybuy_trolley (userId,product_id,count)values(#{userId},#{productId},#{count})")
    public int saveProduct(EBTrolley ebTrolley) throws Exception;

    /**
     * 修改购物车商品数量
     * @param ebTrolley
     * @return
     */
    @Update("update easybuy_trolley set count=#{count} where product_id=#{productId}")
    public int updateTrolley(EBTrolley ebTrolley);


    /**
     * 删除购物车商品
     * @param productId
     * @return
     * @throws Exception
     */
    @Delete("delete from easybuy_trolley where product_id=#{productId}")
    public int delTrolleyProduct(String productId) throws Exception;

    /**
     * 订单提交后删除用户购物车
     * @param userId
     * @return
     * @throws Exception
     */
    @Delete("delete from easybuy_trolley where userId=#{userId}")
    public int delUserTrolley(String userId) throws Exception;


}
