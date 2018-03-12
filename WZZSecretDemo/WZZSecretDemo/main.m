//
//  main.m
//  WZZSecretDemo
//
//  Created by 王泽众 on 2017/8/21.
//  Copyright © 2017年 王泽众. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZZSecret.h"

//MARK:3DES
void wzzDes3Test() {
    NSString * mainKey = @"";
    NSString * mPinKey = @"";
    NSString * pinBlock = @"";
    
    NSString * pinKey = [WZZSecret DES3DecryptWithString:mPinKey key:mainKey];
    NSString * pin = [WZZSecret DES3DecryptWithString:pinBlock key:pinKey];

    NSLog(@"pin:%@, pinKey:%@", pin, pinKey);
}

//MARK:base64
void wzzBase64() {
    NSString * base64Str = @"eyJsb2NhRGF0ZSI6IjIwMTctMDktMjgiLCJzdGFuIjoiUDIwMTcxMTAxMTMyOTM3IiwibXNndHlwZSI6IkgxOTUiLCJzZXR0bGV0eXBlIjoiUzAiLCJuYW1lIjoi5LqO5ZSv6LGqIiwicHJlU2VyaWFsIjoiUDEwMDA1MTU3MTA1IiwiZW5jb2RlZCI6IlVURi04Iiwic2lnbmF0dXJlIjoiNTE2ZGEyZmYxNDc4OWUxMjcyZDNlZThkMmI2MGNlYjQiLCJkbW51bSI6IjEwMDAwNiIsInRyYW5vIjoiSEYxMDAwMDAwMzY1NzU3IiwicHJlTXNnIjoiSDE5NyJ9";
    NSString * deStr = [WZZSecret base64DecryptWithData:base64Str];
    NSLog(@"%@", deStr);
    NSString * string = [WZZSecret hexStringWithData:[deStr dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%@", string);
}

//MARK:MD5
void wzzMD5() {
    NSString * str = @"123456";
    NSString * md5Str = [WZZSecret MD5WithString:str];
    NSLog(@"%@", md5Str);
}

//MARK:AES
void wzzAES() {
    NSString * str = @"123456";
    NSString * key = @"123456";
    NSString * aesStr = [WZZSecret AES128EncryptWithString:str key:key];
    NSLog(@"aes128E:%@", aesStr);
    aesStr = @"4f1eb44d4de6ae7e97d3800ee5370f1f";
    NSString * aes2 = [WZZSecret AES128DecryptWithString:aesStr key:key];
    NSLog(@"aes128D:%@", aes2);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        wzzAES();
    }
    return 0;
}
