package cn.ebuy.service;

import cn.ebuy.domain.EBProduct;
import cn.ebuy.domain.EBProductCategory;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 查询1~3级分类
 * service
 * @author 微笑
 */
public interface IEBProductCategoryService {


    /**
     * 修改商品
     * @param inventory
     * @param productId
     * @return
     */
    public int updateProductInventory(@Param("inventory") Integer inventory,@Param("productId") String productId);

    /**
     * 根据商品名称模糊查询商品
     * @param productName
     * @return
     */
    public List<EBProduct> findByProductName(@Param("productName")String productName);

    /**
     * 修改商品是否删除信息
     * @param id
     * @return
     */
    public int updateIsDel(Integer id);


    /**
     * 保存商品信息
     * @param ebProduct
     * @return
     */
    public int saveProduct(EBProduct ebProduct);

    /**
     * 修改商品信息
     * @param ebProduct
     * @return
     */
    public int updateProduct(EBProduct ebProduct);

    /**
     * 保存分类信息
     * @param ebProductCategory
     * @return
     * @throws Exception
     */
    public int saveCategory(EBProductCategory ebProductCategory)throws Exception;

    /**
     * 根据父级id查询子级
     * @param parentId
     * @return
     */
    public List<EBProductCategory> findBySonId(String parentId);

    /**
     * 根据id查询分类信息
     * @param parentId
     * @return
     * @throws Exception
     */
    public EBProductCategory findByParentId(String parentId) throws Exception;

    /**
     * 查询所有分类信息
     * @return
     */
    public List<EBProductCategory> findCategoryAll(Integer page,Integer size);

    /**
     * 查询1~3级分类
     * @return
     */
    public List<EBProductCategory> findByCategory(String type) throws Exception;

    /**
     * 查询指定三级分类下的产品
     * @param cateGoryId
     * @return
     */
    public List<EBProduct> findByCategoryId(String cateGoryId) throws Exception;

    /**
     * 查询单条商品信息
     * @param productId
     * @return
     */
    public EBProduct findByProductId(String productId) throws Exception;


    /**
     * 查询所有商品
     * @return
     */
    public List<EBProduct> findProductAll();

    /**
     * 查询所有商品并分页
     * @return
     */
    public List<EBProduct> findProductAllByPage(Integer page,Integer size);

    /**
     * 根据二级分类id查询
     * @param categoryId
     * @return
     */
    public List<EBProduct> findByProductCateGory2Id(String categoryId);


}
