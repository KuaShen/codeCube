//
//  XTTableDataDelegate.m
//  TableDatasourceSeparation
//
//  Created by TuTu on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "XTTableDataDelegate.h"
#import "UITableViewCell+Extension.h"

@interface XTTableDataDelegate ()
@property (nonatomic, strong) NSArray *items ;
@property (nonatomic, copy) NSString *cellIdentifier ;
@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock ;
@property (nonatomic, copy) CellHeightBlock             heightConfigureBlock ;
@property (nonatomic, copy) DidSelectCellBlock          didSelectCellBlock ;
@property (nonatomic) NSInteger cellSection;
@property (nonatomic) NSInteger cellRows;
@end

@implementation XTTableDataDelegate

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock
    cellHeightBlock:(CellHeightBlock)aHeightBlock
     didSelectBlock:(DidSelectCellBlock)didselectBlock
           cellRows:(NSInteger)cellRows
        cellSection:(NSInteger)cellSection
{
    self = [super init] ;
    if (self) {
        
        self.items = anItems ;
        self.cellIdentifier = aCellIdentifier ;
        self.configureCellBlock = aConfigureCellBlock ;
        self.heightConfigureBlock = aHeightBlock ;
        self.didSelectCellBlock = didselectBlock ;
        self.cellRows = cellRows;
        self.cellSection = cellSection;
    }
    
    return self ;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[(int)indexPath.row] ;
}

- (id)itemAtSection:(NSIndexPath *)indexPath{
//    NSLog(@"self.items[(int)indexPath.section] == %@",self.items[(int)indexPath.section]);
    return self.items[(int)indexPath.section];

//    return self.items[indexPath.section];
}

- (void)handleTableViewDatasourceAndDelegate:(UITableView *)table
{
    table.dataSource = self ;
    table.delegate   = self ;
}

#pragma mark --
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellRows;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.cellSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item;
    if (tableView.style == UITableViewStylePlain) {
        item = [self itemAtIndexPath:indexPath] ;
    }else if (tableView.style == UITableViewStyleGrouped){
        
        item = [self itemAtSection:indexPath] ;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier] ;
    if (!cell) {
        [UITableViewCell registerTable:tableView nibIdentifier:self.cellIdentifier] ;
        cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    }
    self.configureCellBlock(indexPath,item,cell) ;
    return cell ;
}

#pragma mark --
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self itemAtIndexPath:indexPath] ;
    return self.heightConfigureBlock(indexPath,item) ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self itemAtIndexPath:indexPath] ;
    self.didSelectCellBlock(indexPath,item) ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 7;
}

@end
