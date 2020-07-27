package cn.ebuy.domain;

import java.io.Serializable;

/**
 * @author ：微笑
 * @date ：Created in 2020/7/9 21:39
 * @modified By：
 */

public class EBProductCategory implements Serializable {


    private Integer id;
    private String name;
    private Integer parentId;
    private String parentName;
    private String iconClass;
    private Integer type;


    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public String getIconClass() {
        return iconClass;
    }

    public void setIconClass(String iconClass) {
        this.iconClass = iconClass;
    }


    @Override
    public String toString() {
        return "EBProductCategory{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", parentId=" + parentId +
                ", parentName='" + parentName + '\'' +
                ", iconClass='" + iconClass + '\'' +
                ", type=" + type +
                '}';
    }
}
