//
//  WZZSecret.h
//  WZZSecretDemo
//
//  Created by 王泽众 on 2017/8/21.
//  Copyright © 2017年 王泽众. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZZSecret : NSObject

#pragma mark - 散列算法

/// MARK:MD5
/// @param data 数据
+ (NSData *)MD5WithData:(NSData *)data;

/**
 MARK:SHA1加密

 @param data 明文
 @return 密文
 */
+ (NSData *)SHA1WithData:(NSData *)data;

/**
 MARK:SHA256加密

 @param data 明文
 @return 密文
 */
+ (NSData *)SHA256WithData:(NSData *)data;

#pragma mark - 对称算法
/**
 MARK:AES128位加密
 
 加密模式：ECB
 填充模式：PKCS7Padding
 数据块：128位

 @param data 明文数据
 @param key 密钥
 @return 密文数据
 */
+ (NSData *)AES128EncryptWithData:(NSData *)data
                              key:(NSString *)key;

/**
 MARK:AES128位解密
 
 加密模式：ECB
 填充模式：PKCS7Padding
 数据块：128位

 @param data 密文数据
 @param key 密钥
 @return 明文数据
 */
+ (NSData *)AES128DecryptWithData:(NSData *)data
                              key:(NSString *)key;

/**
 MARK:AES256位加密

 @param data 明文数据
 @param key 密钥
 @return 密文数据
 */
+ (NSData *)AES256EncryptWithData:(NSData *)data
                              key:(NSString *)key;

/**
 MARK:AES256位解密

 @param data 密文数据
 @param key 密钥
 @return 明文数据
 */
+ (NSData *)AES256DecryptWithData:(NSData *)data
                              key:(NSString *)key;

/**
 MARK:DES加密

 @param data 明文数据
 @param key 密钥
 @return 密文数据
 */
+ (NSData *)DESEncryptWithData:(NSData *)data
                           key:(NSString *)key;


/**
 MARK:DES解密

 @param data 密文数据
 @param key 密钥
 @return 明文数据
 */
+ (NSData *)DESDecryptWithData:(NSData *)data
                           key:(NSString *)key;

/**
 MARK:3DES加密

 @param data 明文数据
 @param key 密钥
 @return 密文数据
 */
+ (NSData *)DES3EncryptWithData:(NSData *)data
                            key:(NSString *)key;

/**
 MARK:3DES解密
 
 @param data 密文数据
 @param key 密钥
 @return 明文数据
 */
+ (NSData *)DES3DecryptWithData:(NSData *)data
                            key:(NSString *)key;

#pragma mark - 非对称算法


#pragma mark - 辅助方法

/**
 MARK:base64编码

 @param data 待编码data
 @return 编码后字符串
 */
+ (NSString *)base64EncodeStringWithData:(NSData *)data;

/**
 MARK:base64解码

 @param string 待解码字符串
 @return 解码后data
 */
+ (NSData *)base64DecodeDataWithString:(NSString *)string;

/**
 MARK:data转16进制字符串

 @param data 数据
 @return 16进制字符串
 */
+ (NSString *)hexStringWithData:(NSData *)data;

/**
 MARK:16进制字符串转data

 @param hexStr 16进制字符串
 @return 数据
 */
+ (NSData *)dataWithHEXString:(NSString *)hexStr;

@end
