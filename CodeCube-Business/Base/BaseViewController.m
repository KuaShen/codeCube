//
//  BaseViewController.m
//  CodeCube-Business
//
//  Created by apple on 2018/4/30.
//  Copyright © 2018年 lab. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginController.h"
//#import "ResigterViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)toLogInView{
    
    LoginController *loginViewController = [[LoginController alloc] init];

    UINavigationController *navgationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    navgationController.navigationBar.hidden = YES;

    [self presentViewController:navgationController animated:YES completion:nil];
    
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
