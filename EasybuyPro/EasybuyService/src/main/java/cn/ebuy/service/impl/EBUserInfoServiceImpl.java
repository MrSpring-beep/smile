package cn.ebuy.service.impl;

import cn.ebuy.dao.IEBUserInfoDao;
import cn.ebuy.domain.EBuyUser;
import cn.ebuy.service.IEBUserInfoService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * @author ：微笑
 * @date ：Created in 2020/7/14 10:10
 * @modified By：
 */

@Service
@Transactional
public class EBUserInfoServiceImpl implements IEBUserInfoService {

    @Autowired
    private IEBUserInfoDao userInfoDao;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;


    @Override
    public int updateUserFace(String userId) {
        return userInfoDao.updateUserFace(userId);
    }

    @Override
    public int updateThisInfo(EBuyUser eBuyUser) {
        return userInfoDao.updateThisInfo(eBuyUser);
    }

    @Override
    public List<EBuyUser> findUserAll(Integer page,Integer size,String userName) throws Exception {
        PageHelper.startPage(page,size);
        return userInfoDao.findUserAll(userName);
    }

    @Override
    public int updateUserInfo(EBuyUser user) throws Exception {
        return userInfoDao.updateUserInfo(user);
    }

    @Override
    public int deleteUserId(String userId) throws Exception {
        return userInfoDao.deleteUserId(userId);
    }
}
