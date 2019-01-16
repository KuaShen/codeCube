//
//  BarCharDataValueFormatter.m
//  MLF
//
//  Created by 123456 on 2018/5/4.
//  Copyright © 2018年 123456. All rights reserved.
//

#import "BarCharDataValueFormatter.h"

@implementation BarCharDataValueFormatter

/// 实现协议方法，返回柱形上显示的数据格式
- (NSString * _Nonnull)stringForValue:(double)value
                                entry:(ChartDataEntry * _Nonnull)entry
                         dataSetIndex:(NSInteger)dataSetIndex
                      viewPortHandler:(ChartViewPortHandler * _Nullable)viewPortHandler {
    
    return [NSString stringWithFormat:@"%.1f%%", entry.y];
}

@end
