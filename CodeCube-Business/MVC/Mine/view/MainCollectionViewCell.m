//
//  MainCollectionViewCell.m
//  UINavigationController
//
//  Created by 张舜豪 on 2018/4/30.
//  Copyright © 2018 张舜豪. All rights reserved.
//

#import "MainCollectionViewCell.h"

@implementation MainCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (UIImageView *)setImage:(UIImageView *)iCon{
    iCon.layer.cornerRadius=5;
    iCon.layer.masksToBounds=YES;
    return iCon;
}
@end
