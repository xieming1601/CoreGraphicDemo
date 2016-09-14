//
//  CostomView.m
//  DrawingDemo
//
//  Created by xsm on 16/9/14.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "CostomView.h"

@implementation CostomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/

- (void)drawRect:(CGRect)rect {
    // Drawing code

    //使用UIBezierPath进行绘图操作
//    [self DrawUsingBezier];
    
    //使用coreGraphics进行绘图，实现方式更加底层一些
    [self DrawUsingCoreGraphic];

}

-(void) DrawUsingBezier{
    UIColor *color = [UIColor colorWithRed:0 green:0 blue:0.7 alpha:1];
    [color set]; //设置线条颜色
    
    //画矩形
    //UIBezierPath* aPath = [UIBezierPath bezierPathWithRect:CGRectMake(20, 20, 100, 50)];
    
    //画圆
    //    UIBezierPath* aPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 20, 100, 100)];
    
    //椭圆
    //    UIBezierPath* aPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 20, 100, 50)];
    
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    
    aPath.lineWidth = 5.0;
    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
    
    // 起点
    [aPath moveToPoint:CGPointMake(100.0, 0.0)];
    
    // 绘制线条
    [aPath addLineToPoint:CGPointMake(200.0, 40.0)];
    [aPath addLineToPoint:CGPointMake(160, 140)];
    [aPath addLineToPoint:CGPointMake(40.0, 140)];
    [aPath addLineToPoint:CGPointMake(0.0, 40.0)];
    [aPath closePath];//第五条线通过调用closePath方法得到的
    
    //根据坐标点连线
    [aPath stroke];
    
    //填充多边形
    [aPath fill];
}

-(void) DrawUsingCoreGraphic{
    
    //绘制矩形
    [self DrawRectangle];
    
    //绘制圆形或者弧形
    [self DrawCircleAtX:self.bounds.size.width/2 Y:self.bounds.size.height/2 - 30];
    
    //绘制椭圆
    [self DrawEllipseAtX:self.bounds.size.width/2 - 90 Y:self.bounds.size.height/2 - 90];
    [self DrawEllipseAtX:self.bounds.size.width/2 + 30 Y:self.bounds.size.height/2 - 90];
    
    //绘制多边形
    [self DrawTriangle];
    
    //绘制圆形渐变
    [self DrawdrawRadialGradientWithRect:CGRectMake(120, 510, 60, 60)];
    
    //绘制线形渐变
    [self DrawingLinearGradientWithStartPoint:CGPointMake(50, 50) endPoint:CGPointMake(100, 100)];
    
    //自定义图形实现渐变
    [self DrawMyGradient];
    
}

-(void) DrawRectangle{
    CGRect rectangle = CGRectMake(self.bounds.size.width/2 - 80, self.bounds.size.height/2 + 150, 160, 60);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddRect(ctx, rectangle);
    CGContextSetFillColorWithColor(ctx, [UIColor lightGrayColor].CGColor);
    
    CGContextFillPath(ctx);
}

- (void)DrawCircleAtX:(float)x Y:(float)y {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddArc(ctx, x, y, 150, 0, 2 * M_PI, 1);
    //添加阴影效果
    CGContextSetShadowWithColor(ctx, CGSizeMake(10, 10), 20.0f, [[UIColor grayColor] CGColor]);
    CGContextSetFillColorWithColor(ctx, [UIColor yellowColor].CGColor);
    CGContextFillPath(ctx);
}

- (void)DrawEllipseAtX:(float)x Y:(float)y {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rectangle = CGRectMake(x, y, 60, 30);
    CGContextAddEllipseInRect(ctx, rectangle);
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextFillPath(ctx);
}

- (void)DrawTriangle {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(ctx);
    NSLog(@"%f",self.bounds.size.height/2);
    CGContextMoveToPoint(ctx, self.bounds.size.width/2, self.bounds.size.height/2 - 220);
    CGContextAddLineToPoint(ctx, self.bounds.size.width/2 + 40, self.bounds.size.height/2 - 180);
    CGContextAddLineToPoint(ctx, self.bounds.size.width/2 - 40, self.bounds.size.height/2 - 180);
    CGContextClosePath(ctx);
    
    CGContextSetFillColorWithColor(ctx, [UIColor greenColor].CGColor);
    CGContextFillPath(ctx);
}

- (void)DrawdrawRadialGradientWithRect:(CGRect)rect
{
    //先创造一个CGGradientRef,颜色是白,黑,location分别是0,1
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSArray* gradientColors = [NSArray arrayWithObjects:
                               (id)[UIColor whiteColor].CGColor,
                               (id)[UIColor blackColor].CGColor, nil];
    CGFloat gradientLocations[] = {0, 1};
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace,
                                                        (__bridge CFArrayRef)gradientColors,
                                                        gradientLocations);
    CGPoint startCenter = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    CGFloat radius = MAX(CGRectGetHeight(rect), CGRectGetWidth(rect));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawRadialGradient(context, gradient,
                                startCenter, 0,
                                startCenter, radius,
                                0);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

- (void)DrawingLinearGradientWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSArray* gradientColors = [NSArray arrayWithObjects:
                               (id)[UIColor whiteColor].CGColor,
                               (id)[UIColor purpleColor].CGColor, nil];
    CGFloat gradientLocations[] = {0, 1};
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace,
                                                        (__bridge CFArrayRef)gradientColors,
                                                        gradientLocations);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint,0);
    CGContextRestoreGState(context);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

-(void) DrawMyGradient{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSArray* gradientColors = [NSArray arrayWithObjects:
                               (id)[UIColor whiteColor].CGColor,
                               (id)[UIColor purpleColor].CGColor, nil];
    CGFloat gradientLocations[] = {0, 1};
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace,
                                                        (__bridge CFArrayRef)gradientColors,
                                                        gradientLocations);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextMoveToPoint(context, 100, 100);
    CGContextAddArc(context, 100, 100, 60, 1.04 , 2.09 , 0);
    CGContextClosePath(context);
    CGContextClip(context);
    
    
    CGPoint endshine;
    CGPoint startshine;
    startshine = CGPointMake(100 + 60 * cosf( 1.57 ),100+ 60 * sinf( 1.57 ));
    endshine = CGPointMake(100,100);
    CGContextDrawLinearGradient(context,gradient , startshine, endshine, kCGGradientDrawsAfterEndLocation);
    CGContextRestoreGState(context);
}
@end
