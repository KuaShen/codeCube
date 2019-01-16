//
//  SelectButton.m
//  Ma
//
//  Created by 天真 on 2018/5/3.
//  Copyright © 2018年 zyc. All rights reserved.
//

#import "SelectButton.h"

@implementation SelectButton

- (instancetype)initWithFrame:(CGRect)frame title:(NSArray *)titleArray
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width/2, frame.size.height)];
        [button1 setTitle:titleArray[0] forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1.00] forState:UIControlStateNormal];
        button1.titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:button1];
        UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(button1.bounds.size.width/2-25, 43, 50, 2)];
        bottomLine.backgroundColor = [UIColor colorWithRed:0.14 green:0.69 blue:0.96 alpha:1.00];
        [button1 addSubview:bottomLine];
        UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width/2, 0, frame.size.width/2, frame.size.height)];
        [button2 setTitle:titleArray[1] forState:UIControlStateNormal];
        [button2 setTitleColor:[UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1.00] forState:UIControlStateNormal];
        button2.titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:button2];
        [button2 addTarget:self action:@selector(DidClick) forControlEvents:UIControlEventTouchUpInside];
        
      
    }
    return self;
}
- (void)DidClick
{
    if ([self.delegate respondsToSelector:@selector(sendString)]) 
        [self.delegate sendString];
    
   
    
}

@end
