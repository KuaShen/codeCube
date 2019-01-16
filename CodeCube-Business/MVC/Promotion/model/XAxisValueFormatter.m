//
//  XAxisValueFormatter.m
//  MLF
//
//  Created by 123456 on 2018/5/3.
//  Copyright © 2018年 123456. All rights reserved.
//

#import "XAxisValueFormatter.h"

@implementation XAxisValueFormatter

/// 实现协议方法，返回 x 轴的数据
- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
    
    // value 为 x 轴的值
    
    NSString *returnStr;
    
    switch ((NSInteger)value) {
        case 0:
            returnStr = @"香草味";
            break;
        case 1:
            returnStr = @"巧克力味";
            break;
        case 2:
            returnStr = @"慕斯味";
            break;
        case 3:
            returnStr = @"黑巧克力味";
            break;
        case 4:
            returnStr = @"草莓味";
            break;
            
            
        default:
            break;
    }
    
//    return [NSString stringWithFormat:@"%ld 月", (NSInteger)value + 1];
    
    return returnStr;
}

@end
