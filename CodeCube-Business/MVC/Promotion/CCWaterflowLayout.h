//
//  CCWaterflowLayout.h
//  有余
//
//  Created by 天真 on 2017/12/27.
//  Copyright © 2017年 zyc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCWaterflowLayout;

@protocol CCWaterFlowLayoutDelegate <NSObject>
@required

- (CGFloat)waterflowLayout:(CCWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
- (CGFloat)columnCountInWaterflowLayout:(CCWaterflowLayout *)waterflowLayout;

- (CGFloat)columnMarginInWaterflowLayout:(CCWaterflowLayout *)waterflowLayout;

- (CGFloat)rowMarginInWaterflowLayout:(CCWaterflowLayout *)waterflowLayout;

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(CCWaterflowLayout *)waterflowLayout;
@end

@interface CCWaterflowLayout : UICollectionViewLayout

@property (nonatomic, weak) id<CCWaterFlowLayoutDelegate> delegate;

@end
