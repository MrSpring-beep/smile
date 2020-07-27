package cn.ebuy.service.impl;

import cn.ebuy.dao.IEBTrolleyDao;
import cn.ebuy.domain.EBProduct;
import cn.ebuy.domain.EBTrolley;
import cn.ebuy.service.IEBTrolleyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author ：微笑
 * @date ：Created in 2020/7/11 17:52
 * @modified By：
 */

@Service
@Transactional
public class EBTrolleyServiceImpl implements IEBTrolleyService {

    @Autowired
    private IEBTrolleyDao trolleyDao;

    @Override
    public List<EBTrolley> findByTrolley(String userId) {
        return trolleyDao.findByTrolley(userId);
    }

    @Override
    public int saveProduct(EBTrolley ebTrolley) throws Exception {
        return trolleyDao.saveProduct(ebTrolley);
    }

    @Override
    public int updateTrolley(EBTrolley ebTrolley) {
        return trolleyDao.updateTrolley(ebTrolley);
    }

    @Override
    public int delTrolleyProduct(String productId) throws Exception {
        return trolleyDao.delTrolleyProduct(productId);
    }

    @Override
    public int delUserTrolley(String userId) throws Exception {
        return trolleyDao.delUserTrolley(userId);
    }
}
