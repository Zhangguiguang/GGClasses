//
//  GGKeyChain.h
//  ClubFactory
//
//  Created by 张贵广 on 2017/4/28.
//  Copyright © 2017年 GG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGKeyChain : NSObject

+ (void)setData:(NSData *)data forKey:(NSString *)key;
+ (void)deleteDataForKey:(NSString *)key;
+ (NSData *)getDataForKey:(NSString *)key;

+ (void)setString:(NSString *)string forKey:(NSString *)key;
+ (NSString *)getStringForKey:(NSString *)key;

@end
