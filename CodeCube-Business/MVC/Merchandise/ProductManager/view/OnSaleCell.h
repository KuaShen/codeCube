//
//  OnSaleCell.h
//  码立方（商品管理）
//
//  Created by lxg on 2018/5/1.
//  Copyright © 2018年 浙江传媒学院603多媒体实验室. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnSaleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *flag;

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *productNameLab;

@property (weak, nonatomic) IBOutlet UILabel *detailLab;

@property (weak, nonatomic) IBOutlet UILabel *priceLab;

@property (weak, nonatomic) IBOutlet UILabel *stockLab;

@property (weak, nonatomic) IBOutlet UIButton *stateBtn;

@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (weak, nonatomic) IBOutlet UILabel *limitBuyingLab;



//给cell设置内容
- (void)setupCellWithIcon:(UIImage *)iconImage productName:(NSString *)productName detail:(NSString *)detail price:(NSString *)price stock:(NSString *)stock limitBuyingStr:(NSString *)limitBuyingStr andState:(NSString *)stateStr;
@end
