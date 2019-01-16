//
//  AddOnItemsTableViewController.m
//  码立方（商品管理）
//
//  Created by lxg on 2018/5/1.
//  Copyright © 2018年 浙江传媒学院603多媒体实验室. All rights reserved.
//

#import "AddOnItemsTableViewController.h"
#import "AddOnItemCell.h"

#define ScreenH self.view.bounds.size.height
#define ScreenW self.view.bounds.size.width

@interface AddOnItemsTableViewController ()

@end


static  NSString * const reuseIdentifier = @"cell";

@implementation AddOnItemsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView registerNib:[UINib nibWithNibName:@"AddOnItemCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    
    [self.tableView setAllowsMultipleSelection:YES];
    [self.tableView setSectionHeaderHeight:8];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddOnItemCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AddOnItemCell" owner:nil options:nil] lastObject];
    }
    
    
    
    if (indexPath.section == 0) {
        [cell setupCellWithIcon:[UIImage imageNamed:@"test1"] productName:@"芒果干" detail:@"" price:@"18" stock:@"1000" limitBuyingStr:@"" andState:@"1"];
    }
    if (indexPath.section == 1) {
        [cell setupCellWithIcon:[UIImage imageNamed:@"test2"] productName:@"软糯麻薯团" detail:@"抹茶味" price:@"20" stock:@"1000" limitBuyingStr:@"4月20日结束 每人限购10件" andState:@"0"];
    }
    if (indexPath.section == 2) {
        [cell setupCellWithIcon:[UIImage imageNamed:@"test3"] productName:@"可口香蕉片" detail:@"" price:@"18" stock:@"1000" limitBuyingStr:@"4月20日结束 每人限购10件" andState:@"0"];
    }
    if (indexPath.section == 3) {
        [cell setupCellWithIcon:[UIImage imageNamed:@"test4"] productName:@"软糯麻薯团" detail:@"" price:@"18" stock:@"1000" limitBuyingStr:@"" andState:@"1"];
    }
    
    if (self.selectAllFlag) {
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    }else {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    
    
    
    
    // Configure the cell...
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0.19 * ScreenH;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
}




/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
