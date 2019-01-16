//
//  SelectButton.h
//  Ma
//
//  Created by 天真 on 2018/5/3.
//  Copyright © 2018年 zyc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol selectButtonDelegate <NSObject>

- (void)sendString;

@end

@interface SelectButton : UIView

- (instancetype)initWithFrame:(CGRect)frame title:(NSArray *)titleArray;

@property (weak,nonatomic)id<selectButtonDelegate> delegate;


@end
