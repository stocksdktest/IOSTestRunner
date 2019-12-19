/////////////////////////////////////////////////////////
//                                                     //
// Copyright (c) 2016年 上证云平台. All rights reserved. //
//                                                     //
/////////////////////////////////////////////////////////


#import <UIKit/UIKit.h>

#pragma mark - 图型化接口

/** 注册查价线开始查询时的NotificationKey */
extern NSString * const MChartDidStartEnquiryNotification;
/** 注册查价线结束查询时的NotificationKey */
extern NSString * const MChartDidEndEnquiryNotification;

/** 注册基金净值查价线开始查询时的NotificationKey */
extern NSString * const MFundValueDidStartEnquiryNotification;
/** 注册基金净值查价线结束查询时的NotificationKey */
extern NSString * const MFundValueDidEndEnquiryNotification;

/** 通知的原对象*/
extern NSString * const MChartViewTargetNotificationInfoKey;

typedef NS_OPTIONS(NSInteger, MChartEnquiryLineMode) {
    MChartEnquiryLineModeNone = 1 << 0,
    MChartEnquiryLineModeSticky = 1 << 1,
    
    MChartEnquiryLineModeNotToDisappear = 1 << 10,
    MChartEnquiryLineModeDelayDisappear = 1 << 11,
    
    MChartEnquiryLineModeDelayAppear = 1 << 20,
    MChartEnquiryLineModeAppearImmediately = 1 << 21
};


#pragma mark - 线图父类

@class MStockItem;

/*! @brief 线图父类别
 */
@interface MChartView : UIView
/** 股票代码(包含市场别) 如：000001.sh */
@property (nonatomic, copy) NSString *code;
/** y轴文字风格 */
@property (nonatomic, strong) UIFont *yAxisFont;
/** x轴文字风格 */
@property (nonatomic, strong) UIFont *xAxisFont;
/** x轴文字颜色 */
@property (nonatomic, strong) UIColor *xAxisTextColor;
/** 外框线宽px */
@property (nonatomic, assign) CGFloat borderWidth;
/** 外框颜色 */
@property (nonatomic, strong) UIColor *borderColor;
/** 内部线宽px */
@property (nonatomic, assign) CGFloat insideLineWidth;
/** 内部线颜色 */
@property (nonatomic, strong) UIColor *insideLineColor;
/** 是否可使用查价线, 默认 YES */
@property (nonatomic, assign) BOOL enquiryEnabled;
/** 查价线颜色 */
@property (nonatomic, readwrite) UIColor *enquiryLineColor;
/** 查价线外框颜色 */
@property (nonatomic, readwrite) UIColor *enquiryFrameColor;
/** 查价线文字风格 */
@property (nonatomic, readwrite) UIFont *enquiryTextFont;
/** 查价线文字颜色 */
@property (nonatomic, readwrite) UIColor *enquiryTextColor;
/** 查价线模式, 默认 MChartEnquiryLineModeSticky */
@property (nonatomic, assign) MChartEnquiryLineMode enquiryLineMode;

@property (nonatomic, strong) NSDictionary *options;
@property (nonatomic, assign) UIEdgeInsets yAxisLabelInsets;

@property (nonatomic, assign) NSTimeInterval delayEndEnquireTimeInterval;


/*! @brief 刷新线图
 *
 * 包含请求数据及计算指标。
 */
- (void)reloadData;
- (void)reloadDataWithStockItem:(MStockItem *)stockItem;

@end

@interface MChartView4Trend : MChartView
/** 渐层颜色位置 */
@property (nonatomic, readwrite) CGFloat *gradientLocations;

@end

#pragma mark - 走势图

typedef NS_ENUM(NSInteger, MTrendChartType) {
    MTrendChartTypeOneDay,
    MTrendChartTypeFiveDays,
};

@interface MChartDotView : UIView
@property (nonatomic, strong) UIColor *color;
+ (MChartDotView *)blinkDot;
@end

/*! @brief 走势图
 */
