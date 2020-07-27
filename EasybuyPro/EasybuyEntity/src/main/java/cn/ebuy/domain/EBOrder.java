package cn.ebuy.domain;


/**
 * @author ：微笑
 * @date ：Created in 2020/7/12 22:32
 * @modified By：
 */

import java.util.List;
import java.util.Date;

/**
 * 订单实体类
 * @@author 微笑
 */
public class EBOrder {

    private Integer id;
    private Integer userId;
    private String loginName;
    private String userAddress;
    private Date createTime;
    private Float cost;
    private String serialNumber;
    private String phone;
    private String email;
    private String emailCode;
    private EBProduct product;
    private List<EBOrderDetail> orderDetails;

    public List<EBOrderDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<EBOrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }

    public EBProduct getProduct() {
        return product;
    }

    public void setProduct(EBProduct productList) {
        this.product = productList;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getEmailCode() {
        return emailCode;
    }

    public void setEmailCode(String emailCode) {
        this.emailCode = emailCode;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getUserAddress() {
        return userAddress;
    }

    public void setUserAddress(String userAddress) {
        this.userAddress = userAddress;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Float getCost() {
        return cost;
    }

    public void setCost(Float cost) {
        this.cost = cost;
    }

    public String getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber;
    }


    @Override
    public String toString() {
        return "EBOrder{" +
                "id=" + id +
                ", userId=" + userId +
                ", loginName='" + loginName + '\'' +
                ", userAddress='" + userAddress + '\'' +
                ", createTime=" + createTime +
                ", cost=" + cost +
                ", serialNumber='" + serialNumber + '\'' +
                ", phone='" + phone + '\'' +
                ", email='" + email + '\'' +
                ", emailCode='" + emailCode + '\'' +
                '}';
    }
}
