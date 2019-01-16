//
//  TabbarController.m
//  CodeCube-Business
//
//  Created by apple on 2018/4/30.
//  Copyright © 2018年 lab. All rights reserved.
//

#import "TabbarController.h"
#import "OperateController.h"
#import "PromotionController.h"
#import "MerchandiseController.h"
#import "MineController.h"
#import "ProductsManagementViewController.h"

@interface TabbarController ()

@end

@implementation TabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.backgroundImage = [self imageWithColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]];
    self.tabBar.shadowImage = [UIImage new];
    self.selectedIndex = 1;
    self.tabBar.tintColor = COLOR_TAB;
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
    [self addAllChildViewController];
    // Do any additional setup after loading the view.
}
- (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f,0.0f, 1.0f,1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

#pragma mark - Private Methods

// 添加全部的 childViewcontroller
- (void)addAllChildViewController
{
    OperateController *homeVC = [[OperateController alloc] init];
    //    homeVC.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:homeVC title:@"运营" imageNamed:@"运营_31"];

    PromotionController *activityVC = [[PromotionController alloc] init];
    //    activityVC.view.backgroundColor = [UIColor yellowColor];
    [self addChildViewController:activityVC title:@"推广" imageNamed:@"运营_39"];

    ProductsManagementViewController *findVC = [[ProductsManagementViewController alloc] init];
    //    findVC.view.backgroundColor = [UIColor blueColor];
    [self addChildViewController:findVC title:@"货物" imageNamed:@"运营_33"];

    MineController *mineVC = [[MineController alloc] init];
    //    mineVC.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:mineVC title:@"我的" imageNamed:@"运营_36"];
}

// 添加某个 childViewController
- (void)addChildViewController:(UIViewController *)vc title:(NSString *)title imageNamed:(NSString *)imageNamed
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    // 如果同时有navigationbar 和 tabbar的时候最好分别设置它们的title
    vc.navigationItem.title = title;
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imageNamed];
    
    [self addChildViewController:nav];
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
