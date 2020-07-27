package cn.ebuy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.FileWriter;
import java.io.IOException;

/**
 * @author ：微笑
 * @date ：Created in 2020/7/22 22:49
 * @modified By：
 */


public class AlipayConfig {

    //↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

    // 应用ID,您的APPID，收款账号既是您的APPID对应支付宝账号
    public static String app_id = "2021000116659243";

    // 商户私钥，您的PKCS8格式RSA2私钥
    public static String merchant_private_key = "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCR1eTzhlogwNso98H9XxTSI3M6I/BF0R59CCieqqDzOiJbYF0fjch0p8mvnzkXe7yBYdFVpTT7fefE+vej2O22bXyzkhxERVNco+7vff8PRJuBka5A1HtSqIth0/z5aCvY27yRLCow2dIqqyPrLP3XKFuGptztEAQxDhIoeVUnlAJYvDr7sa963FHyC09/d4UAY1TBZVETZLMp2bf8aZXebc49KjxOvjpSW5Sl5I6mnDph8iew7RLRP07m3n/e9/iOmRFBVwOicncc0tBCHQAv6ofqiuQxf3/wKQvswu/eZXY5MtzYMZ295/7TmRbmfFjEfsxEqZL1JYyEHAgaAYwrAgMBAAECggEAVb2e3Tp5VNZuQ7jeuduj/yROg7lLc5DOTw5z601AUaA1QOn39ixC1assXe/L/i2Gl77t91+pNc9Ba8Ntw0wv/liCv4TAz7a+mzHasb2vLsfUcao3+++xDdkAEaU0D2KanOYcCHIh4BTAhsuV05fhKhWVMiZ6r3oCLOEr9dXYJerum7mVCEeysAp91/qzz+Ic+QJ4NE3qx7in0weQj6pajB5qvM0IZUY1z5VOKoXhQ7dtPuWB3THboUMR5AzIcfzlULVCzkvCkh74CGGSEV99T2ZbMTCiVENaRBmzL9MtRIZ5rrp7cJ7X1HbpV5ufIu8VDMzGavrqhOz2nmZNcbW3MQKBgQDfU1qB8KMjazQFBeAXxv/UKVMtSaL6Fuqw8wfhS+DF9/vpzfyKRyvm/vlgpWgRO+FoU6QteoWUUvmIY5t0Xf0nlXJmkkMS6GzM7bCwmpsCDV3DHUL7r3HnDF/lLPbaMSAH4gXx/zkEYVMWSfkWNloHtTVXpe50DERwCUUwazb90wKBgQCnLCekgDgLts5WkQXVT/igDnicF2nmo3ow6Qd1XC7I0+vxjgPMC6I5WVsVGg8Jvas75IWpkB68oI0LbGwHSwWEjMiXRef/b/AcUa9K2p9+gtZCwVYMw9gYoYgw6ToOOWh/JgPxVNcH1FQGOedk6LnoAWwMplKj+FtN2VgRwgZJSQKBgQCpenE6ISs86tM8aJwKj1uAX6geuz4yeoe6p4S4ZkP7GNmVMlxPd/mKQL9xp7UVNxM1gBwc41lSGbIC3kyP/+/pRVHfI2pBhB9lWZB4RawS35/jPWai6B8Rj2OK4ReouBUtxkpqvxw/BbjvNk4QnEiwhsUnceZHLTQWrgJS31qJPwKBgF8U2xtSHg5zlBpic7nmuVd3w5usKXyXwJjvAWH741QwTMNf7cLxXvxVWVvALYtxyGHRUUCnCwRoILC9oxfm0KWaWUDI7vI3HY9N2nCttgeDrQ/c3O93uIIR5d9D19RdTJT870Mk6QS3/G5qIrUfNRXDMUxkkR5X1L6Lfu7ityaZAoGBALatqRTFbuldV/EW4F+ma3FgjboLhinJpZHzA9Y/SIIjj1S30ktWF3cp+/k9RPzmpzfxCQHIAJz5BgZW4VgSzf12Bme1w1Pq0dFQ9OjXO/IL4kszEEmm35V7GIeP8hBXuZ2U0l/l2SBH5+GvXY6TT7l/KJ5Z0o4HcuEhlKxW/iql";


    // 支付宝公钥,查看地址：https://openhome.alipay.com/platform/keyManage.htm 对应APPID下的支付宝公钥。
    public static String alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtmZK86LdmaQmZUQP9WYzb/AlD77KoGoeRfz3td/Za4bZlGUh5i8ET7umFkVfGr9jk2oUM9D/vjqnwe1DlWRBjEn76F/m8sc2Rq0OMs+TQ38/V4pp+wQuEUUFsMR8sp346f+KhVrd13X3vHC2dcna4SlqnvOG5YwnDPA//ydBTETYmmHuueNhboo72OUt/XGlFMNQJDlj/UThA+kK0fbGiecadu3JHmLmCM95WwWA6bDeRNSdpIYZqiOaPeZmkkU5suMbdBD8mba/esoFfbqFRJZGOgVA+ICLGlJJpfSzO1H7ISlGLbd9RpKBrVlsbKiEwPuLYOoCtmenmgAumHDX4wIDAQAB";

    // 服务器异步通知页面路径  需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
    public static String notify_url = "http://localhost:8090/EasybuyWeb/alipaySuccess/ifSuccess.do";

    // 页面跳转同步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
    public static String return_url = "http://localhost:8090/EasybuyWeb/alipaySuccess/ifSuccess.do";

    // 签名方式
    public static String sign_type = "RSA2";

    // 字符编码格式
    public static String charset = "utf-8";

    // 支付宝网关
    public static String gatewayUrl = "https://openapi.alipaydev.com/gateway.do";

    // 支付宝网关
    public static String log_path = "https://openapi.alipaydev.com/gateway.do";


//↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

    /**
     * 写日志，方便测试（看网站需求，也可以改成把记录存入数据库）
     * @param sWord 要写入日志里的文本内容
     */
    public static void logResult(String sWord) {
        FileWriter writer = null;
        try {
            writer = new FileWriter(log_path + "alipay_log_" + System.currentTimeMillis()+".txt");
            writer.write(sWord);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (writer != null) {
                try {
                    writer.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }


}
