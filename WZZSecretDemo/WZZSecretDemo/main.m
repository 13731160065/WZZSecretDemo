//
//  main.m
//  WZZSecretDemo
//
//  Created by 王泽众 on 2017/8/21.
//  Copyright © 2017年 王泽众. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZZSecret.h"
#import "NSData+WZZAESEncrypt.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString * mainKey = @"";
        NSString * mPinKey = @"";
        NSString * pinBlock = @"";
        
        NSString * pinKey = [WZZSecret DES3DecryptWithString:mPinKey key:mainKey];
        NSString * pin = [WZZSecret DES3DecryptWithString:pinBlock key:pinKey];
        NSString * acc = @"";
        
    }
    return 0;
}
