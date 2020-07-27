package cn.ebuy.dao;

import cn.ebuy.domain.EBProduct;
import cn.ebuy.domain.EBProductCategory;
import org.apache.ibatis.annotations.*;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
/**
 * 商品信息及分类
 * @author 微笑
 */
public interface IEBProductCategoryDao {


    /**
     * 修改商品库存
     * @param inventory
     * @param productId
     * @return
     */
    @Update("update easybuy_product set inventory=#{inventory} where id=#{productId}")
    public int updateProductInventory(@Param("inventory") Integer inventory,@Param("productId") String productId);

    /**
     * 根据商品名称模糊查询商品
     * @param productName
     * @return
     */
    @Select("select * from easybuy_product where name like '%${productName}%' ")
    public List<EBProduct> findByProductName(@Param("productName")String productName);

    /**
     * 修改是否删除
     * @param id
     * @return
     */
    @Update("update easybuy_product set isDelete=1 where id=#{id}")
    public int updateIsDel(Integer id);

    /**
     * 保存商品信息
     * @param ebProduct
     * @return
     */
    @Insert("insert into easybuy_product values(null,#{name},#{description},#{price},#{stock},#{categoryLevel1Id},#{categoryLevel2Id}," +
            "#{categoryLevel3Id},#{fileName},#{isDelete},1000)")
    public int saveProduct(EBProduct ebProduct);

    /**
     * 修改商品信息
     * @param ebProduct
     * @return
     */
    @Update("update easybuy_product set name=#{name},description=#{description},price=#{price},stock=#{stock},categoryLevel1Id=#{categoryLevel1Id}," +
            "categoryLevel2Id=#{categoryLevel2Id},categoryLevel3Id=#{categoryLevel3Id},fileName=#{fileName},isDelete=#{isDelete} where id=#{id}")
    public int updateProduct(EBProduct ebProduct);

    /**
     * 保存分类信息
     * @param ebProductCategory
     * @return
     * @throws Exception
     */
    @Insert("insert into easybuy_product_category(name,parentId,type,iconClass)value(#{name},#{parentId},#{type},#{iconClass})")
    public int saveCategory(EBProductCategory ebProductCategory)throws Exception;

    /**
     * 根据父级id查询子级
     * @param parentId
     * @return
     */
    @Select("select * from easybuy_product_category where parentId=#{parentId}")
    public  List<EBProductCategory> findBySonId(String parentId);

    /**
     * 根据id查询分类信息
     * @param parentId
     * @return
     * @throws Exception
     */
    @Select("select * from easybuy_product_category where id=#{parentId}")
    public EBProductCategory findByParentId(String parentId) throws Exception;

    /**
     * 查询所有分类信息
     * @return
     */
    @Select("select * from easybuy_product_category")
    public List<EBProductCategory> findCategoryAll();

    /**
     * 查询1~3级分类
     * @return
     */
    @Select("select * from easybuy_product_category where type=#{type}")
    public List<EBProductCategory> findByCategory(String type) throws Exception;

    /**
     * 查询指定三级分类下的产品
     * @param cateGoryId
     * @return
     */
    @Select("select * from easybuy_product where categoryLevel3Id=#{cateGoryId}")
    public List<EBProduct> findByCategoryId(String cateGoryId) throws Exception;

    /**
     * 查询单条商品信息
     * @param productId
     * @return
     */
    @Select("select * from easybuy_product where id=#{productId}")
    public EBProduct findByProductId(String productId) throws Exception;

    /**
     * 查询所有商品
     * @return
     */
    @Select("select * from easybuy_product  where isDelete=0")
    public List<EBProduct> findProductAll();

    /**
     * 根据二级分类id查询
     * @param categoryId
     * @return
     */
    @Select("select * from easybuy_product where categoryLevel2Id=#{categoryId}")
    public List<EBProduct> findByProductCateGory2Id(String categoryId);


}
