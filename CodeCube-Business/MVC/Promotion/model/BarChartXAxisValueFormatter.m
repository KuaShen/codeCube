//
//  BarChartXAxisValueFormatter.m
//  MLF
//
//  Created by 123456 on 2018/5/4.
//  Copyright © 2018年 123456. All rights reserved.
//

#import "BarChartXAxisValueFormatter.h"

@implementation BarChartXAxisValueFormatter

/// 实现协议方法，返回 x 轴的数据
- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
    
    // value 为 x 轴的值
    
    NSString *returnStr;
    
    switch (((NSInteger)value) + 1) {
            
        case 0:
            returnStr = @"零食";
            break;
        case 1:
            returnStr = @"水果";
            break;
        case 2:
            returnStr = @"蔬菜";
            break;
        case 3:
            returnStr = @"日用品";
            break;
        case 4:
            returnStr = @"家电";
            break;
            
            
        default:
            break;
    }
    
//        return [NSString stringWithFormat:@"%ld 月", (NSInteger)value + 1];
    
    NSLog(@"%lf-----%@\n",value,returnStr);
    
    return returnStr;
}

@end
