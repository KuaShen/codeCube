//
//  model.m
//  UINavigationController
//
//  Created by 张舜豪 on 2018/4/30.
//  Copyright © 2018 张舜豪. All rights reserved.
//

#import "model.h"

@implementation model
-(model *)setData:(NSString *)iCon sellerName:(NSString *)seller starNumber:(NSInteger)number moneyA:(float)A moneyB:(float)B moneyC:(float)C{
    self.iConName=iCon;
    self.sellerName=seller;
    self.starNumber=number;
    self.moneyA=A;
    self.moneyB=B;
    self.moneyC=C;
    return self;
}
@end
