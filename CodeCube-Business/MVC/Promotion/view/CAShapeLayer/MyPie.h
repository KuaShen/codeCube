//
//  MyPie.h
//  QiuDouMaDai
//
//  Created by 王威 on 2016/12/21.
//  Copyright © 2016年 王威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WWShapeLayer.h"
@protocol MyPieDelegate <NSObject>

-(void)touchTheShapeLayer:(WWShapeLayer *)layer;

@end
@interface MyPie : UIView
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)NSMutableArray *sliceLayerArray;
@property(nonatomic,strong)NSMutableArray *colorArray;
@property(nonatomic,strong)NSMutableArray *textArray;
@property(nonatomic,assign)id<MyPieDelegate>delegate;
@end
