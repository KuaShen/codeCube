//
//  OrdChildRefundController.m
//  CodeCube-Business
//
//  Created by apple on 2018/5/4.
//  Copyright © 2018年 lab. All rights reserved.
//

#import "OrdChildRefundController.h"

#import "OrdChildModel.h"
#import "OrdChildOrdCell.h"

#import "UITableViewCell+Extension.h"
#import "XTTableDataDelegate.h"

@interface OrdChildRefundController (){
    
    NSArray *comArray;
    NSArray *perArray;
    NSArray *nameArray;
    NSArray *storeArray;
    NSArray *phoneArray;
    NSArray *cashArray;
    
    
}

@property (strong, nonatomic) UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic,strong) XTTableDataDelegate *tableHandler ;

@end

@implementation OrdChildRefundController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self setUI];
    [self setupTableView];
}

- (void)setUI{
    [self.view addSubview:self.myTableView];
}
- (void)initData{
    
    self.list = [[NSMutableArray alloc]init];
    
    comArray = @[@"马克保温杯",@"酸奶"];
    perArray = @[@"2018-4-8",@"2018-4-18"];
    nameArray = @[@"梁小姐",@"张先生"];
    storeArray = @[@"20:00",@"20:00"];
    phoneArray = @[@"13306525820",@"18100173505"];
    cashArray = @[@"254.50",@"188.30"];
    
    for (int i = 0; i < comArray.count; i++) {
        OrdChildModel *model = [OrdChildModel new];
        model.commodityString = comArray[i];
        model.perdetermindString = perArray[i];
        model.nameString = nameArray[i];
        model.storeString = storeArray[i];
        model.phoneNumber = phoneArray[i];
        model.cashAmountString = cashArray[i];
        model.height = 130;
        [self.list addObject:model];
    }
    
}

- (void)setupTableView{
    
    
    TableViewCellConfigureBlock configureCell = ^(NSIndexPath *indexPath, OrdChildModel *obj, UITableViewCell *cell){
        [cell configure:cell
              customObj:obj
              indexPath:indexPath];
        
    };
    
    CellHeightBlock heightBlock = ^CGFloat(NSIndexPath *indexPath, id item) {
        return [OrdChildOrdCell getCellHeightWithCustomObj:item
                                                 indexPath:indexPath] ;
    } ;
    
    DidSelectCellBlock selectedBlock = ^(NSIndexPath *indexPath, id item) {
        NSLog(@"click row : %@",@(indexPath.row)) ;
        //        JFLoginViewController *controller = [[JFLoginViewController alloc]init];
        ////        controller.hidesBottomBarWhenPushed = YES;
        //        [self.navigationController pushViewController:controller animated:YES];
    } ;
    
    self.tableHandler = [[XTTableDataDelegate alloc] initWithItems:self.list
                                                    cellIdentifier:@"OrdChildOrdCell"
                                                configureCellBlock:configureCell
                                                   cellHeightBlock:heightBlock
                                                    didSelectBlock:selectedBlock
                                                          cellRows:1
                                                       cellSection:self.list.count] ;
    
    [self.tableHandler handleTableViewDatasourceAndDelegate:self.myTableView] ;
    //    self.tableview.delegate = self;
    
}

- (UITableView *)myTableView{
    
    if(!_myTableView){
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(2, NAV_HEIGHT, ScreenW-4, ScreenH-NAV_HEIGHT*2-20) style:UITableViewStyleGrouped];
        _myTableView.backgroundColor = [UIColor clearColor];
    }
    return _myTableView;
}


@end
