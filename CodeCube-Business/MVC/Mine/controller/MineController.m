//
//  MineController.m
//  CodeCube-Business
//
//  Created by apple on 2018/4/30.
//  Copyright © 2018年 lab. All rights reserved.
//

#import "MineController.h"
#import "DataStatisticsController.h"
#import "MainCollectionViewCell.h"
#import "model.h"
#import "InputDetailController.h"
#import "OrdController.h"
#import "EQCodeController.h"

@interface MineController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UIImageView *settingImage;
@property(nonatomic,strong)model *mymodel;
@property(nonatomic,strong)UIView *aview;
@property(nonatomic,strong)UIView * TopView;
@property(nonatomic,strong)UIImageView *sellerImage;
@property(nonatomic,strong)UIView *bView;
@property(nonatomic,strong)UIView *cView;
@property(nonatomic,strong)UIView *seperateview;
@property(nonatomic,strong)UILabel *nameLable;
@property(nonatomic,strong)UIImageView *star0;
@property(nonatomic,strong)UIImageView *star1;
@property(nonatomic,strong)UIImageView *star2;
@property(nonatomic,strong)UIImageView *star3;
@property(nonatomic,strong)UIImageView *star4;
@property(nonatomic,strong)UILabel *lable0;
@property(nonatomic,strong)UILabel *lable1;
@property(nonatomic,strong)UILabel *lable2;
@property(nonatomic,strong)UILabel *lable3;
@property(nonatomic,strong)UILabel *lable4;
@property(nonatomic,strong)UILabel *lable5;
@property(nonatomic,strong)UICollectionView *collectionView;
-(void)setStar:(model*)mymodel;
-(void)setMoney:(model*)mymodel;
@end

@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self navigationBarItemSet];
    self.mymodel=[[model alloc]init];
    [_mymodel setData:@"headImage" sellerName:@"JNBY旗舰店" starNumber:4 moneyA:5632.50 moneyB:563.50 moneyC:263.00];
    //背景底色
    self.aview=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.aview.backgroundColor=[[UIColor grayColor]colorWithAlphaComponent:0.2];
    //顶端蓝色界面
    self.TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    _TopView.backgroundColor=[UIColor colorWithRed:0.076 green:0.5 blue:1.0 alpha:1.0];
    
    //卖家信息界面
    self.bView=[[UIView alloc]initWithFrame:CGRectMake(20, 115,self.view.bounds.size.width-40, 200)];
    self.bView.layer.cornerRadius=10;
    self.bView.layer.masksToBounds=YES;
    _bView.backgroundColor=[UIColor whiteColor];
    
    //卖家头像
    self.sellerImage=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenW/2-50, 50, 100, 100)];
    self.sellerImage.layer.cornerRadius=50;
    self.sellerImage.layer.masksToBounds=YES;
    self.sellerImage.layer.borderWidth=3;
    self.sellerImage.layer.borderColor=[UIColor whiteColor].CGColor;
    self.sellerImage.image=[UIImage imageNamed:@"headImage"];
    
    //设置标志
    self.settingImage=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-45, 40, 25, 25)];
    self.settingImage.image=[UIImage imageNamed:@"setting"];
    
    //设置分割线
    self.seperateview=[[UIView alloc]initWithFrame:CGRectMake(20, 100, self.bView.bounds.size.width-40, 2)];
    self.seperateview.backgroundColor=[[UIColor grayColor]colorWithAlphaComponent:0.2];
    
    //商家名称
    self.nameLable=[[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-70, 30, 100, 40)];
    self.nameLable.text=_mymodel.sellerName;
    
    //评分星星
    self.star0=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-85, 65, 20, 20)];
    self.star1=[[UIImageView alloc]initWithFrame:CGRectMake(self.star0.frame.origin.x+30, 65, 20, 20)];
    self.star2=[[UIImageView alloc]initWithFrame:CGRectMake(self.star1.frame.origin.x+30, 65, 20, 20)];
    self.star3=[[UIImageView alloc]initWithFrame:CGRectMake(self.star2.frame.origin.x+30, 65, 20, 20)];
    self.star4=[[UIImageView alloc]initWithFrame:CGRectMake(self.star3.frame.origin.x+30, 65, 20, 20)];
    [self setStar:_mymodel];
    
    //经济状况(数据）
    self.lable0=[[UILabel alloc]initWithFrame:CGRectMake(25, View_Y_HEIGHT(_seperateview)+20, self.nameLable.bounds.size.width, 25)];
    self.lable1=[[UILabel alloc]initWithFrame:CGRectMake(self.lable0.frame.origin.x+120, Y_EQUAL(_lable0), self.nameLable.bounds.size.width, 25)];
    self.lable2=[[UILabel alloc]initWithFrame:CGRectMake(self.lable1.frame.origin.x+120, Y_EQUAL(_lable0), self.nameLable.bounds.size.width, 25)];
    _lable0.font = FONT(15);
    _lable1.font = FONT(15);
    _lable2.font = FONT(15);
    self.lable0.textColor=[[UIColor redColor]colorWithAlphaComponent:0.5];
    self.lable1.textColor=[[UIColor redColor]colorWithAlphaComponent:0.5];
    self.lable2.textColor=[[UIColor redColor]colorWithAlphaComponent:0.5];
    self.lable0.textAlignment=NSTextAlignmentCenter;
    self.lable1.textAlignment=NSTextAlignmentCenter;
    self.lable2.textAlignment=NSTextAlignmentCenter;
    [self setMoney:_mymodel];
    
    //经济状况（参数）
    self.lable3=[[UILabel alloc]initWithFrame:CGRectMake(25, View_Y_HEIGHT(_lable0)-10, 110, 30)];
    self.lable4=[[UILabel alloc]initWithFrame:CGRectMake(self.lable3.frame.origin.x+120, View_Y_HEIGHT(_lable0)-10, 110, 30)];
    self.lable5=[[UILabel alloc]initWithFrame:CGRectMake(self.lable4.frame.origin.x+120, View_Y_HEIGHT(_lable0)-10, 110, 30)];
    _lable3.font = FONT(12);
    _lable4.font = FONT(12);
    _lable5.font = FONT(12);
    self.lable3.textAlignment=NSTextAlignmentCenter;
    self.lable4.textAlignment=NSTextAlignmentCenter;
    self.lable5.textAlignment=NSTextAlignmentCenter;
    _lable3.text=@"可用余额 (元)";
    _lable4.text=@"今日收入 (元)";
    _lable5.text=@"待结算 (元)";
    
    //选项界面
    
    
    
    [self.view addSubview:_aview];
    [self.view addSubview:_TopView];
    [self.view addSubview:_bView];
    [self.view addSubview:_sellerImage];
    [self.view addSubview:_settingImage];
    [self.bView addSubview:_seperateview];
    [self.bView addSubview:_nameLable];
    [self.bView addSubview:_star0];
    [self.bView addSubview:_star1];
    [self.bView addSubview:_star2];
    [self.bView addSubview:_star3];
    [self.bView addSubview:_star4];
    [self.bView addSubview:_lable0];
    [self.bView addSubview:_lable1];
    [self.bView addSubview:_lable2];
    [self.bView addSubview:_lable3];
    [self.bView addSubview:_lable4];
    [self.bView addSubview:_lable5];
    [self.view addSubview:self.collectionView];
    
