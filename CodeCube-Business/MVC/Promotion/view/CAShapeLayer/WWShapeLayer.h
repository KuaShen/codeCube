//
//  WWShapeLayer.h
//  QiuDouMaDai
//
//  Created by 王威 on 2016/12/21.
//  Copyright © 2016年 王威. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@interface WWShapeLayer : CAShapeLayer
//! 起始角度
@property(nonatomic,assign)CGFloat startAngle;
//! 结束角度
@property(nonatomic,assign)CGFloat endAngle;
//! 中心
@property(nonatomic,assign)CGPoint centerPoint;
//! 半径
@property(nonatomic,assign)CGFloat radius;
//! 内容
@property(nonatomic,strong)NSString *text;
//! 是否可以被选中
@property(nonatomic,assign)BOOL seclected;
//! 设置tag值 判断点到的是哪个
@property(nonatomic,assign)NSInteger tag;
//! 设置病状图的填充颜色
@property(nonatomic,strong)UIColor *fullColor;
//! 数据数组
@property(nonatomic, strong) NSMutableArray *dataArray;
//! 创建绘图
-(void)creat;
@end
