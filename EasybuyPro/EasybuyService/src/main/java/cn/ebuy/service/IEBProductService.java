package cn.ebuy.service;

import org.apache.ibatis.annotations.Delete;

/**
 * 删除商品及分类
 * @author 微笑
 */
public interface IEBProductService {


    public int delByCategoryLevel1Id(String id);


    public int delByCategoryLevel2Id(String id);


    public int delByCategoryLevel3Id(String id);

    public int delCategoryById(String id);

    public int delCategoryParentId(String id);

    public int delThree(String id);

}
