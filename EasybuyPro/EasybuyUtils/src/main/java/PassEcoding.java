import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

/**
 * @author ：微笑
 * @date ：Created in 2020/7/21 15:58
 * @modified By：密码加密
 */


public class PassEcoding {

    private static BCryptPasswordEncoder bCryptPasswordEncoder=new BCryptPasswordEncoder();

    public static void main(String[] args) {
        String encode = bCryptPasswordEncoder.encode("9696996");
        System.out.println(encode);
    }
}
