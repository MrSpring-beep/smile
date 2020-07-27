package cn.ebuy.service.impl;

import cn.ebuy.dao.IEBProductDel;
import cn.ebuy.domain.EBProductCategory;
import cn.ebuy.service.IEBProductCategoryService;
import cn.ebuy.service.IEBProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author ：微笑
 * @date ：Created in 2020/7/15 16:49
 * @modified By：
 */
@Service
@Transactional
public class IEBProductServiceImpl implements IEBProductService {


    @Autowired
    private IEBProductDel productDel;

    @Autowired
    private IEBProductCategoryService productCategoryService;


    @Override
    public int delByCategoryLevel1Id(String id) {
        return productDel.delByCategoryLevel1Id(id);
    }

    @Override
    public int delByCategoryLevel2Id(String id) {
        return productDel.delByCategoryLevel2Id(id);
    }

    @Override
    public int delByCategoryLevel3Id(String id) {
        return productDel.delByCategoryLevel3Id(id);
    }

    @Override
    public int delCategoryById(String id) {
        return productDel.delCategoryById(id);
    }

    @Override
    public int delCategoryParentId(String id) {
        return productDel.delCategoryParentId(id);
    }

    @Override
    public int delThree(String id){
        int del=0;
        List<EBProductCategory> categories = productCategoryService.findBySonId(id);
        for (EBProductCategory category : categories) {
           del= productDel.delCategoryParentId(category.getId().toString());
        }
        return del;
    }
}
