package cn.ebuy.dao;

import cn.ebuy.domain.EBUserAddress;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * 用户地址
 * @author 微笑
 */
public interface IEBUserAddressDao {


    /**
     * 删除用户地址
     * @param id
     * @return
     */
    @Delete("delete from easybuy_user_address where id=#{id}")
    public Integer delUserAddress(Integer id);

    /**
     * 查询用户默认地址
     * @return
     */
    @Select("select * from easybuy_user_address where isDefault=1")
    public EBUserAddress findByIsDefault();

    /**
     * 根据用户id查询用户收货地址
     * @param userId
     * @return
     */
    @Select("select * from easybuy_user_address where userId=#{userId}")
    public List<EBUserAddress> findByUserIdAddress(String userId);


    /**
     * 根据id查询地址
     * @param id
     * @return
     */
    @Select("select * from easybuy_user_address where id=#{id}")
    public EBUserAddress findByAddressId(String id);


    /**
     * 修改用户地址
     * @param address
     * @return
     * @throws Exception
     */
    @Update("update easybuy_user_address set address=#{address},isDefault=#{isDefault},remark=#{remark} where id=#{id}")
    public int updateAddress(EBUserAddress address) throws Exception;


    /**
     * 保存用户地址
     * @param address
     * @return
     * @throws Exception
     */
    @Insert("insert into easybuy_user_address values(null,#{userId},#{address},#{createTime},#{isDefault},#{remark})")
    public int saveUserAddress(EBUserAddress address) throws Exception;

}
