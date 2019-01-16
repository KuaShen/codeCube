//
//  NewMessageViewController.m
//  Ma
//
//  Created by 天真 on 2018/5/3.
//  Copyright © 2018年 zyc. All rights reserved.
//

#import "NewMessageViewController.h"
#import "CCWaterflowLayout.h"
#import "DetailMessageController.h"
#import "SSSearchBar.h"

@interface NewMessageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,CCWaterFlowLayoutDelegate,UISearchBarDelegate>{
    SSSearchBar *searchBar;
}

@end

@implementation NewMessageViewController

-(NSArray *)data
{
    if(!_data)
    {
        _data = [[NSArray alloc]init];
        _data = @[@[@"推广-画像_09",@"时尚 新潮 眼镜  "],@[@"推广-画像_13",@"小清新 福利 文艺  "],@[@"推广-画像_14",@"欢乐 福利 食品  "]];
    }
    return _data;
}

- (void)navigationBarItemSet{
    
    /*
     *设置标题
     */
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    //    titleLabel.backgroundColor = [UIColor grayColor];
    //    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"新建推文";
    self.navigationItem.titleView = titleLabel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    searchBar = [[SSSearchBar alloc] init];
    searchBar.placeholder = @"搜索模板";
    searchBar.delegate = self;
    searchBar.frame = CGRectMake(0,NAV_HEIGHT,ScreenW-24,30);
    searchBar.layer.cornerRadius = 4;
    searchBar.layer.masksToBounds = YES;
    //边框线粗细
    [searchBar.layer setBorderWidth:8];
    //设置边框为白色是为了盖住UISearchBar上的灰色
    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    UITextField *textfield = [searchBar valueForKey:@"_searchField"];
    [textfield setValue:RGB(210, 210, 210) forKeyPath:@"_placeholderLabel.textColor"];
    [textfield setValue:[UIFont boldSystemFontOfSize:12]forKeyPath:@"_placeholderLabel.font"];
    
    CCWaterflowLayout *layout = [[CCWaterflowLayout alloc]init];
    
    layout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, View_Y_HEIGHT(searchBar)-10, self.view.bounds.size.width, ScreenH-(View_Y_HEIGHT(searchBar)-10)) collectionViewLayout:layout];
    
    self.collectionView.dataSource = self;
    
    self.collectionView.delegate = self;
    
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView setAccessibilityIdentifier:@"collectionView"];
    
    [self.collectionView setIsAccessibilityElement:YES];
    

    
    [self.view addSubview:searchBar];
    [self navigationBarItemSet];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [searchBar endEditing:YES];
}

#pragma mark - <CCWaterFlowLayoutDelegate>
- (CGFloat)waterflowLayout:(CCWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth
{
    return itemWidth*0.75;
}

- (CGFloat)rowMarginInWaterflowLayout:(CCWaterflowLayout *)waterflowLayout
{
    return 10;
}

- (CGFloat)columnCountInWaterflowLayout:(CCWaterflowLayout *)waterflowLayout
{
    return 2;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(CCWaterflowLayout *)waterflowLayout
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellid = [NSString stringWithFormat:@"cellID"];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellid];
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    
    if(indexPath.row==0)
    {
        UIImageView *add = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
        add.image = [UIImage imageNamed:@"推广-画像_07"];
        [cell addSubview:add];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, cell.bounds.size.height*0.65, cell.bounds.size.width, 10)];
        label.text = @"新建";
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        [add addSubview:label];
    }
    else
    {
        UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
        view.image = [UIImage imageNamed:_data[indexPath.row-1][0]];
        [cell addSubview:view];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, cell.bounds.size.height-15, cell.bounds.size.width, 10)];
        label.text = _data[indexPath.row-1][1];
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:13];
        [view addSubview:label];
    }
    
   
    
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.hidesBottomBarWhenPushed = YES;
    DetailMessageController *v = [[DetailMessageController alloc]init];
    indexPath.row !=0 ? [self.navigationController pushViewController:v animated:YES] : nil;
    self.hidesBottomBarWhenPushed = NO;
}



@end
