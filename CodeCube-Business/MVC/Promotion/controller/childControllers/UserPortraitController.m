//
//  UserPortraitController.m
//  CodeCube-Business
//
//  Created by apple on 2018/4/30.
//  Copyright © 2018年 lab. All rights reserved.
//

#import "UserPortraitController.h"
#import "MyPie.h"

#define titleColor [UIColor grayColor]

@interface UserPortraitController ()<MyPieDelegate>

@property (strong, nonatomic) UILabel *firstLabel;
@property (strong, nonatomic) UILabel *secondlabel;

@property (strong, nonatomic) UIView *firstView;
@property (strong, nonatomic) UIView *secondView;
@property (strong, nonatomic) MyPie *pieView;

@end

@implementation UserPortraitController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
}

- (void)setUI{
    
    [self.view addSubview:self.firstLabel];
    [self.view addSubview:self.firstView];
    [self.view addSubview:self.secondlabel];
    [self.view addSubview:self.secondView];
    
    [_firstView addSubview:self.pieView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma ----------------------------------   代理   ----------------------------------
//! 饼状图的点击事件
-(void)touchTheShapeLayer:(WWShapeLayer *)layer{

    
}



#pragma ----------------------------------  懒加载  ----------------------------------

- (UILabel *)firstLabel{
    
    if(!_firstLabel){
        _firstLabel = [[UILabel alloc]init];
        _firstLabel.frame = CGRectMake(20, 20+NAV_HEIGHT, ScreenW-20, 20);
        _firstLabel.textColor = titleColor;
        _firstLabel.font = FONT(13);
        _firstLabel.text = @"近七日喜欢购买产品类型";
    }
    return _firstLabel;
}

- (UILabel *)secondlabel{
    
    if(!_secondlabel){
        _secondlabel = [[UILabel alloc]init];
        _secondlabel.frame = CGRectMake(20, View_Y_HEIGHT(_firstView), ScreenW-20, 20);
        _secondlabel.textColor = titleColor;
        _secondlabel.font = FONT(13);
        _secondlabel.text = @"近七日顾客消费能力（元）";
    }
    return _secondlabel;
}

- (UIView *)firstView{
    
    if(!_firstView){
        _firstView = [[UIView alloc]init];
        _firstView.frame = CGRectMake(0, View_Y_HEIGHT(_firstLabel), ScreenW, (ScreenH-Y_EQUAL(_firstLabel)-TAB_HEIGHT)/2-65);
        _firstView.backgroundColor = [UIColor whiteColor];
    }
    return _firstView;
}

- (UIView *)secondView{
    
    if(!_secondView){
        _secondView = [[UIView alloc]init];
        _secondView.frame = CGRectMake(0, View_Y_HEIGHT(_secondlabel), ScreenW, (ScreenH-Y_EQUAL(_firstLabel)-TAB_HEIGHT)/2-65);
        _secondView.backgroundColor = [UIColor whiteColor];
    }
    return _secondView;
}

- (MyPie *)pieView{
    
    if(!_pieView){
        _pieView = [[MyPie alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HEIGHT_EQUAL(_firstView))];
        _pieView.dataArray = @[@.1,@0.2,@0.3,@0.1,@0.1,@0.1,@0.1];
        [_pieView.textArray addObjectsFromArray:@[@"我",@"的",@"名",@"字",@"叫",@"哈",@"ha"]];
        _pieView.backgroundColor = [UIColor whiteColor];
        _pieView.delegate = self;
    }
    return _pieView;
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
