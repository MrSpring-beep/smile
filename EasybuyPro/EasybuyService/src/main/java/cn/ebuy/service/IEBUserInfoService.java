package cn.ebuy.service;

import cn.ebuy.domain.EBuyUser;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * 用户信息管理业务层
 * @author 微笑
 */
public interface IEBUserInfoService {


    /**
     * 修改用户人脸状态
     * @param userId
     * @return
     */
    public int updateUserFace(String userId);

    /**
     * 修改自身信息
     * @param eBuyUser
     * @return
     */
    public int updateThisInfo(EBuyUser eBuyUser);

    /**
     * 查询所有用户信息
     * @return
     * @throws Exception
     */
    public List<EBuyUser> findUserAll(Integer page,Integer size,String userName) throws Exception;

    /**
     * 修改用户信息
     * @param user
     * @return
     * @throws Exception
     */
    public int updateUserInfo(EBuyUser user) throws Exception;

    /**
     * 删除用户信息
     * @param userId
     * @return
     */
    public int deleteUserId(String userId) throws Exception;

}