__attribute__((deprecated("已弃用, 使用MOHLCChartView")))
@interface MTrendChartView : MChartView4Trend
/** 走势图类型 @see MTrendChartType */
@property (nonatomic, assign) MTrendChartType type;
/** 价格涨文字颜色 */
@property (nonatomic, strong) UIColor *priceRiseTextColor;
/** 价格平盘文字颜色 */
@property (nonatomic, strong) UIColor *priceFlatTextColor;
/** 价格跌文字颜色 */
@property (nonatomic, strong) UIColor *priceDropTextColor;
/** 价格涨幅文字颜色 */
@property (nonatomic, strong) UIColor *rangeRiseTextColor;
/** 价格幅度平盘文字颜色 */
@property (nonatomic, strong) UIColor *rangeFlatTextColor;
/** 价格跌幅文字颜色 */
@property (nonatomic, strong) UIColor *rangeDropTextColor;
/** 量文字颜色 */
@property (nonatomic, strong) UIColor *volumeTextColor;
/** 价格线颜色 */
@property (nonatomic, strong) UIColor *currentLineColor;
/** 价格线宽px */
@property (nonatomic, assign) CGFloat currentLineWidth;
/** 均价线颜色 */
@property (nonatomic, strong) UIColor *averageLineColor;
/** 均价线宽px */
@property (nonatomic, assign) CGFloat averageLineWidth;
/** 量涨颜色 */
@property (nonatomic, strong) UIColor *volumeRiseColor;
/** 量跌颜色 */
@property (nonatomic, strong) UIColor *volumeDropColor;
/** 基金净值线颜色 */
@property (nonatomic, strong) UIColor *IOPVLineColor;
/** 基金净值线宽px */
@property (nonatomic, assign) CGFloat IOPVLineWidth;
/** 渐层颜色 */
@property (nonatomic, strong) NSArray *gradientColors;
/** 最后一个报价发亮点 */
@property (nonatomic, strong) UIView *lastBlinkDot;
/** MChartEnquiryLineModeNone模式下 查价线中心偏移量 */
@property (nonatomic, assign) CGPoint enquiryLocationOffset;


@end


#pragma mark - k线图

@class MPlot, MMAPlot;
typedef NS_ENUM(NSInteger, MOHLCChartType) {
    MOHLCChartTypeDay,
    MOHLCChartTypeWeek,
    MOHLCChartTypeMonth,
    MOHLCChartTypeMin5,
    MOHLCChartTypeMin15,
    MOHLCChartTypeMin30,
    MOHLCChartTypeMin60,
    MOHLCChartTypeMin120,
    MOHLCChartTypeMin1,
    MOHLCChartTypeYear
};


typedef NS_ENUM(NSInteger, MOHLCChartPriceAdjustedMode) {
    MOHLCChartPriceAdjustedModeNone,
    MOHLCChartPriceAdjustedModeForward,
    MOHLCChartPriceAdjustedModeBackward
};

typedef NS_ENUM(NSInteger, MOHLCChartEnquiryLineMovingDirection) {
    MOHLCChartEnquiryLineMovingDirectionLeft,
    MOHLCChartEnquiryLineMovingDirectionRight
};

typedef NS_ENUM(NSInteger,MOHLCChartLongitudinalLatitude) {
    MOHLCChartLongitudinalLatitudeNone = 0,
    MOHLCChartLongitudinalLatitudeOneMonth = 1,
    MOHLCChartLongitudinalLatitudeThreeMonth = 3,
    MOHLCChartLongitudinalLatitudeOneYear = 12,
};
typedef NS_ENUM(NSInteger,MOHLCChartXAxisTextLocation) {
    MOHLCChartXAxisTextLocationBottom,
    MOHLCChartXAxisTextLocationCenter,
};

extern NSString * const MOHLCChartViewPreviousItemNotificationInfoKey;

@protocol MChartBorderTheme;
@class MChartTheme;

@interface MOHLCScrollableGraphView : UIScrollView

@end

/*! @brief k线图
 */
