//
//  CustomerPreferenceController.m
//  CodeCube-Business
//
//  Created by apple on 2018/4/30.
//  Copyright © 2018年 lab. All rights reserved.
//

#import "CustomerPreferenceController.h"

#define viewHeight (ScreenH-NAV_HEIGHT-TAB_HEIGHT-20-44)/2-20

@interface CustomerPreferenceController ()

@property (strong, nonatomic) UIView *firstView;
@property (strong, nonatomic) UIView *secondView;

@end

@implementation CustomerPreferenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
    
}

- (void)setUI{
    
    [self.view addSubview:self.firstView];
    [self.view addSubview:self.secondView];
}



#pragma ----------------------------------  懒加载  ----------------------------------

- (UIView *)firstView{
    
    if(!_firstView){
        _firstView = [[UIView alloc]init];
        _firstView.frame = CGRectMake(0, 20+NAV_HEIGHT+10, ScreenW, viewHeight);
        _firstView.backgroundColor = [UIColor whiteColor];
    }
    return _firstView;
}

- (UIView *)secondView{
    
    if(!_secondView){
        _secondView = [[UIView alloc]init];
        _secondView.frame = CGRectMake(0, View_Y_HEIGHT(_firstView), ScreenW, viewHeight);
        _secondView.backgroundColor = [UIColor whiteColor];
    }
    return _secondView;
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
