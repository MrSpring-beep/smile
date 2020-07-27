package cn.ebuy.dao;

import java.util.List;
import cn.ebuy.domain.EBOrder;
import cn.ebuy.domain.EBOrderDetail;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

/**
 * 订单信息数据
 * @author 微笑
 */
public interface IEBOrderDao {


    /**
     * 根据用户ID查询订单
     * @param userId
     * @return
     */
    @Select("select * from easybuy_order where userId=#{userId}")
    public List<EBOrder> findByUserId(String userId);


    /**
     * 根据订单id查询详细订单信息
     * @param orderId
     * @return
     */
    @Select("select * from easybuy_order_detail where orderId=#{orderId}")
    public List<EBOrderDetail> findByOrderId(String orderId) throws Exception;


    /**
     * 保存订单信息
     * @param ebOrder
     * @return
     */
    @Insert("insert into easybuy_order(userId,loginName,userAddress,createTime,cost,serialNumber) values (#{userId},#{loginName},#{userAddress}, " +
            " #{createTime},#{cost},#{serialNumber})")
    public int saveOrder(EBOrder ebOrder);


    /**
     * 查询所有订单信息
     * @return
     */
    @Select("select * from easybuy_order")
    public List<EBOrder> findAllOrder();


    /**
     * 根据订单编号查询订单信息
     * @param serialNumber
     * @return
     */
    @Select("select * from easybuy_order where serialNumber=#{serialNumber}")
    public EBOrder findBySerialNumber(String serialNumber);


    /**
     * 保存订单详细信息
     * @param ebOrderDetail
     * @return
     */
    @Insert("insert into easybuy_order_detail(orderId,productId,quantity,cost) values (#{orderId},#{productId},#{quantity},#{cost})")
    public int saveOrderDetail(EBOrderDetail ebOrderDetail);

}
