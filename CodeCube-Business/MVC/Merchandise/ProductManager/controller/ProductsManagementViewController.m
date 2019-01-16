//
//  ProductsManagementViewController.m
//  码立方（商品管理）
//
//  Created by lxg on 2018/4/30.
//  Copyright © 2018年 浙江传媒学院603多媒体实验室. All rights reserved.
//

#import "ProductsManagementViewController.h"
#import "TopScrollBar.h"
#import "UIView+Frame.h"
#import "UpDownTableViewController.h"
#import "AddOnItemsTableViewController.h"
#import "OnSaleTableViewController.h"
#import "SDAutoLayout.h"
#import "Ctr1ViewController.h"
#import "Ctr2ViewController.h"
#import "Ctr3ViewController.h"
#import "AddProductViewController.h"

#define themeColor [UIColor colorWithRed:108/255.0 green:203/255.0 blue:252/255.0 alpha:1];




@interface ProductsManagementViewController ()



@end

@implementation ProductsManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self navigationBarItemSet];
    [self setupUI];
    
    // Do any additional setup after loading the view.
}
- (void)navigationBarItemSet{
    self.navigationController.navigationBar.barTintColor = COLOR_MAIN;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    /*
     *设置标题
     */
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    //    titleLabel.backgroundColor = [UIColor grayColor];
    //    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"商品管理";
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"加号"] style:UIBarButtonItemStylePlain target:self action:@selector(showRight)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)setupUI {
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    Ctr1ViewController *ctr1 =  [[Ctr1ViewController alloc]init];
   
    Ctr2ViewController *ctr2 =  [[Ctr2ViewController alloc]init];
    
    Ctr3ViewController *ctr3 =  [[Ctr3ViewController alloc]init];
    
    
    NSArray *arr = @[ctr1,ctr2,ctr3];
    [arr enumerateObjectsUsingBlock:^(UIViewController *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self addChildViewController:obj];
        
    }];
    
    NSArray *titleArr = @[@"上架下架",@"发起拼单",@"打折促销"];
    
    TopScrollBar *top = [TopScrollBar topViewWithTitleArr:titleArr];
    top.controller = arr;
    top.frame = self.view.bounds;
    top.y = 64;
    top.height = self.view.height - 64;
    top.underLineColor = themeColor;
    top.titleNormalColor = [UIColor lightGrayColor];
    top.titleSelectColor = [UIColor lightGrayColor];
    [self.view addSubview:top];
}

- (void)showRight{
    self.hidesBottomBarWhenPushed = YES;
    AddProductViewController *controller = [[AddProductViewController alloc]init];
    
    [self.navigationController pushViewController:controller animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
