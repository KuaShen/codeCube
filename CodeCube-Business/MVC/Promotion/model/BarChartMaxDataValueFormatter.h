//
//  BarChartMaxDataValueFormatter.h
//  MLF
//
//  Created by 123456 on 2018/5/4.
//  Copyright © 2018年 123456. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MLF-Bridging-Header.h"

@import Charts;

@interface BarChartMaxDataValueFormatter : NSObject <IChartValueFormatter>

- (instancetype)initWithYDataVals:(NSArray *)yVals;

@end
