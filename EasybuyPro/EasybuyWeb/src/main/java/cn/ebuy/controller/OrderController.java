package cn.ebuy.controller;

import cn.ebuy.domain.*;
import cn.ebuy.service.*;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * @author ：微笑
 * @date ：Created in 2020/7/13 13:28
 * @modified By：
 */

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private IEBUserAddressService userAddressService;

    @Autowired
    private IEBOrderService orderService;

    @Autowired
    private IEBProductCategoryService iebProductCategoryService;

    @Autowired
    private ProductCategoryController productCategoryController;

    @Autowired
    private ILoginService loginService;

    @Autowired
    private IEBTrolleyService trolleyService;


    @RequestMapping("/findOrderAll.do")
    public ModelAndView findOrderAll(@RequestParam(name = "page", required = true, defaultValue = "1") Integer page,
                                     @RequestParam(name = "size", required = true, defaultValue = "2") Integer size,
                                     HttpServletRequest request) throws Exception {
        ModelAndView modelAndView = new ModelAndView();
        List<EBOrder> allOrder = orderService.findAllOrder(page, size);
        for (EBOrder ebOrder : allOrder) {
            ebOrder.setOrderDetails(orderService.findByOrderId(ebOrder.getId().toString()));
            for (EBOrderDetail detail : ebOrder.getOrderDetails()) {
                EBProduct ebProduct = iebProductCategoryService.findByProductId(detail.getProductId().toString());
                detail.setEbProduct(ebProduct);
            }
        }
        PageInfo<EBOrder> pageInfo = new PageInfo<EBOrder>(allOrder);

        modelAndView.addObject("pageInfo", pageInfo);
        modelAndView.addObject("url", "order/findOrderAll.do");
        modelAndView.addObject("menu", "9");
        modelAndView.setViewName("backend/order/orderList");
        return modelAndView;
    }


    /**
     * 根据订单id查询订单信息
     *
     * @return
     */
    @RequestMapping("/findBySerialNumber.do")
    public ModelAndView findBySerialNumber(@RequestParam("orderId") String orderId) throws Exception {
        ModelAndView modelAndView = new ModelAndView();

        List<EBOrderDetail> ebOrderDetailList = orderService.findByOrderId(orderId);
        for (EBOrderDetail ebOrderDetail : ebOrderDetailList) {
            EBProduct byProductId = iebProductCategoryService.findByProductId(ebOrderDetail.getProductId().toString());
            ebOrderDetail.setEbProduct(byProductId);
        }
        modelAndView.addObject("ebOrderDetailList", ebOrderDetailList);
        modelAndView.setViewName("backend/order/orderDetailList");
        return modelAndView;
    }

    /**
     * 确认订单信息
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/affirmOrderInfo.do")
    public ModelAndView affirmOrderInfo(HttpServletRequest request) throws Exception {
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
        modelAndView.setViewName("/pre/BuyCar_Two");
        return modelAndView;
    }

    /**
     * 成功提交订单信息
     *
     * @return
     */
    @RequestMapping("/successSubmitOrder.do")
    public ModelAndView successSubmitOrder(HttpServletRequest request, @RequestParam("addressId") String addressId,
                                           EBUserAddress ebUserAddress,
                                           @RequestParam("address1") String address1) throws Exception {
        //购物车列表
        List<EBProduct> products = new ArrayList<EBProduct>();
        ModelAndView modelAndView = new ModelAndView();

        request.setCharacterEncoding("utf-8");

        String orderAddress = "";

        //订单总金额
        Double totalPrice = 0.00;

        String uuid = UUID.randomUUID().toString();
        //去掉“-”符号
        String serialNumber = uuid.replaceAll("-", "");
        HttpSession session = request.getSession();
        session.setAttribute("serialNumber",serialNumber);

        //查询当前用户
        SecurityContextImpl securityContext = (SecurityContextImpl) request.getSession().getAttribute("SPRING_SECURITY_CONTEXT");
        String username = securityContext.getAuthentication().getName();
        EBuyUser eBuyUser = loginService.findUserName(username);

        //查询用户地址
        if (addressId.equals("0")) {
            if (ebUserAddress != null) {
                ebUserAddress.setCreateTime(new Date());
                ebUserAddress.setIsDefault(0);
                ebUserAddress.setUserId(eBuyUser.getId());
                ebUserAddress.setAddress(address1);
                //新增地址
                int i = userAddressService.saveUserAddress(ebUserAddress);
                orderAddress = address1;
            }
        } else {
            EBUserAddress addressById = userAddressService.findByAddressId(addressId);
            orderAddress = addressById.getAddress();

        }

        List<EBTrolley> ebTrolleys = trolleyService.findByTrolley(eBuyUser.getId().toString());


        for (EBTrolley ebTrolley : ebTrolleys) {
            EBProduct product = iebProductCategoryService.findByProductId(ebTrolley.getProductId().toString());
            product.setCount(ebTrolley.getCount());
            products.add(product);
            //修改库存
            System.out.println(product.getInventory()-ebTrolley.getCount()+"XXXXXXXX"+ebTrolley.getProductId());
            int i = iebProductCategoryService.updateProductInventory(product.getInventory()-ebTrolley.getCount(), ebTrolley.getProductId().toString());
            totalPrice += product.getPrice() * product.getCount();

        }

        //新增订单信息
        EBOrder ebOrder = new EBOrder();
        ebOrder.setUserId(eBuyUser.getId());
        ebOrder.setLoginName(eBuyUser.getLoginName());
        ebOrder.setUserAddress(orderAddress);
        ebOrder.setCreateTime(new Date());
        ebOrder.setCost(Float.parseFloat(totalPrice.toString()));
        ebOrder.setSerialNumber(serialNumber);
        orderService.saveOrder(ebOrder);

        //新增订单详细信息
        EBOrder order = orderService.findBySerialNumber(serialNumber);
        for (EBTrolley ebTrolley : ebTrolleys) {
            EBOrderDetail ebOrderDetail = new EBOrderDetail();
            ebOrderDetail.setOrderId(order.getId());
            ebOrderDetail.setProductId(ebTrolley.getProductId());
            ebOrderDetail.setQuantity(ebTrolley.getCount());

            EBProduct ebProduct = iebProductCategoryService.findByProductId(ebTrolley.getProductId().toString());
            if (ebProduct != null) {
                ebOrderDetail.setCost(Float.parseFloat(ebTrolley.getCount().toString()) * ebProduct.getPrice());
            }
            orderService.saveOrderDetail(ebOrderDetail);

        }

        productCategoryController.getCategory(modelAndView, request);

        //删除用户购物车
        int i = trolleyService.delUserTrolley(eBuyUser.getId().toString());

        //刷新购物车
        productCategoryController.getEBTrolley(modelAndView, request);
        modelAndView.addObject("serialNumber", serialNumber);
        modelAndView.addObject("totalPrice", totalPrice);

        session.setAttribute("totalPrice",totalPrice);

        modelAndView.setViewName("/pre/BuyCar_Three");

        return modelAndView;
    }

    /**
     * 根据用户id查询订单信息
     *
     * @param
     * @return
     */
    @RequestMapping("/findByUserId.do")
    public ModelAndView findByUserId(@RequestParam(name = "page", required = true, defaultValue = "1") Integer page,
                                     @RequestParam(name = "size", required = true, defaultValue = "2") Integer size,
                                     HttpServletRequest request) throws Exception {
        ModelAndView modelAndView = new ModelAndView();
        HttpSession session = request.getSession();
        EBuyUser user = (EBuyUser) session.getAttribute("user");
        if (user == null) {
            modelAndView.addObject("msg", "请先登录");
            modelAndView.setViewName("redirect:news/findNewList.do");
        }


        List<EBOrder> ebOrders = null;
        try {
            ebOrders = orderService.findByUserId(page, size, user.getId().toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (ebOrders != null && ebOrders.size()!=0) {
            for (EBOrder ebOrder : ebOrders) {
                ebOrder.setOrderDetails(orderService.findByOrderId(ebOrder.getId().toString()));
                for (EBOrderDetail ebOrderDetail : ebOrder.getOrderDetails()) {
                    EBProduct ebProduct = iebProductCategoryService.findByProductId(ebOrderDetail.getProductId().toString());
                    ebOrderDetail.setEbProduct(ebProduct);
                }
            }
            PageInfo<EBOrder> ebOrderPageInfo = new PageInfo<EBOrder>(ebOrders);
            modelAndView.addObject("pageInfo", ebOrderPageInfo);
            modelAndView.addObject("url", "order/findByUserId.do");
            modelAndView.addObject("menu", "1");
        }else{
            modelAndView.addObject("msg","啊哦！你好穷 暂时没有买过一件商品");
        }

        modelAndView.setViewName("backend/order/orderList");
        return modelAndView;
    }


}
