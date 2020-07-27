package cn.ebuy.service;


import cn.ebuy.domain.EBTrolley;

import java.util.List;

public interface IEBTrolleyService {

    /**
     * 用户的购物车
     * @param userId
     * @return
     */
    public List<EBTrolley> findByTrolley(String userId);

    /**
     * 将商品添加到购物车
     * @param ebTrolley
     * @return
     * @throws Exception
     */
    public int saveProduct(EBTrolley ebTrolley) throws Exception;

    /**
     * 修改购物车商品数量
     * @param ebTrolley
     * @return
     */
    public int updateTrolley(EBTrolley ebTrolley);

    /**
     * 删除购物车商品
     * @param productId
     * @return
     * @throws Exception
     */
    public int delTrolleyProduct(String productId) throws Exception;

    /**
     * 订单提交后删除用户购物车
     * @param userId
     * @return
     * @throws Exception
     */
    public int delUserTrolley(String userId) throws Exception;
}
