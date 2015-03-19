//
//  UIImageView+SLImageLoader.m
//  SLImageLoader
//
//  Created by liusilan on 15/3/19.
//  Copyright (c) 2015年 YY, Inc. All rights reserved.
//

#import "UIImageView+SLImageLoader.h"
#import "SLImageLoaderView.h"
#import "objc/runtime.h"

@implementation UIImageView (SLImageLoader)

- (SLImageLoaderView*)imageLoaderView
{
    SLImageLoaderView *loaderView = objc_getAssociatedObject(self, @selector(imageLoaderView));
    if (!loaderView) {
        loaderView = [SLImageLoaderView new];
        loaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        objc_setAssociatedObject(self, @selector(imageLoaderView), loaderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return loaderView;
}

- (void)startLoading
{
    [[self imageLoaderView] startLoading];
}

- (void)stopLoading
{
    [[self imageLoaderView] stopLoading];
}

- (void)initLoader
{
    SLImageLoaderView *loaderView = self.imageLoaderView;
    loaderView.frame = self.bounds;
    [self addSubview:loaderView];
}

- (void)reveal
{
    [self.imageLoaderView reveal];
}

@end
