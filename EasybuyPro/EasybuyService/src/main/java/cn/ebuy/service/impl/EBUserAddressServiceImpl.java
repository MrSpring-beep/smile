package cn.ebuy.service.impl;

import cn.ebuy.dao.IEBUserAddressDao;
import cn.ebuy.domain.EBUserAddress;
import cn.ebuy.service.IEBUserAddressService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

/**
 * @author ：微笑
 * @date ：Created in 2020/7/12 22:45
 * @modified By：
 */
@Service
@Transactional
public class EBUserAddressServiceImpl implements IEBUserAddressService {

    @Autowired
    private IEBUserAddressDao userAddressDao;

    @Override
    public Integer delUserAddress(Integer id) {
        return userAddressDao.delUserAddress(id);
    }

    @Override
    public EBUserAddress findByIsDefault() {
        return userAddressDao.findByIsDefault();
    }

    @Override
    public List<EBUserAddress> findByUserIdAddress(String userId) {
        return userAddressDao.findByUserIdAddress(userId);
    }

    @Override
    public List<EBUserAddress> findByUserPageIdAddress(String userId, Integer page, Integer size) {
        PageHelper.startPage(page,size);
        return userAddressDao.findByUserIdAddress(userId);
    }


    @Override
    public EBUserAddress findByAddressId(String id) {
        return userAddressDao.findByAddressId(id);
    }

    @Override
    public int updateAddress(EBUserAddress address) throws Exception {
        return userAddressDao.updateAddress(address);
    }

    @Override
    public int saveUserAddress(EBUserAddress address) throws Exception {
        return userAddressDao.saveUserAddress(address);
    }
}
