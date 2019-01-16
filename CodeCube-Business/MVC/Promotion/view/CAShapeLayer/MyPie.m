//
//  MyPie.m
//  QiuDouMaDai
//
//  Created by 王威 on 2016/12/21.
//  Copyright © 2016年 王威. All rights reserved.
//

#import "MyPie.h"
#import "JXCircleModel.h"

/*! 白色圆的半径 */
static CGFloat const whiteCircleRadius = 25.0;
/*! 指引线的小圆 */
static CGFloat const smallCircleRadius = 4.0;
/*! 指引线的文字字体大小 */
static CGFloat const nameTextFont = 10.0;
/*! 指引线的宽度 */
static CGFloat const lineWidth = 60.0;
/*! 折线的宽度 */
static CGFloat const foldLineWidth = 10.0;

#define degreesToRadian(x) ( 180.0 / PI * (x))

@implementation MyPie{
    CGFloat percentage;
}
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.sliceLayerArray=[[NSMutableArray alloc]init];
//        self.textArray=[[NSMutableArray alloc]init];
//        self.colorArray=[[NSMutableArray alloc]init];
//        self.textColorr=[[NSMutableArray alloc]init];
    }
    return self;
}
//画线
-(void)addLineAndnumber:(UIColor *)color
        andCGContextRef:(CGContextRef)ctx
                   andX:(CGFloat)x
                   andY:(CGFloat)y
                 andInt:(int)n
                 angele:(CGFloat)angele{
    
    // 1.小圆的圆心
    CGFloat smallCircleCenterPointX = x;
    CGFloat smallCircleCenterPointY = y;
    
    
    // 2.折点
    CGFloat lineLosePointX = 0.0 ; //指引线的折点
    CGFloat lineLosePointY = 0.0 ; //
    
    // 3.指引线的终点
    CGFloat lineEndPointX ; //
    CGFloat lineEndPointY ; //
    
    // 4.数字的起点
    CGFloat numberStartX;
    CGFloat numberStartY;
    
    // 5.文字的起点
    CGFloat textStartX;
    CGFloat textStartY;
    
    // 6.数字的长度
    JXCircleModel *model = self.dataArray[n];
    NSString *number = model.number;
    CGSize numberSize = [number sizeWithAttributes:@{
                                                     NSFontAttributeName:[UIFont systemFontOfSize:16.0]
                                                     }];
    
    // 文字size
    CGSize textSize = [model.name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:nameTextFont]}];
    
    
    // 设置折点
    lineLosePointX = smallCircleCenterPointX + foldLineWidth * cos(angele);
    lineLosePointY = smallCircleCenterPointY + foldLineWidth * sin(angele);
    
    
    // 7.画小圆
    if (smallCircleCenterPointX > self.bounds.size.width * 0.5) {
        
        // 指引线终点
        lineEndPointX = lineLosePointX + lineWidth;
        lineEndPointY = lineLosePointY;
        
        // 数字
        numberStartX = lineEndPointX - numberSize.width;
        numberStartY = lineEndPointY - numberSize.height;
        
        // 文字
        textStartX = lineEndPointX - textSize.width;
        textStartY = lineEndPointY;
        
    }else{
        
        // 指引线终点
        lineEndPointX = lineLosePointX - lineWidth;
        lineEndPointY = lineLosePointY;
        
        // 数字
        numberStartX = lineEndPointX;
        numberStartY = lineEndPointY - numberSize.height;
        
        // 文字
        textStartX = lineEndPointX;
        textStartY = lineEndPointY;
        
    }
    
    // 8.画小圆
    /*!创建圆弧
     参数：
     center->圆点
     radius->半径
     startAngle->起始位置
     endAngle->结束为止
     clockwise->是否顺时针方向
     */
    
    //    UIBezierPath *arcPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(smallCircleCenterPointX, smallCircleCenterPointY) radius:smallCircleRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    //
    //    [color set];
    //    // 填充
    //    [arcPath fill];
    //    // 描边，路径创建需要描边才能显示出来
    //    [arcPath stroke];
    
    // 9.画指引线
    CGContextBeginPath(ctx);
    
    CGContextMoveToPoint(ctx, smallCircleCenterPointX, smallCircleCenterPointY);
    
    CGContextAddLineToPoint(ctx, lineLosePointX, lineLosePointY);
    CGContextAddLineToPoint(ctx, lineEndPointX, lineEndPointY);
    CGContextSetLineWidth(ctx, 1);
    
    //填充颜色
    CGContextSetFillColorWithColor(ctx , color.CGColor);
    CGContextStrokePath(ctx);
    
    // 10.画指引线上的数字
    [model.number drawAtPoint:CGPointMake(numberStartX, numberStartY) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0],NSForegroundColorAttributeName:color}];
    
    // 11.画指引线下的文字
    // 11.1设置段落风格
    NSMutableParagraphStyle * paragraph = [[NSMutableParagraphStyle alloc]init];
    paragraph.alignment = NSTextAlignmentRight;
    
    if (lineEndPointX < [UIScreen mainScreen].bounds.size.width / 2.0) {
        paragraph.alignment = NSTextAlignmentLeft;
    }
    
    [model.name drawInRect:CGRectMake(textStartX, textStartY, textSize.width, textSize.height) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:nameTextFont],NSForegroundColorAttributeName:color,NSParagraphStyleAttributeName:paragraph}];
    
    
}
-(void)setDataArray:(NSArray *)dataArray{
    _dataArray=dataArray;
    CGFloat startAngle=0;
    CGFloat endAngle=0;
    for (int i=0; i<dataArray.count; i++) {
        percentage=[dataArray[i] floatValue];
        CGFloat angle=percentage*M_PI*2;
        endAngle=angle+startAngle;
        WWShapeLayer *shaperLayer=[WWShapeLayer layer];
        shaperLayer.startAngle=startAngle;
        shaperLayer.endAngle=endAngle;
        shaperLayer.radius=100.0f;
        shaperLayer.centerPoint=CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        shaperLayer.tag=i;
        shaperLayer.fullColor=[UIColor colorWithRed:arc4random()%200/255.0 green:arc4random()%200/255.0 blue:arc4random()%255/255.0 alpha:1];
//        shaperLayer.fullColor=(__bridge UIColor *)([_colorArray[i] color]);
        [shaperLayer creat];
        [self.layer addSublayer:shaperLayer];
        [self.sliceLayerArray addObject:shaperLayer];
        CATextLayer *textLayer=[CATextLayer layer];
        textLayer.frame = CGRectMake(shaperLayer.centerPoint.x + cosf((startAngle + endAngle) / 2) * 70 - 15, shaperLayer.centerPoint.y + sinf((startAngle + endAngle) / 2) * 70 - 10, 40, 20);
        textLayer.string = [NSString stringWithFormat:@"%1.f%%", percentage * 100];
        textLayer.foregroundColor = COLOR_TAB.CGColor;
        shaperLayer.text=_textArray[i];
        textLayer.fontSize=14.0f;
        textLayer.contentsScale=2;
//        textLayer.foregroundColor=[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1].CGColor;
//        textLayer.foregroundColor=[UIColor whiteColor].CGColor;
//        textLayer.foregroundColor=[_textColorr[i] color];
        [shaperLayer addSublayer:textLayer];
        startAngle =endAngle;
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    for (WWShapeLayer *shapeLayer in _sliceLayerArray) {
        //判断选择区域
        if (CGPathContainsPoint(shapeLayer.path, 0, touchPoint, YES)) {
            shapeLayer.seclected = YES;
            [self.delegate touchTheShapeLayer:shapeLayer];
        } else {
            shapeLayer.seclected = NO;
        }
    }
}
@end
