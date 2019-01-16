//
//  OnSaleCell.m
//  码立方（商品管理）
//
//  Created by lxg on 2018/5/1.
//  Copyright © 2018年 浙江传媒学院603多媒体实验室. All rights reserved.
//

#import "OnSaleCell.h"

@implementation OnSaleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    [self.flag setSelected:selected];
    // Configure the view for the selected state
}

- (void)setupCellWithIcon:(UIImage *)iconImage productName:(NSString *)productName detail:(NSString *)detail price:(NSString *)price stock:(NSString *)stock limitBuyingStr:(NSString *)limitBuyingStr andState:(NSString *)stateStr {
    [self.icon setImage:iconImage];
    [self.productNameLab setText:productName];
    [self.detailLab setText:detail];
    [self.stockLab setText:[NSString stringWithFormat:@"还剩%@件",stock]];
    [self.priceLab setText:[NSString stringWithFormat:@"¥%@",price]];
    
    if ([stateStr isEqualToString:@"0"]) {
        [self.stateBtn setImage:[UIImage imageNamed:@"pingdan"] forState:UIControlStateNormal];
    }
    
    [self.limitBuyingLab setText:limitBuyingStr];
}

@end
