//
//  ResigterViewController.m
//  Ma
//
//  Created by 天真 on 2018/5/4.
//  Copyright © 2018年 zyc. All rights reserved.
//

#import "ResigterViewController.h"
#import "AFN.h"

#define mainW (self.view.bounds.size.width)

#define mainH (self.view.bounds.size.height)

@interface ResigterViewController ()<UITextFieldDelegate>{
    UITextField *phone;
    UIButton *verifyButton;
    NSString *vertifyCode;
}

@end

@implementation ResigterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
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
    titleLabel.text = @"注册";
    self.navigationItem.titleView = titleLabel;
//    [self loadTitleView];
    [self loadUI];
}

- (void)viewWillAppear:(BOOL)animated{
    
}

- (void)loadTitleView
{
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainW, mainH*0.1)];
    titleView.backgroundColor = [UIColor colorWithRed:0.28 green:0.80 blue:1.00 alpha:1.00];
    [self.view addSubview:titleView];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 28, mainW, 20)];
    label.text = @"注册";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor whiteColor];
    [titleView addSubview:label];
}
- (void)loadUI
{
    
    
    NSArray *array = @[@"手机号",@"密码",@"确认密码",@"验证码",@"营业执照"];
    for (int i = 0; i < 5; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40, 110+60*i, mainW-80, 30)];
        label.text = array[i];
        label.font = [UIFont systemFontOfSize:16];
        [self.view addSubview:label];
    }
    for (int i = 0; i < 4; i++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(35, 140+60*i, mainW-70, 1.2)];
        line.backgroundColor =[UIColor grayColor];
        [self.view addSubview:line];
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(150, 110+60*i, 180, 30)];
        textField.delegate = self;
        textField.placeholder = [NSString stringWithFormat:@"请输入%@",array[i]];
        [self.view addSubview:textField];
        if (i == 0) {
            phone = textField;
        }
        if(i==3)
        {
            UIButton *button  =[[ UIButton alloc]initWithFrame:CGRectMake(textField.bounds.size.width-60, 10, 110, 15)];
            button.backgroundColor = COLOR_MAIN;
            [button setTitle:@"点击获取验证码" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(getVeriCode) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:11];
            button.layer.cornerRadius = 8;
            button.layer.masksToBounds = YES;
            [textField addSubview:button];
            verifyButton = button;
        }
    }
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(150, 380, 60, 60)];
    image.image = [UIImage imageNamed:@"cccc"];
    [self.view addSubview:image];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(32, mainH-150, mainW-64, 40)];
    button.layer.cornerRadius = 10;
    button.layer.masksToBounds = YES;
    button.backgroundColor = COLOR_MAIN;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"注    册" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(re) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)getVeriCode{
    
    if ([phone.text isEqualToString:@""]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入手机号" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defa = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:defa];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setValue:phone.text forKey:@"myphone"];
        
        [AFN setPostWithUrl:@"http://139.224.164.183:8012/returncode.aspx" parameters:dict currentView:self.view getAFNdata:^(id responseObject, NSString *errorMsg) {
            NSDictionary *dic = responseObject;
            vertifyCode = [dic valueForKey:@"data"];

            NSLog(@"%@",dic);

        }];
//        [AFN setPostWithUrl:@"http://121.43.59.5:8081/code/Verification_code" parameters:dict currentView:self.view getAFNdata:^(id responseObject, NSString *errorMsg) {
//            NSDictionary *dic = responseObject;
//            vertifyCode = [dic valueForKey:@"data"];
//            
//            NSLog(@"%@",dic);
//            
//        }];
        
        [self openCountdown];
    }
}
-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [verifyButton setTitle:@"重新发送" forState:UIControlStateNormal];
                [verifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                verifyButton.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [verifyButton setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [verifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                verifyButton.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

- (void)re
{
    NSLog(@"注册");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}


@end
