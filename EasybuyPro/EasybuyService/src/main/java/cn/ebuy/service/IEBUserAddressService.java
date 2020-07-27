package cn.ebuy.service;

import cn.ebuy.domain.EBUserAddress;
import java.util.List;

public interface IEBUserAddressService {


    /**
     * 删除用户地址
     * @param id
     * @return
     */
    public Integer delUserAddress(Integer id);

    /**
     * 查询用户默认地址
     * @return
     */
    public EBUserAddress findByIsDefault();

    /**
     * 根据用户id查询用户收货地址
     * @param userId
     * @return
     */
    public List<EBUserAddress> findByUserIdAddress(String userId);

    /**
     * 根据用户id查询用户收货地址
     * 分页
     * @param userId
     * @return
     */
    public List<EBUserAddress> findByUserPageIdAddress(String userId,Integer page,Integer size);

    /**
     * 根据id查询地址
     * @param id
     * @return
     */
    public EBUserAddress findByAddressId(String id);


    /**
     * 修改用户地址
     * @param address
     * @return
     * @throws Exception
     */
    public int updateAddress(EBUserAddress address) throws Exception;

    /**
     * 保存用户地址
     * @param address
     * @return
     * @throws Exception
     */
    public int saveUserAddress(EBUserAddress address) throws Exception;
}
