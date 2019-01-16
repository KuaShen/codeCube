//
//  InputDetailController.m
//  CodeCube-Business
//
//  Created by apple on 2018/5/3.
//  Copyright © 2018年 lab. All rights reserved.
//

#import "InputDetailController.h"

#import "UITableViewCell+Extension.h"
#import "XTTableDataDelegate.h"

#import "InputModel.h"
#import "InputDetailCell.h"

@interface InputDetailController (){
    
    NSArray *titleArray;
    NSArray *dataArray;
    
    NSArray *tArray;
    NSArray *dArray;
    
}

@property (strong, nonatomic) UIView *firstView;

@property (strong, nonatomic) UIView *secondView;

@property (strong, nonatomic) UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic,strong) XTTableDataDelegate *tableHandler ;

@end

@implementation InputDetailController

- (void)viewDidLoad{
    [self navigationBarSet];
    self.view.backgroundColor = COLOR_BACKGROUND;
    [self initData];
    [self setUI];
    [self setupTableView];
    
}

- (void)initData{
    
    self.list = [[NSMutableArray alloc]init];
    
    titleArray = @[@"收到的好评",@"收到的中评",@"收到的差评"];
    dataArray = @[@"6",@"2",@"1"];
    tArray = @[@"描述相符",@"服务态度",@"发货速度"];
    dArray = @[@"5.0",@"4.8",@"4.8"];

    for (int i = 0; i < titleArray.count; i++) {
        InputModel *model = [InputModel new];
        model.title = titleArray[i];
        model.messageCount = dataArray[i];
        model.height = 44;
        [self.list addObject:model];
    }
    
}

- (void)setUI{
    
    [self.view addSubview:self.firstView];
    [self.view addSubview:self.secondView];
    [self.view addSubview:self.myTableView];
    
    UILabel *firL = [[UILabel alloc]init];
    firL.frame = CGRectMake(30, NAV_HEIGHT+10, ScreenW-30, 20);
    firL.text = @"动态评分";
    firL.font = FONT(13);
    firL.textColor = [UIColor grayColor];

    UILabel *secL = [[UILabel alloc]init];
    secL.frame = CGRectMake(30, View_Y_HEIGHT(_secondView), ScreenW-30, 20);
    secL.text = @"近6个月的评价";
    secL.font = FONT(13);
    secL.textColor = [UIColor grayColor];
    
    [self.view addSubview:firL];
    [self.view addSubview:secL];
    
    for (int i = 0; i < tArray.count; i++) {
        [self creatViewWithString:tArray[i] andScore:dArray[i] withFrame:CGRectMake(ScreenW*i/3, 0, ScreenW/3, 70)];
    }
    
    
}

- (void)setupTableView{
    
    
    TableViewCellConfigureBlock configureCell = ^(NSIndexPath *indexPath, InputModel *obj, UITableViewCell *cell){
        [cell configure:cell
              customObj:obj
              indexPath:indexPath];
        
    };
    
    CellHeightBlock heightBlock = ^CGFloat(NSIndexPath *indexPath, id item) {
        return [InputDetailCell getCellHeightWithCustomObj:item
                                                indexPath:indexPath] ;
    } ;
    
    DidSelectCellBlock selectedBlock = ^(NSIndexPath *indexPath, id item) {
        NSLog(@"click row : %@",@(indexPath.row)) ;
        //        JFLoginViewController *controller = [[JFLoginViewController alloc]init];
        ////        controller.hidesBottomBarWhenPushed = YES;
        //        [self.navigationController pushViewController:controller animated:YES];
    } ;
    
    self.tableHandler = [[XTTableDataDelegate alloc] initWithItems:self.list
                                                    cellIdentifier:@"InputDetailCell"
                                                configureCellBlock:configureCell
                                                   cellHeightBlock:heightBlock
                                                    didSelectBlock:selectedBlock
                                                          cellRows:self.list.count
                                                       cellSection:1] ;
    
    [self.tableHandler handleTableViewDatasourceAndDelegate:self.myTableView] ;
    //    self.tableview.delegate = self;
    
}

