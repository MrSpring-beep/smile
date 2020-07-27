package cn.ebuy.controller;

import cn.ebuy.domain.*;
import cn.ebuy.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
 * @date ：Created in 2020/7/11 22:01
 * @modified By：
 */
@Controller
@RequestMapping("/trolley")
public class ProductTrolleyController {

    @Autowired
    private IEBTrolleyService trolleyService;

    @Autowired
    private ProductCategoryController productCategoryController;

    @Autowired
    private ILoginService loginService;


    /**
     * 查看购物车信息
     * /product/closeAnAccount.do
     *
     * @return
     */

    @RequestMapping("/closeAnAccount.do")
    public ModelAndView closeAnAccount(HttpServletRequest request) throws Exception {
        ModelAndView modelAndView = new ModelAndView();
        //查询商品分类
        productCategoryController.getCategory(modelAndView, request);
        //查询购物车
        SecurityContextImpl securityContext = (SecurityContextImpl) request.getSession().getAttribute("SPRING_SECURITY_CONTEXT");
        try {
            if (securityContext.getAuthentication().getName() != null) {
                productCategoryController.getEBTrolley(modelAndView, request);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        modelAndView.setViewName("/pre/BuyCar");

        return modelAndView;
    }


    /**
     * 保存商品到购物车
     *
     * @param productId
     * @param count
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping("/saveProductTrolley.do")
    public void saveProductTrolley(@RequestParam("productId") Integer productId, @RequestParam("count") Integer count, HttpServletRequest request, HttpServletResponse response) throws Exception {

        PrintWriter out = response.getWriter();
        SecurityContextImpl securityContext = (SecurityContextImpl) request.getSession().getAttribute("SPRING_SECURITY_CONTEXT");
        String username = securityContext.getAuthentication().getName();

        EBuyUser eBuyUser = loginService.findUserName(username);

        System.out.println(username);
        System.out.println(eBuyUser);

        EBTrolley ebTrolley = new EBTrolley();
        ebTrolley.setProductId(productId);
        ebTrolley.setUserId(eBuyUser.getId());

        List<EBTrolley> trolley = trolleyService.findByTrolley(eBuyUser.getId().toString());

        for (EBTrolley trolleyId : trolley) {
            //已存在 商品 数量+1
            if (trolleyId.getProductId().equals(productId)) {
                ebTrolley.setCount(trolleyId.getCount() + count);
                int updateTrolley = trolleyService.updateTrolley(ebTrolley);
                out.print(updateTrolley);
                return;
            }
        }


        ebTrolley.setCount(count);


        int product = trolleyService.saveProduct(ebTrolley);
        out.print(product);

    }

    /**
     * 购物车删除
     *
     * @param productId
     * @return
     * @throws Exception
     */
    @RequestMapping("/delTrolleyProduct.do")
    public String delTrolleyProduct(@RequestParam("productId") String productId) throws Exception {

        int delTrolleyProduct = trolleyService.delTrolleyProduct(productId);
        System.out.println(delTrolleyProduct);

        return "redirect:/trolley/closeAnAccount.do";
    }

    /**
     * 修改购物车商品数量
     *
     * @param count
     */
    @RequestMapping("/updateTrolleyCount.do")
    public void updateTrolleyCount(@RequestParam("count") Integer count, @RequestParam("id") Integer id) {
        EBTrolley ebTrolley = new EBTrolley();
        ebTrolley.setCount(count);
        ebTrolley.setProductId(id);
        int i = trolleyService.updateTrolley(ebTrolley);
    }

}
