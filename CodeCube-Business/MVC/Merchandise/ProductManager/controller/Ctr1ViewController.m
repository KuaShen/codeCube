//
//  Ctr1ViewController.m
//  码立方（商品管理）
//
//  Created by lxg on 2018/5/1.
//  Copyright © 2018年 浙江传媒学院603多媒体实验室. All rights reserved.
//

#import "Ctr1ViewController.h"
#import "UpDownTableViewController.h"
#import "SDAutoLayout.h"

@interface Ctr1ViewController ()

@property (nonatomic, strong)  UpDownTableViewController *vc1;

@end

@implementation Ctr1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _vc1 = [[UpDownTableViewController alloc] init];
    [self addChildViewController:_vc1];
    [self.view addSubview:_vc1.tableView];
    [_vc1.tableView setFrame:self.view.bounds];
    UIView *footerView = [[UIView alloc] init];
    [footerView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:footerView];
    footerView.sd_layout
    .heightIs(0.06 * ScreenH)
    .leftEqualToView(self.view)
    .bottomSpaceToView(self.view, TAB_HEIGHT)
    .rightEqualToView(self.view);
    UIButton *selectAllBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [footerView addSubview:selectAllBtn];
    selectAllBtn.sd_layout
    .topSpaceToView(footerView, 5)
    .leftEqualToView(self.view)
    .bottomSpaceToView(footerView, 5)
    .widthIs(0.2 * ScreenW);
    [selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    [selectAllBtn setTitleColor:[UIColor colorWithRed:108/255.0 green:203/255.0 blue:252/255.0 alpha:1] forState:UIControlStateNormal];
    [selectAllBtn addTarget:self action:@selector(selectAllBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cancelSelectAllBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [footerView addSubview:cancelSelectAllBtn];
    cancelSelectAllBtn.sd_layout
    .topEqualToView(selectAllBtn)
    .leftSpaceToView(selectAllBtn, 0)
    .bottomEqualToView(selectAllBtn)
    .widthRatioToView(selectAllBtn, 1);
    [cancelSelectAllBtn setTitle:@"取消选定" forState:UIControlStateNormal];
    [cancelSelectAllBtn setTitleColor:[UIColor colorWithRed:108/255.0 green:203/255.0 blue:252/255.0 alpha:1] forState:UIControlStateNormal];
    [cancelSelectAllBtn addTarget:self action:@selector(cancelAllBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cancelSaleBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [footerView addSubview:cancelSaleBtn];
    cancelSaleBtn.sd_layout
    .topEqualToView(selectAllBtn)
    .widthRatioToView(selectAllBtn, 1)
    .bottomEqualToView(selectAllBtn)
    .rightEqualToView(self.view);
    [cancelSaleBtn setTitle:@"删除商品" forState:UIControlStateNormal];
    [cancelSaleBtn setTitleColor:[UIColor colorWithRed:108/255.0 green:203/255.0 blue:252/255.0 alpha:1] forState:UIControlStateNormal];
    [cancelSaleBtn addTarget:self action:@selector(cancelSaleBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *unloadBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [footerView addSubview:unloadBtn];
    unloadBtn.sd_layout
    .centerYEqualToView(selectAllBtn)
    .widthRatioToView(selectAllBtn, 0.5)
    .heightIs(0.06 * ScreenH-20)
    .rightSpaceToView(cancelSaleBtn, 10);
    [unloadBtn setTitle:@"下架" forState:UIControlStateNormal];
    [unloadBtn setTitleColor:[UIColor colorWithRed:108/255.0 green:203/255.0 blue:252/255.0 alpha:1] forState:UIControlStateNormal];
    [unloadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [unloadBtn setBackgroundColor:[UIColor colorWithRed:241/255.0 green:105/255.0 blue:96/255.0 alpha:1]];
    [unloadBtn.layer setCornerRadius:5];
    [unloadBtn addTarget:self action:@selector(unloadBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    

    UIButton *uploadBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [footerView addSubview:uploadBtn];
    uploadBtn.sd_layout
    .centerYEqualToView(selectAllBtn)
    .widthRatioToView(selectAllBtn, 0.5)
    .heightIs(0.06 * ScreenH-20)
    .rightSpaceToView(unloadBtn, 10);
    [uploadBtn setTitle:@"上架" forState:UIControlStateNormal];
    [uploadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [uploadBtn setBackgroundColor:[UIColor colorWithRed:108/255.0 green:203/255.0 blue:252/255.0 alpha:1]];
    [uploadBtn.layer setCornerRadius:5];
    [uploadBtn addTarget:self action:@selector(uploadBtnClicked) forControlEvents:UIControlEventTouchUpInside];

    // Do any additional setup after loading the view.
}

- (void)selectAllBtnClicked {
//    全选
    [_vc1 setSelectAllFlag:YES];
    [_vc1.tableView reloadData];
}

- (void)cancelAllBtnClicked {
//    删除选定
    [_vc1 setSelectAllFlag:NO];
    [_vc1.tableView reloadData];
    
}

- (void)uploadBtnClicked {
    //上架

}

- (void)unloadBtnClicked {
    //下架

}

- (void)cancelSaleBtnClicked {
//    删除商品
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
