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

//MARK:AES128
void wzzAES128() {
    NSString * str = @"123a啊";
    NSString * key = @"123a啊";
    NSString * aesStr = [WZZSecret AES128EncryptWithString:str key:key];
    NSLog(@"明文:%@", str);
    NSLog(@"密钥:%@", key);
    NSLog(@"aes128加密:%@", aesStr);
    NSString * aes2 = [WZZSecret AES128DecryptWithString:aesStr key:key];
    NSLog(@"aes128解密:%@", aes2);
}

//MARK:AES256
void wzzAES256() {
//    NSString * str = @"123456啊";
//    NSString * key = @"123456";
//    NSString * aesStr = [WZZSecret AES256EncryptWithString:str key:key];
//    NSLog(@"aes256E:%@", aesStr);
//
//    NSString * aes2 = [WZZSecret AES256DecryptWithString:aesStr key:key];
//    NSLog(@"aes256D:%@", aes2);
}

void wzzSHA256() {
    NSString * str = @"123a啊";
    NSString * outStr = [WZZSecret SHA256WithString:str];
    NSLog(@"明文:%@", str);
    NSLog(@"sha256:%@", outStr);
}

#pragma mark - 辅助方法
/**
 字典序排序
 
 @param dic 字典
 @return 排序后的key数组
 */
NSArray * keySortDic(NSDictionary * dic) {
    //字典序排序
    NSMutableArray * keySortArr = [NSMutableArray arrayWithArray:[dic allKeys]];
    for (int i = 0; i < keySortArr.count-1; i++) {
        for (int j = 0; j < keySortArr.count-i-1; j++) {
            if (strcmp([keySortArr[j] UTF8String], [keySortArr[j+1] UTF8String]) > 0) {
                [keySortArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    return keySortArr;
}

/**
 字典序排序并以keyvalue拼接
 
 @param dic 字典
 @return 参数拼接
 */
NSString * argsToStr(NSDictionary * dic, NSArray * keySortArr) {
    //拼接参数
    NSMutableArray * argsArr = [NSMutableArray array];
    for (int i = 0; i < keySortArr.count; i++) {
        NSString * key = keySortArr[i];
        NSString * value = dic[key];
        [argsArr addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
    }
    NSString * argsStr = [argsArr componentsJoinedByString:@"&"];
    return argsStr;
}

//对象转json
NSString * jsonFromObject(id obj) {
    if (obj == nil) {
        return nil;
    }
    NSError * err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:0 error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//json字符串转对象
id objectFromJsonString(NSString * jsonString) {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return obj;
}

#define SHA1KEY @""
#define AES128KEY @""

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //加签
        NSMutableDictionary * sha1Dic = [NSMutableDictionary dictionaryWithDictionary:@{@"a":@"A", @"h":@"好", @"3":@"f3"}];
        NSArray * keySortArr = keySortDic(sha1Dic);//字典序key
        NSString * argsStr = argsToStr(sha1Dic, keySortArr);//拼接keyvalue
        NSString * signOrgStr = [argsStr stringByAppendingString:@""];//拼接密钥
        NSString * sha1 = [WZZSecret SHA1WithString:signOrgStr];
        NSLog(@"\n>sha1:\n>%@\n>%@", signOrgStr, sha1);
        
        sha1Dic[@"sign"] = sha1;
        
        //加aes
        NSString * json = jsonFromObject(sha1Dic);
        NSString * aes = [[WZZSecret AES128EncryptWithString:json key:AES128KEY] lowercaseString];
        NSLog(@"\n>aes:\n>%@\n>%@", json, aes);
        
        //解aes
        NSString * dataJson = @"60CC0C5BCD3827CA126DF2F02002CC9AA6630D1E600D126685A64A171A94EA023F4020F055C061FA63935A756DD2254F25A59BFF0EB87B8F33EEE52A5CEFEF088413104806394A5C336D2076DF351A4D3DDC0BF08B8FECEFE7EECEA49EC6AAC33F66434B4D95B01EDC3F60F5FC719EA4";
        NSString * aesD = [WZZSecret AES128DecryptWithString:dataJson key:AES128KEY];
        NSMutableDictionary * aesDic = [NSMutableDictionary dictionaryWithDictionary:objectFromJsonString(aesD)];
        NSString * sign = [aesDic[@"sign"] lowercaseString];
        aesDic[@"sign"] = nil;
        NSLog(@"\naesD\n%@\n%@\n%@", dataJson, aesD, aesDic);
        
        //验签
        NSArray * keySortArr2 = keySortDic(aesDic);//字典序key
        NSString * argsStr2 = argsToStr(aesDic, keySortArr2);//拼接keyvalue
        NSString * signOrgStr2 = [argsStr2 stringByAppendingString:SHA1KEY];//拼接密钥
        NSString * sha12 = [WZZSecret SHA1WithString:signOrgStr2];
        NSLog(@"%@", sha12);
        if ([sha12 isEqualToString:sign]) {
            NSLog(@"验签成功");
        }
    }
    return 0;
}
