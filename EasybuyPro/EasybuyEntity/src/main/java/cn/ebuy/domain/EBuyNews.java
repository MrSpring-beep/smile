package cn.ebuy.domain;

import java.io.Serializable;
import java.util.Date;

/**
 * @author ：微笑
 * @date ：Created in 2020/6/25 0:56
 * @modified By：
 */

public class EBuyNews{

    private Integer id;
    private String title;
    private String content;
    private Date createTime;



    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return "EBuyNews{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", createTime=" + createTime +
                '}';
    }
}
