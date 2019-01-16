//
//  OperateController.m
//  CodeCube-Business
//
//  Created by apple on 2018/4/30.
//  Copyright © 2018年 lab. All rights reserved.
//

#import "OperateController.h"

#import "UITableViewCell+Extension.h"
#import "XTTableDataDelegate.h"

#import "OperateModel.h"
#import "OperateCell.h"

#import "CustomModel.h"
#import "CustomCell.h"

#import "ListView.h"
#import "CircleView.h"

#import "SNChart.h"
#import "LYLineChartView.h"
#import "JFChartView.h"

#import "EQCodeController.h"
#import "ScanController.h"


@interface OperateController ()<SNChartDataSource>{
    
    NSString *timeString;
    
    BOOL isPrediction;
    
    CGFloat viewWidth;
    CGFloat viewHeight;
    //
    NSString *secDate;
    NSString *showData;

    //chartViewDatas(SecondChartView)
    NSString *titleOfYStr;
    NSString *titleOfXStr;
    NSArray *tempDataArrOfY;
    NSArray *dataArrOfY;
    NSArray *dataArrOfX;
    //ShowView的数据
    NSArray *titLArray;
    NSMutableArray *showArray;
    NSArray *imageArray;
    UILabel *titL;
    NSString *titString;
    UILabel *dataL;
    NSString *moduleDataString;
    
    //第三个视图
    UILabel *titleLabel;
    NSString *titleString;
    UILabel *timeLabel;
    UIView *view;
    UILabel *percentLabel;
    NSString *changeTitleString;
    NSString *changedataString;
    
    
    //listView
    NSArray *listTitleArray;
    NSArray *listDataArray;
    NSArray *listImgArray;
    
    //顾客数据
    NSArray *headImageArray;
    NSArray *nameArray;
    NSArray *dataArray;
    
}

@property (strong, nonatomic) UIView *firstView;

@property (strong, nonatomic) UIView *secondView;
@property (strong, nonatomic) JFChartView *secondChartView;

@property (strong, nonatomic) UIView *thirdView;
@property (strong, nonatomic) UITableView *myTableView;
@property (strong, nonatomic) UIView *showView;
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIView *contextView;
@property (strong, nonatomic) UIView *chartView;

@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic,strong) XTTableDataDelegate *tableHandler;

@property (nonatomic, strong) NSMutableArray *listCustom;
@property (nonatomic,strong) XTTableDataDelegate *tableHandlerCustom;

@end

@implementation OperateController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defa = [NSUserDefaults standardUserDefaults];
    [defa setValue:@"NO" forKey:@"isLogin"];
    [defa synchronize];
    isPrediction = NO;
    [self navigationBarItemSet];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    [self setUI];
    [self setupTableView];
}

- (void)viewDidAppear:(BOOL)animated{
    NSUserDefaults *defa = [NSUserDefaults standardUserDefaults];
    NSString *isLogin = [defa valueForKey:@"isLogin"];

    if ([isLogin isEqualToString:@"NO"]) {
        [self toLogInView];
    }

}

