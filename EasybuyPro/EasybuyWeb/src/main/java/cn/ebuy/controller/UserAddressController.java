package cn.ebuy.controller;

import cn.ebuy.domain.EBUserAddress;
import cn.ebuy.domain.EBuyUser;
import cn.ebuy.service.IEBUserAddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;

/**
 * @author ：微笑
 * @date ：Created in 2020/7/22 9:57
 * @modified By：
 */

@Controller
@RequestMapping("/userAddress")
public class UserAddressController {

    @Autowired
    private IEBUserAddressService userAddressService;


    /**
     * 删除用户地址
     * @param id
     * @return
     */
    @RequestMapping("/delUserAddress.do")
    public String delUserAddress(@RequestParam("id")Integer id){
        Integer integer = userAddressService.delUserAddress(id);
        return "redirect:/backstage/findUserAddress.do";
    }

    /**
     * 修改用户地址
     * @param ebUserAddress
     * @return
     */
    @RequestMapping("/updateUserAddress.do")
    public String updateUserAddress(EBUserAddress ebUserAddress) throws Exception {
        System.out.println("修改:"+ebUserAddress);
        int updateAddress = userAddressService.updateAddress(ebUserAddress);
        return "redirect:/backstage/findUserAddress.do";
    }

    /**
     * 修改用户地址并设置为默认
     * @param ebUserAddress
     * @return
     */
    @RequestMapping("/updateUserAddressAndIsDefault.do")
    public String updateUserAddressAndIsDefault(EBUserAddress ebUserAddress) throws Exception {
        System.out.println("修改并默认"+ebUserAddress);
        ebUserAddress.setIsDefault(1);

        try {
            //更改原默认地址
            EBUserAddress isDefault = userAddressService.findByIsDefault();
            isDefault.setIsDefault(0);
            int i = userAddressService.updateAddress(isDefault);

        } catch (Exception e) {
            e.printStackTrace();
        }

        //修改并保存默认地址
        int i1 = userAddressService.updateAddress(ebUserAddress);

        return "redirect:/backstage/findUserAddress.do";
    }

    /**
     * 新增地址信息
     * @param ebUserAddress
     * @return
     */
    @RequestMapping("saveUserAddress.do")
    public String saveUserAddress(EBUserAddress ebUserAddress,HttpServletRequest request) throws Exception {

        //绑定参数
        HttpSession session = request.getSession();
        EBuyUser user = (EBuyUser) session.getAttribute("user");
        ebUserAddress.setUserId(user.getId());
        ebUserAddress.setIsDefault(0);
        ebUserAddress.setCreateTime(new Date());

        int saveUserAddress = userAddressService.saveUserAddress(ebUserAddress);
        return "redirect:/backstage/findUserAddress.do";
    }

}