- (void)creatViewWithString:(NSString *)string andScore:(NSString *)score withFrame:(CGRect)frame{
    
    UILabel *titleL = [[UILabel alloc]init];
    titleL.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height/2);
    titleL.text = string;
    titleL.textColor = [UIColor grayColor];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.font = FONT(15);
    
    UILabel *dataL = [[UILabel alloc]init];
    dataL.frame = CGRectMake(frame.origin.x, frame.origin.y+titleL.frame.size.height, frame.size.width, frame.size.height/2);
    dataL.text = score;
    dataL.textColor = COLOR_MAIN;
    dataL.textAlignment = NSTextAlignmentCenter;
    dataL.font = FONT(15);
    
    [_firstView addSubview:titleL];
    [_firstView addSubview:dataL];
}

- (void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = NO;
    
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
#pragma mark ------------------------  delegate  ---------------------------
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

#pragma mark --------------------------  lazy load -------------------------------

- (UIView *)firstView{
    
    if(!_firstView){
        _firstView = [[UIView alloc]init];
        _firstView.frame = CGRectMake(0, NAV_HEIGHT+30, ScreenW, 70);
        _firstView.backgroundColor = [UIColor whiteColor];
    }
    return _firstView;
}

- (UIView *)secondView{
    
    if(!_secondView){
        _secondView = [[UIView alloc]init];
        _secondView.frame = CGRectMake(3, View_Y_HEIGHT(_firstView), ScreenW-6, 90);
        _secondView.backgroundColor = [UIColor whiteColor];
        _secondView.layer.cornerRadius = 10;
        _secondView.layer.masksToBounds = YES;
        _secondView.layer.borderWidth = .1;
        
        UIView *lineView = [[UIView alloc]init];
        lineView.frame = CGRectMake(10, HEIGHT_EQUAL(_secondView)/2, ScreenW-20, 1);
        lineView.backgroundColor = [UIColor grayColor];
        
        UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(0, lineView.center.y-30, ScreenW/3, 20)];
        titleL.text = @"卖家信用";
        titleL.textColor = [UIColor grayColor];
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.font = FONT(15);
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(0, 0, 20, 20);
        imageView.center = CGPointMake(ScreenW*5/6, titleL.center.y);
        imageView.image = [UIImage imageNamed:@"crown03"];
        

        UILabel *rateL = [[UILabel alloc]init];
        rateL.frame = CGRectMake(0, lineView.center.y+10, ScreenW/3, 20);
        rateL.text = @"好评率";
        rateL.textAlignment = NSTextAlignmentCenter;
        rateL.textColor = [UIColor grayColor];
        rateL.font = FONT(15);
        
        UILabel *rate = [[UILabel alloc]init];
        rate.frame = CGRectMake(0, 0, ScreenW/3, 20);
        rate.center = CGPointMake(imageView.center.x, rateL.center.y);
        rate.text = @"98%";
        rate.textAlignment = NSTextAlignmentCenter;
        rate.textColor = [UIColor grayColor];
        rate.font = FONT(15);
        
        [_secondView addSubview:titleL];
        [_secondView addSubview:imageView];
        [_secondView addSubview:lineView];
        [_secondView addSubview:rateL];
        [_secondView addSubview:rate];
        
    }
    return _secondView;
}

- (UITableView *)myTableView {
    
    if(!_myTableView) {
        
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(3, View_Y_HEIGHT(_secondView)+30, ScreenW-6, 44*3) style:UITableViewStylePlain];
        _myTableView.backgroundColor = [UIColor whiteColor];
        _myTableView.layer.cornerRadius = 10;
        _myTableView.layer.masksToBounds = YES;
        _myTableView.scrollEnabled = NO;
        _myTableView.layer.borderWidth = .1;
        
    }
    
    return _myTableView;
    
}

@end
