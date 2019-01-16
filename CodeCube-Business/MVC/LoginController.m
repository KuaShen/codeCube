//
//  LoginController.m
//  CodeCube-Business
//
//  Created by apple on 2018/5/4.
//  Copyright © 2018年 lab. All rights reserved.
//

#import "LoginController.h"
#import "ResigterViewController.h"
#import "MBProgressHUD.h"
#import "AFN.h"

@interface LoginController ()<UITextFieldDelegate>

@property UIImageView *imageview;
@property UITextField *namefile;
@property UITextField *codefile;
@property UIButton *question;
@property UIButton *registor;
@property UIButton *login;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:self];
    
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)setUI{
    //图标设置
    self.imageview = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenW/4, ScreenH/4-ScreenW/4, ScreenW/2, ScreenW/2)];
    self.imageview.image = [UIImage imageNamed:@"logo.png"];
    //标题设置
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(X_EQUAL(_imageview),View_Y_HEIGHT(_imageview)-10,ScreenW/2,30)];
    title1.text = @"码立方";
    title1.font = FONT(20);
    title1.textColor = COLOR_MAIN;
    title1.textAlignment = NSTextAlignmentCenter;
    
    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(X_EQUAL(title1),View_Y_HEIGHT(title1)-10,ScreenW/2,20)];
    title2.text = @"（商家端）";
    title2.textColor = COLOR_MAIN;
    title2.textAlignment = NSTextAlignmentCenter;
    title2.font = [UIFont systemFontOfSize:10];
    
    //username设置
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(50, View_Y_HEIGHT(title2)+30, 80, 30)];
    name.text = @"用户名";
    name.textColor = COLOR_MAIN;
    name.font = [UIFont systemFontOfSize:17];
//    name.textAlignment = NSTextAlignmentRight;
    UIView *linea = [[UIView alloc]initWithFrame:CGRectMake(30, View_Y_HEIGHT(name)-10, self.view.bounds.size.width-60, .4)];
    linea.backgroundColor = COLOR_MAIN;
    self.namefile = [[UITextField alloc]initWithFrame:CGRectMake(View_X_WIDTH(name), Y_EQUAL(name), ScreenW-60-80, 30)];
    self.namefile.textColor = COLOR_MAIN;
    self.namefile.keyboardType = UIKeyboardTypeNumberPad;
    self.namefile.clearsOnBeginEditing = YES;
    self.namefile.delegate = self;
    _namefile.placeholder = @"请输入用户名或账号";
    _namefile.text = @"2932500100";
    // code设置
    UILabel *code = [[UILabel alloc]initWithFrame:CGRectMake(50, View_Y_HEIGHT(linea), 80, 30)];
    code.text = @"密码";
    code.textColor = COLOR_MAIN;
    code.font = [UIFont systemFontOfSize:17];
//    code.textAlignment = NSTextAlignmentRight;
    UIView *lineb = [[UIView alloc]initWithFrame:CGRectMake(30, View_Y_HEIGHT(code), self.view.bounds.size.width-60, .4)];
    lineb.backgroundColor = COLOR_MAIN;
    self.codefile = [[UITextField alloc]initWithFrame:CGRectMake(View_X_WIDTH(code), Y_EQUAL(code), ScreenW-60-80, 30)];
    self.codefile.textColor = COLOR_MAIN;
    self.codefile.clearsOnBeginEditing = YES;
    self.codefile.delegate = self;
    self.codefile.secureTextEntry = YES;
    self.codefile.delegate = self;
    _codefile.placeholder = @"请输入密码";
    _codefile.text = @"QW12895671";
    //密码找回
    self.question = [UIButton buttonWithType:UIButtonTypeCustom];
    self.question.frame = CGRectMake(X_EQUAL(code), View_Y_HEIGHT(lineb), 100, 20);
    [self.question setTitle:@"忘记密码？" forState:0];
    [self.question setTitleColor:COLOR_MAIN forState:0];
    self.question.titleLabel.font = [UIFont systemFontOfSize:13];
    [_question addTarget:self action:@selector(forgetAction) forControlEvents:UIControlEventTouchUpInside];
    //新用户注册
    self.registor = [[UIButton alloc]init];
    self.registor.frame = CGRectMake(ScreenW-30-100, Y_EQUAL(_question), 100, 20);
    [self.registor setTitle:@"新用户注册" forState:0];
    [self.registor setTitleColor:[UIColor whiteColor] forState:0];
    self.registor.titleLabel.font = [UIFont systemFontOfSize:15];
    [_registor addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    self.registor.layer.cornerRadius = 10;
    self.registor.layer.masksToBounds = YES;
    self.registor.backgroundColor = COLOR_MAIN;
    //登录按钮
    self.login = [UIButton buttonWithType:UIButtonTypeCustom];
    self.login.frame = CGRectMake(ScreenW/2-120, View_Y_HEIGHT(_registor)+40, 240, 35);
    [self.login setTitle:@"登录" forState:0];
    [self.login setTitleColor:[UIColor whiteColor] forState:0];
    self.login.layer.cornerRadius = 35/2;
    self.login.titleLabel.font = [UIFont systemFontOfSize:20];
    self.login.layer.masksToBounds = YES;
    self.login.backgroundColor = COLOR_MAIN;
    [_login addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_imageview];
    [self.view addSubview:title1];
    [self.view addSubview:title2];
    [self.view addSubview:name];
    [self.view addSubview:linea];
    [self.view addSubview:_namefile];
    [self.view addSubview:code];
    [self.view addSubview:lineb];
    [self.view addSubview:_codefile];
    [self.view addSubview:_question];
    [self.view addSubview:_login];
    [self.view addSubview:_registor];
}

- (void)loginAction{
    
    NSUserDefaults *deaf = [NSUserDefaults standardUserDefaults];
    [deaf setValue:@"YES" forKey:@"isLogin"];
    [deaf synchronize];
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在登陆...";
    HUD.removeFromSuperViewOnHide = YES;//ZHY
    
    NSDictionary *datadict= [[NSDictionary alloc]init];
    datadict = @{@"username":_namefile.text,@"password":_codefile.text};
    
//    [AFN setPostWithUrl:@"http://121.43.59.5:8081/code/login" parameters:datadict currentView:self.view getAFNdata:^(id responseObject, NSString *errorMsg) {
//        NSLog(@"错误信息====%@",errorMsg);
//
//        NSDictionary *dic = responseObject;
//        NSLog(@"返回信息====%@",dic);
//        NSString *message = [dic valueForKey:@"resultMessage"];
//        if ([[dic valueForKey:@"resultCode"] isEqual:@0]) {
//
//             [self dismissViewControllerAnimated:YES completion:nil];//ZHY
//
//        }else{
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"message:message preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
//            [alert addAction:defaultAction];
//            [self presentViewController:alert animated:YES completion:nil];
//        }
//            [HUD hide:YES];
//        }];
    
    
    if ([_namefile.text isEqualToString:@"2932500100"]&&[_codefile.text isEqualToString:@"QW12895671"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"message:@"请重新确认登录信息" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
        
        
        

   
}

- (void)registerAction{
    
    ResigterViewController *controller = [[ResigterViewController alloc]init];
    NSLog(@"nav==%@",self.navigationController);
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)forgetAction{
    
}




-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.namefile resignFirstResponder];
    [self.codefile resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return YES;
}


@end
