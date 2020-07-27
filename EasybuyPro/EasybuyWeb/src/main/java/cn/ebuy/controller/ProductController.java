package cn.ebuy.controller;

import cn.ebuy.domain.EBProduct;
import cn.ebuy.service.IEBProductCategoryService;
import cn.ebuy.service.IEBProductService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

/**
 * @author ：微笑
 * @date ：Created in 2020/7/15 16:54
 * @modified By：
 */

@Controller
@RequestMapping("/productController")
public class ProductController {


    @Autowired
    private IEBProductService productService;

    @Autowired
    private IEBProductCategoryService productCategoryService;

    @Autowired
    private ProductCategoryController productCategoryController;


    /**
     * 根据商品名称模糊查询商品信息
     *
     * @param productName
     * @return
     */
    @RequestMapping("/findByProductName.do")
    public ModelAndView findByProductName(@RequestParam(name = "name", required = true, defaultValue = "") String productName, HttpServletRequest request) throws Exception {
        ModelAndView modelAndView = new ModelAndView();
        List<EBProduct> products = productCategoryService.findByProductName(productName);
        modelAndView.addObject("products", products);
        try {
            productCategoryController.getCategory(modelAndView, request);
            productCategoryController.getEBTrolley(modelAndView, request);
        } catch (Exception e) {
            e.printStackTrace();
        }
        modelAndView.setViewName("/pre/CategoryList");
        modelAndView.addObject("productName", productName);
        return modelAndView;
    }


    /**
     * 修改商品IsDel属性
     *
     * @param id
     * @return
     */
    @RequestMapping("/updateProductIsDel.do")
    public String updateProductIsDel(@RequestParam("id") Integer id) {

        //修改IsDel
        int i = productCategoryService.updateIsDel(id);

        return "redirect:/product/findProductAll.do";
    }


    /**
     * 删除分类信息
     *
     * @param id
     * @param type
     * @return
     */
    @RequestMapping("/delProductAndCate.do")
    public String delProductAndCate(@RequestParam("id") String id, @RequestParam("type") Integer type) {
        if (type == 1) {
            productService.delByCategoryLevel1Id(id);
        } else if (type == 2) {
            productService.delByCategoryLevel2Id(id);
        } else if (type == 3) {
            productService.delByCategoryLevel3Id(id);
        }
        int i = productService.delThree(id);
        productService.delCategoryById(id);
        productService.delCategoryParentId(id);

        return "redirect:/product/findCategoryAll.do";
    }

    /**
     * 修改商品
     *
     * @param ebProduct
     * @param multipartFile
     * @param request
     * @return
     * @throws IOException
     */
    @RequestMapping("/updateProduct.do")
    public String updateProduct(EBProduct ebProduct, @RequestParam(value = "photo", required = false) MultipartFile multipartFile, HttpServletRequest request) throws IOException {


        //默认商品不删除
        ebProduct.setIsDelete(0);

        //设置上传位置
        String realPath = request.getSession().getServletContext().getRealPath("/images/");
        System.out.println(realPath);


        //如果没有改路径则创建
        File file = new File(realPath);
        if (!file.exists()) {
            file.mkdir();
        }


        if (StringUtils.isNotBlank(multipartFile.getOriginalFilename())) {
            String filename = multipartFile.getOriginalFilename();

            String uuid = UUID.randomUUID().toString().replace("_", "");
            filename = uuid + "_" + filename;

            //上传
            multipartFile.transferTo(new File(realPath, filename));

            ebProduct.setFileName(filename);
        }

        int i = productCategoryService.updateProduct(ebProduct);

        return "redirect:/product/findProductAll.do";
    }

    /**
     * 保存商品信息
     *
     * @param ebProduct
     * @param multipartFile
     * @param request
     * @return
     * @throws IOException
     */
    @RequestMapping("/saveProduct.do")
    public String saveProduct(EBProduct ebProduct, @RequestParam(value = "photo", required = false)
            MultipartFile multipartFile,
                              HttpServletRequest request) throws IOException {

        //默认商品不删除
        ebProduct.setIsDelete(0);

        //设置上传位置
        String realPath = request.getSession().getServletContext().getRealPath("/images/");
        System.out.println(realPath);


        //如果没有改路径则创建
        File file = new File(realPath);
        if (!file.exists()) {
            file.mkdir();
        }


        try {
            if (StringUtils.isNotBlank(multipartFile.getOriginalFilename())) {
                String filename = multipartFile.getOriginalFilename();

                String uuid = UUID.randomUUID().toString().replace("_", "");
                filename = uuid + "_" + filename;

                //上传
                multipartFile.transferTo(new File(realPath, filename));

                ebProduct.setFileName(filename);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (IllegalStateException e) {
            e.printStackTrace();
        }
        productCategoryService.saveProduct(ebProduct);

        return "redirect:/product/findProductAll.do";
    }

}