//    UIButton *push = [[UIButton alloc]initWithFrame:CGRectMake(ScreenW/2-80, ScreenH/2-40, 160, 80)];
//    [push setTitle:@"push" forState:UIControlStateNormal];
//    [push setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [push addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
//
//    [self.view addSubview:push];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [self navigationBarItemSet];
    self.navigationController.navigationBar.hidden = YES;
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
    titleLabel.text = @"个人中心";
    self.navigationItem.titleView = titleLabel;
}

- (void)setMoney:(model *)mymodel{
    self.lable0.text=[NSString stringWithFormat:@"%.2lf",mymodel.moneyA];
    self.lable1.text=[NSString stringWithFormat:@"%.2lf",mymodel.moneyB];
    self.lable2.text=[NSString stringWithFormat:@"%.2lf",mymodel.moneyC];
    
}
- (void)setStar:(model *)mymodel{
    if(mymodel.starNumber==0){
        self.star0.image=[UIImage imageNamed:@"star-1"];
        self.star1.image=[UIImage imageNamed:@"star-1"];
        self.star2.image=[UIImage imageNamed:@"star-1"];
        self.star3.image=[UIImage imageNamed:@"star-1"];
        self.star4.image=[UIImage imageNamed:@"star-1"];
    }
    else if(mymodel.starNumber==1){
        self.star0.image=[UIImage imageNamed:@"star"];
        self.star1.image=[UIImage imageNamed:@"star-1"];
        self.star2.image=[UIImage imageNamed:@"star-1"];
        self.star3.image=[UIImage imageNamed:@"star-1"];
        self.star4.image=[UIImage imageNamed:@"star-1"];
    }
    else if(mymodel.starNumber==2){
        self.star0.image=[UIImage imageNamed:@"star"];
        self.star1.image=[UIImage imageNamed:@"star"];
        self.star2.image=[UIImage imageNamed:@"star-1"];
        self.star3.image=[UIImage imageNamed:@"star-1"];
        self.star4.image=[UIImage imageNamed:@"star-1"];
    }
    else if(mymodel.starNumber==3){
        self.star0.image=[UIImage imageNamed:@"star"];
        self.star1.image=[UIImage imageNamed:@"star"];
        self.star2.image=[UIImage imageNamed:@"star"];
        self.star3.image=[UIImage imageNamed:@"star-1"];
        self.star4.image=[UIImage imageNamed:@"star-1"];
    }
    else if(mymodel.starNumber==4){
        self.star0.image=[UIImage imageNamed:@"star"];
        self.star1.image=[UIImage imageNamed:@"star"];
        self.star2.image=[UIImage imageNamed:@"star"];
        self.star3.image=[UIImage imageNamed:@"star"];
        self.star4.image=[UIImage imageNamed:@"star-1"];
    }
    else if(mymodel.starNumber==5){
        self.star0.image=[UIImage imageNamed:@"star"];
        self.star1.image=[UIImage imageNamed:@"star"];
        self.star2.image=[UIImage imageNamed:@"star"];
        self.star3.image=[UIImage imageNamed:@"star"];
        self.star4.image=[UIImage imageNamed:@"star"];
    }
}
- (UICollectionView *)collectionView{
    if(_collectionView == nil){
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(20, View_Y_HEIGHT(_bView)+10, self.view.bounds.size.width-40, 270) collectionViewLayout:flowlayout];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.layer.cornerRadius = 10;
        self.collectionView.layer.masksToBounds = YES;
        UINib *nib = [UINib nibWithNibName:@"MainCollectionViewCell" bundle:nil];
        MainCollectionViewCell *cell=[nib instantiateWithOwner:nil options:nil].lastObject;
        flowlayout.itemSize=cell.frame.size;
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        flowlayout.minimumLineSpacing = 5;
        flowlayout.minimumInteritemSpacing = 15;
        [_collectionView registerNib:nib forCellWithReuseIdentifier:@"MainCollectionViewCell"];
    }
    return _collectionView;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    UIEdgeInsets insets=UIEdgeInsetsMake(20, 15, 5, 15);
    return insets;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//选项设置
