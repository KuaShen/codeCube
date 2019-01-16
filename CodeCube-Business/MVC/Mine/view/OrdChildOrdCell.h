//
//  OrdChildOrdCell.h
//  CodeCube-Business
//
//  Created by apple on 2018/5/4.
//  Copyright © 2018年 lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrdChildOrdCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *commodityLabel;

@property (weak, nonatomic) IBOutlet UILabel *perdetermindTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *storeTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;

@property (weak, nonatomic) IBOutlet UIButton *callButton;

@property (weak, nonatomic) IBOutlet UILabel *cashAmount;

@property (weak, nonatomic) IBOutlet UIButton *confirmButton;


@end
