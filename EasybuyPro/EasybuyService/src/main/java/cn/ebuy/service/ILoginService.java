package cn.ebuy.service;

import cn.ebuy.domain.EBuyUser;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.security.core.userdetails.UserDetailsService;

public interface ILoginService extends UserDetailsService {

    public EBuyUser findByLogin(@Param("userName") String userName,@Param("password") String password) throws Exception;

    public EBuyUser findUserName(String username) throws Exception;

    public EBuyUser findByLoginName(String username) throws Exception;

    public int addUser(EBuyUser eBuyUser) throws Exception;

}
