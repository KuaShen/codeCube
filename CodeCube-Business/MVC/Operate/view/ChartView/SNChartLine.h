//
//  SNChartLine.h
//  shudaixiongTEA
//
//  Created by shen on 16/10/17.
//  Copyright © 2016年 shen. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat chartLineStartX = 20.f;
static const CGFloat chartLineTheXAxisSpan = 25.f;
static const CGFloat chartLineTheYAxisSpan = 30.f;

@interface SNChartLine : UIView

@property (nonatomic, strong) NSArray * xValues;
@property (nonatomic, strong) NSArray * yValues;

@property (nonatomic, assign) CGFloat yMax;

@property (nonatomic, assign) BOOL curve;//是否曲线

/**
 *  @author sen, 15-12-24 10:12:59
 *
 *  开始绘制图表
 */
- (void)startDrawLines;

@end