- (void)setUI{
    
    [self.view addSubview:self.firstView];
    [self.view addSubview:self.secondView];
    [self.view addSubview:self.thirdView];
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
    titleLabel.text = @"运营数据";
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"运营_06"] style:UIBarButtonItemStylePlain target:self action:@selector(showLeft)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"运营_03"] style:UIBarButtonItemStylePlain target:self action:@selector(showRight)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)showLeft{
    self.hidesBottomBarWhenPushed = YES;
    ScanController *controller = [[ScanController alloc]init];
    controller.controllerTitle = @"扫描";
    [self.navigationController pushViewController:controller animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}

- (void)showRight{
    self.hidesBottomBarWhenPushed = YES;
    EQCodeController *controller = [[EQCodeController alloc]init];
    controller.controllerTitle = @"收款码";
    [self.navigationController pushViewController:controller animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)initData{
    self.list = [[NSMutableArray alloc]init];
    self.listCustom = [[NSMutableArray alloc]init];
    viewWidth = (ScreenW - 40)/2;
    viewHeight = ScreenH-TAB_HEIGHT-NAV_HEIGHT-300;
    titLArray = @[@"购物时长",@"老顾客到店率",@"新增顾客"];//
    showArray = [[NSMutableArray alloc]initWithArray:@[@"9min",@"82%",@"7位"]];//
    //    showArray = [[NSMutableArray alloc]initWithCapacity:3];
    imageArray = @[@"icon1",@"icon2",@"高考3"];//tableViews上的图片
    titleString = @"顾客数据记录";
    listTitleArray = @[@"广告",@"营销",@"活动"];//
    listDataArray = @[@"4000元",@"9000元",@"6000元"];//
    listImgArray = @[@"运营_18",@"运营_23",@"运营_20"];//
    changeTitleString = @"购物时长";
    changedataString = @"3.31-4.06";
    //OldViewSecondData
//    titleOfYStr = @"";
//    titleOfXStr = @"(日)";
    tempDataArrOfY = @[@"44",@"32",@"16",@"42",@"57",@"33",@"26"];
    dataArrOfY = @[@"60",@"50",@"40",@"30",@"20",@"10",@"0"];//拿到Y轴坐标
    dataArrOfX = @[@"08:00",@"08:10",@"08:20",@"08:20",@"08:30",@"08:40",@"08:50"];//拿到X轴坐标
    //customDataSource
    headImageArray = @[@"pic_user1",@"pic_user2",@"pic_user3",@"pic_user4",@"pic_user5",@"pic_user6",@"pic_user7"];
    nameArray = @[@"Yami",@"Sanny",@"Mako",@"Kako",@"Quien",@"Nike",@"Aya"];
    dataArray = @[@"9min",@"30min",@"45min",@"26min",@"30min",@"20min",@"45min"];
    
    for (int i = 0; i < showArray.count; i++) {
        OperateModel *model = [OperateModel new];
        model.dataString = showArray[i];
        model.itemString = titLArray[i];
        model.imageName = imageArray[i];
        model.height = (ScreenH-TAB_HEIGHT-NAV_HEIGHT-300-50)/3;
        [self.list addObject:model];
    }
    for (int i = 0; i < nameArray.count; i++) {
        CustomModel *model = [CustomModel new];
        model.data = dataArray[i];
        model.name = nameArray[i];
        model.headImage = [UIImage imageNamed:headImageArray[i]];
        model.height = (viewHeight-95)/7;
        [self.listCustom addObject:model];
    }
    
}

#pragma mark -------------------------------  加载界面  ----------------------------
//预估界面加载
- (void)loadNew{
    isPrediction = YES;
    
    titleLabel.text = @"预计收益内容";
    [_myTableView removeFromSuperview];
    [_showView removeFromSuperview];
    [self addNewViews];
    [_thirdView addSubview:self.contextView];
    [_thirdView addSubview:self.chartView];
    [self changeSecondView];
    [self loadChartView];
    
}
//更换预估界面的中间图表（需要先把原来的图表remove）
- (void)changeSecondView{
    for(UIView *subview in [self->_secondView subviews])
    {
        [subview removeFromSuperview];
    }
    UILabel *firL = [[UILabel alloc]init];
    firL.frame = CGRectMake(30, 10, 200, 10);
    firL.textColor = [UIColor grayColor];
    firL.text = @"需补货商品";
    firL.font = FONT(13);
    
    UILabel *secL = [[UILabel alloc]init];
    secL.frame = CGRectMake(X_EQUAL(firL), View_Y_HEIGHT(firL)-10, WIDTH_EQUAL(firL), 10);
    secL.textColor = [UIColor grayColor];
    secL.text = timeString;
    
    SNChart *chartView = [[SNChart alloc] initWithFrame:CGRectMake(10, 30, ScreenW-20, HEIGHT_EQUAL(_secondView)-50) withDataSource:self andChatStyle:SNChartStyleBar];
    chartView.backgroundColor = [UIColor whiteColor];
    [chartView show];
    [chartView showInView:_secondView];
    
    [_secondView addSubview:firL];
    [_secondView addSubview:secL];
}
//加载预估界面最下面的图表
- (void)loadChartView{
    
    LYLineChartView *chartView2 = [[LYLineChartView alloc] initWithFrame:CGRectMake(0, 40, ScreenW-20, (viewHeight-50)*5/7-20-50)];
//    chartView2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
    [_chartView addSubview:chartView2];
    
    chartView2.row = 7;
    chartView2.column = 5;
    
    chartView2.columnData = @[@"08:00",@"08:10",@"08:20",@"08:20",@"08:30",@"08:40",@"08:50"];
    chartView2.valueData = @[@"50",@"40",@"70",@"10",@"25"];
    
    chartView2.isShowGriddingGuide = NO;
    chartView2.isShowVerticalGuide = NO;
    chartView2.isShowHorizontalGuide = YES;
    //    chartView2.benchmarkLineStyle.benchmarkValue = @"0.6";
    
    chartView2.canvasEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    chartView2.precisionScale = 1000;
    chartView2.yAxisPrecisionScale = 0;
    
    
    [chartView2 reloadData];
}

//未来预估的界面
- (void)addNewViews{//预估的界面
    _contextView = [[UIView alloc]init];
    _contextView.frame = CGRectMake(10, View_Y_HEIGHT(titleLabel), ScreenW-20, (viewHeight-50)*2/7);
    _contextView.backgroundColor = [UIColor whiteColor];
    CGFloat listWidth = (ScreenW-20)/3;
    for (int i = 0; i < listTitleArray.count; i++) {
        ListView *view = [[ListView alloc]init];
        UIImage *image = [UIImage imageNamed:listImgArray[i]];
        [view creatNewWithTitle:listTitleArray[i] andData:listDataArray[i] andImage:image withFrame:CGRectMake(listWidth*i, 0, listWidth, (viewHeight-50)*2/7)];
        [_contextView addSubview:view];
    }
    
    _chartView = [[UIView alloc]init];
    _chartView.frame = CGRectMake(10, View_Y_HEIGHT(_contextView)+10, ScreenW-20, (viewHeight-50)*5/7-20);
    _chartView.backgroundColor = [UIColor whiteColor];
    
    
}
#pragma mark ------------------------------------  原始界面加载  -----------------------------------
//原始界面加载
- (void)loadOld{
    isPrediction = NO;
    titleLabel.text = titleString;
    
    [_contextView removeFromSuperview];
    [_showView removeFromSuperview];
    [_chartView removeFromSuperview];
    [_thirdView addSubview:self.myTableView];
    [_thirdView addSubview:self.showView];
    [self addOldSecondView];

}
//添加原始界面的图表
- (void)addOldSecondView{
    for(UIView *subview in [self->_secondView subviews])
    {
        [subview removeFromSuperview];
    }
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(10, 20, 60, 20);
    label.text = @"客流分析";
    label.textColor = [UIColor grayColor];
    label.font = FONT(13);
    UILabel *timeL = [[UILabel alloc]init];
    timeL.frame = CGRectMake(10, 40, 60, 10);
    timeL.text = @"2018.04.06";
    timeL.textColor = [UIColor grayColor];
    timeL.font = FONT(8);
    
    _secondChartView = [[JFChartView alloc]initWithFrame:CGRectMake(10, 60, ScreenW-20, HEIGHT_EQUAL(_secondView)-50)];
    //        _chartView.frame = CGRectMake(30, 20, ScreenW-60, HEIGHT_EQUAL(_chartBackgroundView)-30);
    _secondChartView.backgroundColor = [UIColor clearColor];
    //        [_chartBackgroundView addSubview:cashLabel];
    _secondChartView.titleOfYStr = titleOfYStr;
    _secondChartView.titleOfXStr = titleOfXStr;
    _secondChartView.leftDataArr = tempDataArrOfY;
    _secondChartView.dataArrOfY = dataArrOfY;//拿到Y轴坐标
    _secondChartView.dataArrOfX = dataArrOfX;//拿到X轴坐标
    [_secondView  addSubview:self.secondChartView];
    [_secondView addSubview:label];
    [_secondView addSubview:timeL];
    
}
//原始界面装需要更换数据的部分
- (void)addOldViews{

    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(20, View_Y_HEIGHT(titleLabel), viewWidth, viewHeight-50)];
    _myTableView.scrollEnabled = NO;
    _myTableView.backgroundColor = [UIColor clearColor];
    
    _showView = [[UIView alloc]init];
    _showView.frame = CGRectMake(ScreenW/2, View_Y_HEIGHT(titleLabel), viewWidth, viewHeight);
    titL = [[UILabel alloc]init];
    titL.frame = CGRectMake(10, 20, viewWidth-20, 20);
    titL.textColor = [UIColor grayColor];
    titL.font = FONT(13);
    titL.text = changeTitleString;
    
    dataL = [[UILabel alloc]init];
    dataL.frame = CGRectMake(10, View_Y_HEIGHT(titL)-10, viewWidth-20, 15);
    dataL.textColor = [UIColor lightGrayColor];
    dataL.font = FONT(10);
    dataL.text = changedataString;
    
    view = [[UIView alloc]init];
    view.frame = CGRectMake(0, View_Y_HEIGHT(dataL)-10, viewWidth, viewHeight-45-50);
//    view.backgroundColor = [UIColor whiteColor];
    
    [_showView addSubview:titL];
    [_showView addSubview:dataL];
    [_showView addSubview:view];
    [self addOldSecondView];
}
#pragma mark -------------------------  加载原始界面下的showView  ----------------------------------

- (void)loadFirstView{
    
    titL.text = @"购物时长";
    dataL.text = @"3.31-4.06";
    
//    UIView *testView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
//    testView.backgroundColor = [UIColor yellowColor];
//    [view addSubview:testView];
    
    CircleView *ringView = [[CircleView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewWidth)];
//    ringView.center = self.view.center;
    NSMutableArray *chartItems = [[NSMutableArray alloc] init];
    NSArray *colors = @[[UIColor redColor], [UIColor cyanColor], [UIColor yellowColor]];
    ringView.contentLabel.text = @"9Min\n平均购物时长";
    ringView.contentLabel.font = FONT(12);
    NSArray *arr = @[@11,@25,@90];
    for (NSInteger i = 0; i < colors.count; i++) {
        ChartItem *item = [[ChartItem alloc] init];
        item.value = arr[i];
        item.color = colors[i];
        [chartItems addObject:item];
    }
    ringView.chartItems = chartItems;
    //    ringView.ringMargin = 10;
    //    ringView.innerRingWidth = 10;
    //    ringView.outerRingWidth = 60;
    //    ringView.dotMargin = 0;
    //    //    ringView.hideDot = YES;
    //    //    ringView.animate = NO;
    //    ringView.dotSize = CGSizeMake(10, 10);
    [view addSubview:ringView];
    
}


- (void)loadSecondView{
    titL.text = @"老顾客到店率";
    dataL.text = @"今日顶峰82%";
    
    percentLabel = [[UILabel alloc]init];
    percentLabel.frame = CGRectMake(viewWidth/2-80, 20, 160, 25);
    percentLabel.textColor = [UIColor grayColor];
    percentLabel.textAlignment = NSTextAlignmentCenter;
    percentLabel.font = FONT(20);
    percentLabel.text = @"82%";
    [view addSubview:percentLabel];
    //折线图
    SNChart *chartView = [[SNChart alloc] initWithFrame:CGRectMake(0, View_Y_HEIGHT(percentLabel)+10, viewWidth, viewWidth) withDataSource:self andChatStyle:SNChartStyleLine];
    chartView.backgroundColor = [UIColor clearColor];
    
    [chartView show];
    [chartView showInView:view];
    
}

- (void)loadThirdView{
    titL.text = @"新增顾客";
    dataL.text = @"7位";
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [view addSubview:_tableView];
    [self setupThirdTableView];
    
}

- (void)setupThirdTableView{
    
    
    TableViewCellConfigureBlock configureCell = ^(NSIndexPath *indexPath, CustomModel *obj, UITableViewCell *cell){
        [cell configure:cell
              customObj:obj
              indexPath:indexPath];
        
    };
    
    CellHeightBlock heightBlock = ^CGFloat(NSIndexPath *indexPath, id item) {
        return [CustomCell getCellHeightWithCustomObj:item
                                             indexPath:indexPath] ;
    } ;
    
    DidSelectCellBlock selectedBlock = ^(NSIndexPath *indexPath, id item) {
        NSLog(@"hhclick row : %@",@(indexPath.row)) ;
        
    } ;
    
    self.tableHandlerCustom = [[XTTableDataDelegate alloc] initWithItems:self.listCustom
                                                    cellIdentifier:@"CustomCell"
                                                configureCellBlock:configureCell
                                                   cellHeightBlock:heightBlock
                                                    didSelectBlock:selectedBlock
                                                          cellRows:self.listCustom.count
                                                       cellSection:1] ;
    
    [self.tableHandlerCustom handleTableViewDatasourceAndDelegate:self.tableView] ;
    //    self.tableview.delegate = self;
    
}

//翻转动画效果
- (void)predicte{
//    [self animationWithView:self.view WithAnimationTransition:UIViewAnimationTransitionFlipFromLeft];
    [self transitionWithType:@"oglFlip" WithSubtype:kCATransitionFromLeft ForView:self.view];
    if (isPrediction) {
        [self loadOld];
        
    }else{
        [self loadNew];
    }
        
    
}

#pragma UIView实现动画
- (void) animationWithView : (UIView *)view WithAnimationTransition : (UIViewAnimationTransition) transition
{
    [UIView animateWithDuration:0.7f animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}
#pragma CATransition动画实现
- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = 0.7f;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
    }
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
}

