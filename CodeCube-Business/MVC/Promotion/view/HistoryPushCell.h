//
//  HistoryPushCell.h
//  CodeCube-Business
//
//  Created by apple on 2018/5/4.
//  Copyright © 2018年 lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryPushCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *bigTitle;

@property (weak, nonatomic) IBOutlet UILabel *littleTittle;

@property (weak, nonatomic) IBOutlet UILabel *amount;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
