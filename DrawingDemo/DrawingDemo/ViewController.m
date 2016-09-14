//
//  ViewController.m
//  DrawingDemo
//
//  Created by xsm on 16/9/14.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize myView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    myView = [[CostomView alloc] init];
    
    [self.view addSubview:myView];
    
    [myView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //子view的上边缘离父view的上边缘40个像素
    NSLayoutConstraint *contraint1 = [NSLayoutConstraint constraintWithItem:myView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.0];
    
    //子view的左边缘离父view的左边缘40个像素
    
    NSLayoutConstraint *contraint2 = [NSLayoutConstraint constraintWithItem:myView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.0];
    
    //子view的下边缘离父view的下边缘40个像素
    
    NSLayoutConstraint *contraint3 = [NSLayoutConstraint constraintWithItem:myView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10.0];
    
    //子view的右边缘离父view的右边缘40个像素
    
    NSLayoutConstraint *contraint4 = [NSLayoutConstraint constraintWithItem:myView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.0];
    
    //把约束添加到父视图上
    
    NSArray *array = [NSArray arrayWithObjects:contraint1, contraint2, contraint3, contraint4, nil];
    
    [self.view addConstraints:array];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