- (void)setupTableView{
    
    
    TableViewCellConfigureBlock configureCell = ^(NSIndexPath *indexPath, OperateModel *obj, UITableViewCell *cell){
        [cell configure:cell
              customObj:obj
              indexPath:indexPath];
        
    };
    
    CellHeightBlock heightBlock = ^CGFloat(NSIndexPath *indexPath, id item) {
        return [OperateCell getCellHeightWithCustomObj:item
                                                indexPath:indexPath] ;
    } ;
    
    DidSelectCellBlock selectedBlock = ^(NSIndexPath *indexPath, id item) {
        NSLog(@"click row : %@",@(indexPath.row)) ;
        for(UIView *subview in [self->view subviews])
        {
            [subview removeFromSuperview];
        }
        if (indexPath.row == 0) {
            [self loadFirstView];
        }else if (indexPath.row == 1){
            
            [self loadSecondView];
        }else{
            
            [self loadThirdView];
        }
    } ;
    
    self.tableHandler = [[XTTableDataDelegate alloc] initWithItems:self.list
                                                    cellIdentifier:@"OperateCell"
                                                configureCellBlock:configureCell
                                                   cellHeightBlock:heightBlock
                                                    didSelectBlock:selectedBlock
                                                          cellRows:self.list.count
                                                       cellSection:1] ;
    
    [self.tableHandler handleTableViewDatasourceAndDelegate:self.myTableView] ;
    //    self.tableview.delegate = self;
    
}
#pragma mark ---------------------------  tableView的分割线从零开始  ------------------------------
-(void)viewDidLayoutSubviews
{
    if ([self.myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.myTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.myTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark ----------------------------------  dataSource代理  ----------------------------------
- (NSArray *)chatConfigYValue:(SNChart *)chart {
    //    NSArray *array = currentArray;
    //    [self loadData];
    if (isPrediction) {//预估界面的数据
        return @[@"5",@"10",@"15",@"20",@"25",@"30",@"30"];
    }else//开始界面的数据
        return @[@"5",@"10",@"15",@"20",@"25",@"30",@"30"];
    return @[];
    //    return @[@"80",@"60",@"70",@"30",@"50",@"14",@"90",@"100",@"50",@"20"];//currentArray
    //        return @[@"100",@"50",@"70",@"30",@"50",@"14",@"5",@"14",@"5",@"14"];
}

- (NSArray *)chatConfigXValue:(SNChart *)chart {
    
    if (isPrediction) {//预估界面的X轴上的显示数据
        return @[@"乐事",@"士力架",@"炫迈",@"冰红茶",@"牛奶",@"大白兔",@"清风"];
    }else//开始界面的X轴上的显示数据
        return @[@"S",@"M",@"T",@"W",@"T",@"F",@"S"];
    return @[];
    //    return @[@"1.3",@"1.6",@"1.12",@"1.15",@"1.17",@"1.21",@"1.25",@"1.28"];
    //    return @[@"12-1",@"12-2",@"12-3",@"12-4",@"12-5",@"12-6",@"12-7",@"12-8",@"12-9",@"12-10"];//timeArray
}

#pragma mark ----------------------------------  懒加载  ----------------------------------

- (UIView *)firstView{
    
    if(!_firstView){
        _firstView = [[UIView alloc]init];
        _firstView.frame = CGRectMake(0, NAV_HEIGHT+20, ScreenW, 35);
        _firstView.backgroundColor = [UIColor clearColor];
        
        UILabel *bigLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 200, 25)];
        bigLabel.textColor = COLOR_TAB;
        [bigLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
        bigLabel.text = @"嗨！店长";
        
        UILabel *smallLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, View_Y_HEIGHT(bigLabel)-5, ScreenW-20, 10)];
        smallLabel.textColor = COLOR_TAB;
        smallLabel.font = FONT(13);
        smallLabel.text = @"店铺近期的经营情况如下";
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(ScreenW-120, View_Y_HEIGHT(bigLabel)-10, 80, 20)];
        [button setTitle:@"未来预估" forState:UIControlStateNormal];
        [button setTitleColor:COLOR_TAB forState:UIControlStateNormal];
        [button addTarget:self action:@selector(predicte) forControlEvents:UIControlEventTouchUpInside];
        
        
        [_firstView addSubview:bigLabel];
        [_firstView addSubview:smallLabel];
        [_firstView addSubview:button];
    }
    return _firstView;
}

