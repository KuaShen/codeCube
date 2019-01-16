//
//  SNChartBar.h
//  shudaixiongTEA
//
//  Created by shen on 16/10/17.
//  Copyright © 2016年 shen. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat chartBarStartX = 20.f;
static const CGFloat chartBarTheXAxisSpan = 50.f;
static const CGFloat chartBarTheYAxisSpan = 20.f;

@interface SNChartBar : UIView

@property (nonatomic, strong) NSArray * xValues;
@property (nonatomic, strong) NSArray * yValues;

@property (nonatomic, assign) CGFloat yMax;

/**
 *  @author sen, 15-12-24 10:12:59
 *
 *  开始绘制图表
 */
- (void)startDrawBars;

@end
