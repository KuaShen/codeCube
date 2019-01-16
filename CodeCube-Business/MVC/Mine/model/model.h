//
//  model.h
//  UINavigationController
//
//  Created by 张舜豪 on 2018/4/30.
//  Copyright © 2018 张舜豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface model : NSObject
@property NSString *iConName;
@property NSString *sellerName;
@property NSInteger starNumber;
@property float moneyA;
@property float moneyB;
@property float moneyC;
-(model *)setData:(NSString *)iCon sellerName:(NSString *)seller starNumber:(NSInteger)number moneyA:(float)A moneyB:(float)B moneyC:(float)C;
@end