@interface MOHLCChartView : MChartView
/** 主图当前索引值 */
@property (nonatomic, assign) NSUInteger majorPlotIndex;
/** 副图当前索引值 */
@property (nonatomic, assign) NSUInteger minorPlotIndex;
/** 主图左边按钮 */
@property (nonatomic, strong) NSArray *majorPlotLeftButtons;
/** 主图右边按钮 */
@property (nonatomic, strong) NSArray *majorPlotRightButtons;
/** 副图左边按钮 */
@property (nonatomic, strong) NSArray *minorPlotLeftButtons;
/** 副图右边按钮 */
@property (nonatomic, strong) NSArray *minorPlotRightButtons;
/** 主图plot数组, 详见MPlot */
@property (nonatomic, readwrite) NSArray *majorPlots;
/** 副图plot数组, 详见MPlot */
@property (nonatomic, readwrite) NSArray *minorPlots;
/** 主图实例 */
@property (nonatomic, readonly) MOHLCScrollableGraphView *majorGraphView;
/** 副图实例 */
@property (nonatomic, readonly) MOHLCScrollableGraphView *minorGraphView;
/** y轴文字颜色 */
@property (nonatomic, strong) UIColor *yAxisTextColor;
/** 副图工具栏是否悬浮在副图上 默认为NO */
@property (nonatomic, assign) BOOL isMinorToorBarSuspended;
/** 框线风格 */
@property (nonatomic, strong) __kindof MChartTheme<MChartBorderTheme> *theme;
/** 加载提示颜色 */
@property (nonatomic, strong) UIColor *indicatorColor;
/** 主图设定按钮 */
@property (nonatomic, strong) UIButton *majorPlotSettingButton __attribute__((deprecated("请改用majorPlotLeftButtons")));
/** 主图切换索引按钮 */
@property (nonatomic, strong) UIButton *majorPlotChangeIndexButton __attribute__((deprecated("请改用majorPlotLeftButtons")));
/** 主图切换前后复权按钮 */
@property (nonatomic, strong) UIButton *majorPlotPriceAdjustedButton __attribute__((deprecated("请改用majorPlotLeftButtons")));
/** 副图切换索引按钮 */
@property (nonatomic, strong) UIButton *minorPlotChangeIndexButton __attribute__((deprecated("请改用minorPlotLeftButtons")));
/** k棒是否填充  默认 NO */
@property (nonatomic, readwrite) BOOL barFill __attribute__((deprecated("请改用MPlot单独设置")));
/** x轴时间坐标显示的位置 */
@property (nonatomic, readwrite) MOHLCChartXAxisTextLocation xAxisTextLocation __attribute__((deprecated("请改用MChartTheme")));
/// 纵向纬度
@property (nonatomic, readwrite) MOHLCChartLongitudinalLatitude longitudinalLatitude __attribute__((deprecated("请改用MOHLCChartTheme")));
/** 设置画面k棒笔数，默认为20 */
@property (nonatomic, assign) NSUInteger numberOfVisibleRecords __attribute__((deprecated("请改用MOHLCChartTheme")));
/** 设置缩放时最少显示k棒笔数，默认为10 */
@property (nonatomic, assign) NSUInteger numberOfMinimumVisibleRecords __attribute__((deprecated("请改用MOHLCChartTheme")));
/** k线图类型 @see MOHLCChartType */
@property (nonatomic, assign) MOHLCChartType type __attribute__((deprecated("请改用MOHLCPlot")));
/** 复权模式 默认不复权 */
@property (nonatomic, assign) MOHLCChartPriceAdjustedMode priceAdjustedMode __attribute__((deprecated("请改用MOHLCPlot")));
/** 是否可滚动  默认 YES */
@property (nonatomic, assign) BOOL scrollEnabled __attribute__((deprecated("请改用MOHLCChartTheme")));
/** 是否可缩放  默认 YES */
@property (nonatomic, assign) BOOL zoomEnabled __attribute__((deprecated("请改用MOHLCChartTheme")));

/*! @brief 加入主图
 *
 * 设置主图，需为MMAPlot子类
 * @param plot 主图实例
 */
