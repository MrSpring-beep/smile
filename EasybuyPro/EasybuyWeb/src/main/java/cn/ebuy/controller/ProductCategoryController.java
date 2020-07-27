package cn.ebuy.controller;

import cn.ebuy.domain.*;
import cn.ebuy.service.*;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.github.pagehelper.PageInfo;
import com.sun.org.apache.regexp.internal.RE;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;


/**
 * @author ：微笑
 * @date ：Created in 2020/7/9 22:21
 * @modified By：
 */

@RequestMapping("/product")
@Controller
public class ProductCategoryController {

    @Autowired
    private ILoginService loginService;

    @Autowired
    private IEBProductCategoryService iebProductCategoryService;

    @Autowired
    private IEBuyNewsService newsService;

    @Autowired
    private IEBTrolleyService trolleyService;

    @Autowired
    private IEBUserAddressService userAddressService;


    /**
     * 保存分类信息
     *
     * @param ebProductCategory
     * @return
     */
    @RequestMapping("/saveCategory.do")
    public String saveCategory(EBProductCategory ebProductCategory, HttpServletRequest request) throws Exception {
        request.setCharacterEncoding("utf-8");

        try {
            int saveCategory = iebProductCategoryService.saveCategory(ebProductCategory);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/product/findCategoryAll.do";
    }


    /**
     * 根据父级id查询子级
     *
     * @param id
     * @param response
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/findByCategoryId.do", produces = "application/json;charset=utf-8")
    public Object findByCategoryId(@RequestParam("id") String id, HttpServletResponse response) throws Exception {
        List<EBProductCategory> categories = iebProductCategoryService.findBySonId(id);
        String cate = JSON.toJSONString(categories);
        return cate;
    }

    /**
     * 查询所有商品信息并分页
     *
     * @param page
     * @param size
     * @return
     */
    @RequestMapping("/findProductAll.do")
    public ModelAndView findProductAll(@RequestParam(name = "page", required = true, defaultValue = "1") Integer page,
                                       @RequestParam(name = "size", required = true, defaultValue = "5") Integer size) {

        ModelAndView modelAndView = new ModelAndView();

        List<EBProduct> productAll = iebProductCategoryService.findProductAllByPage(page, size);

        PageInfo<EBProduct> productPageInfo = new PageInfo<EBProduct>(productAll);

        modelAndView.addObject("pageInfo", productPageInfo);
        modelAndView.addObject("url", "product/findProductAll.do");
        modelAndView.addObject("menu", "5");
        modelAndView.setViewName("backend/product/productList");
        return modelAndView;
    }


    /**
     * 查询所有分类信息
     *
     * @param page
     * @param size
     * @return
     */
    @RequestMapping("/findCategoryAll.do")
    public ModelAndView findCategoryAll(@RequestParam(name = "page", required = true, defaultValue = "1") Integer page,
                                        @RequestParam(name = "size", required = true, defaultValue = "10") Integer size, HttpServletRequest request) throws Exception {
        ModelAndView modelAndView = new ModelAndView();
        List<EBProductCategory> categoryAll = iebProductCategoryService.findCategoryAll(page, size);
        for (EBProductCategory ebProductCategory : categoryAll) {
            EBProductCategory productCategory = iebProductCategoryService.findByParentId(ebProductCategory.getParentId().toString());
            if (productCategory != null) {
                ebProductCategory.setParentName(productCategory.getName());
            }
        }
        PageInfo<EBProductCategory> pageInfo = new PageInfo<EBProductCategory>(categoryAll);
        modelAndView.addObject("pageInfo", pageInfo);
        modelAndView.addObject("url", "product/findCategoryAll.do");
        modelAndView.addObject("menu", "4");
        getCategory(modelAndView, request);
        modelAndView.setViewName("backend/productCategory/productCategoryList");
        return modelAndView;
    }


    /**
     * 查询二级分类下的所有产品
     *
     * @param cateGoryId
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/findByParenCategoryId.do")
    public ModelAndView findByParenCategoryId(@RequestParam("cateGoryId") String cateGoryId, HttpServletRequest request) throws Exception {
        ModelAndView modelAndView = new ModelAndView();
        List<EBProduct> products = iebProductCategoryService.findByProductCateGory2Id(cateGoryId);

        getCategory(modelAndView, request);
        SecurityContextImpl securityContext = (SecurityContextImpl) request.getSession().getAttribute("SPRING_SECURITY_CONTEXT");

        try {
            if (securityContext.getAuthentication().getName() != null) {
                getEBTrolley(modelAndView, request);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        modelAndView.addObject("products", products);

        modelAndView.setViewName("/pre/CategoryList");

        return modelAndView;
    }

    /**
     * 查询1~3级商品分类
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/findCategory.do")
    public ModelAndView findByProductCategory(HttpServletRequest request) throws Exception {
        ModelAndView modelAndView = new ModelAndView();
        List<EBuyNews> news = newsService.findAllNews();
        modelAndView.addObject("news", news);
        SecurityContextImpl securityContext = (SecurityContextImpl) request.getSession().getAttribute("SPRING_SECURITY_CONTEXT");

        getCategory(modelAndView, request);
        try {
            if (securityContext.getAuthentication().getName() != null) {
                getEBTrolley(modelAndView, request);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        modelAndView.setViewName("pre/Index");
        return modelAndView;
    }

    /**
     * 查询三级分类下的商品信息
     *
     * @param category3Id
     * @return
     * @throws Exception
     */
    @RequestMapping("/findByCategory3Id.do")
    public ModelAndView findByCategory3Id(@RequestParam("category3Id") String category3Id, HttpServletRequest request) throws Exception {
        ModelAndView modelAndView = new ModelAndView();
        List<EBProduct> products = iebProductCategoryService.findByCategoryId(category3Id);
        getCategory(modelAndView, request);
        modelAndView.addObject("products", products);
        modelAndView.addObject("category3Id", category3Id);
        //拼接URL字符串
        String uri = request.getRequestURL().toString();
        uri=uri+"?category3Id="+category3Id;
        modelAndView.addObject("uri", uri);
        SecurityContextImpl securityContext = (SecurityContextImpl) request.getSession().getAttribute("SPRING_SECURITY_CONTEXT");
        try {
            if (securityContext.getAuthentication().getName() != null) {
                getEBTrolley(modelAndView, request);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        modelAndView.setViewName("pre/CategoryList");
        return modelAndView;
    }

    /**
     * 根据商品id查询单个商品
     *
     * @param productId
     * @return
     * @throws Exception
     */
    @RequestMapping("/findByProductId.do")
    public ModelAndView findByProductId(@RequestParam("productId") Integer productId, HttpServletRequest request) throws Exception {
        ModelAndView modelAndView = new ModelAndView();
        EBProduct product = iebProductCategoryService.findByProductId(productId.toString());
        modelAndView.addObject("product", product);
        getCategory(modelAndView, request);
        SecurityContextImpl securityContext = (SecurityContextImpl) request.getSession().getAttribute("SPRING_SECURITY_CONTEXT");
        try {
            if (securityContext.getAuthentication().getName() != null) {
                getEBTrolley(modelAndView, request);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        modelAndView.setViewName("pre/Product");
        return modelAndView;
    }


    /**
     * 查询三级分类及所有商品
     *
     * @param modelAndView
     * @param request
     * @throws Exception
     */
    public void getCategory(ModelAndView modelAndView, HttpServletRequest request) throws Exception {

        List<EBProductCategory> category1 = iebProductCategoryService.findByCategory("1");
        List<EBProductCategory> category2 = iebProductCategoryService.findByCategory("2");
        List<EBProductCategory> category3 = iebProductCategoryService.findByCategory("3");
        List<EBProduct> productAll = iebProductCategoryService.findProductAll();

        HttpSession session = request.getSession();

        modelAndView.addObject("category1", category1);
        modelAndView.addObject("category2", category2);
        modelAndView.addObject("category3", category3);
        modelAndView.addObject("productAll", productAll);
        session.setAttribute("category1", category1);
        session.setAttribute("category2", category2);
        session.setAttribute("category3", category3);
        session.setAttribute("productAll", productAll);
    }

    public void getEBTrolley(ModelAndView modelAndView, HttpServletRequest request) throws Exception {

        Double totalPrice = 0.00;
        List<EBProduct> products = new ArrayList<EBProduct>();
        SecurityContextImpl securityContext = (SecurityContextImpl) request.getSession().getAttribute("SPRING_SECURITY_CONTEXT");
        String username = securityContext.getAuthentication().getName();

        EBuyUser eBuyUser = loginService.findUserName(username);

        //将用户信息存入session
        HttpSession session = request.getSession();
        session.setAttribute("user", eBuyUser);


        List<EBUserAddress> userAddresses = userAddressService.findByUserIdAddress(eBuyUser.getId().toString());
        modelAndView.addObject("userAddress", userAddresses);
        session.setAttribute("userAddress", userAddresses);

        List<EBTrolley> ebTrolleys = trolleyService.findByTrolley(eBuyUser.getId().toString());


        for (EBTrolley ebTrolley : ebTrolleys) {
            EBProduct product = iebProductCategoryService.findByProductId(ebTrolley.getProductId().toString());
            product.setCount(ebTrolley.getCount());
            products.add(product);
            totalPrice += product.getPrice() * product.getCount();

        }
        modelAndView.addObject("totalPrice", totalPrice);
        modelAndView.addObject("productList", products);
        session.setAttribute("totalPrice", totalPrice);
        session.setAttribute("productList", products);
    }


}
