package cn.ebuy.controller;

import cn.ebuy.domain.EBuyUser;
import cn.ebuy.service.IEBUserInfoService;
import cn.ebuy.service.ILoginService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import com.sun.org.apache.xpath.internal.objects.XNull;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * @author ：微笑
 * @date ：Created in 2020/7/14 10:13
 * @modified By：
 */

@Controller
@RequestMapping("/userInfo")
public class UserInfoController {


    @Autowired
    private IEBUserInfoService userInfoService;

    @Autowired
    private ILoginService loginService;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    /**
     * 修改用户面部信息
     * @param userId
     * @return
     */
    @RequestMapping("/updateUserFace.do")
    public String updateUserFace(@RequestParam("userId")String userId,HttpServletRequest request) throws Exception {
        int i = userInfoService.updateUserFace(userId);
        HttpSession session = request.getSession();
        EBuyUser user = (EBuyUser) session.getAttribute("user");
        EBuyUser byLoginName = loginService.findByLoginName(user.getLoginName());
        //更新session中的用户信息
        session.setAttribute("user",byLoginName);
        return "backend/user/userInfo";
    }


    /**
     * 修改自身信息
     * @param eBuyUser
     * @return
     */
    @RequestMapping("/updateThisInfo.do")
    public String updateThisInfo(EBuyUser eBuyUser,HttpServletRequest request){

        //密码加密
        eBuyUser.setPassword(passwordEncoder.encode(eBuyUser.getPassword()));
        int i = userInfoService.updateThisInfo(eBuyUser);

        HttpSession session = request.getSession();
        session.removeAttribute("user");
        session.invalidate();

        return "/pre/forword";
    }


    /**
     * 检查原密码
     * @param pass
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/checkPass.do")
    public void checkPassword(@RequestParam("pass")String pass, HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        EBuyUser user = (EBuyUser) session.getAttribute("user");
        boolean matches = passwordEncoder.matches(pass, user.getPassword());
        PrintWriter out = response.getWriter();
        out.print(matches);
    }


    /**
     * 删除用户信息
     *
     * @param userId
     * @return
     * @throws Exception
     */
    @RequestMapping("/deleteUserId.do")
    public String deleteUserId(@RequestParam("userId") String userId) throws Exception {
        int i = userInfoService.deleteUserId(userId);
        return "redirect:findUserAll.do";
    }

    /**
     * 修改用户信息
     *
     * @param eBuyUser
     * @return
     * @throws Exception
     */
    @RequestMapping("/updateUserInfo.do")
    public String updateUserInfo(EBuyUser eBuyUser) throws Exception {
        System.out.println("----------------------------------------------------------------");
        System.out.println(eBuyUser);
        System.out.println("----------------------------------------------------------------");

        int i = userInfoService.updateUserInfo(eBuyUser);
        return "redirect:findUserAll.do";
    }


    /**
     * 新增用户信息
     *
     * @param eBuyUser
     * @return
     * @throws Exception
     */
    @RequestMapping("/saveUserInfo.do")
    public String saveUserInfo(EBuyUser eBuyUser) throws Exception {
        eBuyUser.setSex(1);
        int i = loginService.addUser(eBuyUser);
        return "redirect:findUserAll.do";
    }

    /**
     * 查询所有用户信息
     *
     * @param page
     * @param size
     * @return
     */
    @RequestMapping("/findUserAll.do")
    public ModelAndView findUserAll(@RequestParam(name = "page", required = true, defaultValue = "1") Integer page,
                                    @RequestParam(name = "size", required = true, defaultValue = "10") Integer size,
                                    @RequestParam(name = "userName", required = true, defaultValue = "") String userName) throws Exception {
        ModelAndView modelAndView = new ModelAndView();

        List<EBuyUser> users = userInfoService.findUserAll(page, size, userName);
        for (EBuyUser user : users) {
            System.out.println(user);
        }
        PageInfo<EBuyUser> userPageInfo = new PageInfo<EBuyUser>(users);

        modelAndView.addObject("pageInfo", userPageInfo);
        modelAndView.addObject("url", "userInfo/findUserAll.do");
        modelAndView.addObject("menu", "8");
        modelAndView.setViewName("/backend/user/userList");

        return modelAndView;
    }

}