- (void)addMajorPlot:(MMAPlot *)plot;
- (void)addMajorPlots:(MMAPlot *)plots, ...;

/*! @brief 加入副图
 *
 * 设置附图，需为MPlot子类
 * @param plot 副图实例
 */
- (void)addMinorPlot:(MPlot *)plot;
- (void)addMinorPlots:(MPlot *)plots, ...;

- (void)moveEnquiryLineToDirection:(MOHLCChartEnquiryLineMovingDirection)direction;
@end


#pragma mark - 基金净值走势图

/*! @brief 净值走势图
 */
@interface MFundChartView : MChartView4Trend
/** 价格涨文字颜色 */
@property (nonatomic, strong) UIColor *priceRiseTextColor;
/** 价格平盘文字颜色 */
@property (nonatomic, strong) UIColor *priceFlatTextColor;
/** 价格跌文字颜色 */
@property (nonatomic, strong) UIColor *priceDropTextColor;
/** 价格涨幅文字颜色 */
@property (nonatomic, strong) UIColor *rangeRiseTextColor;
/** 价格幅度平盘文字颜色 */
@property (nonatomic, strong) UIColor *rangeFlatTextColor;
/** 价格跌幅文字颜色 */
@property (nonatomic, strong) UIColor *rangeDropTextColor;
/** 价格线颜色 */
@property (nonatomic, strong) UIColor *currentLineColor;
/** 价格线宽px */
@property (nonatomic, assign) CGFloat currentLineWidth;
/** 渐层颜色 */
@property (nonatomic, strong) NSArray *gradientColors;
/** 开始时间 */
@property (nonatomic, copy) NSString *startTime;
/** 结束时间 */
@property (nonatomic, copy) NSString *endTime;
/** MChartEnquiryLineModeNone模式下 查价线中心偏移量 */
@property (nonatomic, assign) CGPoint enquiryLocationOffset;

/*! @brief 获取净值数组
 *
 * 一年内所有净值信息
 */
- (NSArray *)getALLFundValue;

@end

#pragma mark - 图型物件
@class MOHLCItem;
@protocol MPlotDrawDelegate <NSObject>

@optional
/*! @brief 线图绘制代理函数，部分plot支持
 *
 * @param plot 指标实例
 * @param rect 整个指标的绘制区间
 * @param recordIndex 绘图数据的起始位置
 * @param numberOfVisibleRecords 当前屏幕显示的数据条数
 * @param items 数据
 *
 */
- (void)plot:(MPlot *)plot
willdrawRect:(CGRect)rect
atRecordIndex:(NSInteger)recordIndex
numberOfVisibleRecords:(NSInteger)numberOfVisibleRecords
       items:(NSArray<MOHLCItem *>*)items;

/*! @brief 线图绘制代理函数，部分plot支持
 *
 * @param plot 指标实例；通过plot类型的判断，可以在指点的指标中绘制自定义的标识
 * @param rect 整个指标的绘制区间；此区间仅为主图或幅图当前plot指标线条绘制所在的区间
 * @param context 图形上下文
 * @param recordIndex 当前绘制数据索引；结合items数组可以获取当前绘制的数据信息
 * @param recordRect 当前绘制数据所在区间；如果是K线指标recordRect.size.width为K棒宽度，如果是其它走势指标recordRect.size.width为1。
 * @param maxValue 区间最大值；最大值，结合最小值、rect的高度可以计算出纵坐标比率
 * @param minValue 区间最小值；最大值，结合最小值、rect的高度可以计算出纵坐标比率
 * @param items 数据
 *
 事例代码：在K线MMAPlot指标每根K棒的上面画一个方形
 - (void)plot:(MPlot *)plot drawRect:(CGRect)rect inContext:(CGContextRef)context atRecordIndex:(NSInteger)recordIndex recordRect:(CGRect)recordRect withMaxValue:(double)maxValue minValue:(double)minValue items:(NSArray<MOHLCItem *> *)items {
 if (recordIndex < 0 || recordIndex >= items.count) {
 return;
 }
 if ([plot isKindOfClass:[MMAPlot class]]) {
 CGContextSaveGState(context);
 MOHLCItem *item = items[recordIndex];
 double hight = item.highPrice.doubleValue;
 double scale = rect.size.height/(maxValue - minValue);
 CGRect drawRect = CGRectMake(recordRect.origin.x, (rect.origin.y + (maxValue - hight)*scale) - 10, recordRect.size.width, 10); -10 是因为高度是10 ，y坐标上调10
 CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
 CGContextFillRect(context, drawRect);
 CGContextRestoreGState(context);
 }
 }
 */
