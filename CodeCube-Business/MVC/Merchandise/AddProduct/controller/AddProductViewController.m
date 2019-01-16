//
//  AddProductViewController.m
//  码立方（商品管理）
//
//  Created by lxg on 2018/5/3.
//  Copyright © 2018年 浙江传媒学院603多媒体实验室. All rights reserved.
//

#import "AddProductViewController.h"
#import "SDAutoLayout.h"

#define themeColor [UIColor colorWithRed:108/255.0 green:203/255.0 blue:252/255.0 alpha:1]

@interface AddProductViewController ()<UIScrollViewDelegate>


@property (nonatomic, strong) UIScrollView *myScrollView;

@property (nonatomic, strong) UIPageControl *pageControl;


@end

@implementation AddProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navigationBarItemSet];
    [self setupUI];
    // Do any additional setup after loading the view.
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
    titleLabel.text = @"添加商品";
    self.navigationItem.titleView = titleLabel;
    
}

- (void)setupUI {
    [self.view setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
    
    
    _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0.35 * ScreenH)];
    [self.view addSubview:_myScrollView];
    
    _pageControl = [[UIPageControl alloc] init];
    [self.view addSubview:_pageControl];
    _pageControl.sd_layout.heightIs(30).leftEqualToView(self.view).bottomEqualToView(self.myScrollView).rightEqualToView(self.view);

    int count = 2;
    
    self.myScrollView.contentSize = CGSizeMake(count * self.myScrollView.frame.size.width, 0);
    for (int i = 1 ; i <= count ; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.myScrollView addSubview:imageView];
        
        
        //        设置图片内容