- (__kindof UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"MainCollectionViewCell" forIndexPath:indexPath];
    if(indexPath.section==0&&indexPath.row==0){
        cell.iCon.image=[UIImage imageNamed:@"e"];
        cell.lable.text=@"订单管理";
    }
    else if(indexPath.section==0&&indexPath.row==1){
        cell.iCon.image=[UIImage imageNamed:@"f"];
        cell.lable.text=@"评价管理";
    }
    else if(indexPath.section==0&&indexPath.row==2){
        cell.iCon.image=[UIImage imageNamed:@"g"];
        cell.lable.text=@"收入明细";
    }
    else if(indexPath.section==0&&indexPath.row==3){
        cell.iCon.image=[UIImage imageNamed:@"h"];
        cell.lable.text=@"收款码";
    }
    else if(indexPath.section==0&&indexPath.row==4){
        cell.iCon.image=[UIImage imageNamed:@"i"];
        cell.lable.text=@"消息通知";
    }
    else{
        cell.iCon.image=[UIImage imageNamed:@"j"];
        cell.lable.text=@"数据统计";
    }
    return cell;
}
//单元格可以被选中
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//单元格可以取消选中
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//各单元格选中时调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        self.hidesBottomBarWhenPushed = YES;
        OrdController *controller = [[OrdController alloc]init];
        controller.controllerTitle = @"订单";
        [self.navigationController pushViewController:controller animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    else if(indexPath.row==1){
        self.hidesBottomBarWhenPushed = YES;
        InputDetailController *controller = [[InputDetailController alloc]init];
        controller.controllerTitle = @"评价管理";
        [self.navigationController pushViewController:controller animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    else if(indexPath.row==2){
        self.hidesBottomBarWhenPushed = YES;
        InputDetailController *controller = [[InputDetailController alloc]init];
        controller.controllerTitle = @"收入明细";
        [self.navigationController pushViewController:controller animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    else if(indexPath.row==3){
        self.hidesBottomBarWhenPushed = YES;
        EQCodeController *controller = [[EQCodeController alloc]init];
        controller.controllerTitle = @"收款码";
        [self.navigationController pushViewController:controller animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    else if(indexPath.row==4){
//        messageViewController *message=[[messageViewController alloc]init];
//        [self.navigationController pushViewController:message animated:YES];
    }
    else{
        self.hidesBottomBarWhenPushed = YES;
        DataStatisticsController *controller = [[DataStatisticsController alloc]init];
        controller.controllerTitle = @"数据统计";
        [self.navigationController pushViewController:controller animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}



@end




