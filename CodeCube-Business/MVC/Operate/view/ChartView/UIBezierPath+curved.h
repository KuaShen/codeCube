//
//  UIBezierPath+curved.h
//  shudaixiongTEA
//
//  Created by shen on 16/10/17.
//  Copyright © 2016年 shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (curved)

- (UIBezierPath*)smoothedPathWithGranularity:(NSInteger)granularity;

@end
