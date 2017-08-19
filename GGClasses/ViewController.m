//
//  ViewController.m
//  GGClasses
//
//  Created by 张贵广 on 2017/8/16.
//  Copyright © 2017年 GG. All rights reserved.
//

#import "ViewController.h"
#import "GGKeyChain.h"
#import "GGButton.h"

@interface ViewController ()
@property (nonatomic, strong) GGButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    NSString *key = @"com.gg.keychain.test000";
//    NSString *value = @"GGHAHAHA";
//    
//    NSString *keyChainValue = [GGKeyChain getStringForKey:key];
//    NSLog(@"keyChainValue = %@", keyChainValue);
//    
//    [GGKeyChain setString:value forKey:key];
//    
//    keyChainValue = [GGKeyChain getStringForKey:key];
//    NSLog(@"keyChainValue = %@", keyChainValue);

    // normal UIButton
    _button = [[GGButton alloc] init];
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_button setImage:[UIImage imageNamed:@"icon_selected"] forState:UIControlStateNormal];
    [_button setImage:[UIImage imageNamed:@"ic_gift"] forState:UIControlStateHighlighted];
    [_button setTitle:@"Normal" forState:UIControlStateNormal];
    [_button setTitle:@"Selected" forState:UIControlStateHighlighted];
    [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    _button.imageView.backgroundColor = [UIColor colorWithRed:0.30 green:0.94 blue:0.99 alpha:0.6];
    _button.titleLabel.backgroundColor = [UIColor colorWithRed:0.99 green:0.52 blue:0.44 alpha:0.6];
    _button.backgroundColor = [UIColor colorWithRed:0.75 green:0.99 blue:0.38 alpha:1];
    
    _button.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 20, 15);
    _button.bounds = CGRectMake(0, 0, 100, 100);
    _button.center = self.view.center;
    [self.view addSubview:_button];
    
    // GGButton
    _button.imageTitleSpace = 10;
    _button.imageRate = 0.5;
    _button.imageDirection = GGButtonImageAtTop;
//    [_button setSpace:10 rate:0.5 direction:GGButtonImageAtTop];
    
}

- (void)buttonClick {
    CGFloat space = arc4random() % 20 + 5;              // (5 - 25)
    CGFloat rate  = (arc4random() % 50 + 25) / 100.0;   // (0.25 - 0.75)
    NSUInteger direction = arc4random() % 4;
    NSLog(@"space : %lf, rate : %.2lf, direction : %lu", space, rate, direction);
    
    [UIView animateWithDuration:0.4
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         _button.bounds = CGRectMake(0, 0, arc4random() % 100 + 100, arc4random() % 100 + 100);
//                         _button.frame = CGRectMake(arc4random() % 100 + 100, arc4random() % 100 + 100, arc4random() % 100 + 100, arc4random() % 100 + 100);
                         _button.contentEdgeInsets = UIEdgeInsetsMake(arc4random() % 10 + 5, arc4random() % 10 + 5, arc4random() % 10 + 5, arc4random() % 10 + 5);
                         [_button setSpace:space rate:rate direction:direction];
    } completion:nil];
}

@end
