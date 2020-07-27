import java.util.UUID;

/**
 * @author ：微笑
 * @date ：Created in 2020/7/12 23:20
 * @modified By：
 */

public class TestUUID {
    public static void main(String[] args) {
        String uuid = UUID.randomUUID().toString();
        //去掉“-”符号
        String serialNumber = uuid.replaceAll("-", "");
        System.out.println(serialNumber);
    }
}
