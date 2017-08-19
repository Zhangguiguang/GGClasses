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

@property (nonatomic, assign) CGRect cacheRect;
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
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    [self calculateImageAndTitleRectWithContentRect:contentRect];
    return _imageRect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    [self calculateImageAndTitleRectWithContentRect:contentRect];
    return _titleRect;
}

#pragma mark - private function
- (void)calculateImageAndTitleRectWithContentRect:(CGRect)contentRect {
    if (!CGRectEqualToRect(_cacheRect, contentRect)) {
        _needRecalculate = YES;
    }
    
    if (_needRecalculate == NO) {
        return ;
    }
    NSLog(@"calculateImageAndTitleFrame");
    // recalculate _imageRect _titleRect
    BOOL isVertical = (_imageDirection == GGButtonImageAtTop || _imageDirection == GGButtonImageAtBottom);
    
    // set Rects's size
    if (isVertical) {
        CGFloat usefulHeight = contentRect.size.height - _imageTitleSpace;
        _imageRect.size = CGSizeMake(contentRect.size.width, usefulHeight * _imageRate);
        _titleRect.size = CGSizeMake(contentRect.size.width, usefulHeight * (1 - _imageRate));
    } else {
        CGFloat usefulWidth  = contentRect.size.width - _imageTitleSpace;
        _imageRect.size = CGSizeMake(usefulWidth * _imageRate, contentRect.size.height);
        _titleRect.size = CGSizeMake(usefulWidth * (1 - _imageRate), contentRect.size.height);
    }
    
    // set Rects's origin
    _imageRect.origin = contentRect.origin;
    _titleRect.origin = contentRect.origin;
    BOOL isImageLeading = (_imageDirection == GGButtonImageAtTop || _imageDirection == GGButtonImageAtLeft);
    CGRect *leadingRect = isImageLeading ? &_imageRect : &_titleRect;
    CGRect *tailingRect = isImageLeading ? &_titleRect : &_imageRect;
    if (isVertical) {
        tailingRect->origin.y = CGRectGetMaxY(*leadingRect) + _imageTitleSpace;
    } else {
        tailingRect->origin.x = CGRectGetMaxX(*leadingRect) + _imageTitleSpace;
    }
    
    // 标记
    _cacheRect = contentRect;
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
