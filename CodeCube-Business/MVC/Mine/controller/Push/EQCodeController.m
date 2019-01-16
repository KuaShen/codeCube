//
//  EQCodeController.m
//  CodeCube-Business
//
//  Created by apple on 2018/5/4.
//  Copyright © 2018年 lab. All rights reserved.
//

#import "EQCodeController.h"

@interface EQCodeController (){
    UIImageView *EQImage;
    
}

@property (strong, nonatomic) UIView *backView;

@property (strong, nonatomic) UIView *EQView;

@property (strong, nonatomic) UISegmentedControl *segmentCtrl;

@end

@implementation EQCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationBarSet];
    [self setUI];
    
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)setUI{
    
    self.view.backgroundColor = COLOR_BACKGROUND;
    
    [self.view addSubview:self.backView];
    [self.view addSubview:self.EQView];
    [self.view addSubview:self.segmentCtrl];
}

- (void)navigationBarSet{
    
    /*
     *设置标题
     */
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    //    titleLabel.backgroundColor = [UIColor grayColor];
    //    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.controllerTitle;
    self.navigationItem.titleView = titleLabel;
    
}

- (void)save{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"message:@"保存成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
    }];
   
    [alert addAction:defaultAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)share{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"message:@"分享成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
    }];
    
    [alert addAction:defaultAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

// 点击segmentCtrl 调用方法
- (void)segmentBtnClick{
    NSLog(@"点击");
    if (self.segmentCtrl.selectedSegmentIndex == 0) {
        EQImage.image = [UIImage imageNamed:@"微信.jpg"];
    }else{
        EQImage.image = [UIImage imageNamed:@"支付宝.jpg"];
    }
    
}


- (UIView *)backView{
    
    if(!_backView){
        _backView = [[UIView alloc]init];
        _backView.frame = CGRectMake(0, NAV_HEIGHT, ScreenW, 150);
        _backView.backgroundColor = COLOR_MAIN;
        
    }
    return _backView;
}

- (UIView *)EQView{
    
    if(!_EQView){
        _EQView = [[UIView alloc]init];
        _EQView.frame = CGRectMake(20, NAV_HEIGHT+30, ScreenW-40, ScreenW-40);
        _EQView.backgroundColor = [UIColor whiteColor];
        _EQView.layer.cornerRadius = 10;
        _EQView.layer.masksToBounds = YES;
        _EQView.backgroundColor = [UIColor whiteColor];
        
        EQImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
        EQImage.center = CGPointMake(_EQView.center.x-20, (ScreenW-40)/2);
        EQImage.image = [UIImage imageNamed:@"微信.jpg"];
        
        UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(0, ScreenW-40-50, (ScreenW-40)/2, 50)];
        [save addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        [save setTitle:@"保存图片" forState:UIControlStateNormal];
        [save setTitleColor:COLOR_MAIN forState:UIControlStateNormal];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake((ScreenW-40)/2-0.5, ScreenW-40-50+10, 1, 30)];
        lineView.backgroundColor = COLOR_MAIN;
        UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenW-40-50, ScreenW-40, .1)];
        lineV.backgroundColor = COLOR_BACKGROUND;
        
        UIButton *share = [[UIButton alloc]initWithFrame:CGRectMake((ScreenW-40)/2, ScreenW-40-50, (ScreenW-40)/2, 50)];
        [share addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
        [share setTitle:@"分享链接" forState:UIControlStateNormal];
        [share setTitleColor:COLOR_MAIN forState:UIControlStateNormal];
        
        [_EQView addSubview:EQImage];
        [_EQView addSubview:save];
        [_EQView addSubview:lineView];
        [_EQView addSubview:lineV];
        [_EQView addSubview:share];
        
    }
    return _EQView;
}

- (UISegmentedControl *)segmentCtrl{
    
    if(!_segmentCtrl){
        _segmentCtrl = [[UISegmentedControl alloc]initWithItems:@[@"微信",@"支付宝"]];
        _segmentCtrl.frame = CGRectMake(ScreenW/2-100, View_Y_HEIGHT(_EQView)+40, 200, 30);
        _segmentCtrl.selectedSegmentIndex = 0;
        _segmentCtrl.layer.cornerRadius = 14;
        _segmentCtrl.layer.masksToBounds = YES;
        _segmentCtrl.layer.borderWidth = 0;
        // 设置test空间的颜色为透明
        _segmentCtrl.tintColor = COLOR_MAIN;
        // 定义未选中状态下的样式normal,类型为字典
        NSDictionary *normal = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:COLOR_MAIN};
        // 定位选中状态下的样式selected，类型为字典
        NSDictionary *selected = @{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]};
        // 通过setTitleTextAttributes: forState: 方法来给test控件设置文字内容的格式
        [_segmentCtrl setTitleTextAttributes:normal forState:UIControlStateNormal];
        [_segmentCtrl setTitleTextAttributes:selected forState:UIControlStateSelected];
        [_segmentCtrl addTarget:self action:@selector(segmentBtnClick) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentCtrl;
}


@end
