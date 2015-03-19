//
//  UIImageView+SLImageLoader.h
//  SLImageLoader
//
//  Created by liusilan on 15/3/19.
//  Copyright (c) 2015年 YY, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImageView (SLImageLoader)

- (void)initLoader;
- (void)reveal;

- (void)startLoading;
- (void)stopLoading;

@end
