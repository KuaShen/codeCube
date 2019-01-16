//
//  OrdChildOrdCell.m
//  CodeCube-Business
//
//  Created by apple on 2018/5/4.
//  Copyright © 2018年 lab. All rights reserved.
//

#import "OrdChildOrdCell.h"
#import "OrdChildModel.h"

@implementation OrdChildOrdCell

- (void)configure:(UITableViewCell *)cell
        customObj:(id)obj
        indexPath:(NSIndexPath *)indexPath
{
    OrdChildModel *myObj = (OrdChildModel *)obj ;
    OrdChildOrdCell *mycell = (OrdChildOrdCell *)cell ;
    mycell.commodityLabel.text = myObj.commodityString ;
    mycell.perdetermindTimeLabel.text = myObj.perdetermindString;
    mycell.name.text = myObj.nameString ;
    mycell.storeTimeLabel.text = myObj.storeString ;
    mycell.phoneNumberLabel.text = myObj.phoneNumber ;
    mycell.cashAmount.text = myObj.cashAmountString ;
    cell.backgroundColor = [UIColor whiteColor] ;
    
    cell.layer.cornerRadius = 10;
    cell.layer.masksToBounds = YES;
    
}

+ (CGFloat)getCellHeightWithCustomObj:(id)obj
                            indexPath:(NSIndexPath *)indexPath
{
    return ((OrdChildModel *)obj).height ;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    _confirmButton.layer.cornerRadius = 8;
    _confirmButton.clipsToBounds = YES;
    [_confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    
    [_callButton addTarget:self action:@selector(call) forControlEvents:UIControlEventTouchUpInside];
    

}

- (void)confirm{
    [self removeFromSuperview];
    
}

- (void)call{
    NSMutableString *str=[[NSMutableString alloc]initWithFormat:@"tel:%@",_phoneNumberLabel.text];
                          
                          UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:_phoneNumberLabel.text preferredStyle:UIAlertControllerStyleAlert];
                          
                          
                          
                          UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        
        
    }];
                          
                          
                          
                          UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }];
                          
                          
                          
                          // Add the actions.
                          
                          [alertController addAction:cancelAction];
                          
                          [alertController addAction:otherAction];
                          
                          [[self currentViewController] presentViewController:alertController animated:YES completion:nil];
}

- (UIViewController*)currentViewController{
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
