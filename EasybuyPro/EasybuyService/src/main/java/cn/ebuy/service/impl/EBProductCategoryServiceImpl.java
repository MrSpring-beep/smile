package cn.ebuy.service.impl;

import cn.ebuy.dao.IEBProductCategoryDao;
import cn.ebuy.domain.EBProduct;
import cn.ebuy.domain.EBProductCategory;
import cn.ebuy.service.IEBProductCategoryService;
import com.github.pagehelper.PageHelper;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author ：微笑
 * @date ：Created in 2020/7/9 22:19
 * @modified By：
 */
@Service
@Transactional
public class EBProductCategoryServiceImpl implements IEBProductCategoryService {

    @Autowired
    private IEBProductCategoryDao iebProductCategoryDao;

    @Override
    public int updateProductInventory(@Param("inventory") Integer inventory, @Param("productId") String productId) {
        return iebProductCategoryDao.updateProductInventory(inventory,productId);
    }

    @Override
    public List<EBProduct> findByProductName(String productName) {
        return iebProductCategoryDao.findByProductName(productName);
    }

    @Override
    public int updateIsDel(Integer id) {
        return iebProductCategoryDao.updateIsDel(id);
    }

    @Override
    public int saveProduct(EBProduct ebProduct) {
        return iebProductCategoryDao.saveProduct(ebProduct);
    }

    @Override
    public int updateProduct(EBProduct ebProduct) {
        return iebProductCategoryDao.updateProduct(ebProduct);
    }

    @Override
    public int saveCategory(EBProductCategory ebProductCategory) throws Exception {
        return iebProductCategoryDao.saveCategory(ebProductCategory);
    }

    @Override
    public List<EBProductCategory> findBySonId(String parentId) {
        return iebProductCategoryDao.findBySonId(parentId);
    }

    @Override
    public EBProductCategory findByParentId(String parentId) throws Exception {
        return iebProductCategoryDao.findByParentId(parentId);
    }

    @Override
    public List<EBProductCategory> findCategoryAll(Integer page,Integer size) {
        PageHelper.startPage(page,size);
        return iebProductCategoryDao.findCategoryAll();
    }

    @Override
    public List<EBProductCategory> findByCategory(String type) throws Exception {
        return iebProductCategoryDao.findByCategory(type);
    }

    @Override
    public List<EBProduct> findByCategoryId(String cateGoryId) throws Exception {
        return iebProductCategoryDao.findByCategoryId(cateGoryId);
    }

    @Override
    public EBProduct findByProductId(String productId) throws Exception {
        return iebProductCategoryDao.findByProductId(productId);
    }

    @Override
    public List<EBProduct> findProductAll() {
        return iebProductCategoryDao.findProductAll();
    }

    @Override
    public List<EBProduct> findProductAllByPage(Integer page, Integer size) {
        PageHelper.startPage(page,size);
        return iebProductCategoryDao.findProductAll();
    }

    @Override
    public List<EBProduct> findByProductCateGory2Id(String categoryId) {
        return iebProductCategoryDao.findByProductCateGory2Id(categoryId);
    }
}
