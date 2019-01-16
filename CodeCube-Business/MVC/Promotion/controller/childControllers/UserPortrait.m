//
//  UserPortrait.m
//  MLF
//
//  Created by 123456 on 2018/5/3.
//  Copyright © 2018年 123456. All rights reserved.
//

#import "UserPortrait.h"
#import "MLF-Bridging-Header.h"

// 数据格式头文件
//#import "BarChartXAxisValueFormatter.h"
//#import "BarCharDataValueFormatter.h"
//#import "BarChartMaxDataValueFormatter.h"


@interface UserPortrait () <ChartViewDelegate>

@property (nonatomic, weak) BarChartView *barChartView;

@end

@implementation UserPortrait


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

- (void)initUI {

//    self.view.backgroundColor = [self colorWithHexString:@"#efefef"];
    //这部分属于最上面的控件搭建
#pragma mark 第一个
    UILabel *visitorLabel = [[UILabel alloc] init];
    visitorLabel.text = @"访客";
    visitorLabel.textColor = [UIColor grayColor];
    visitorLabel.textAlignment = NSTextAlignmentCenter;
    visitorLabel.font = [UIFont systemFontOfSize:13];
    CGFloat visitorLabelW = [self adjustWidthToFitStrFontSize:13 andString:visitorLabel.text].width;
    CGFloat visitorLabelH = [self adjustWidthToFitStrFontSize:13 andString:visitorLabel.text].height;
    visitorLabel.frame = CGRectMake(ScreenW / 13, NAV_HEIGHT+20, visitorLabelW, visitorLabelH);
    [self.view addSubview:visitorLabel];
    UIImageView *userIcon1 = [[UIImageView alloc] init];
    userIcon1.image = [UIImage imageNamed:@"user_icon"];
    userIcon1.frame = CGRectMake(CGRectGetMaxX(visitorLabel.frame), Y_EQUAL(visitorLabel), ScreenW * 17 / 370, ScreenW * 17 / 370);
    [self.view addSubview:userIcon1];
    UILabel *numLabel1 = [[UILabel alloc] init];
    numLabel1.text = @"3,608";
    numLabel1.textColor = [UIColor grayColor];
    numLabel1.textAlignment = NSTextAlignmentCenter;
    numLabel1.font = [UIFont systemFontOfSize:11];
    CGFloat numLabel1H = [self adjustWidthToFitStrFontSize:11 andString:numLabel1.text].height;
    numLabel1.frame = CGRectMake(visitorLabel.frame.origin.x, CGRectGetMaxY(visitorLabel.frame) + 2, visitorLabelW + ScreenW * 17 / 370, numLabel1H);
    [self.view addSubview:numLabel1];

#pragma mark 第二个
    
    UILabel *turnoverLabel = [[UILabel alloc] init];
    turnoverLabel.text = @"成交用户";
    turnoverLabel.textColor = [UIColor grayColor];
    turnoverLabel.textAlignment = NSTextAlignmentCenter;
    turnoverLabel.font = [UIFont systemFontOfSize:13];
    CGFloat turnoverLabelW = [self adjustWidthToFitStrFontSize:13 andString:turnoverLabel.text].width;
    CGFloat turnoverLabelH = [self adjustWidthToFitStrFontSize:13 andString:turnoverLabel.text].height;
    turnoverLabel.frame = CGRectMake((ScreenW - turnoverLabelW - ScreenW * 17 / 370) / 2, Y_EQUAL(visitorLabel), turnoverLabelW, turnoverLabelH);
    [self.view addSubview:turnoverLabel];
    UIImageView *userIcon2 = [[UIImageView alloc] init];
    userIcon2.image = [UIImage imageNamed:@"user_icon"];
    userIcon2.frame = CGRectMake(CGRectGetMaxX(turnoverLabel.frame), Y_EQUAL(visitorLabel), ScreenW * 17 / 370, ScreenW * 17 / 370);
    [self.view addSubview:userIcon2];
    UILabel *numLabel2 = [[UILabel alloc] init];
    numLabel2.text = @"67";
    numLabel2.textColor = [UIColor grayColor];
    numLabel2.textAlignment = NSTextAlignmentCenter;
    numLabel2.font = [UIFont systemFontOfSize:11];
    CGFloat numLabel2H = [self adjustWidthToFitStrFontSize:11 andString:numLabel2.text].height;
    numLabel2.frame = CGRectMake(turnoverLabel.frame.origin.x, CGRectGetMaxY(turnoverLabel.frame) + 2, turnoverLabelW + ScreenW * 17 / 370, numLabel2H);
    [self.view addSubview:numLabel2];
#pragma mark 第三个
    UILabel *unTurnoverLabel = [[UILabel alloc] init];
    unTurnoverLabel.text = @"未成交用户";
    unTurnoverLabel.textColor = [UIColor grayColor];
    unTurnoverLabel.textAlignment = NSTextAlignmentCenter;
    unTurnoverLabel.font = [UIFont systemFontOfSize:13];
    CGFloat unTurnLabelW = [self adjustWidthToFitStrFontSize:13 andString:unTurnoverLabel.text].width;
    CGFloat unTurnLabelH = [self adjustWidthToFitStrFontSize:13 andString:unTurnoverLabel.text].height;
    unTurnoverLabel.frame = CGRectMake((ScreenW * 12 / 13 - unTurnLabelW - ScreenW * 17 / 370), Y_EQUAL(visitorLabel), unTurnLabelW, unTurnLabelH);
    [self.view addSubview:unTurnoverLabel];
    UIImageView *userIcon3 = [[UIImageView alloc] init];
    userIcon3.image = [UIImage imageNamed:@"user_icon"];
    userIcon3.frame = CGRectMake(CGRectGetMaxX(unTurnoverLabel.frame), Y_EQUAL(visitorLabel), ScreenW * 17 / 370, ScreenW * 17 / 370);
    [self.view addSubview:userIcon3];
    UILabel *numLabel3 = [[UILabel alloc] init];
    numLabel3.text = @"3,541";
    numLabel3.textColor = [UIColor grayColor];
    numLabel3.textAlignment = NSTextAlignmentCenter;
    numLabel3.font = [UIFont systemFontOfSize:11];
    CGFloat numLabel3H = [self adjustWidthToFitStrFontSize:11 andString:numLabel3.text].height;
    numLabel3.frame = CGRectMake(unTurnoverLabel.frame.origin.x, CGRectGetMaxY(unTurnoverLabel.frame) + 2, unTurnLabelW + ScreenW * 17 / 370, numLabel3H);
    [self.view addSubview:numLabel3];
    
    // 上面的控件并没有什么卵用
    
    UIView *sexBackView = [[UIView alloc] init];
    sexBackView.backgroundColor = [UIColor whiteColor];
    sexBackView.frame = CGRectMake(0, CGRectGetMaxY(numLabel3.frame)+20, ScreenW, ScreenH * 100 / 660);
    [self.view addSubview:sexBackView];
    UIImageView *sexImageView = [[UIImageView alloc] init];
    sexImageView.frame = CGRectMake(ScreenW * 3 / 27, (sexBackView.frame.size.height - (ScreenW / 9) * 33 / 22) / 2, ScreenW / 9, (ScreenW / 9) * 33 / 22);
    sexImageView.image = [UIImage imageNamed:@"sex"];
    [sexBackView addSubview:sexImageView];
    
    UILabel *womanLabel = [[UILabel alloc] init];
    womanLabel.text = @"女";
    womanLabel.textAlignment = NSTextAlignmentCenter;
    womanLabel.textColor = [UIColor grayColor];
    womanLabel.font = [UIFont systemFontOfSize:13];
    CGFloat womanLabelW = [self adjustWidthToFitStrFontSize:13 andString:womanLabel.text].width;
    CGFloat womanLabelH = [self adjustWidthToFitStrFontSize:13 andString:womanLabel.text].height;
    womanLabel.frame = CGRectMake(ScreenW / 3, ScreenH * 25 / 660, womanLabelW, womanLabelH);
    [sexBackView addSubview:womanLabel];
    
    CGFloat womanNum = 65.0f;
    UIImageView *womanImage = [[UIImageView alloc] init];
    womanImage.layer.cornerRadius = 2.0f;
    womanImage.layer.masksToBounds = YES;
    womanImage.image = [UIImage imageNamed:@"womanPercentage"];
    womanImage.frame = CGRectMake(ScreenW * 20 / 36, womanLabel.frame.origin.y, (ScreenW * 100 / 360) * (womanNum / 100), womanLabelH);
    [sexBackView addSubview:womanImage];
    UILabel *womanNumLabel = [[UILabel alloc] init];
    womanNumLabel.text = [NSString stringWithFormat:@"%.0f%%",womanNum];
    womanNumLabel.textAlignment = NSTextAlignmentCenter;
    womanNumLabel.textColor = [UIColor grayColor];
    womanNumLabel.font = [UIFont systemFontOfSize:13];
    CGFloat womanNumLabelW = [self adjustWidthToFitStrFontSize:13 andString:womanNumLabel.text].width;
    CGFloat womanNumLabelH = [self adjustWidthToFitStrFontSize:13 andString:womanNumLabel.text].height;
    womanNumLabel.frame = CGRectMake(ScreenW * 310 / 360, womanImage.frame.origin.y, womanNumLabelW, womanNumLabelH);
    [sexBackView addSubview:womanNumLabel];
    
    UILabel *manLabel = [[UILabel alloc] init];
    manLabel.text = @"男";
    manLabel.textAlignment = NSTextAlignmentCenter;
    manLabel.textColor = [UIColor grayColor];
    manLabel.font = [UIFont systemFontOfSize:13];
    CGFloat manLabelW = [self adjustWidthToFitStrFontSize:13 andString:manLabel.text].width;
    CGFloat manLabelH = [self adjustWidthToFitStrFontSize:13 andString:manLabel.text].height;
    manLabel.frame = CGRectMake(ScreenW / 3, ScreenH * 60 / 660, manLabelW, manLabelH);
    [sexBackView addSubview:manLabel];
    
    CGFloat manNum = 25.0f;
    UIImageView *manImage = [[UIImageView alloc] init];
    manImage.layer.cornerRadius = 2.0f;
    manImage.layer.masksToBounds = YES;
    manImage.image = [UIImage imageNamed:@"manPercentage"];
    manImage.frame = CGRectMake(ScreenW * 20 / 36, manLabel.frame.origin.y, (ScreenW * 100 / 360) * (manNum / 100), manLabelH);
    [sexBackView addSubview:manImage];
    UILabel *manNumLabel = [[UILabel alloc] init];
    manNumLabel.text = [NSString stringWithFormat:@"%.0f%%",manNum];
    manNumLabel.textAlignment = NSTextAlignmentCenter;
    manNumLabel.textColor = [UIColor grayColor];
    manNumLabel.font = [UIFont systemFontOfSize:13];
    CGFloat manNumLabelW = [self adjustWidthToFitStrFontSize:13 andString:manNumLabel.text].width;
    CGFloat manNumLabelH = [self adjustWidthToFitStrFontSize:13 andString:manNumLabel.text].height;
    manNumLabel.frame = CGRectMake(ScreenW * 310 / 360, manImage.frame.origin.y, manNumLabelW, manNumLabelH);
    [sexBackView addSubview:manNumLabel];
    
    ////////////////////////////////////////////////////////////////////////
    UIView *levelBackView = [[UIView alloc] init];
    levelBackView.backgroundColor = [UIColor whiteColor];
    levelBackView.frame = CGRectMake(0, CGRectGetMaxY(sexBackView.frame) + 3, ScreenW, ScreenH * 150 / 660);
    [self.view addSubview:levelBackView];
    UIImageView *levelImageView = [[UIImageView alloc] init];
    levelImageView.frame = CGRectMake(ScreenW * 3 / 27, (levelBackView.frame.size.height - (ScreenW * 5 / 36) * 99 / 78) / 2, ScreenW * 5 / 36, (ScreenW * 5 / 36) * 99 / 78);
    levelImageView.image = [UIImage imageNamed:@"capability_level"];
    [levelBackView addSubview:levelImageView];
    
    UILabel *Label1 = [[UILabel alloc] init];
    Label1.text = @"0-50";
    Label1.textAlignment = NSTextAlignmentCenter;
    Label1.textColor = [UIColor grayColor];
    Label1.font = [UIFont systemFontOfSize:13];
    CGFloat Label1W = [self adjustWidthToFitStrFontSize:13 andString:Label1.text].width;
    CGFloat Label1H = [self adjustWidthToFitStrFontSize:13 andString:Label1.text].height;
    Label1.frame = CGRectMake(ScreenW / 3, (levelBackView.frame.size.height - Label1H * 5) / 6, Label1W, Label1H);
    [levelBackView addSubview:Label1];
    
    CGFloat Label1Num = 65.0f;
    UIImageView *Label1Image = [[UIImageView alloc] init];
    Label1Image.layer.cornerRadius = 2.0f;
    Label1Image.layer.masksToBounds = YES;
    Label1Image.image = [UIImage imageNamed:@"0-50"];
    Label1Image.frame = CGRectMake(ScreenW * 20 / 36, Label1.frame.origin.y, (ScreenW * 100 / 360) * (Label1Num / 100), Label1H);
    [levelBackView addSubview:Label1Image];
    UILabel *Label1NumLabel = [[UILabel alloc] init];
    Label1NumLabel.text = [NSString stringWithFormat:@"%.0f%%",Label1Num];
    Label1NumLabel.textAlignment = NSTextAlignmentCenter;
    Label1NumLabel.textColor = [UIColor grayColor];
    Label1NumLabel.font = [UIFont systemFontOfSize:13];
    CGFloat Label1NumLabelW = [self adjustWidthToFitStrFontSize:13 andString:Label1NumLabel.text].width;
    CGFloat Label1NumLabelH = [self adjustWidthToFitStrFontSize:13 andString:Label1NumLabel.text].height;
    Label1NumLabel.frame = CGRectMake(ScreenW * 310 / 360, Label1Image.frame.origin.y, Label1NumLabelW, Label1NumLabelH);
    [levelBackView addSubview:Label1NumLabel];
    
    UILabel *Label2 = [[UILabel alloc] init];
    Label2.text = @"50-95";
    Label2.textAlignment = NSTextAlignmentCenter;
    Label2.textColor = [UIColor grayColor];
    Label2.font = [UIFont systemFontOfSize:13];
    CGFloat Label2W = [self adjustWidthToFitStrFontSize:13 andString:Label2.text].width;
    CGFloat Label2H = [self adjustWidthToFitStrFontSize:13 andString:Label2.text].height;
    Label2.frame = CGRectMake(ScreenW / 3, CGRectGetMaxY(Label1.frame) + (levelBackView.frame.size.height - Label1H * 5) / 6, Label2W, Label2H);
    [levelBackView addSubview:Label2];
    
    CGFloat Label2Num = 18.0f;
    UIImageView *Label2Image = [[UIImageView alloc] init];
    Label2Image.layer.cornerRadius = 2.0f;
    Label2Image.layer.masksToBounds = YES;
    Label2Image.image = [UIImage imageNamed:@"50-95"];
    Label2Image.frame = CGRectMake(ScreenW * 20 / 36, Label2.frame.origin.y, (ScreenW * 100 / 360) * (Label2Num / 100), Label2H);
    [levelBackView addSubview:Label2Image];
    UILabel *Label2NumLabel = [[UILabel alloc] init];
    Label2NumLabel.text = [NSString stringWithFormat:@"%.0f%%",Label2Num];
    Label2NumLabel.textAlignment = NSTextAlignmentCenter;
    Label2NumLabel.textColor = [UIColor grayColor];
    Label2NumLabel.font = [UIFont systemFontOfSize:13];
    CGFloat Label2NumLabelW = [self adjustWidthToFitStrFontSize:13 andString:Label2NumLabel.text].width;
    CGFloat Label2NumLabelH = [self adjustWidthToFitStrFontSize:13 andString:Label2NumLabel.text].height;
    Label2NumLabel.frame = CGRectMake(ScreenW * 310 / 360, Label2Image.frame.origin.y, Label2NumLabelW, Label2NumLabelH);
    [levelBackView addSubview:Label2NumLabel];
    
    UILabel *Label3 = [[UILabel alloc] init];
    Label3.text = @"95-225";
    Label3.textAlignment = NSTextAlignmentCenter;
    Label3.textColor = [UIColor grayColor];
    Label3.font = [UIFont systemFontOfSize:13];
    CGFloat Label3W = [self adjustWidthToFitStrFontSize:13 andString:Label3.text].width;
    CGFloat Label3H = [self adjustWidthToFitStrFontSize:13 andString:Label3.text].height;
    Label3.frame = CGRectMake(ScreenW / 3, CGRectGetMaxY(Label2.frame) + (levelBackView.frame.size.height - Label1H * 5) / 6, Label3W, Label3H);
    [levelBackView addSubview:Label3];
    
    CGFloat Label3Num = 4.0f;
    UIImageView *Label3Image = [[UIImageView alloc] init];
    Label3Image.layer.cornerRadius = 2.0f;
    Label3Image.layer.masksToBounds = YES;
    Label3Image.image = [UIImage imageNamed:@"95-225"];
    Label3Image.frame = CGRectMake(ScreenW * 20 / 36, Label3.frame.origin.y, (ScreenW * 100 / 360) * (Label3Num / 100), Label3H);
    [levelBackView addSubview:Label3Image];
    UILabel *Label3NumLabel = [[UILabel alloc] init];
    Label3NumLabel.text = [NSString stringWithFormat:@"%.0f%%",Label3Num];
    Label3NumLabel.textAlignment = NSTextAlignmentCenter;
    Label3NumLabel.textColor = [UIColor grayColor];
    Label3NumLabel.font = [UIFont systemFontOfSize:13];
    CGFloat Label3NumLabelW = [self adjustWidthToFitStrFontSize:13 andString:Label3NumLabel.text].width;
    CGFloat Label3NumLabelH = [self adjustWidthToFitStrFontSize:13 andString:Label3NumLabel.text].height;
    Label3NumLabel.frame = CGRectMake(ScreenW * 310 / 360, Label3Image.frame.origin.y, Label3NumLabelW, Label3NumLabelH);
    [levelBackView addSubview:Label3NumLabel];
    
    UILabel *Label4 = [[UILabel alloc] init];
    Label4.text = @"225-525";
    Label4.textAlignment = NSTextAlignmentCenter;
    Label4.textColor = [UIColor grayColor];
    Label4.font = [UIFont systemFontOfSize:13];
    CGFloat Label4W = [self adjustWidthToFitStrFontSize:13 andString:Label4.text].width;
    CGFloat Label4H = [self adjustWidthToFitStrFontSize:13 andString:Label4.text].height;
    Label4.frame = CGRectMake(ScreenW / 3, CGRectGetMaxY(Label3.frame) + (levelBackView.frame.size.height - Label1H * 5) / 6, Label4W, Label4H);
    [levelBackView addSubview:Label4];
    
    CGFloat Label4Num = 2.0f;
    UIImageView *Label4Image = [[UIImageView alloc] init];
    Label4Image.layer.cornerRadius = 2.0f;
    Label4Image.layer.masksToBounds = YES;
    Label4Image.image = [UIImage imageNamed:@"225-525"];
    Label4Image.frame = CGRectMake(ScreenW * 20 / 36, Label4.frame.origin.y, (ScreenW * 100 / 360) * (Label4Num / 100), Label4H);
    [levelBackView addSubview:Label4Image];
    UILabel *Label4NumLabel = [[UILabel alloc] init];
    Label4NumLabel.text = [NSString stringWithFormat:@"%.0f%%",Label4Num];
    Label4NumLabel.textAlignment = NSTextAlignmentCenter;
    Label4NumLabel.textColor = [UIColor grayColor];
    Label4NumLabel.font = [UIFont systemFontOfSize:13];
    CGFloat Label4NumLabelW = [self adjustWidthToFitStrFontSize:13 andString:Label4NumLabel.text].width;
    CGFloat Label4NumLabelH = [self adjustWidthToFitStrFontSize:13 andString:Label4NumLabel.text].height;
    Label4NumLabel.frame = CGRectMake(ScreenW * 310 / 360, Label4Image.frame.origin.y, Label4NumLabelW, Label4NumLabelH);
    [levelBackView addSubview:Label4NumLabel];
    
    UILabel *Label5 = [[UILabel alloc] init];
    Label5.text = @"525以上";
    Label5.textAlignment = NSTextAlignmentCenter;
    Label5.textColor = [UIColor grayColor];
    Label5.font = [UIFont systemFontOfSize:13];
    CGFloat Label5W = [self adjustWidthToFitStrFontSize:13 andString:Label5.text].width;
    CGFloat Label5H = [self adjustWidthToFitStrFontSize:13 andString:Label5.text].height;
    Label5.frame = CGRectMake(ScreenW / 3, CGRectGetMaxY(Label4.frame) + (levelBackView.frame.size.height - Label1H * 5) / 6, Label5W, Label5H);
    [levelBackView addSubview:Label5];
    
    CGFloat Label5Num = 1.0f;
    UIImageView *Label5Image = [[UIImageView alloc] init];
    Label5Image.layer.cornerRadius = 2.0f;
    Label5Image.layer.masksToBounds = YES;
    Label5Image.image = [UIImage imageNamed:@"525"];
    Label5Image.frame = CGRectMake(ScreenW * 20 / 36, Label5.frame.origin.y, (ScreenW * 100 / 360) * (Label5Num / 100), Label5H);
    [levelBackView addSubview:Label5Image];
    UILabel *Label5NumLabel = [[UILabel alloc] init];
    Label5NumLabel.text = [NSString stringWithFormat:@"%.0f%%",Label5Num];
    Label5NumLabel.textAlignment = NSTextAlignmentCenter;
    Label5NumLabel.textColor = [UIColor grayColor];
    Label5NumLabel.font = [UIFont systemFontOfSize:13];
    CGFloat Label5NumLabelW = [self adjustWidthToFitStrFontSize:13 andString:Label5NumLabel.text].width;
    CGFloat Label5NumLabelH = [self adjustWidthToFitStrFontSize:13 andString:Label5NumLabel.text].height;
    Label5NumLabel.frame = CGRectMake(ScreenW * 310 / 360, Label5Image.frame.origin.y, Label5NumLabelW, Label5NumLabelH);
    [levelBackView addSubview:Label5NumLabel];
    
    ///////////////////////////////////////////////////////////////////////
    UIView *preferencesBackView = [[UIView alloc] init];
    preferencesBackView.backgroundColor = [UIColor whiteColor];
    preferencesBackView.frame = CGRectMake(0, CGRectGetMaxY(levelBackView.frame) + 3, ScreenW, ScreenH * 190 / 660);
    [self.view addSubview:preferencesBackView];
    UIImageView *preferencesImageView = [[UIImageView alloc] init];
    preferencesImageView.frame = CGRectMake(ScreenW * 3 / 27, (preferencesBackView.frame.size.height - (ScreenW / 9) * 5 / 3) / 2, ScreenW / 9, (ScreenW / 9) * 5 / 3);
    preferencesImageView.image = [UIImage imageNamed:@"preferences"];
    [preferencesBackView addSubview:preferencesImageView];
    
    UILabel *label100 = [[UILabel alloc] init];
    label100.text = @"总计100%";
    label100.textAlignment = NSTextAlignmentCenter;
    label100.textColor = [UIColor grayColor];
    label100.font = [UIFont systemFontOfSize:11];
    CGFloat label100W = [self adjustWidthToFitStrFontSize:11 andString:label100.text].width;
    CGFloat label100H = [self adjustWidthToFitStrFontSize:11 andString:label100.text].height;
    label100.frame = CGRectMake(ScreenW * 75 / 270, preferencesBackView.frame.size.height * 25 / 190, label100W, label100H);
    [preferencesBackView addSubview:label100];
    
    // 手动柱状图
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.frame = CGRectMake(ScreenW * 110 / 370, preferencesBackView.frame.size.height * 130 / 185, ScreenW * 220 / 370, 1);
    [preferencesBackView addSubview:lineView];
    
    CGFloat image1Num = 30.0f;
    UIImageView *imageView1 = [[UIImageView alloc] init];
    imageView1.image = [UIImage imageNamed:@"100"];
    imageView1.layer.cornerRadius = 2.0f;
    imageView1.layer.masksToBounds = YES;
    imageView1.frame = CGRectMake((lineView.frame.size.width - 20 * 5) / 10 + lineView.frame.origin.x, CGRectGetMinY(lineView.frame) - (preferencesBackView.frame.size.height * 100 / 180) * (image1Num / 100) + 1, 20, (preferencesBackView.frame.size.height * 100 / 180) * (image1Num / 100));
    [preferencesBackView addSubview:imageView1];
    UILabel *image1Label = [[UILabel alloc] init];
    image1Label.text = [NSString stringWithFormat:@"%.0f%%",image1Num];
    image1Label.textAlignment = NSTextAlignmentCenter;
    image1Label.textColor = [UIColor grayColor];
    image1Label.font = [UIFont systemFontOfSize:11];
    CGFloat image1LabelW = [self adjustWidthToFitStrFontSize:11 andString:image1Label.text].width;
    CGFloat image1LabelH = [self adjustWidthToFitStrFontSize:11 andString:image1Label.text].height;
    image1Label.frame = CGRectMake(CGRectGetMidX(imageView1.frame) - image1LabelW/2, CGRectGetMinY(imageView1.frame) - 5 - image1LabelH, image1LabelW, image1LabelH);
    [preferencesBackView addSubview:image1Label];
    UILabel *nameLabel1 = [[UILabel alloc] init];
    nameLabel1.text = @"零食";
    nameLabel1.textAlignment = NSTextAlignmentCenter;
    nameLabel1.textColor = [UIColor grayColor];
    nameLabel1.font = [UIFont systemFontOfSize:11];
    CGFloat nameLabel1W = [self adjustWidthToFitStrFontSize:11 andString:nameLabel1.text].width;
    CGFloat nameLabel1H = [self adjustWidthToFitStrFontSize:11 andString:nameLabel1.text].height;
    nameLabel1.frame = CGRectMake(CGRectGetMidX(imageView1.frame) - nameLabel1W/2, CGRectGetMaxY(imageView1.frame) + 5, nameLabel1W, nameLabel1H);
    [preferencesBackView addSubview:nameLabel1];
    
    CGFloat image2Num = 10.0f;
    UIImageView *imageView2 = [[UIImageView alloc] init];
    imageView2.image = [UIImage imageNamed:@"100"];
    imageView2.layer.cornerRadius = 2.0f;
    imageView2.layer.masksToBounds = YES;
    imageView2.frame = CGRectMake((lineView.frame.size.width - 20 * 5) * 3 / 10 + lineView.frame.origin.x + 20, CGRectGetMinY(lineView.frame) - (preferencesBackView.frame.size.height * 100 / 180) * (image2Num / 100) + 1, 20, (preferencesBackView.frame.size.height * 100 / 180) * (image2Num / 100));
    [preferencesBackView addSubview:imageView2];
    UILabel *image2Label = [[UILabel alloc] init];
    image2Label.text = [NSString stringWithFormat:@"%.0f%%",image2Num];
    image2Label.textAlignment = NSTextAlignmentCenter;
    image2Label.textColor = [UIColor grayColor];
    image2Label.font = [UIFont systemFontOfSize:11];
    CGFloat image2LabelW = [self adjustWidthToFitStrFontSize:11 andString:image2Label.text].width;
    CGFloat image2LabelH = [self adjustWidthToFitStrFontSize:11 andString:image2Label.text].height;
    image2Label.frame = CGRectMake(CGRectGetMidX(imageView2.frame) - image2LabelW/2, CGRectGetMinY(imageView2.frame) - 5 - image2LabelH, image2LabelW, image2LabelH);
    [preferencesBackView addSubview:image2Label];
    UILabel *nameLabel2 = [[UILabel alloc] init];
    nameLabel2.text = @"水果";
    nameLabel2.textAlignment = NSTextAlignmentCenter;
    nameLabel2.textColor = [UIColor grayColor];
    nameLabel2.font = [UIFont systemFontOfSize:11];
    CGFloat nameLabel2W = [self adjustWidthToFitStrFontSize:11 andString:nameLabel2.text].width;
    CGFloat nameLabel2H = [self adjustWidthToFitStrFontSize:11 andString:nameLabel2.text].height;
    nameLabel2.frame = CGRectMake(CGRectGetMidX(imageView2.frame) - nameLabel2W/2, CGRectGetMaxY(imageView2.frame) + 5, nameLabel2W, nameLabel2H);
    [preferencesBackView addSubview:nameLabel2];
    
    CGFloat image3Num = 6.0f;
    UIImageView *imageView3 = [[UIImageView alloc] init];
    imageView3.image = [UIImage imageNamed:@"100"];
    imageView3.layer.cornerRadius = 2.0f;
    imageView3.layer.masksToBounds = YES;
    imageView3.frame = CGRectMake((lineView.frame.size.width - 20 * 5) * 5 / 10 + lineView.frame.origin.x + 20 * 2, CGRectGetMinY(lineView.frame) - (preferencesBackView.frame.size.height * 100 / 180) * (image3Num / 100) + 1, 20, (preferencesBackView.frame.size.height * 100 / 180) * (image3Num / 100));
    [preferencesBackView addSubview:imageView3];
    UILabel *image3Label = [[UILabel alloc] init];
    image3Label.text = [NSString stringWithFormat:@"%.0f%%",image3Num];
    image3Label.textAlignment = NSTextAlignmentCenter;
    image3Label.textColor = [UIColor grayColor];
    image3Label.font = [UIFont systemFontOfSize:11];
    CGFloat image3LabelW = [self adjustWidthToFitStrFontSize:11 andString:image3Label.text].width;
    CGFloat image3LabelH = [self adjustWidthToFitStrFontSize:11 andString:image3Label.text].height;
    image3Label.frame = CGRectMake(CGRectGetMidX(imageView3.frame) - image3LabelW/2, CGRectGetMinY(imageView3.frame) - 5 - image3LabelH, image3LabelW, image3LabelH);
    [preferencesBackView addSubview:image3Label];
    UILabel *nameLabel3 = [[UILabel alloc] init];
    nameLabel3.text = @"蔬菜";
    nameLabel3.textAlignment = NSTextAlignmentCenter;
    nameLabel3.textColor = [UIColor grayColor];
    nameLabel3.font = [UIFont systemFontOfSize:11];
    CGFloat nameLabel3W = [self adjustWidthToFitStrFontSize:11 andString:nameLabel3.text].width;
    CGFloat nameLabel3H = [self adjustWidthToFitStrFontSize:11 andString:nameLabel3.text].height;
    nameLabel3.frame = CGRectMake(CGRectGetMidX(imageView3.frame) - nameLabel3W/2, CGRectGetMaxY(imageView3.frame) + 5, nameLabel3W, nameLabel3H);
    [preferencesBackView addSubview:nameLabel3];
    
    CGFloat image4Num = 40.0f;
    UIImageView *imageView4 = [[UIImageView alloc] init];
    imageView4.image = [UIImage imageNamed:@"100"];
    imageView4.layer.cornerRadius = 2.0f;
    imageView4.layer.masksToBounds = YES;
    imageView4.frame = CGRectMake((lineView.frame.size.width - 20 * 5) * 7 / 10 + lineView.frame.origin.x + 20 * 3, CGRectGetMinY(lineView.frame) - (preferencesBackView.frame.size.height * 100 / 180) * (image4Num / 100) + 1, 20, (preferencesBackView.frame.size.height * 100 / 180) * (image4Num / 100));
    [preferencesBackView addSubview:imageView4];
    UILabel *image4Label = [[UILabel alloc] init];
    image4Label.text = [NSString stringWithFormat:@"%.0f%%",image4Num];
    image4Label.textAlignment = NSTextAlignmentCenter;
    image4Label.textColor = [UIColor grayColor];
    image4Label.font = [UIFont systemFontOfSize:11];
    CGFloat image4LabelW = [self adjustWidthToFitStrFontSize:11 andString:image4Label.text].width;
    CGFloat image4LabelH = [self adjustWidthToFitStrFontSize:11 andString:image4Label.text].height;
    image4Label.frame = CGRectMake(CGRectGetMidX(imageView4.frame) - image4LabelW/2, CGRectGetMinY(imageView4.frame) - 5 - image4LabelH, image4LabelW, image4LabelH);
    [preferencesBackView addSubview:image4Label];
    UILabel *nameLabel4 = [[UILabel alloc] init];
    nameLabel4.text = @"日用品";
    nameLabel4.textAlignment = NSTextAlignmentCenter;
    nameLabel4.textColor = [UIColor grayColor];
    nameLabel4.font = [UIFont systemFontOfSize:11];
    CGFloat nameLabel4W = [self adjustWidthToFitStrFontSize:11 andString:nameLabel4.text].width;
    CGFloat nameLabel4H = [self adjustWidthToFitStrFontSize:11 andString:nameLabel4.text].height;
    nameLabel4.frame = CGRectMake(CGRectGetMidX(imageView4.frame) - nameLabel4W/2, CGRectGetMaxY(imageView4.frame) + 5, nameLabel4W, nameLabel4H);
    [preferencesBackView addSubview:nameLabel4];
    
    CGFloat image5Num = 14.0f;
    UIImageView *imageView5 = [[UIImageView alloc] init];
    imageView5.image = [UIImage imageNamed:@"100"];
    imageView5.layer.cornerRadius = 2.0f;
    imageView5.layer.masksToBounds = YES;
    imageView5.frame = CGRectMake((lineView.frame.size.width - 20 * 5) * 9 / 10 + lineView.frame.origin.x + 20 * 4, CGRectGetMinY(lineView.frame) - (preferencesBackView.frame.size.height * 100 / 180) * (image5Num / 100) + 1, 20, (preferencesBackView.frame.size.height * 100 / 180) * (image5Num / 100));
    [preferencesBackView addSubview:imageView5];
    UILabel *image5Label = [[UILabel alloc] init];
    image5Label.text = [NSString stringWithFormat:@"%.0f%%",image5Num];
    image5Label.textAlignment = NSTextAlignmentCenter;
    image5Label.textColor = [UIColor grayColor];
    image5Label.font = [UIFont systemFontOfSize:11];
    CGFloat image5LabelW = [self adjustWidthToFitStrFontSize:11 andString:image5Label.text].width;
    CGFloat image5LabelH = [self adjustWidthToFitStrFontSize:11 andString:image5Label.text].height;
    image5Label.frame = CGRectMake(CGRectGetMidX(imageView5.frame) - image5LabelW/2, CGRectGetMinY(imageView5.frame) - 5 - image5LabelH, image5LabelW, image5LabelH);
    [preferencesBackView addSubview:image5Label];
    UILabel *nameLabel5 = [[UILabel alloc] init];
    nameLabel5.text = @"家电";
    nameLabel5.textAlignment = NSTextAlignmentCenter;
    nameLabel5.textColor = [UIColor grayColor];
    nameLabel5.font = [UIFont systemFontOfSize:11];
    CGFloat nameLabel5W = [self adjustWidthToFitStrFontSize:11 andString:nameLabel5.text].width;
    CGFloat nameLabel5H = [self adjustWidthToFitStrFontSize:11 andString:nameLabel5.text].height;
    nameLabel5.frame = CGRectMake(CGRectGetMidX(imageView5.frame) - nameLabel5W/2, CGRectGetMaxY(imageView5.frame) + 5, nameLabel5W, nameLabel5H);
    [preferencesBackView addSubview:nameLabel5];
    
   
    // 柱状图
    

    

    
    
    
    
    
    
    
    
    
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGSize)adjustWidthToFitStrFontSize:(CGFloat)font andString:(NSString *)str
{
    NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    return [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}

- (UIColor *)colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length ]< 6) {
        return [UIColor clearColor];
    }
    
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        return [UIColor clearColor];
    }
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
    
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
