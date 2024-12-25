package com.example.tool;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;

public class OpenSSLUtil {

    // 密钥和 IV，替换为实际生成的值
    private static final String SECRET_KEY = "2B7E151628AED2A6ABF7158809CF4F3C"; // 32 字符
    private static final String IV = "000102030405060708090A0B0C0D0E0F";       // 16 字符

    /**
     * 加密密码
     *
     * @param password 明文密码
     * @return 加密后的密码（Base64 编码）
     */
    public static String encrypt(String password) {
        try {
            IvParameterSpec iv = new IvParameterSpec(hexToBytes(IV));
            SecretKeySpec key = new SecretKeySpec(hexToBytes(SECRET_KEY), "AES");

            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            cipher.init(Cipher.ENCRYPT_MODE, key, iv);

            byte[] encrypted = cipher.doFinal(password.getBytes());
            return Base64.getEncoder().encodeToString(encrypted);
        } catch (Exception e) {
            throw new RuntimeException("Error occurred while encrypting", e);
        }
    }

    /**
     * 解密密码
     *
     * @param encryptedPassword 加密后的密码（Base64 编码）
     * @return 解密后的明文密码
     */
    public static String decrypt(String encryptedPassword) {
        try {
            IvParameterSpec iv = new IvParameterSpec(hexToBytes(IV));
            SecretKeySpec key = new SecretKeySpec(hexToBytes(SECRET_KEY), "AES");

            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            cipher.init(Cipher.DECRYPT_MODE, key, iv);

            byte[] decoded = Base64.getDecoder().decode(encryptedPassword);
            byte[] original = cipher.doFinal(decoded);
            return new String(original);
        } catch (Exception e) {
            throw new RuntimeException("Error occurred while decrypting", e);
        }
    }

    /**
     * 将十六进制字符串转换为字节数组
     *
     * @param hex 十六进制字符串
     * @return 字节数组
     */
    private static byte[] hexToBytes(String hex) {
        int length = hex.length();
        byte[] bytes = new byte[length / 2];
        for (int i = 0; i < length; i += 2) {
            bytes[i / 2] = (byte) ((Character.digit(hex.charAt(i), 16) << 4)
                    + Character.digit(hex.charAt(i + 1), 16));
        }
        return bytes;
    }
}

