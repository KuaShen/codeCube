//
//  ListView.m
//  CodeCube-Business
//
//  Created by apple on 2018/5/2.
//  Copyright © 2018年 lab. All rights reserved.
//

#import "ListView.h"

@implementation ListView

- (void)creatNewWithTitle:(NSString *)title andData:(NSString *)data andImage:(UIImage *)image withFrame:(CGRect)frame{
    UILabel *upLabel = [[UILabel alloc]initWithFrame:CGRectMake(frame.origin.x+10, frame.size.height/2-20, frame.size.width/2-10, frame.size.height/4)];
    upLabel.textColor = [UIColor grayColor];
    upLabel.font = FONT(12);
    upLabel.text = title;
    
    UILabel *downLabel = [[UILabel alloc]initWithFrame:CGRectMake(frame.origin.x+10, frame.size.height/2, frame.size.width/2-10, frame.size.height/4)];
    downLabel.textColor = [UIColor grayColor];
    downLabel.font = FONT(16);
    downLabel.text = data;
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2+frame.origin.x, frame.origin.y+5, frame.size.width*2/5, frame.size.width*2/5)];
    imgView.image = image;
    
    [self addSubview:upLabel];
    [self addSubview:downLabel];
    [self addSubview:imgView];
    
}

@end
