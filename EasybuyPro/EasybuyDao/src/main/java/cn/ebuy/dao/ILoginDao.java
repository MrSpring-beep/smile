package cn.ebuy.dao;

import cn.ebuy.domain.EBuyNews;
import cn.ebuy.domain.EBuyUser;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

/**
 * @author ：微笑
 * @date ：Created in 2020/6/24 23:25
 * @modified By：
 */

public interface ILoginDao {


  @Select("select * from easybuy_user where userName=#{userName} and password=#{password}")
  public EBuyUser findByLogin(@Param("userName") String userName,@Param("password") String password) throws Exception;

  @Select("select * from easybuy_user where userName=#{username}")
  public EBuyUser findByUserName(String username) throws Exception;

  @Select("select * from easybuy_user where loginName=#{username}")
  public EBuyUser findByLoginName(String username) throws Exception;

  @Insert("insert into easybuy_user(loginName,userName,password,sex,identityCode,email,mobile,type) " +
          " values (#{loginName},#{userName},#{password},#{sex},#{identityCode},#{email},#{mobile},#{type})")
  public int saveUser(EBuyUser eBuyUser) throws Exception;

}
