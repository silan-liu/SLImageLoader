//
//  ViewController.m
//  SLImageLoader
//
//  Created by liusilan on 15/3/19.
//  Copyright (c) 2015年 YY, Inc. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+SLImageLoader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [_imageView initLoader];
    [_imageView reveal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
