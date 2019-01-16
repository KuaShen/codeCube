//
//  CustomCell.m
//  CodeCube-Business
//
//  Created by apple on 2018/5/3.
//  Copyright © 2018年 lab. All rights reserved.
//

#import "CustomCell.h"
#import "CustomModel.h"

@implementation CustomCell

- (void)configure:(UITableViewCell *)cell
        customObj:(id)obj
        indexPath:(NSIndexPath *)indexPath
{
    CustomModel *myObj = (CustomModel *)obj ;
    CustomCell *mycell = (CustomCell *)cell ;
    mycell.headImgView.image = myObj.headImage ;
    mycell.nameLabel.text = myObj.name;
    mycell.dataLabel.text = myObj.data;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.backgroundColor = [UIColor whiteColor] ;
    
}

+ (CGFloat)getCellHeightWithCustomObj:(id)obj
                            indexPath:(NSIndexPath *)indexPath
{
    return ((CustomModel *)obj).height ;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
