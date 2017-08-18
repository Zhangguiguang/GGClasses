//
//  GGButton.h
//  UIButtonTest
//
//  Created by 广锅锅 on 2017/5/13.
//  Copyright © 2017年 GG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GGButtonImageDirection) {
    GGButtonImageAtLeft = 0,
    GGButtonImageAtRight = 2,
    GGButtonImageAtTop = 1,
    GGButtonImageAtBottom = 3,
};

@interface GGButton : UIButton

- (void)setSpace:(CGFloat)space rate:(CGFloat)rate direction:(GGButtonImageDirection)direction;

@property (nonatomic, assign) CGFloat imageTitleSpace;

// default 0.7
@property (nonatomic, assign) CGFloat imageRate;

// default = GGButtonImageAtLeft
@property (nonatomic, assign) GGButtonImageDirection imageDirection;

@end
