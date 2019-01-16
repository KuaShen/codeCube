//
//  OperateCell.m
//  CodeCube-Business
//
//  Created by apple on 2018/5/1.
//  Copyright © 2018年 lab. All rights reserved.
//

#import "OperateCell.h"
#import "OperateModel.h"

@implementation OperateCell


- (void)configure:(UITableViewCell *)cell
        customObj:(id)obj
        indexPath:(NSIndexPath *)indexPath
{
    OperateModel *myObj = (OperateModel *)obj ;
    OperateCell *mycell = (OperateCell *)cell ;
    mycell.dataLabel.text = myObj.dataString ;
    mycell.itemLabel.text = myObj.itemString;
    mycell.rightView.image = [UIImage imageNamed:myObj.imageName];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.backgroundColor = [UIColor whiteColor] ;
    
}

+ (CGFloat)getCellHeightWithCustomObj:(id)obj
                            indexPath:(NSIndexPath *)indexPath
{
    return ((OperateModel *)obj).height ;
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
