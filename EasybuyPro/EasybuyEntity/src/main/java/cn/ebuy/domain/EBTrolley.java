package cn.ebuy.domain;

import java.util.List;

/**
 * @author ：微笑
 * @date ：Created in 2020/7/11 17:32
 * @modified By：购物车
 */

public class EBTrolley {

    private Integer id;
    private Integer userId;
    private Integer productId;
    private Integer count;


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

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }


    @Override
    public String toString() {
        return "EBTrolley{" +
                "id=" + id +
                ", userId=" + userId +
                ", productId=" + productId +
                ", count=" + count +
                '}';
    }
}
