//
//  MessageTableView.m
//  Ma
//
//  Created by 天真 on 2018/5/3.
//  Copyright © 2018年 zyc. All rights reserved.
//

#import "MessageTableView.h"

@interface MessageTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MessageTableView

- (NSArray *)data
{
    if(!_data)
        _data = [[NSArray alloc]init];
    return _data;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style data:(NSArray *)data
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        _data = data;
        
        self.delegate =self;
        
        self.dataSource = self;
        
        self.separatorStyle = NO;
        
    }
    return self;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 190;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"ID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = NO;
        
        cell.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, self.bounds.size.width-20, 185 )];
        
        image.image = [UIImage imageNamed:_data[indexPath.row]];
        [cell addSubview:image];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

@end
