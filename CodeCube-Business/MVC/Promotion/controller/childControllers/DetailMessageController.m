//
//  DetailMessageController.m
//  Ma
//
//  Created by 天真 on 2018/5/3.
//  Copyright © 2018年 zyc. All rights reserved.
//

#import "DetailMessageController.h"

@interface DetailMessageController ()

@end

@implementation DetailMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
    [self navigationSet];
}

- (void)navigationSet{
    
    /*
     *设置标题
     */
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    //    titleLabel.backgroundColor = [UIColor grayColor];
    //    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"推送模板";
    self.navigationItem.titleView = titleLabel;
}

- (void)loadUI
{
    
    
    
    UIImageView *pic1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"a"]];
    pic1.frame = CGRectMake(0, 0, self.view.bounds.size.width, pic1.bounds.size.height);
    pic1.contentMode = UIViewContentModeScaleAspectFit;
    UIImageView *pic2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"b"]];
    pic2.frame = CGRectMake(0, pic1.bounds.size.height, self.view.bounds.size.width, pic1.bounds.size.width-50);
    pic2.contentMode = UIViewContentModeScaleAspectFit;
    UIImageView *pic3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"c"]];
    pic3.frame = CGRectMake(0, pic1.bounds.size.height+pic2.bounds.size.height, self.view.bounds.size.width, pic1.bounds.size.height);
    pic3.contentMode = UIViewContentModeScaleAspectFit;
    UIImageView *pic4 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"d"]];
    pic4.frame = CGRectMake(0, pic1.bounds.size.height+pic2.bounds.size.height+pic3.bounds.size.height, self.view.bounds.size.width, pic1.bounds.size.height);
    pic4.contentMode = UIViewContentModeScaleAspectFit;
    
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:mainView];
    mainView.contentSize = CGSizeMake(self.view.bounds.size.width, pic1.bounds.size.height+pic2.bounds.size.height+pic3.bounds.size.height+pic4.bounds.size.height);
    [mainView addSubview:pic1];
    [mainView addSubview:pic2];
    [mainView addSubview:pic3];
    [mainView addSubview:pic4];
}

@end
