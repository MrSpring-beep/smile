package cn.ebuy.domain;

/**
 * @author ：微笑
 * @date ：Created in 2020/7/12 22:35
 * @modified By：
 */

/**
 * 订单详细信息实体类
 */
public class EBOrderDetail {

    private Integer id;
    private Integer orderId;
    private Integer productId;
    private Integer quantity;
    private Float cost;
    private EBProduct ebProduct;

    public EBProduct getEbProduct() {
        return ebProduct;
    }

    public void setEbProduct(EBProduct ebProduct) {
        this.ebProduct = ebProduct;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Float getCost() {
        return cost;
    }

    public void setCost(Float cost) {
        this.cost = cost;
    }
}
