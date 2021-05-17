//
//  WZZSecret.m
//  WZZSecretDemo
//
//  Created by 王泽众 on 2017/8/21.
//  Copyright © 2017年 王泽众. All rights reserved.
//

#import "WZZSecret.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@implementation WZZSecret

#pragma mark - 散列算法

/// MARK:MD5
/// @param data 数据
+ (NSData *)MD5WithData:(NSData *)data {
    uint8_t digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
        
    return [self dataWithHEXString:output];
}

/**
 MARK:SHA1加密
 
 @param data 明文
 @return 密文
 */
+ (NSData *)SHA1WithData:(NSData *)data {
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSData * outData = [NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
    return outData;
}

/**
 MARK:SHA256加密
 
 @param data 明文
 @return 密文
 */
+ (NSData *)SHA256WithData:(NSData *)data {
    uint8_t digest[CC_SHA256_DIGEST_LENGTH] = {0};
    CC_SHA256(data.bytes, (CC_LONG)data.length, digest);
    NSData * outData = [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    return outData;
}

#pragma mark - 对称算法
/**
 MARK:AES128位加密
 
 @param data 明文数据
 @param key 密钥
 @return 密文数据
 */
+ (NSData *)AES128EncryptWithData:(NSData *)data
                              key:(NSString *)key {
    NSInteger length = key.length*8;
    int keyLength = kCCKeySizeAES128;
    if (length >= 192) {
        keyLength = kCCKeySizeAES192;
    }
    if (length >= 256) {
        keyLength = kCCKeySizeAES256;
    }
    char keyPtr[keyLength+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr,
                                          keyLength,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        return resultData;
    }
    free(buffer);
    return nil;
}

/**
 MARK:AES128位解密
 
 @param data 密文数据
 @param key 密钥
 @return 明文数据
 */
+ (NSData *)AES128DecryptWithData:(NSData *)data
                              key:(NSString *)key {
    NSInteger length = key.length*8;
    int keyLength = kCCKeySizeAES128;
    if (length >= 192) {
        keyLength = kCCKeySizeAES192;
    }
    if (length >= 256) {
        keyLength = kCCKeySizeAES256;
    }
    char keyPtr[keyLength+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr,
                                          keyLength,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return resultData;
    }
    free(buffer);
    return nil;
}

/**
 MARK:DES加密
 
 @param data 明文数据
 @param key 密钥
 @return 密文数据
 */
+ (NSData *)DESEncryptWithData:(NSData *)data
                           key:(NSString *)key; {
    NSUInteger dataLength = [data length];
    unsigned char buffer[1024 * 5];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          [key UTF8String], kCCKeySizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *dataRes = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        return dataRes;
    }
    free(buffer);
    return nil;
}

/**
 MARK:DES解密
 
 @param data 密文数据
 @param key 密钥
 @return 明文数据
 */
+ (NSData *)DESDecryptWithData:(NSData *)data
                           key:(NSString *)key {
    NSUInteger dataLength = [data length];
    unsigned char buffer[1024 * 5];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          [key UTF8String], kCCKeySizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *dataRes = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        return dataRes;
    }
    free(buffer);
    return nil;
}

/**
 MARK:3DES加密
 
 @param data 明文数据
 @param key 密钥
 @return 密文数据
 */
+ (NSData *)DES3EncryptWithData:(NSData *)data
                            key:(NSString *)key {
    NSString * string = [self hexStringWithData:data];
    if (key.length != 32) {
        return nil;
    }
    if (string.length != 16 && string.length != 32) {
        return nil;
    }
    
    NSString * keyT8 = [key substringToIndex:16];
    NSString * keyF8 = [key substringFromIndex:16];
    NSString * text11 = [self _3DESEncryptWithString:[string substringToIndex:16] key:keyT8];
    NSString * text12 = [self _3DESDecryptWithString:text11 key:keyF8];
    NSString * text13 = [self _3DESEncryptWithString:text12 key:keyT8];
    
    NSString * text21;
    NSString * text22;
    NSString * text23;
    if (string.length > 16) {
        NSData * text21Data = [self DESEncryptWithData:[self dataWithHEXString:[string substringFromIndex:16]] key:keyT8];
        text21 = [self hexStringWithData:text21Data];
        text22 = [self _3DESDecryptWithString:text21 key:keyF8];
        text23 = [self _3DESEncryptWithString:text22 key:keyT8];
    }
    
    if (text13 && text23) {
        NSString * returnStr = [text13 stringByAppendingString:text23];
        return [self dataWithHEXString:returnStr];
    }
    
    if (text13) {
        return [self dataWithHEXString:text13];
    }
    
    return nil;
}

/**
 MARK:3DES解密
 
 @param data 密文数据
 @param key 密钥
 @return 明文数据
 */
