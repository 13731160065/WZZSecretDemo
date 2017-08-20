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
#pragma mark MD5
/**
 MD5加密
 */
+ (NSString *)MD5WithString:(NSString *)string;

#pragma mark SHA1
/**
 SHA1加密
 */
+ (NSString *)SHA1WithString:(NSString *)string;

#pragma mark - 对称算法
#pragma mark base64
/**
 base64加密
 */
+ (NSString *)base64EncryptWithData:(NSData *)data;

/**
 base64解密
 */
+ (NSData *)base64DecryptWithData:(NSString *)string;

#pragma mark AES
/**
 AES加密
 */
+ (NSData *)AES256EncryptWithData:(NSData *)data key:(NSString *)key;

/**
 AES解密
 */
+ (NSData *)AES256DecryptWithData:(NSData *)data key:(NSString *)key;

#pragma mark DES
//DES加密
+ (NSString *)DESEncryptWithString:(NSString *)data key:(NSString *)key;

//DES解密
+ (NSString *)DESDecryptWithString:(NSString *)data key:(NSString *)key;

#pragma mark 3DES
//3DES加密
+ (NSString *)DES3EncryptWithString:(NSString *)string key:(NSString *)key;

//3DES解密
+ (NSString *)DES3DecryptWithString:(NSString *)string key:(NSString *)key;

#pragma mark - 非对称算法

@end
