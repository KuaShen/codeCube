//
//  DataStatisticsController.m
//  CodeCube-Business
//
//  Created by apple on 2018/4/30.
//  Copyright © 2018年 lab. All rights reserved.
//

#import "DataStatisticsController.h"

#import "UITableViewCell+Extension.h"
#import "XTTableDataDelegate.h"

#import "DataStaticCell.h"
#import "DataStaticCellModel.h"
#import "ChartLineInfoView.h"
#import "LRSChartView.h"

#define defaultMoney 85706.50

@interface DataStatisticsController (){
    CGFloat moneyAmount;
    NSArray *titleArray;
    NSArray *initArray;
    NSMutableArray *dataArray;
    
    //chartViewDatas
    NSString *titleOfYStr;
    NSString *titleOfXStr;
    NSArray *tempDataArrOfY;
    NSArray *dataArrOfY;
    NSArray *dataArrOfX;
}

@property (strong, nonatomic) UIView *showAllView;
@property (strong, nonatomic) UILabel *moneyLabel;

@property (strong, nonatomic) UIView *chartBackgroundView;
@property (strong, nonatomic) LRSChartView *chartView;

@property (strong, nonatomic) UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic,strong) XTTableDataDelegate *tableHandler ;

@end

@implementation DataStatisticsController

- (void)viewDidLoad {
    [super viewDidLoad];
    titleArray = @[@"本月成交额(元)",@"本月累计成交单数(单)",@"成交率"];
    initArray = @[@"0",@"0",@"0"];
    dataArray = [[NSMutableArray alloc]init];
    
    [self navigationBarSet];
    [self initData];
    [self setUI];
    [self setupTableView];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    if (dataArray.count) {
        [self refrashData];
    }
    
    
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

- (void)setUI{
    self.view.backgroundColor = COLOR_BACKGROUND;
    
    [self.view addSubview:self.showAllView];
    [_showAllView addSubview:self.moneyLabel];
    [self.view addSubview:self.chartBackgroundView];
    [_chartBackgroundView addSubview:self.chartView];
    [self.view addSubview:self.myTableView];
    
}

- (void)loadData{
    
    [dataArray addObject:@"85706.50"];
    [dataArray addObject:@"451"];
    [dataArray addObject:@"98.44"];
}

- (void)initData{
    self.list = [[NSMutableArray alloc]init];
    
    titleOfYStr = @"成交额(元)";
    titleOfXStr = @"(日)";
    tempDataArrOfY = @[@"2425",@"4723",@"6666",@"2132",@"3879",@"2576",@"9548"];
    dataArrOfY = @[@"10000",@"8000",@"6000",@"4000",@"2000",@"1000",@"0"];//拿到Y轴坐标
    dataArrOfX = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];//拿到X轴坐标
    

    for (int i = 0; i < titleArray.count; i++) {
        DataStaticCellModel *model = [DataStaticCellModel new];
        model.titleString = titleArray[i];
        model.data = initArray[i];
        model.height = 44;
        [self.list addObject:model];
    }
    
}

- (void)refrashData{
    [self.list removeAllObjects];
    for (int i = 0; i < dataArray.count; i++) {
        DataStaticCellModel *model = [DataStaticCellModel new];
        model.titleString = titleArray[i];
        model.data = dataArray[i];
        model.height = 44;
        [self.list addObject:model];
    }
    [self.myTableView reloadData];
}


- (void)setupTableView{
    
    
    TableViewCellConfigureBlock configureCell = ^(NSIndexPath *indexPath, DataStaticCellModel *obj, UITableViewCell *cell){
        [cell configure:cell
              customObj:obj
              indexPath:indexPath];
        
    };
    
    CellHeightBlock heightBlock = ^CGFloat(NSIndexPath *indexPath, id item) {
        return [DataStaticCell getCellHeightWithCustomObj:item
                                                indexPath:indexPath] ;
    } ;
    
    DidSelectCellBlock selectedBlock = ^(NSIndexPath *indexPath, id item) {
        NSLog(@"click row : %@",@(indexPath.row)) ;
        //        JFLoginViewController *controller = [[JFLoginViewController alloc]init];
        ////        controller.hidesBottomBarWhenPushed = YES;
        //        [self.navigationController pushViewController:controller animated:YES];
    } ;
    
    self.tableHandler = [[XTTableDataDelegate alloc] initWithItems:self.list
                                                    cellIdentifier:@"DataStaticCell"
                                                configureCellBlock:configureCell
                                                   cellHeightBlock:heightBlock
                                                    didSelectBlock:selectedBlock
                                                          cellRows:self.list.count
                                                       cellSection:1] ;
    
    [self.tableHandler handleTableViewDatasourceAndDelegate:self.myTableView] ;
    //    self.tableview.delegate = self;
    
}
// tableView的分割线从零开始
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

#pragma ----------------------------------  懒加载  ----------------------------------

- (UIView *)showAllView{
    
    if(!_showAllView){
        _showAllView = [[UIView alloc]init];
        _showAllView.frame = CGRectMake(0, NAV_HEIGHT, ScreenW, 150);
        _showAllView.backgroundColor = COLOR_MAIN;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(ScreenW/2-100, 20, 200, 20);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = FONT(13);
        titleLabel.text = @"本月累计成交金额（元）";
        [_showAllView addSubview:titleLabel];

    }
    return _showAllView;
}

- (UILabel *)moneyLabel{
    
    if(!_moneyLabel){
        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.frame = CGRectMake(ScreenW/2-100, 55, 200, 60);
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.textColor = [UIColor whiteColor];
        _moneyLabel.font = FONT(60);
        _moneyLabel.text = [NSString stringWithFormat:@"%.2f",(CGFloat)defaultMoney];
    }
    return _moneyLabel;
}

- (UIView *)chartBackgroundView{
    
    if(!_chartBackgroundView){
        _chartBackgroundView = [[UIView alloc]init];
        _chartBackgroundView.frame = CGRectMake(0, View_Y_HEIGHT(_showAllView)+10, ScreenW, 250);
        _chartBackgroundView.backgroundColor = [UIColor whiteColor];
    }
    return _chartBackgroundView;
}

- (UITableView *)myTableView{
    
    if(!_myTableView){
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, View_Y_HEIGHT(_chartBackgroundView)+10, ScreenW, 44*3) style:UITableViewStylePlain];
        _myTableView.backgroundColor = [UIColor whiteColor];
        _myTableView.scrollEnabled = NO;
    }
    return _myTableView;
}
- (LRSChartView *)chartView{
    
    if(!_chartView){
       
        _chartView = [[LRSChartView alloc]initWithFrame:CGRectMake(30, 20, ScreenW-60, HEIGHT_EQUAL(_chartBackgroundView)-30)];
//        _chartView.frame = CGRectMake(30, 20, ScreenW-60, HEIGHT_EQUAL(_chartBackgroundView)-30);
        _chartView.backgroundColor = [UIColor clearColor];
//        [_chartBackgroundView addSubview:cashLabel];
        _chartView.titleOfYStr = titleOfYStr;
        _chartView.titleOfXStr = titleOfXStr;
        _chartView.leftDataArr = tempDataArrOfY;
        _chartView.dataArrOfY = dataArrOfY;//拿到Y轴坐标
        _chartView.dataArrOfX = dataArrOfX;//拿到X轴坐标
    }
    return _chartView;
}

@end