+ (NSData *)DES3DecryptWithData:(NSData *)data
                            key:(NSString *)key; {
    NSString * string = [self hexStringWithData:data];
    if (key.length != 32) {
        return nil;
    }
    if (string.length != 16 && string.length != 32) {
        return nil;
    }
    
    NSString * keyT8 = [key substringToIndex:16];
    NSString * keyF8 = [key substringFromIndex:16];
    NSString * text11 = [self _3DESDecryptWithString:[string substringToIndex:16] key:keyT8];
    NSString * text12 = [self _3DESEncryptWithString:text11 key:keyF8];
    NSString * text13 = [self _3DESDecryptWithString:text12 key:keyT8];
    
    NSString * text21;
    NSString * text22;
    NSString * text23;
    if (string.length > 16) {
        NSData * text21Data = [self DESDecryptWithData:[self dataWithHEXString:[string substringFromIndex:16]] key:keyT8];
        text21 = [self hexStringWithData:text21Data];
        text22 = [self _3DESEncryptWithString:text21 key:keyF8];
        text23 = [self _3DESDecryptWithString:text22 key:keyT8];
    }
    
    if (text13 && text23) {
        NSString * returnStr = [text13 stringByAppendingString:text23];
        return [self dataWithHEXString:returnStr];
    }
    if (text13) {
        return [self dataWithHEXString:text13];
    }
    return nil;
}

//3DES需要调用的DES加密
+ (NSString *)_3DESEncryptWithString:(NSString *)string key:(NSString *)key {
    if (string.length != 16 || key.length != 16) {
        return nil;
    }
    NSData * data = [self dataWithHEXString:string];
    NSData * keyData = [self dataWithHEXString:key];
    uint8_t tmp[1024];
    void *bufferPtr = NULL;
    NSInteger bufferPtrSize = data.length;
    
    if (data.length > 1024) {
        bufferPtr = (void*)malloc(data.length);
    }else{
        bufferPtr = tmp;
    }
    
    size_t datalen = 0;
    CCCryptorStatus ccStatus = CCCrypt(kCCEncrypt,
                                       kCCAlgorithmDES,
                                       kCCOptionECBMode,
                                       keyData.bytes,
                                       keyData.length,
                                       NULL,
                                       data.bytes,
                                       data.length,
                                       bufferPtr,
                                       bufferPtrSize,
                                       &datalen);
    
    NSData * cryptData;
    if (ccStatus == kCCSuccess) {
        cryptData = [NSData dataWithBytes:(const void*)bufferPtr length:datalen];
    }
    
    if (bufferPtr != tmp) {
        free(bufferPtr);
        bufferPtr = NULL;
    }
    
    NSString * returnStr = nil;
    if (cryptData) {
        returnStr = [self hexStringWithData:cryptData];
    }
    return returnStr;
}

//3DES需要调用的DES解密
+ (NSString *)_3DESDecryptWithString:(NSString *)string key:(NSString *)key {
    if (string.length != 16 || key.length != 16) {
        return nil;
    }
    NSData * data = [self dataWithHEXString:string];
    NSData * keyData = [self dataWithHEXString:key];
    uint8_t tmp[1024];
    void *bufferPtr = NULL;
    NSInteger bufferPtrSize = data.length;
    
    if (data.length > 1024) {
        bufferPtr = (void*)malloc(data.length);
    }else{
        bufferPtr = tmp;
    }
    
    size_t datalen = 0;
    CCCryptorStatus ccStatus = CCCrypt(kCCDecrypt,
                                       kCCAlgorithmDES,
                                       kCCOptionECBMode,
                                       keyData.bytes,
                                       keyData.length,
                                       NULL,
                                       data.bytes,
                                       data.length,
                                       bufferPtr,
                                       bufferPtrSize,
                                       &datalen);
    
    NSData * cryptData;
    if (ccStatus == kCCSuccess) {
        cryptData = [NSData dataWithBytes:(const void*)bufferPtr length:datalen];
    }
    
    if (bufferPtr != tmp) {
        free(bufferPtr);
        bufferPtr = NULL;
    }
    
    NSString * returnStr = nil;
    if (cryptData) {
        returnStr = [self hexStringWithData:cryptData];
    }
    return returnStr;
}

#pragma mark - 非对称算法

#pragma mark - 其他方法

/**
 MARK:base64编码

 @param data 待编码data
 @return 编码后字符串
 */
+ (NSString *)base64EncodeStringWithData:(NSData *)data {
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

/**
 MARK:base64解码

 @param string 待解码字符串
 @return 解码后字符串
 */
+ (NSData *)base64DecodeDataWithString:(NSString *)string; {
    NSData * decodeData = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return decodeData;
}

//data转换成十六进制字符串
+ (NSString*)hexStringWithData:(NSData *)data {
    NSMutableString *arrayString = [[NSMutableString alloc]initWithCapacity:data.length * 2];
    int len = (int)data.length;
    unsigned char* bytes = (unsigned char*)data.bytes;
    
    for (int i = 0; i < len; i++) {
        unsigned char cValue = bytes[i];
        
        //        int iValue = cValue;
        //        iValue = iValue & 0x000000FF;
        
        NSString *str = [NSString stringWithFormat:@"%02x",cValue];
        
        [arrayString appendString:str];
    }
    
    return arrayString.uppercaseString;
}

//16进制字符串转data
+ (NSData*)dataWithHEXString:(NSString *)hexStr {
    const char * ch = [[hexStr lowercaseString] cStringUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* data = [NSMutableData data];
    while (*ch) {
        char byte = 0;
        if ('0' <= *ch && *ch <= '9') {
            byte = *ch - '0';
        } else if ('a' <= *ch && *ch <= 'f') {
            byte = *ch - 'a' + 10;
        }
        ch++;
        byte = byte << 4;
        if (*ch) {
            if ('0' <= *ch && *ch <= '9') {
                byte += *ch - '0';
            } else if ('a' <= *ch && *ch <= 'f') {
                byte += *ch - 'a' + 10;
            }
            ch++;
        }
        [data appendBytes:&byte length:1];
    }
    return data;
    
}

@end
