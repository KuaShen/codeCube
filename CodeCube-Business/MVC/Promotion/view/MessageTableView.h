//
//  MessageTableView.h
//  Ma
//
//  Created by 天真 on 2018/5/3.
//  Copyright © 2018年 zyc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableView : UITableView

@property (strong,nonatomic)NSArray *data;

@property (copy,nonatomic)NSString *imageString;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style data:(NSArray *)data;

@end
