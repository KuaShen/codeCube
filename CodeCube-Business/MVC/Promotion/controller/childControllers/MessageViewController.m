//
//  MessageViewController.m
//  Ma
//
//  Created by 天真 on 2018/5/3.
//  Copyright © 2018年 zyc. All rights reserved.
//

#import "MessageViewController.h"
#import "SelectButton.h"
#import "NewMessageViewController.h"

@interface MessageViewController ()<selectButtonDelegate>

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    
    [rightButton setTitle:@"发送" forState:UIControlStateNormal];
    
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    [self loadUI];
    [self navigationBarItemSet];
}

- (void)navigationBarItemSet{

    /*
     *设置标题
     */
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    //    titleLabel.backgroundColor = [UIColor grayColor];
    //    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"消息推送";
    self.navigationItem.titleView = titleLabel;
}
- (void)loadUI
{
    SelectButton *selectButton = [[SelectButton alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 50) title:@[@"历史推送",@"新建推送"]];
    selectButton.delegate = self;
    [self.view addSubview:selectButton];
    
    self.tableView  = [[MessageTableView alloc]initWithFrame:CGRectMake(0, 120, self.view.bounds.size.width, self.view.bounds.size.height-120) style:UITableViewStylePlain data:@[@"1 (3)",@"1 (2)",@"1 (1)"]];
    [self.view addSubview:self.tableView];
    
    
}
- (void)sendString
{
    NewMessageViewController *vc = [[NewMessageViewController alloc]init];
    
    [self.navigationController pushViewController:vc
                                         animated:YES];
    
    
}


@end
