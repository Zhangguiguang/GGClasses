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

@property (nonatomic, assign) CGSize cacheSize;
@property (nonatomic, assign) BOOL needRecalculate;

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
        
        _imageTitleSpace = 0.0;
        _imageRate = 0.7;
        _imageDirection = GGButtonImageAtLeft;
    }
    return self;
}

- (void)setSpace:(CGFloat)space rate:(CGFloat)rate direction:(GGButtonImageDirection)direction {
    _imageTitleSpace = space;
    _imageRate = rate;
    _imageDirection = direction;
    _needRecalculate = YES;
    [self layoutSubviews];
}

#pragma mark - override
- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets {
    _needRecalculate = YES;
    [super setContentEdgeInsets:contentEdgeInsets];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    [self calculateImageAndTitleFrame];
    return _imageRect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    [self calculateImageAndTitleFrame];
    return _titleRect;
}

#pragma mark - private function
- (void)calculateImageAndTitleFrame {
    if (!CGSizeEqualToSize(_cacheSize, self.bounds.size)) {
        _needRecalculate = YES;
    }
    
    if (_needRecalculate == NO) {
        return ;
    }
//    NSLog(@"calculateImageAndTitleFrame");
    // recalculate _imageRect _titleRect
    CGFloat usefulWidth  = self.bounds.size.width  - self.contentEdgeInsets.left - self.contentEdgeInsets.right;
    CGFloat usefulHeight = self.bounds.size.height - self.contentEdgeInsets.top  - self.contentEdgeInsets.bottom;
    CGFloat imageLength  = 0;
    CGFloat titleLength  = 0;
    BOOL isVertical = (_imageDirection == GGButtonImageAtTop || _imageDirection == GGButtonImageAtBottom);
    if (isVertical) {
        usefulHeight -= _imageTitleSpace;
        imageLength  = usefulHeight * _imageRate;
        titleLength  = usefulHeight - imageLength;
    } else {
        usefulWidth  -= _imageTitleSpace;
        imageLength  = usefulWidth * _imageRate;
        titleLength  = usefulWidth - imageLength;
    }
    
    if (_imageDirection == GGButtonImageAtLeft) {
        _imageRect = CGRectMake(self.contentEdgeInsets.left,
                                self.contentEdgeInsets.top,
                                imageLength,
                                usefulHeight);
        _titleRect = CGRectMake(CGRectGetMaxX(_imageRect) + _imageTitleSpace,
                                self.contentEdgeInsets.top,
                                titleLength,
                                usefulHeight);
    } else if (_imageDirection == GGButtonImageAtRight) {
        _titleRect = CGRectMake(self.contentEdgeInsets.left,
                                self.contentEdgeInsets.top,
                                titleLength,
                                usefulHeight);
        _imageRect = CGRectMake(CGRectGetMaxX(_titleRect) + _imageTitleSpace,
                                self.contentEdgeInsets.top,
                                imageLength,
                                usefulHeight);
    } else if (_imageDirection == GGButtonImageAtTop) {
        _imageRect = CGRectMake(self.contentEdgeInsets.left,
                                self.contentEdgeInsets.top,
                                usefulWidth,
                                imageLength);
        _titleRect = CGRectMake(self.contentEdgeInsets.left,
                                CGRectGetMaxY(_imageRect) + _imageTitleSpace,
                                usefulWidth,
                                titleLength);
    } else if (_imageDirection == GGButtonImageAtBottom) {
        _titleRect = CGRectMake(self.contentEdgeInsets.left,
                                self.contentEdgeInsets.top,
                                usefulWidth,
                                titleLength);
        _imageRect = CGRectMake(self.contentEdgeInsets.left,
                                CGRectGetMaxY(_titleRect) + _imageTitleSpace,
                                usefulWidth,
                                imageLength);
    } else {
        _imageRect = CGRectZero;
        _titleRect = CGRectZero;
    }
    
    // 标记
    _cacheSize = self.bounds.size;
    _needRecalculate = NO;
}

#pragma mark - my setter
- (void)setImageDirection:(GGButtonImageDirection)imageDirection {
    if (_imageDirection != imageDirection) {
        _imageDirection  = imageDirection;
        _needRecalculate = YES;
        [self layoutSubviews];
    }
}

- (void)setImageRate:(CGFloat)imageRate {
    if (_imageRate != imageRate) {
        _imageRate  = imageRate;
        _needRecalculate = YES;
        [self layoutSubviews];
    }
}

- (void)setImageTitleSpace:(CGFloat)imageTitleSpace {
    if (_imageTitleSpace != imageTitleSpace) {
        _imageTitleSpace  = imageTitleSpace;
        _needRecalculate  = YES;
        [self layoutSubviews];
    }
}

@end
