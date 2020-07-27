package cn.ebuy.service.impl;

import cn.ebuy.dao.IEBOrderDao;
import cn.ebuy.domain.EBOrder;
import cn.ebuy.domain.EBOrderDetail;
import cn.ebuy.service.IEBOrderService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author ：微笑
 * @date ：Created in 2020/7/12 23:14
 * @modified By：
 */

@Service
@Transactional
public class EBOrderServiceImpl implements IEBOrderService {

    @Autowired
    private IEBOrderDao oderDao;

    @Override
    public List<EBOrder> findByUserId(Integer page, Integer size,String userId) {
        PageHelper.startPage(page,size);
        return oderDao.findByUserId(userId);
    }

    @Override
    public List<EBOrderDetail> findByOrderId(String orderId) throws Exception {
        return oderDao.findByOrderId(orderId);
    }

    @Override
    public int saveOrder(EBOrder ebOrder) {
        return oderDao.saveOrder(ebOrder);
    }

    @Override
    public List<EBOrder> findAllOrder(Integer page, Integer size) {
        PageHelper.startPage(page,size);
        return oderDao.findAllOrder();
    }

    @Override
    public EBOrder findBySerialNumber(String serialNumber) {
        return oderDao.findBySerialNumber(serialNumber);
    }

    @Override
    public int saveOrderDetail(EBOrderDetail ebOrderDetail) {
        return oderDao.saveOrderDetail(ebOrderDetail);
    }
}
