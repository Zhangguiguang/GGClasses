//
//  ViewController.m
//  GGClasses
//
//  Created by 张贵广 on 2017/8/16.
//  Copyright © 2017年 GG. All rights reserved.
//

#import "ViewController.h"
#import "GGKeyChain.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *key = @"com.gg.keychain.test000";
    NSString *value = @"GGHAHAHA";
    
    NSString *keyChainValue = [GGKeyChain getStringForKey:key];
    NSLog(@"keyChainValue = %@", keyChainValue);
    
    
    [GGKeyChain setString:value forKey:key];
    
    keyChainValue = [GGKeyChain getStringForKey:key];
    NSLog(@"keyChainValue = %@", keyChainValue);
}

@end