- (void)plot:(MPlot *)plot
    drawRect:(CGRect)rect
   inContext:(CGContextRef)context
atRecordIndex:(NSInteger)recordIndex
  recordRect:(CGRect)recordRect
withMaxValue:(double)maxValue
    minValue:(double)minValue
       items:(NSArray<MOHLCItem *>*)items;
@end

@interface MPlot : NSObject
/** 图型标题 */
@property (nonatomic, readonly) NSString *title;
/** 当前画面显示根数 */
@property (nonatomic, readonly) NSUInteger numberOfVisibleRecords;
/** 其他参数 */
@property (nonatomic, strong) NSDictionary *options;
/** 绘制代理，可以线图中自定义绘制 */
@property (nonatomic, weak) id<MPlotDrawDelegate> drawDelegate;

/*! @brief 初始化
 *
 * 初始化并设置y轴Label个数
 * @param yAxisLabelCount y轴Label个数
 */
- (instancetype)initWithYAxisLabelCount:(NSInteger)yAxisLabelCount;

/*! @brief 重新绘制
 *
 * 重新计算并绘制
 */
- (void)redraw;

/*! @brief 设置参数
 *
 * 设置参数请参照各指标参数文档
 * @notice 必须以 nil 结尾
 *
 * @param param 参数值
 */
- (void)setParameters:(NSUInteger)param, ...;

/*! @brief 设置参数
 *
 * 设置参数请参照各指标参数文档
 * @param params 参数值数组
 */
- (void)setParametersFromArray:(NSArray *)params;

/*! @brief 设置线的颜色
 *
 * 设置线的颜色，与参数成对
 * @param color 线颜色
 */
- (void)setLineColors:(UIColor *)color, ...;
- (void)setLineColorsFromArray:(NSArray *)colors;

/*! @brief 设置全局线的颜色
 *
 * 设置线的颜色，与参数成对
 * @param color 线颜色
 */
+ (void)setDefaultLineColors:(UIColor *)color, ...;

@end


#pragma mark - OHLC

@interface MOHLCPlot : MPlot
/** k线图类型 @see MOHLCChartType */
@property (nonatomic, assign) MOHLCChartType type;
/** 复权模式 默认不复权 */
@property (nonatomic, assign) MOHLCChartPriceAdjustedMode priceAdjustedMode;
/** k棒是否填充 */
@property (nonatomic, assign) BOOL barFill;
/** 复权标记 */
@property (nonatomic, strong) UIImage *priceAdjustedImage;
/** 最新价线是否隐藏，默认YES */
@property (nonatomic, assign) BOOL lastPriceLineHidden;
/** 最新价线颜色 */
@property (nonatomic, strong) UIColor *lastPriceLineColor;
/** 最新价线宽px */
@property (nonatomic, assign) CGFloat lastPriceLineWidth;
/** 虚线间隔 不传，默认实线 例:(CGFloat []){3,1}*/
@property (nonatomic, readwrite) CGFloat *lastPriceLineDash;
- (instancetype)initWithYAxisLabelCount:(NSInteger)yAxisLabelCount
                                barFill:(BOOL)barFill;

@end


#pragma mark - MA

@interface MMAPlot : MOHLCPlot

/** 是否隐藏k棒, 默认NO */
@property (nonatomic, assign, getter=isKBarHidden) BOOL kBarHidden;
/** k棒平盘颜色 */
@property (nonatomic, strong) UIColor *flatColor;
/** k棒涨颜色 */
@property (nonatomic, strong) UIColor *riseColor;
/** k棒跌颜色 */
@property (nonatomic, strong) UIColor *dropColor;

