package cn.ebuy.dao;

import java.util.List;
import cn.ebuy.domain.EBuyUser;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

/**
 * 用户信息管理
 * @author weixiao
 */
public interface IEBUserInfoDao {


    /**
     * 修改用户人脸状态
     * @param userId
     * @return
     */
    @Update("update easybuy_user set isFaceExists=1 where id=#{userId}")
    public int updateUserFace(String userId);

    /**
     * 修改自身信息
     * @param eBuyUser
     * @return
     */
    @Update("update easybuy_user set loginName=#{loginName},password=#{password},email=#{email},mobile=#{mobile} where id=#{id}")
    public int updateThisInfo(EBuyUser eBuyUser);

    /**
     * 查询所有用户信息
     * @return
     * @throws Exception
     */
    @Select("select * from easybuy_user where username like '%${username}%'")
    public List<EBuyUser> findUserAll(@Param("username")String username) throws Exception;

    /**
     * 修改用户信息
     * @param user
     * @return
     * @throws Exception
     */
    @Update("update easybuy_user set loginName=#{loginName},userName=#{userName}," +
            "identityCode=#{identityCode},email=#{email},mobile=#{mobile},type=#{type} where id=#{id}")
    public int updateUserInfo(EBuyUser user) throws Exception;


    /**
     * 删除用户信息
     * @param userId
     * @return
     */
    @Delete("delete from easybuy_user where id=#{userId}")
    public int deleteUserId(String userId) throws Exception;

}
