/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package wang.dshui.order;
import org.apache.commons.lang3.RandomStringUtils;  
/**
 *
 * @author 刘经济 <york_mail@qq.com>
 */
public class OrderGenerator {  
  
    private static final int ORDER_DEFAULT_LENGTH = 20;  
  
    public static String order() {  
    return orders(ORDER_DEFAULT_LENGTH);  
    } 
    public static String order(int length) {  
    return orders(length);  
    }  
    //获取一个指定长度的订单号  
    private static String orders(int length) {  
    return RandomStringUtils.randomNumeric(length);  
    }  
}  