@end


#pragma mark - BOLL
@interface MBOLLPlot : MMAPlot
@end


#pragma mark - VOL
@interface MVOLPlot : MPlot
/** k棒是否填充 */
@property (nonatomic, assign) BOOL barFill;
/** k棒平盘颜色 */
@property (nonatomic, strong) UIColor *flatColor;
/** k棒涨颜色 */
@property (nonatomic, strong) UIColor *riseColor;
/** k棒跌颜色 */
@property (nonatomic, strong) UIColor *dropColor;
/** 虚拟成交量*/
@property (nonatomic, assign) double vitualVolume;

- (instancetype)initWithYAxisLabelCount:(NSInteger)yAxisLabelCount
                                barFill:(BOOL)barFill;
@end

#pragma mark - AMO
@interface MAMOPlot : MVOLPlot
@end

#pragma mark - RSI
@interface MRSIPlot : MPlot

@end

#pragma mark - KDJ
@interface MKDJPlot : MPlot

@end

#pragma mark - MACD
@interface MMACDPlot : MOHLCPlot
/** 涨颜色 */
@property (nonatomic, strong) UIColor *riseColor;
/** 跌颜色 */
@property (nonatomic, strong) UIColor *dropColor;
@end

#pragma mark - BIAS
@interface MBIASPlot : MPlot

@end

#pragma mark - CCI

@interface MCCIPlot : MPlot

@end

#pragma mark - WR

@interface MWRPlot : MPlot

@end


#pragma mark - AR

@interface MARPlot : MPlot

@end

#pragma mark - BBI

@interface MBBIPlot : MPlot

@end

#pragma mark - BR

@interface MBRPlot : MPlot

@end

#pragma mark - KD

@interface MKDPlot : MPlot

@end

#pragma mark - DMI

@interface MDMIPlot : MPlot

@end

#pragma mark - PSY

@interface MPSYPlot : MPlot

@end

#pragma mark - OBV

@interface MOBVPlot : MPlot

@end

#pragma mark - MTM

@interface MMTMPlot : MPlot

@end

#pragma mark - VR

@interface MVRPlot : MPlot

@end

#pragma mark - ROC

@interface MROCPlot : MPlot

@end


#pragma mark - NVI

@interface MNVIPlot : MPlot

@end

#pragma mark - PVI

@interface MPVIPlot : MPlot

@end

#pragma mark - DMA

@interface MDMAPlot : MPlot

@end

#pragma mark - CR

@interface MCRPlot : MPlot

@end

#pragma MPlot4Trend base

@interface MPlot4Trend : MPlot

@end

#pragma mark - TrendChart

@interface MTrendChartPlot : MPlot4Trend
/** 走势图类型 @see MTrendChartType */
@property (nonatomic, assign) MTrendChartType type;
/** 左边文字颜色 */
@property (nonatomic, strong) NSArray *leftTextColors;
/** 右边文字颜色 */
@property (nonatomic, strong) NSArray *rightTextColors;
/** 渐层颜色位置 */
@property (nonatomic, readwrite) CGFloat *gradientLocations;
/** 渐层颜色 */
@property (nonatomic, strong) NSArray *gradientColors;
/** 最后一个报价发亮点 */
@property (nonatomic, strong) UIView *lastBlinkDot;
/** rg棒涨颜色 */
@property (nonatomic, strong) UIColor *riseColor;
/** rg棒跌颜色 */
@property (nonatomic, strong) UIColor *dropColor;
/** 价格线宽px */
@property (nonatomic, assign) CGFloat currentLineWidth;
/** 均价线宽px */
@property (nonatomic, assign) CGFloat averageLineWidth;
/** 基金净值线宽px  默认线宽为0不显示基金净值走势线*/
@property (nonatomic, assign) CGFloat IOPVLineWidth;
/** 最新价线是否隐藏，默认YES */
@property (nonatomic, assign) BOOL lastPriceLineHidden;
/** 最新价线颜色 */
@property (nonatomic, strong) UIColor *lastPriceLineColor;
/** 最新价线宽px */
@property (nonatomic, assign) CGFloat lastPriceLineWidth;
/** 虚线间隔 不传，默认实线 例:(CGFloat []){3,1}*/
@property (nonatomic, readwrite) CGFloat *lastPriceLineDash;
@end