- (UIView *)secondView{
    
    if(!_secondView){
        _secondView = [[UIView alloc]init];
        _secondView.frame = CGRectMake(0, View_Y_HEIGHT(_firstView)+5, ScreenW, 200);
        _secondView.backgroundColor = [UIColor whiteColor];
    }
    return _secondView;
}


- (UIView *)thirdView{
    
    if(!_thirdView){
        _thirdView = [[UIView alloc]init];
        _thirdView.frame = CGRectMake(0, View_Y_HEIGHT(_secondView)+10, ScreenW, viewHeight);
        _thirdView.backgroundColor = [UIColor whiteColor];
        
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 200, 20)];
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.font = FONT(13);
        titleLabel.text = titleString;
        
        timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW-160, 5+2.5, 60, 15)];
        timeLabel.textColor = COLOR_TAB;
        timeLabel.font = FONT(11);
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.text = @"时间段：";
        
        UILabel *la = [[UILabel alloc]init];
        la.frame = CGRectMake(ScreenW-60, 5+2.5, 60, 15);
        la.textColor = COLOR_TAB;
        la.font = FONT(11);
        la.textAlignment = NSTextAlignmentLeft;
        la.text = @"七天内";
        
        [self addOldViews];
        [self addNewViews];
        [self loadFirstView];
        
        [_thirdView addSubview:titleLabel];
        [_thirdView addSubview:timeLabel];
        [_thirdView addSubview:self.myTableView];
        [_thirdView addSubview:_showView];
        
        
    }
    return _thirdView;
}



@end
