package cn.ebuy.dao;

import org.apache.ibatis.annotations.Delete;

/**
 * 商品删除
 * @author 微笑
 */
public interface IEBProductDel {

    @Delete("delete from easybuy_product where categoryLevel1Id=#{id}")
    public int delByCategoryLevel1Id(String id);

    @Delete("delete from easybuy_product where categoryLevel2Id=#{id}")
    public int delByCategoryLevel2Id(String id);

    @Delete("delete from easybuy_product where categoryLevel3Id=#{id}")
    public int delByCategoryLevel3Id(String id);

    @Delete("delete from easybuy_product_category where id=#{id}")
    public int delCategoryById(String id);

    @Delete("delete from easybuy_product_category where parentId=#{id}")
    public int delCategoryParentId(String id);
}
