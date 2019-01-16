//
//  InputDetailCell.m
//  CodeCube-Business
//
//  Created by apple on 2018/5/4.
//  Copyright © 2018年 lab. All rights reserved.
//

#import "InputDetailCell.h"
#import "InputModel.h"

@implementation InputDetailCell

- (void)configure:(UITableViewCell *)cell
        customObj:(id)obj
        indexPath:(NSIndexPath *)indexPath
{
    InputModel *myObj = (InputModel *)obj ;
    InputDetailCell *mycell = (InputDetailCell *)cell ;
    mycell.titleL.text = myObj.title ;
    mycell.messageCountL.text = myObj.messageCount;
    
    cell.backgroundColor = [UIColor whiteColor] ;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

+ (CGFloat)getCellHeightWithCustomObj:(id)obj
                            indexPath:(NSIndexPath *)indexPath
{
    return ((InputModel *)obj).height ;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    _messageCountL.layer.cornerRadius = 7;
    _messageCountL.layer.masksToBounds = YES;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
