//
//  MainCollectionViewCell.h
//  UINavigationController
//
//  Created by 张舜豪 on 2018/4/30.
//  Copyright © 2018 张舜豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iCon;
@property (weak, nonatomic) IBOutlet UILabel *lable;
+ (UIImageView *)setImage:(UIImageView *)iCon;
@end
