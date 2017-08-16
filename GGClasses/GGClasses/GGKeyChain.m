//
//  GGKeyChain.m
//  ClubFactory
//
//  Created by 张贵广 on 2017/4/28.
//  Copyright © 2017年 GG. All rights reserved.
//

#import "GGKeyChain.h"
#import <Security/Security.h>

@implementation GGKeyChain

+ (NSMutableDictionary *)getKeychainQueryWithKey:(NSString *)key {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword, (id)kSecClass,
            key, (id)kSecAttrService,
            key, (id)kSecAttrAccount,
            nil];
}

+ (void)setData:(NSData *)data forKey:(NSString *)key {
    NSMutableDictionary *keychainQuery = [self getKeychainQueryWithKey:key];
    SecItemDelete((CFDictionaryRef)keychainQuery);
    [keychainQuery setObject:data forKey:(id)kSecValueData];
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

+ (void)deleteDataForKey:(NSString *)key {
    NSMutableDictionary *keychainQuery = [self getKeychainQueryWithKey:key];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

+ (NSData *)getDataForKey:(NSString *)key {
    NSMutableDictionary *keychainQuery = [self getKeychainQueryWithKey:key];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    NSData *ret = nil;
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        ret = (__bridge NSData *)keyData;
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

#pragma mark - 专门操作字符串
+ (void)setString:(NSString *)string forKey:(NSString *)key {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [self setData:data forKey:key];
}

+ (NSString *)getStringForKey:(NSString *)key {
    NSData *data = [self getDataForKey:key];
    if (data == nil) {
        return nil;
    }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
