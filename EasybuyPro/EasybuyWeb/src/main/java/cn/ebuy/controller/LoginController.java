package cn.ebuy.controller;

import cn.ebuy.domain.EBuyUser;
import cn.ebuy.service.ILoginService;
import com.alibaba.fastjson.JSON;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

/**
 * @author ：微笑
 * @date ：Created in 2020/6/24 23:36
 * @modified By：
 */

@Controller
@RequestMapping("/login")
public class LoginController {


    @Autowired
    private ILoginService loginService;

    /**
     * 生成验证码
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/checkCode.do")
    public void checkCode(HttpServletRequest request, HttpServletResponse response) throws IOException {

        //服务器通知浏览器不要缓存
        response.setHeader("pragma", "no-cache");
        response.setHeader("cache-control", "no-cache");
        response.setHeader("expires", "0");

        //在内存中创建一个长80，宽30的图片，默认黑色背景
        //参数一：长
        //参数二：宽
        //参数三：颜色
        int width = 80;
        int height = 30;
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

        //获取画笔
        Graphics g = image.getGraphics();
        //设置画笔颜色为灰色
        g.setColor(Color.WHITE);
        //填充图片
        g.fillRect(0, 0, width, height);

        //产生4个随机验证码，12Ey
        String checkCode = getCheckCode();
        //将验证码放入HttpSession中
        request.getSession().setAttribute("CHECKCODE_SERVER", checkCode);

        //设置画笔颜色为黄色
        g.setColor(Color.GREEN);
        //设置字体的小大
        g.setFont(new Font("黑体", Font.BOLD, 24));
        //向图片上写入验证码
        g.drawString(checkCode, 15, 25);

        //将内存中的图片输出到浏览器
        //参数一：图片对象
        //参数二：图片的格式，如PNG,JPG,GIF
        //参数三：图片输出到哪里去
        System.out.println("BLJL");
        ImageIO.write(image, "PNG", response.getOutputStream());

    }

    /**
     * 产生4位随机字符串
     */
    private String getCheckCode() {
        String base = "0123456789ABCDEFGabcdefg";
        int size = base.length();
        Random r = new Random();
        StringBuffer sb = new StringBuffer();
        for (int i = 1; i <= 4; i++) {
            //产生0到size-1的随机值
            int index = r.nextInt(size);
            //在base字符串中获取下标为index的字符
            char c = base.charAt(index);
            //将c放入到StringBuffer中去
            sb.append(c);
        }
        return sb.toString();
    }

    /**
     *  检测账号是否存在
     * @param loginName
     * @param response
     * @throws Exception
     */
    @RequestMapping("/byLoginName.do")
    public void findUserByLogin(@RequestParam("loginName") String loginName, HttpServletResponse response) throws Exception {
        PrintWriter out = response.getWriter();
        EBuyUser userLoginName = loginService.findByLoginName(loginName);
        if (userLoginName == null) {
            out.print("true");
            return;
        }
        out.print("false");
        System.out.println(userLoginName);

    }

    /**
     * 保存新增用户信息
     * @param eBuyUser
     * @param checkCode
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/saveUser.do")
    public String saveUser(EBuyUser eBuyUser, @RequestParam("checkCode") String checkCode, HttpServletRequest request) throws Exception {
        System.out.println("页面" + checkCode);
        HttpSession session = request.getSession();
        String CHECKCODE_SERVER = (String) session.getAttribute("CHECKCODE_SERVER");
        System.out.println("session" + CHECKCODE_SERVER);
        //确保验证码的一次性
        session.removeAttribute("CHECKCODE_SERVER");
        session.removeAttribute("user");
        session.removeAttribute("msg");
        if (!checkCode.equalsIgnoreCase(CHECKCODE_SERVER)) {
            session.setAttribute("user", eBuyUser);
            session.setAttribute("msg", "验证码不正确");
            return "../Regist";
        }
        System.out.println(eBuyUser);
        loginService.addUser(eBuyUser);
        return "../Login";
    }

}
