//
//  CircleView.m
//  CodeCube-Business
//
//  Created by apple on 2018/5/2.
//  Copyright © 2018年 lab. All rights reserved.
//

#import "CircleView.h"

@interface CircleView()<CAAnimationDelegate>

@property (nonatomic, strong) NSMutableArray *dots;
@property (nonatomic, strong, readwrite) UILabel *contentLabel;

@end


@implementation CircleView
#pragma mark - lazy Load

- (NSMutableArray *)dots {
    if (!_dots) {
        _dots = [[NSMutableArray alloc] init];
    }
    return _dots;
}

#pragma mark - init Method

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaultParameter];
        [self initUI];
        [self layoutUI];
    }
    return self;
}

- (void)setDefaultParameter {
    self.backgroundColor = [UIColor clearColor];
    self.innerRingWidth = 15;
    self.outerRingWidth = 2;
    self.ringMargin = 5;
    self.dotMargin = 10;
    self.dotSize = CGSizeMake(5, 5);
    self.hideDot = NO;
    self.animate = YES;
    self.animateDuration = 0.5;
}

- (void)initUI {
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.alpha = 0;
    [self addSubview:self.contentLabel];
}

#pragma mark - layout Method

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self layoutUI];
}

- (void)layoutUI {
    CGFloat minValue = MIN(self.bounds.size.width - 60, self.bounds.size.height - 60);
    CGFloat contentLabelWidth = minValue - 2 * (self.innerRingWidth + self.outerRingWidth + self.ringMargin);
    CGFloat contentLabelHeight = contentLabelWidth;
    self.contentLabel.frame = CGRectMake(11, 11, contentLabelWidth, contentLabelHeight);
    self.contentLabel.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);;
    self.contentLabel.layer.cornerRadius = contentLabelWidth * 0.5;
    self.contentLabel.layer.masksToBounds = YES;
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.contentLabel.backgroundColor = [UIColor whiteColor];
    self.contentLabel.numberOfLines = 0;
}

#pragma mark - drawRect

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.chartItems.count <= 0) {
        return;
    }
    
    // to tighten
    CGFloat innerRingRadius = (self.contentLabel.bounds.size.width + self.innerRingWidth) * 0.5;
    CGFloat outerRingRadius = innerRingRadius + self.innerRingWidth * 0.5 + self.ringMargin + self.outerRingWidth * 0.5;
    CGPoint centerPoint = self.contentLabel.center;
    CGFloat startAngle = 0;
    CGFloat endAngle = 0;
    
    // total sum
    NSMutableArray *values = [[NSMutableArray alloc] init];
    for (ChartItem *item in self.chartItems) {
        [values addObject:item.value];
    }
    CGFloat totalValue = [[values valueForKeyPath:@"@sum.doubleValue"] doubleValue];
    CGFloat percent = 1 / totalValue;
    
    // draw inner ring and outer ring
    for (NSInteger i = 0; i < self.chartItems.count; i++) {
        startAngle = endAngle;
        endAngle = startAngle + percent * M_PI * 2 * [self.chartItems[i].value doubleValue];
        CGFloat radianCenter = (startAngle + endAngle) * 0.5;
        ChartItem *item = self.chartItems[i];
        
        // outer ring
        CAShapeLayer *outerRingLayer = [self drawRingWithArcCenter:centerPoint radius:outerRingRadius startAngle:startAngle endAngle:endAngle lineWidth:self.outerRingWidth item:item];
        
        // inner ring
        CAShapeLayer *innerRingLayer = [self drawRingWithArcCenter:centerPoint radius:innerRingRadius startAngle:startAngle endAngle:endAngle lineWidth:self.innerRingWidth item:item];
        
        // animation
        CABasicAnimation *basicAnimation = [self makeAnimation];
        
        // draw dot
        UIView *dotView = [self drawDotWithOuterRingRadius:outerRingRadius radianCenter:radianCenter centerPoint:centerPoint item:item];
        
        // property control
        if (self.hideDot) {
            dotView.hidden = YES;
        } else {
            dotView.hidden = NO;
        }
        if (self.animate) {
            [innerRingLayer addAnimation:basicAnimation forKey:@"basicAnimation"];
            [outerRingLayer addAnimation:basicAnimation forKey:@"basicAnimation"];
        } else {
            self.contentLabel.alpha = 1;
            dotView.alpha = 1;
        }
    }
}

#pragma mark - inner method

- (CAShapeLayer *)drawRingWithArcCenter:(CGPoint)centerPoint radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle lineWidth:(CGFloat)lineWidth item:(ChartItem *)item {
    UIBezierPath *ringPath = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    CAShapeLayer *ringLayer = [CAShapeLayer layer];
    ringLayer.strokeColor = item.color.CGColor;
    ringLayer.fillColor = [UIColor clearColor].CGColor;
    ringLayer.lineWidth = lineWidth;
    ringLayer.path = ringPath.CGPath;
    [self.layer addSublayer:ringLayer];
    return ringLayer;
}

- (UIView *)drawDotWithOuterRingRadius:(CGFloat)outerRingRadius radianCenter:(CGFloat)radianCenter centerPoint:(CGPoint)centerPoint item:(ChartItem *)item {
    CGFloat radianCenterX = centerPoint.x + (outerRingRadius + self.outerRingWidth * 0.5) * cos(radianCenter);
    CGFloat radianCenterY = centerPoint.y + (outerRingRadius + self.outerRingWidth * 0.5) * sin(radianCenter);
    CGFloat startX = radianCenterX + self.dotMargin * cos(radianCenter);
    CGFloat startY = radianCenterY + self.dotMargin * sin(radianCenter);
    
    CGFloat offset = -self.dotSize.width * 0.5;
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = item.color;
    view.alpha = 0;
    CGRect rect = view.frame;
    rect.size = self.dotSize;
    rect.origin = CGPointMake(startX + offset, startY + offset);
    view.frame = rect;
    view.layer.cornerRadius = -offset;
    view.layer.masksToBounds = YES;
    [self addSubview:view];
    [self.dots addObject:view];
    return view;
}

- (CABasicAnimation *)makeAnimation {
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    basicAnimation.delegate = self;
    basicAnimation.fromValue = @(0);
    basicAnimation.toValue = @(1);
    basicAnimation.duration = self.animateDuration;
    basicAnimation.fillMode = kCAFillModeForwards;
    return basicAnimation;
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [UIView animateWithDuration:0.25 animations:^{
        self.contentLabel.alpha = 1;
        [self.dots enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.alpha = 1;
        }];
    }];
}

@end


@implementation ChartItem


@end
