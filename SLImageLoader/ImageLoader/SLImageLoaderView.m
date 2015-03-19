//
//  SLImageLoaderView.m
//  SLImageLoader
//
//  Created by liusilan on 15/3/19.
//  Copyright (c) 2015年 YY, Inc. All rights reserved.
//

#import "SLImageLoaderView.h"

@implementation SLImageLoaderView
{
    CAShapeLayer *_circleLayer;
    CAShapeLayer *_pathLayer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _circleLayer = [CAShapeLayer layer];
        
        _circleLayer.strokeColor = [UIColor redColor].CGColor;
        _circleLayer.fillColor = [UIColor clearColor].CGColor;
        _circleLayer.lineWidth = 2;
        
        [self.layer addSublayer:_circleLayer];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGPoint center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:20 startAngle:0 endAngle:M_PI_2 * 3 clockwise:YES];
    
    _circleLayer.frame = self.bounds;
    _circleLayer.path = path.CGPath;
}

- (void)startLoading
{
    // animation
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotationAnimation.toValue = @(M_PI * 2);
    rotationAnimation.repeatCount = 3;
    rotationAnimation.duration = 1;
    
    // 区分type
    [rotationAnimation setValue:@"rotation" forKey:@"animationType"];
    rotationAnimation.delegate = self;
    
    [_circleLayer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)stopLoading
{
    [_circleLayer removeAnimationForKey:@"rotationAnimation"];
    
    [_circleLayer removeFromSuperlayer];
    _circleLayer = nil;
}

- (void)startPathAnimation
{
    if (!_pathLayer)
    {
        _pathLayer = [CAShapeLayer layer];
        _pathLayer.frame = self.bounds;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width / 2,self.frame.size.height / 2) radius:20 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        
        _pathLayer.path = path.CGPath;
    }
    
    // mask
    self.superview.layer.mask = _pathLayer;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(path))];
    
    pathAnimation.delegate = self;
    pathAnimation.duration = 1;
    pathAnimation.toValue = (__bridge id)([self toPath].CGPath);
    
    // 区分type
    [pathAnimation setValue:@"path" forKey:@"animationType"];
    
    [_pathLayer addAnimation:pathAnimation forKey:@"pathAnimation"];
}

- (void)reveal
{
    [self startLoading];
}

- (UIBezierPath *)toPath
{
    CGPoint center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:MAX(self.frame.size.width, self.frame.size.height) startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    return path;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSString *animationType = [anim valueForKey:@"animationType"];
    if ([animationType isEqualToString:@"rotation"])
    {
        [_circleLayer removeAllAnimations];
        [_circleLayer removeFromSuperlayer];
        _circleLayer = nil;
        
        [self startPathAnimation];
    }
    else
    {
        self.superview.layer.mask = nil;
        [_pathLayer removeAllAnimations];
        [self removeFromSuperview];
    }
}

@end
