//
//  DataStaticCell.m
//  CodeCube-Business
//
//  Created by apple on 2018/5/1.
//  Copyright © 2018年 lab. All rights reserved.
//

#import "DataStaticCell.h"
#import "DataStaticCellModel.h"

@implementation DataStaticCell

- (void)configure:(UITableViewCell *)cell
        customObj:(id)obj
        indexPath:(NSIndexPath *)indexPath
{
    DataStaticCellModel *myObj = (DataStaticCellModel *)obj ;
    DataStaticCell *mycell = (DataStaticCell *)cell ;
    mycell.firstLabel.text = myObj.titleString ;
    mycell.secondLabel.text = myObj.data;

    cell.backgroundColor = [UIColor whiteColor] ;
    
}

+ (CGFloat)getCellHeightWithCustomObj:(id)obj
                            indexPath:(NSIndexPath *)indexPath
{
    return ((DataStaticCellModel *)obj).height ;
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
