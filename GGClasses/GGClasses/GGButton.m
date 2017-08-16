//
//  GGButton.m
//  UIButtonTest
//
//  Created by 广锅锅 on 2017/5/13.
//  Copyright © 2017年 GG. All rights reserved.
//

#import "GGButton.h"

@interface GGButton ()

@property (nonatomic, assign) CGRect imageRect;
@property (nonatomic, assign) CGRect titleRect;

@end

@implementation GGButton

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        _ggImageRate = 0.7;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return _imageRect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return _titleRect;
}

#pragma mark - private function
- (void)gg_resetImageTitleFrame {
    BOOL isVertical = (_ggImageDirection == GGButtonImageAtTop || _ggImageDirection == GGButtonImageAtBottom);
    
    CGFloat usefulWidth = self.bounds.size.width - self.contentEdgeInsets.left - self.contentEdgeInsets.right;
    CGFloat usefulHeight = self.bounds.size.height - self.contentEdgeInsets.top - self.contentEdgeInsets.bottom;
    
    if (isVertical) {
        usefulHeight -= _ggImageTitleSpace;
    } else {
        usefulWidth -= _ggImageTitleSpace;
    }
    
    if (_ggImageDirection == GGButtonImageAtLeft) {
        _imageRect = CGRectMake(self.contentEdgeInsets.left,
                                self.contentEdgeInsets.top,
                                usefulWidth * _ggImageRate,
                                usefulHeight);
        _titleRect = CGRectMake(CGRectGetMaxX(_imageRect) + _ggImageTitleSpace,
                                self.contentEdgeInsets.top,
                                usefulWidth * (1-_ggImageRate),
                                usefulHeight);
    } else if (_ggImageDirection == GGButtonImageAtRight) {
        _titleRect = CGRectMake(self.contentEdgeInsets.left,
                                self.contentEdgeInsets.top,
                                usefulWidth * (1-_ggImageRate),
                                usefulHeight);
        _imageRect = CGRectMake(CGRectGetMaxX(_titleRect) + _ggImageTitleSpace,
                                self.contentEdgeInsets.top,
                                usefulWidth * _ggImageRate,
                                usefulHeight);
    } else if (_ggImageDirection == GGButtonImageAtTop) {
        _imageRect = CGRectMake(self.contentEdgeInsets.left,
                                self.contentEdgeInsets.top,
                                usefulWidth,
                                usefulHeight * _ggImageRate);
        _titleRect = CGRectMake(self.contentEdgeInsets.left,
                                CGRectGetMaxY(_imageRect) + _ggImageTitleSpace,
                                usefulWidth,
                                usefulHeight * (1-_ggImageRate));
    } else if (_ggImageDirection == GGButtonImageAtBottom) {
        _titleRect = CGRectMake(self.contentEdgeInsets.left,
                                self.contentEdgeInsets.top,
                                usefulWidth,
                                usefulHeight * (1-_ggImageRate));
        _imageRect = CGRectMake(self.contentEdgeInsets.left,
                                CGRectGetMaxY(_titleRect) + _ggImageTitleSpace,
                                usefulWidth,
                                usefulHeight * _ggImageRate);
    } else {
        _imageRect = CGRectZero;
        _titleRect = CGRectZero;
    }
}

#pragma mark - override setter
- (void)setFrame:(CGRect)frame {
    [self gg_resetImageTitleFrame];
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds {
    [self gg_resetImageTitleFrame];
    [super setBounds:bounds];
}

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets {
    [self gg_resetImageTitleFrame];
    [super setContentEdgeInsets:contentEdgeInsets];
}

#pragma mark - my setter
- (void)setGgImageDirection:(GGButtonImageDirection)ggImageDirection {
    if (_ggImageDirection != ggImageDirection) {
        _ggImageDirection = ggImageDirection;
        [self gg_resetImageTitleFrame];
        [self layoutSubviews];
    }
}

- (void)setGgImageRate:(CGFloat)ggImageRate {
    if (_ggImageRate != ggImageRate) {
        _ggImageRate = ggImageRate;
        [self gg_resetImageTitleFrame];
        [self layoutSubviews];
    }
}

- (void)setGgImageTitleSpace:(CGFloat)ggImageTitleSpace {
    if (_ggImageTitleSpace != ggImageTitleSpace) {
        _ggImageTitleSpace = ggImageTitleSpace;
        [self gg_resetImageTitleFrame];
        [self layoutSubviews];
    }
}

@end
