//
//  MessageController.m
//  CodeCube-Business
//
//  Created by apple on 2018/5/4.
//  Copyright © 2018年 lab. All rights reserved.
//

#import "MessageController.h"

#import "HistoryPushController.h"
#import "NewPushController.h"

@interface MessageController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentCtrl;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) HistoryPushController *firstVC;
@property (nonatomic, strong) NewPushController *secondVC;

@end

@implementation MessageController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = NO;
    self.view.backgroundColor = COLOR_BACKGROUND;
    
    [self setBackgroundView];
    [self settingSrollerView];
    [self settingSegmentCtrl];
    [self navigationBarItemSet];
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
    titleLabel.text = @"消息推送";
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(showRight)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)showRight{
    
    
}

- (void)setBackgroundView{
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT, ScreenW, 44)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
}

- (void)settingSrollerView{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, ScreenW,ScreenH )];
    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.directionalLockEnabled = YES;
    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);  // 内边距
    scrollView.contentSize = CGSizeMake(ScreenW*2, ScreenH);
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    // 将三个视图加入scrollerView
    self.firstVC = [[HistoryPushController alloc] init];
    self.firstVC.view.frame = CGRectMake(0, 0, ScreenW, ScreenH-44);
    self.secondVC = [[NewPushController alloc] init];
    self.secondVC.view.frame = CGRectMake(ScreenW, 0, ScreenW, ScreenH-44);
    
    [self addChildViewController:self.firstVC];
    [self addChildViewController:self.secondVC];
    
    [scrollView addSubview:self.firstVC.view];
    [scrollView addSubview:self.secondVC.view];
    
    
    
    _scrollView = scrollView;
}

#pragma mark -- scrollerView 代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.x;
    self.segmentCtrl.selectedSegmentIndex = offset/ScreenW;
}

-(void)settingSegmentCtrl{
    UISegmentedControl *segmentCtrl = [[UISegmentedControl alloc] initWithItems:@[@"历史推送",@"新建推送"]];
    [self.view addSubview:segmentCtrl];
    segmentCtrl.frame = CGRectMake(0, NAV_HEIGHT, ScreenW, 44);
    segmentCtrl.selectedSegmentIndex = 0;
    // 设置test空间的颜色为透明
    segmentCtrl.tintColor = [UIColor clearColor];
    // 定义未选中状态下的样式normal,类型为字典
    NSDictionary *normal = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:RGB(147, 147, 147)};
    // 定位选中状态下的样式selected，类型为字典
    NSDictionary *selected = @{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:COLOR_MAIN};
    // 通过setTitleTextAttributes: forState: 方法来给test控件设置文字内容的格式
    [segmentCtrl setTitleTextAttributes:normal forState:UIControlStateNormal];
    [segmentCtrl setTitleTextAttributes:selected forState:UIControlStateSelected];
    [segmentCtrl addTarget:self action:@selector(segmentBtnClick) forControlEvents:UIControlEventValueChanged];
    
    _segmentCtrl = segmentCtrl;
}

// 点击segmentCtrl 调用方法
- (void)segmentBtnClick{
    NSLog(@"点击");
    self.scrollView.contentOffset = CGPointMake(self.segmentCtrl.selectedSegmentIndex * self.view.frame.size.width, 0);
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
}

@end
