//
//  WWShapeLayer.m
//  QiuDouMaDai
//
//  Created by 王威 on 2016/12/21.
//  Copyright © 2016年 王威. All rights reserved.
//

#import "WWShapeLayer.h"
@implementation WWShapeLayer{
    CAShapeLayer *backLayer;
}
//-(void)creat{
//    //UIBezierPath是跟CAShapeLayer配套使用 一个CAShapeLayer可以跟好几个UIBezierPath 连用 用来画图
//    UIBezierPath *path=[UIBezierPath bezierPath];
//    //先设置path的起始点
//    [path moveToPoint:self.centerPoint];
//    //以self.centerPint为中心点画一个圆 如果moveTo的中心跟下面这行代码的中心点不在一个点上面 系统就会自动把 两个中心店连到一起  两个center都是绝对坐标
//    [path addArcWithCenter:self.centerPoint radius:self.radius startAngle:self.startAngle endAngle:self.endAngle clockwise:YES];
////    [path addArcWithCenter:self.centerPoint radius:self.radius/2 startAngle:self.startAngle endAngle:self.endAngle clockwise:YES];
//
//    //画完关了 养成良好的习惯是现在我们这一代青少年必备的良好的习惯
//    [path closePath];
////    self.lineWidth = 25;
//    //把CAShaperLayer跟UIBezierPath联系起来  CAShapeLayer是用C语言写的所以 path后面要加个点转化成C语言 跟Color一样
//    self.path=path.CGPath;
//    //设置画笔颜色
//    self.strokeColor=[UIColor whiteColor].CGColor;
//    //设置填充颜色
////    self.fillColor=[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1].CGColor;
//    self.fillColor=self.fullColor.CGColor;
////    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
////    pathAnimation.duration = 1.0;
////    pathAnimation.fromValue = [NSNumber numberWithFloat:0.5f];
////    pathAnimation.toValue = [NSNumber numberWithFloat:0.8f];
////    [self addAnimation:pathAnimation forKey:nil];
//}
- (void)creat{

    UIBezierPath *path=[UIBezierPath bezierPath];
    [path moveToPoint:self.centerPoint];
    [path addArcWithCenter:self.centerPoint radius:self.radius startAngle:self.startAngle endAngle:self.endAngle clockwise:YES];
    [path closePath];
    self.path=path.CGPath;
    self.strokeColor=[UIColor clearColor].CGColor;
    self.fillColor=self.fullColor.CGColor;
    
    backLayer = [CAShapeLayer layer];
    UIBezierPath *pathA=[UIBezierPath bezierPath];
    [pathA moveToPoint:self.centerPoint];
    [pathA addArcWithCenter:self.centerPoint radius:self.radius/2 startAngle:self.startAngle endAngle:self.endAngle clockwise:YES];
    [pathA closePath];
    backLayer.path = pathA.CGPath;
    backLayer.strokeColor = [UIColor whiteColor].CGColor;
    backLayer.fillColor = [UIColor whiteColor].CGColor;
    
    [self addSublayer:backLayer];
}


//下面开始写选中的时候的动画,看好了
-(void)setSeclected:(BOOL)seclected{
    _seclected=seclected;
    CGPoint newCenterPoint=_centerPoint;
    if (seclected) {
        //center 往左上角移动一点 cosf跟sinf高中学过哦
        newCenterPoint=CGPointMake(_centerPoint.x + cosf((_startAngle + _endAngle) / 2) * 30, _centerPoint.y + sinf((_startAngle + _endAngle) / 2) * 30);
    }
    //再创建一个path
    UIBezierPath *path = [UIBezierPath bezierPath];
    //起始中心点改一下
    [path moveToPoint:newCenterPoint];
    [path addArcWithCenter:newCenterPoint radius:_radius startAngle:_startAngle endAngle:_endAngle clockwise:YES];
    
    [path closePath];
    self.path = path.CGPath;
    
    UIBezierPath *pathA=[UIBezierPath bezierPath];
    [pathA moveToPoint:self.centerPoint];
    [pathA addArcWithCenter:newCenterPoint radius:_radius/2 startAngle:_startAngle endAngle:_endAngle clockwise:YES];
    [pathA closePath];
    backLayer.path = pathA.CGPath;
    
    //添加动画
    CABasicAnimation *animation = [CABasicAnimation animation];
    //keyPath内容是只用用对象的哪个属性需要动画
    animation.keyPath = @"path";
    //所改变属性的结束时的值
    animation.toValue = path;
    //动画市场
    animation.duration = 0.5;
    //动画结束时是否执行逆动画
//    animation.autoreverses=YES;
    ///添加动画
    [self addAnimation:animation forKey:nil];
    [backLayer addAnimation:animation forKey:nil];
}
@end
