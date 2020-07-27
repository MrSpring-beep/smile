package cn.ebuy.controller;

import cn.ebuy.dao.IEBUserAddressDao;
import cn.ebuy.domain.EBProduct;
import cn.ebuy.domain.EBUserAddress;
import cn.ebuy.domain.EBuyNews;
import cn.ebuy.domain.EBuyUser;
import cn.ebuy.service.IEBProductCategoryService;
import cn.ebuy.service.IEBUserAddressService;
import cn.ebuy.service.IEBuyNewsService;
import cn.ebuy.service.ILoginService;
import com.github.pagehelper.PageInfo;
import com.sun.org.apache.regexp.internal.RE;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @author ：微笑
 * @date ：Created in 2020/7/14 9:36
 * @modified By：
 */

@Controller
@RequestMapping("/backstage")
public class BackstageController {


    @Autowired
    private ILoginService loginService;

    @Autowired
    private ProductCategoryController productCategoryController;

    @Autowired
    private IEBProductCategoryService productCategoryService;

    @Autowired
    private IEBuyNewsService newsService;

    @Autowired
    private IEBUserAddressService userAddressService;


    /**
     * 修改地址信息回显
     * @param id
     * @return
     */
    @RequestMapping("/updateUserAddressShow.do")
    public ModelAndView updateUserAddressShow(@RequestParam("id")Integer id){
        ModelAndView modelAndView=new ModelAndView();
        EBUserAddress ebUserAddress = userAddressService.findByAddressId(id.toString());
        modelAndView.addObject("ebUserAddress",ebUserAddress);
        modelAndView.setViewName("backend/user/toAddAddress");
        return modelAndView;
    }

    /**
     * 重定向到新增地址
     * @return
     */
    @RequestMapping("/redirectAddUserAddress.do")
    public String redirectAddUserAddress(){
        return "backend/user/toAddAddress";
    }


    /***
     * 查询用户所有地址
     * @return
     */
    @RequestMapping("/findUserAddress.do")
    public ModelAndView findUserAddress(HttpServletRequest request,@RequestParam(name = "page",required = true,defaultValue = "1")Integer page,
                                        @RequestParam(name="size",required = true,defaultValue ="5")Integer size){
        ModelAndView modelAndView=new ModelAndView();
        HttpSession session = request.getSession();
        EBuyUser user = (EBuyUser) session.getAttribute("user");
        List<EBUserAddress> address = userAddressService.findByUserPageIdAddress(user.getId().toString(),page,size);
        PageInfo<EBUserAddress> pageInfo=new PageInfo<EBUserAddress>(address);
        modelAndView.addObject("pageInfo",pageInfo);
        modelAndView.addObject("menu",99);

        //存储访问地址
        modelAndView.addObject("url","backstage/findUserAddress.do");

        modelAndView.setViewName("backend/user/userAddress");
        return modelAndView;
    }


    /**
     * 跳转修改用户页面
     * @return
     */
    @RequestMapping("/toUser.do")
    public ModelAndView redirectUpdateUser(HttpServletRequest request){
        ModelAndView modelAndView=new ModelAndView();

        HttpSession session = request.getSession();
        EBuyUser user = (EBuyUser) session.getAttribute("user");

        modelAndView.addObject("user",user);
        modelAndView.setViewName("/backend/user/toUpdateUser");
        return modelAndView;
    }

    /**
     * 修改信息数据回显
     * @return
     */
    @RequestMapping("/updateNewsShowInfo.do")
    public ModelAndView updateNewsShowInfo(@RequestParam("id")Integer id){
        ModelAndView modelAndView=new ModelAndView();
        EBuyNews eBuyNews = newsService.findByNewsId(id);
        modelAndView.addObject("eBuyNews",eBuyNews);
        modelAndView.setViewName("backend/news/toAddNews");
        return modelAndView;
    }

    /**
     * 跳转新增新闻页面
     * @return
     */
    @RequestMapping("/redirectAddNews.do")
    public String redirectAddNews(){
        return "backend/news/toAddNews";
    }

    /**
     * 跳转新增商品页面
     * @return
     */
    @RequestMapping("/redirectToAddProductAdd.do")
    public ModelAndView redirectToAddProductAdd(HttpServletRequest request) throws Exception {
        ModelAndView modelAndView=new ModelAndView();
        productCategoryController.getCategory(modelAndView,request);
        modelAndView.addObject("menu","6");
        modelAndView.setViewName("backend/product/toAddProduct");
        return modelAndView;
    }

    /**
     * 跳转修改商品页面
     * @return
     */
    @RequestMapping("/redirectToAddProduct.do")
    public ModelAndView redirectToAddProduct(@RequestParam("id")String id,HttpServletRequest request) throws Exception {
        ModelAndView modelAndView=new ModelAndView();
        productCategoryController.getCategory(modelAndView,request);
        EBProduct product = productCategoryService.findByProductId(id);
        modelAndView.addObject("product",product);
        modelAndView.setViewName("backend/product/toAddProduct");
        return modelAndView;
    }


    /**
     * 跳转商品分类页面
     * @return
     */
    @RequestMapping("/redirectJSP.do")
    public String redirectJSP(){
        return "/backend/productCategory/productCategoryList";
    }


    /**
     * 跳转用户信息页面
     * @return
     */
    @RequestMapping("/redirectUserInfoJSP.do")
    public ModelAndView redirectUserInfoJSP(){
        ModelAndView modelAndView=new ModelAndView();

        modelAndView.addObject("menu","2");
        modelAndView.setViewName("/backend/user/userInfo");
        return modelAndView;
    }


    /**
     * 跳转用户添加页面
     * @param request
     * @return
     */
    @RequestMapping("/redirectUserAdd.do")
    public String redirectUserAdd(HttpServletRequest request){
        EBuyUser user=new EBuyUser();
        request.setAttribute("user",user);
        return "backend/user/toUpdateUser";
    }

    /**
     * 跳转用户修改页面
     * @param loginName
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/redirectUserUpdate.do")
    public String redirectUserUpdate(@RequestParam("loginName")String loginName,HttpServletRequest request) throws Exception {
        EBuyUser user = loginService.findByLoginName(loginName);
        request.setAttribute("user",user);
        return "backend/user/toUpdateUser";
    }

    /**
     * 跳转修改新增分类页面
     * @return
     */
    @RequestMapping("/redirectAddCategory.do")
    public String redirectAddCategory(){
        return "backend/productCategory/toAddProductCategory";
    }

}
