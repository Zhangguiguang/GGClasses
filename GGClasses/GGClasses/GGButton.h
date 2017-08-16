//
//  GGButton.h
//  UIButtonTest
//
//  Created by 广锅锅 on 2017/5/13.
//  Copyright © 2017年 GG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    GGButtonImageAtLeft = 0,
    GGButtonImageAtRight = 2,
    GGButtonImageAtTop = 1,
    GGButtonImageAtBottom = 3,
} GGButtonImageDirection;

@interface GGButton : UIButton

@property (nonatomic, assign) CGFloat ggImageTitleSpace;

// default = 0.7;
@property (nonatomic, assign) CGFloat ggImageRate;

// default = GGButtonImageAtLeft
@property (nonatomic, assign) GGButtonImageDirection ggImageDirection;

@end