#pragma mark - DDX

@interface MDDXPlot : MPlot4Trend

@end

#pragma mark - DDY

@interface MDDYPlot : MPlot4Trend

@end

#pragma mark - DDZ

@interface MDDZPlot : MPlot4Trend

@end

#pragma mark - BBD

@interface MBBDPlot : MPlot4Trend

@end

#pragma mark - RatioBS

@interface MRatioBSPlot : MPlot4Trend

@end

#pragma mark - Money

@interface MMoneyPlot : MPlot4Trend

@end

#pragma mark - MBigNetVolume

@interface MBigNetVolumePlot : MPlot4Trend

@end

#pragma mark - MChartBorderTheme
@class MOHLCItem;
@protocol MChartBorderTheme
- (CGRect)rectForPlot:(__kindof MPlot *)plot inRect:(CGRect)rect isMajor:(BOOL)isMajor;
- (void)drawingRectForPlot:(__kindof MPlot *)plot rect:(CGRect)rect inContext:(CGContextRef)context isMajor:(BOOL)isMajor;
- (void)drawingItemForPlot:(__kindof MPlot *)plot atStartIndex:(NSInteger)startIndex rect:(CGRect)rect inContext:(CGContextRef)context;
- (NSString *)enquiryDatetimeForPlot:(__kindof MPlot *)plot OHLCItem:(MOHLCItem *)item;
- (NSUInteger)numberOfVisibleRecords;

@optional
- (void)bidDrawingRectForPlot:(__kindof MPlot *)plot rect:(CGRect)rect inContext:(CGContextRef)context;

@end

#pragma mark - MChartTheme
@class MOHLCChartTheme, MTrendChartTheme;
@interface MChartTheme : NSObject <MChartBorderTheme>
/** x轴时间坐标显示的位置 */
@property (nonatomic, readwrite) MOHLCChartXAxisTextLocation xAxisTextLocation;
/** 主图工具栏是否隐藏，默认NO */
@property (nonatomic, assign) BOOL majorToorBarHidden;
/** 副图工具栏是否隐藏，默认NO */
@property (nonatomic, assign) BOOL minorToorBarHidden;
+ (MOHLCChartTheme *)defaultTheme;
+ (MTrendChartTheme *)trendChartTheme;
@end

@interface MOHLCChartTheme : MChartTheme
/// 纵向纬度
@property (nonatomic, assign) MOHLCChartLongitudinalLatitude longitudinalLatitude;
/** 设置画面k棒笔数，默认为20 */
@property (nonatomic, assign) NSUInteger numberOfVisibleRecords;
/** 设置缩放时最少显示k棒笔数，默认为10 */
@property (nonatomic, assign) NSUInteger numberOfMinimumVisibleRecords;
/** 是否可滚动  默认 YES */
@property (nonatomic, assign) BOOL scrollEnabled;
/** 是否可缩放  默认 YES */
@property (nonatomic, assign) BOOL zoomEnabled;

@end

@interface MTrendChartTheme : MChartTheme
/** 走势图类型 @see MTrendChartType */
@property (nonatomic, assign) MTrendChartType type;
/** MChartEnquiryLineModeNone模式下 查价线中心偏移量 */
@property (nonatomic, assign) CGPoint enquiryLocationOffset;
/** 集合竞价线图，默认不展示为NO */
@property (nonatomic, assign) BOOL bidChartShow;
/** 科创板盘后交易线图，默认不展示为NO */
@property (nonatomic, assign) BOOL AFChartShow;
/** 是否使用TCP推送分时数据，默认NO，不使用*/
@property (nonatomic, assign) BOOL isTCP;
@end

