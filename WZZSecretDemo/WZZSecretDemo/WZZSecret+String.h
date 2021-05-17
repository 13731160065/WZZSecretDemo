//
//  WZZSecret+String.h
//  WZZSecretDemo
//
//  Created by wyq_iMac on 2021/5/14.
//  Copyright © 2021 王泽众. All rights reserved.
//

#import "WZZSecret.h"

@interface WZZSecret (String)

#pragma mark - 散列加密

/// MARK:MD5
/// @param string 数据
+ (NSString *)MD5WithString:(NSString *)string;

/**
 MARK:SHA1加密

 @param string 明文
 @return 密文
 */
+ (NSString *)SHA1WithString:(NSString *)string;

/**
 MARK:SHA256加密

 @param string 明文
 @return 密文
 */
+ (NSString *)SHA256WithString:(NSString *)string;

#pragma mark - 对称算法
/**
 MARK:AES128位加密

 @param string 明文数据
 @param key 密钥
 @return 密文数据
 */
+ (NSString *)AES128EncryptWithString:(NSString *)string
                                  key:(NSString *)key;

/**
 MARK:AES128位解密

 @param string 密文数据
 @param key 密钥
 @return 明文数据
 */
+ (NSString *)AES128DecryptWithString:(NSString *)string
                                key:(NSString *)key;

/**
 MARK:DES加密

 @param string 明文数据
 @param key 密钥
 @return 密文数据
 */
+ (NSString *)DESEncryptWithString:(NSString *)string
                               key:(NSString *)key;


/**
 MARK:DES解密

 @param string 密文数据
 @param key 密钥
 @return 明文数据
 */
+ (NSString *)DESDecryptWithString:(NSString *)string
                               key:(NSString *)key;

/**
 MARK:3DES加密

 @param string 明文数据
 @param key 密钥
 @return 密文数据
 */
+ (NSString *)DES3EncryptWithString:(NSString *)string
                                key:(NSString *)key;

/**
 MARK:3DES解密
 
 @param string 密文数据
 @param key 密钥
 @return 明文数据
 */
+ (NSString *)DES3DecryptWithString:(NSString *)string
                                key:(NSString *)key;

#pragma mark - 非对称算法


#pragma mark - 辅助方法

/**
 MARK:base64编码

 @param string 待编码string
 @return 编码后字符串
 */
+ (NSString *)base64EncodeWithString:(NSString *)string;

/**
 MARK:base64解码

 @param string 待解码字符串
 @return 解码后字符串
 */
+ (NSString *)base64DecodeWithString:(NSString *)string;

@end

