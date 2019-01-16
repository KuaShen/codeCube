//
//  HistoryPushModel.h
//  CodeCube-Business
//
//  Created by apple on 2018/5/4.
//  Copyright © 2018年 lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryPushModel : NSObject

@property(nonatomic,copy) NSString *bigTitle;

@property(nonatomic,copy) NSString *littleTittle;

@property(nonatomic,copy) NSString *amount;

@property(nonatomic,copy) UIImage *image;

@property (nonatomic) CGFloat height;

@end
