//
//  CustomerPreferences.m
//  MLF
//
//  Created by 123456 on 2018/5/3.
//  Copyright © 2018年 123456. All rights reserved.
//

#import "CustomerPreferences.h"
#import "MLF-Bridging-Header.h"
#import "XAxisValueFormatter.h"

@interface CustomerPreferences () <ChartViewDelegate>

@property (nonatomic, weak) UIImageView *keyWordsImageView;

@property (nonatomic, weak) UIView *dongBeiDaBan;

@property (nonatomic, weak) UILabel *dongBeiDaBanLabel;

@property (nonatomic, weak) RadarChartView *radarChartView;

@end

@implementation CustomerPreferences


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    
}

- (void)initUI {

//    self.view.backgroundColor = [self colorWithHexString:@"#efefef"];
    
    // 图片那部分 需要插入图片
    // frame只用调 keyWordsImageView 的 Y
    UIImageView *keyWordsImageView = [[UIImageView alloc] init];
    keyWordsImageView.image = [UIImage imageNamed:@"keyWordImage.png"];
    self.keyWordsImageView = keyWordsImageView;
    keyWordsImageView.backgroundColor = [UIColor blackColor];
    keyWordsImageView.frame = CGRectMake(0, NAV_HEIGHT+20, ScreenW, ScreenH * 105 / 314);
    [self.view addSubview:keyWordsImageView];
    
    // 东北大板 背景View
    UIView *dongBeiDaBan = [[UIView alloc] init];
    self.dongBeiDaBan = dongBeiDaBan;
    dongBeiDaBan.frame = CGRectMake(0, CGRectGetMaxY(self.keyWordsImageView.frame) + ScreenH * 5 / 157, ScreenW, ScreenH * 105 / 314);
    dongBeiDaBan.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dongBeiDaBan];
    // 东北大板 Label
    UILabel *dongBeiDaBanLabel = [[UILabel alloc] init];
    self.dongBeiDaBanLabel = dongBeiDaBanLabel;
    dongBeiDaBanLabel.text = @"东北大板";
    dongBeiDaBanLabel.textAlignment = NSTextAlignmentCenter;
    dongBeiDaBanLabel.textColor = [UIColor lightGrayColor];
    dongBeiDaBanLabel.font = [UIFont systemFontOfSize:16];
    CGFloat dongBeiDaBanLabelW = [self adjustWidthToFitStrFontSize:16 andString:dongBeiDaBanLabel.text].width;
    CGFloat dongBeiDaBanLabelH = [self adjustWidthToFitStrFontSize:16 andString:dongBeiDaBanLabel.text].height;
    dongBeiDaBanLabel.frame = CGRectMake(ScreenH * 17 / 628, ScreenH * 17 / 628, dongBeiDaBanLabelW, dongBeiDaBanLabelH);
    [dongBeiDaBan addSubview:dongBeiDaBanLabel];
    

    // 雷达图
    RadarChartView *radarChartView = [[RadarChartView alloc] initWithFrame:CGRectMake((dongBeiDaBan.frame.size.width - ScreenH * 120 / 314) / 2, 0, ScreenH * 120 / 314, ScreenH * 120 / 314)];
    [dongBeiDaBan addSubview:radarChartView];
    self.radarChartView = radarChartView;
    radarChartView.backgroundColor = [UIColor clearColor];
    radarChartView.delegate = self;
    // 不可以转动
    radarChartView.rotationEnabled = YES;
    // 不可以被选中
    radarChartView.highlightPerTapEnabled = YES;
    // 设置线条宽度与颜色
    radarChartView.webLineWidth = 1;
    radarChartView.webColor = [UIColor lightGrayColor];
    radarChartView.innerWebLineWidth = 1;
    radarChartView.innerWebColor = [UIColor lightGrayColor];
//    radarChartView.webAlpha = 0.5;
    radarChartView.chartDescription.enabled = NO;
    
    
    // 设置X轴label样式
    ChartXAxis *xAxis = radarChartView.xAxis;
    xAxis.valueFormatter = [[XAxisValueFormatter alloc] init];
    xAxis.labelFont = [UIFont systemFontOfSize:13];
    xAxis.labelTextColor = [self colorWithHexString:@"#9ddeff"];
    // 设置Y轴样式
    ChartYAxis *yAxis = radarChartView.yAxis;
    yAxis.labelFont = [UIFont systemFontOfSize:10];
    yAxis.drawLabelsEnabled = NO;
    yAxis.axisMinValue = 0.0;
    yAxis.axisMaxValue = 100.0;
    yAxis.labelTextColor = [UIColor blueColor];
    
    radarChartView.legend.enabled = NO;
    
    
    radarChartView.data = [self setData];

    
    
    
}



// 提供数据
- (RadarChartData *)setData{
    
    int vals_count = 5;
    
//    NSArray *xVals = [NSArray arrayWithObjects:@"香草味", @"巧克力味", @"慕斯味", @"黑巧克力味", @"草莓味", nil];
    
    // 每个维度的名称或描述
    NSMutableArray *chartVals1 = [[NSMutableArray alloc] init];
    for (int i = 0; i < vals_count; i++) {
        
        double partValue = arc4random() % 70 + 30;
        
        RadarChartDataEntry *entry = [[RadarChartDataEntry alloc] initWithValue:partValue];
        [chartVals1 addObject:entry];
    }
    
    // 创建 RadarChartDataSet 对象
    RadarChartDataSet *set1 = [[RadarChartDataSet alloc] initWithValues:chartVals1 label:@"顾客偏好"];
    
    // 设置数据块
    set1.lineWidth = 0.5;
    [set1 setColor:[self colorWithHexString:@"#9ddeff"]];
    set1.drawFilledEnabled = YES;
    set1.fillColor = [self colorWithHexString:@"#9ddeff"];
    set1.fillAlpha = 0.5;
    
    // 设置数据块折点样式
    set1.drawHighlightCircleEnabled = NO;
    set1.highlightCircleStrokeColor = [UIColor greenColor];
    [set1 setDrawHighlightIndicators:NO];
    
    // 设置显示数据
    set1.drawValuesEnabled = NO;
    set1.valueFont = [UIFont systemFontOfSize:9];
    set1.valueTextColor = [UIColor grayColor];
    
    // 创建 RadarChartData 对象, 此对象就是 PieChartData 需要最终数据对象
    RadarChartData *data = [[RadarChartData alloc] initWithDataSets:@[set1]];
    [data setValueFont:[UIFont systemFontOfSize:15]];
    [data setValueTextColor:[UIColor brownColor]];
    
    // 统一数据显示格式
    ChartDefaultValueFormatter *formatter = [[ChartDefaultValueFormatter alloc] init];// 统一设置数据显示的格式
    [data setValueFormatter:formatter];
    
    return data;

}


- (CGSize)adjustWidthToFitStrFontSize:(CGFloat)font andString:(NSString *)str
{
    NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    return [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}

- (UIColor *)colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length ]< 6) {
        return [UIColor clearColor];
    }
    
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        return [UIColor clearColor];
    }
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
    
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