//        NSString *imageViewName = [NSString stringWithFormat:@"img_%02d",i];
        NSString *imageViewName = @"推广-画像_06";
        imageView.image = [UIImage imageNamed:imageViewName];
        
        //        计算farme
        CGFloat imageViewX = (i - 1) * self.myScrollView.frame.size.width;
        CGFloat imageViewY = 0;
        imageView.frame = CGRectMake(imageViewX, imageViewY, self.myScrollView.frame.size.width, self.myScrollView.frame.size.height);
    }
    
    self.myScrollView.pagingEnabled = YES;
    self.pageControl.numberOfPages = count;
    
    
    // 设置scrollView的代理
    self.myScrollView.delegate = self;
    

    
    
    
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:photoBtn];
    photoBtn.sd_layout.heightIs(0.23 * self.myScrollView.bounds.size.height).widthEqualToHeight().leftSpaceToView(self.view, 10).bottomEqualToView(self.myScrollView);
    [photoBtn setImage:[UIImage imageNamed:@"推广-画像_16"] forState:UIControlStateNormal];
    
    
    UIView *firstBackV = [[UIView alloc] init];
    [self.view addSubview:firstBackV];
    [firstBackV setBackgroundColor:[UIColor whiteColor]];
    firstBackV.sd_layout.topSpaceToView(self.myScrollView, 0).leftEqualToView(self.view).heightIs(50).rightEqualToView(self.view);
    
    
    UILabel *kindLab = [[UILabel alloc] init];
    [firstBackV addSubview:kindLab];
    kindLab.sd_layout.topEqualToView(firstBackV).leftEqualToView(firstBackV).bottomEqualToView(firstBackV).widthIs(100);
    [kindLab setText:@"类目"];
    [kindLab setTextAlignment:NSTextAlignmentCenter];
    
    UILabel *foodLab = [[UILabel alloc] init];
    [firstBackV addSubview:foodLab];
    foodLab.sd_layout.topEqualToView(firstBackV).widthIs(100).bottomEqualToView(firstBackV).rightSpaceToView(firstBackV, 10);
    [foodLab setText:@"食品"];
    [foodLab setTextAlignment:NSTextAlignmentRight];
    
    
    
    
    UIView *secondBackV = [[UIView alloc] init];
    [self.view addSubview:secondBackV];
    secondBackV.sd_layout.topSpaceToView(firstBackV, 10).leftSpaceToView(self.view, 5).heightIs(firstBackV.bounds.size.height * 2).rightSpaceToView(self.view, 5);
    [secondBackV setBackgroundColor:[UIColor whiteColor]];
    [secondBackV.layer setCornerRadius:5];
    
    UILabel *priceLab = [[UILabel alloc] init];
    [secondBackV addSubview:priceLab];
    priceLab.sd_layout.topEqualToView(secondBackV).leftEqualToView(secondBackV).heightIs(0.5 * secondBackV.bounds.size.height).widthIs(100);
    [priceLab setText:@"价格"];
    [priceLab setTextAlignment:NSTextAlignmentCenter];
    
    UILabel *moneyLab = [[UILabel alloc] init];
    [secondBackV addSubview:moneyLab];
    moneyLab.sd_layout.topEqualToView(secondBackV).widthIs(100).heightIs(0.5 * secondBackV.bounds.size.height).rightSpaceToView(secondBackV, 10);
    [moneyLab setText:@"¥60.00"];
    [moneyLab setTextAlignment:NSTextAlignmentRight];
    
    UILabel *storeLab = [[UILabel alloc] init];
    [secondBackV addSubview:storeLab];
    storeLab.sd_layout.topSpaceToView(priceLab, 0).leftEqualToView(secondBackV).heightIs(0.5 * secondBackV.bounds.size.height).widthIs(100);
    [storeLab setText:@"库存"];
    [storeLab setTextAlignment:NSTextAlignmentCenter];
    
    UILabel *numberLab = [[UILabel alloc] init];
    [secondBackV addSubview:numberLab];
    numberLab.sd_layout.topSpaceToView(moneyLab, 0).widthIs(100).heightIs(0.5 * secondBackV.bounds.size.height).rightSpaceToView(secondBackV, 10);
    [numberLab setText:@"1"];
    [numberLab setTextAlignment:NSTextAlignmentRight];
    
    
    UIView *thirdBackV = [[UIView alloc] init];
    [self.view addSubview:thirdBackV];
    thirdBackV.sd_layout.topSpaceToView(secondBackV, 10).leftEqualToView(secondBackV).heightIs(150).rightEqualToView(secondBackV);
    [thirdBackV setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *descirbeLab = [[UILabel alloc] init];
    [thirdBackV addSubview:descirbeLab];
    descirbeLab.sd_layout.topEqualToView(thirdBackV).leftEqualToView(thirdBackV).heightIs(0.5 * secondBackV.bounds.size.height).widthIs(100);
    [descirbeLab setText:@"宝贝描述"];
    [descirbeLab setTextAlignment:NSTextAlignmentCenter];
    
    
    UILabel *detailLab = [[UILabel alloc] init];
    [thirdBackV addSubview:detailLab];
    detailLab.sd_layout.topSpaceToView(descirbeLab, 0).leftEqualToView(detailLab).heightIs(80).rightSpaceToView(thirdBackV, 10);
    [detailLab setText:@"    口感丰富，外脆内柔，外观五彩缤纷，精致小巧，咬一口，首先尝到的是很薄很脆的外壳，接着是又软又绵密的内层"];
    [detailLab setFont:[UIFont systemFontOfSize:15]];
    [detailLab setNumberOfLines:0];
    [detailLab setAlpha:0.6];
    
    
    
    UIButton *deliverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:deliverBtn];
    deliverBtn.sd_layout.heightIs(50).leftEqualToView(self.view).bottomEqualToView(self.view).widthIs(0.498 * ScreenW);
    [deliverBtn setTitle:@"发布" forState:UIControlStateNormal];
    [deliverBtn setBackgroundColor:themeColor];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:saveBtn];
    saveBtn.sd_layout.heightIs(50).rightEqualToView(self.view).bottomEqualToView(self.view).widthIs(0.498 * ScreenW);
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:themeColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - scrollView的代理方法
//正在滚动的时候
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //   (offset.x + 100/2)/100
    int page = (scrollView.contentOffset.x + scrollView.frame.size.width / 2)/ scrollView.frame.size.width;
    self.pageControl.currentPage = page;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
