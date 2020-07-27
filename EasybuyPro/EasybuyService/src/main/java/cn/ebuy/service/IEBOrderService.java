package cn.ebuy.service;

import cn.ebuy.domain.EBOrder;
import cn.ebuy.domain.EBOrderDetail;
import org.apache.ibatis.annotations.Insert;
import org.springframework.web.bind.annotation.RequestParam;


import java.util.List;

/**
 * 订单信息业务层
 * @author 微笑
 */
public interface IEBOrderService {



    /**
     *  根据用户id查询订单信息
     * @param userId
     * @return
     */
    public List<EBOrder> findByUserId(Integer page, Integer size,String userId);

    /**
     * 根据订单id查询详细订单信息
     * @param orderId
     * @return
     */
    public List<EBOrderDetail> findByOrderId(String orderId) throws Exception;

    /**
     * 保存订单信息
     * @param ebOrder
     * @return
     */
    public int saveOrder(EBOrder ebOrder);


    /**
     * 查询所有订单信息
     * @return
     */
    public List<EBOrder> findAllOrder(Integer page, Integer size);


    /**
     * 根据订单编号查询订单信息
     * @param serialNumber
     * @return
     */
    public EBOrder findBySerialNumber(String serialNumber);


    /**
     * 保存订单详细信息
     * @param ebOrderDetail
     * @return
     */
    public int saveOrderDetail(EBOrderDetail ebOrderDetail);
}
