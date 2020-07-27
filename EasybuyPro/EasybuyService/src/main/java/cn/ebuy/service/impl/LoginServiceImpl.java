package cn.ebuy.service.impl;

import cn.ebuy.dao.ILoginDao;
import cn.ebuy.domain.EBuyNews;
import cn.ebuy.domain.EBuyUser;
import cn.ebuy.service.ILoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * @author ：微笑
 * @date ：Created in 2020/6/24 23:33
 * @modified By：
 */

@Service("userService")
@Transactional
public class LoginServiceImpl implements ILoginService {


    @Autowired
    private ILoginDao loginDao;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;


    @Override
    public EBuyUser findByLogin(String userName, String password) throws Exception{
        return loginDao.findByLogin(userName,password);
    }

    @Override
    public EBuyUser findUserName(String loginName) throws Exception {
        return loginDao.findByUserName(loginName);
    }

    @Override
    public EBuyUser findByLoginName(String username) throws Exception {
        return loginDao.findByLoginName(username);
    }

    @Override
    public int addUser(EBuyUser eBuyUser) throws Exception {
        eBuyUser.setPassword(passwordEncoder.encode(eBuyUser.getPassword()));
        return loginDao.saveUser(eBuyUser);
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        EBuyUser eBuyUser=null;

        try {
            eBuyUser = loginDao.findByLoginName(username);
        } catch (Exception e) {
            e.printStackTrace();
        }
        //处理自己创建的用户封装为UserDetails
        return new User(eBuyUser.getUserName(),eBuyUser.getPassword(),true,true,true,true,getAuthority(eBuyUser.getTypeStr()));
    }


    public List<SimpleGrantedAuthority> getAuthority(String roleName){
        List<SimpleGrantedAuthority> list=new ArrayList<SimpleGrantedAuthority>();
        list.add(new SimpleGrantedAuthority(roleName));

        return list;

    }





}
