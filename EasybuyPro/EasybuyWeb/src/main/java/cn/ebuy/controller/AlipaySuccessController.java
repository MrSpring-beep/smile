package cn.ebuy.controller;

import cn.ebuy.domain.EBUserAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * @author ：微笑
 * @date ：Created in 2020/7/23 9:03
 * @modified By：
 */

@Controller
@RequestMapping("/alipaySuccess")
public class AlipaySuccessController {


    @Autowired
    private OrderController orderController;


    @RequestMapping("/submit.do")
    public ModelAndView submit(HttpServletRequest request, @RequestParam("addressId") String addressId,
                               EBUserAddress ebUserAddress,
                               @RequestParam("address1") String address1, @RequestParam("totalPrice") String totalPrice) {

        ModelAndView modelAndView = new ModelAndView();

        HttpSession session = request.getSession();
        session.setAttribute("addressId", addressId);
        session.setAttribute("ebUserAddress", ebUserAddress);
        session.setAttribute("address1", address1);
        session.setAttribute("totalPrice",totalPrice);

        System.out.println(addressId);
        System.out.println(ebUserAddress);
        System.out.println(address1);

        modelAndView.setViewName("../indexs");
        modelAndView.addObject("totalPrice", totalPrice);
        return modelAndView;

    }


    /**
     * 检测支付是否成功
     *
     * @return
     */
    @RequestMapping("/ifSuccess.do")
    public ModelAndView ifSuccess(HttpServletRequest request) throws Exception {

        HttpSession session = request.getSession();
        String addressId = (String) session.getAttribute("addressId");
        EBUserAddress ebUserAddress = (EBUserAddress) session.getAttribute("ebUserAddress");
        String address1 = (String) session.getAttribute("address1");

        ModelAndView modelAndView = orderController.successSubmitOrder(request, addressId, ebUserAddress, address1);

        return modelAndView;
    }

}
