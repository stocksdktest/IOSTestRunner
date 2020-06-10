/////////////////////////////////////////////////////////
//                                                     //
// Copyright (c) 2016年 上证云平台. All rights reserved. //
//                                                     //
/////////////////////////////////////////////////////////


#import <UIKit/UIKit.h>

@class MTOptionView;
@class MStockItem;

@protocol MTOptionViewDelegate <NSObject>
 @optional

- (void)optionView:(MTOptionView *)optionView didSelectStockItem:(MStockItem *)stockItem stockItems:(NSArray *)stockItems;
@end


typedef NS_ENUM(NSInteger, MSortingField){
    MSortingFieldLastPrice = 0,     //最新价
    MSortingFieldChangeRate = 1,    //涨跌幅
    MSortingFieldChange = 2,        //涨跌额
    MSortingFieldBuyPrice = 3,      //买价
    MSortingFieldSellPrice = 4,     //卖价
    MSortingFieldVolume = 5,        //总量
    MSortingFieldAmount = 6,        //金额
    MSortingFieldOpenInterest = 7,  //持仓量
    MSortingFieldExePrice = 8       //行权价
};


@interface MTOptionView : UIView
/**
 *  到期日文字颜色
 */
@property (nonatomic , strong) UIColor *expiryDateColor;
/**
 *  到期日文字大小
 */
@property (nonatomic , assign) CGFloat expiryDateFontSize;
/**
 *  到期日月份文字颜色
 */
@property (nonatomic , strong) UIColor *expiryDateMonthColor;
/**
 *  到期日背景颜色
 */
@property (nonatomic , strong) UIColor *expiryDateBackgroundColor;

/**
 *  认沽、认购标题文字颜色
 */
@property (nonatomic , strong) UIColor *callPutTitleColor;
/**
 *  认沽、认购标题文字大小
 */
@property (nonatomic , assign) CGFloat callPutTitleFontSize;
/**
 *  认沽、认购标题背景颜色
 */
@property (nonatomic , strong) UIColor *callPutBackgroundColor;

/**
 *  认沽、认购列表header标题文字颜色
 */
@property (nonatomic , strong) UIColor *callPutCellHeaderTitleColor;
/**
 *  认沽、认购列表header标题文字大小
 */
@property (nonatomic , assign) CGFloat callPutCellHeaderTitleFontSize;
/**
 *  认沽、认购列表header标题背景颜色
 */
@property (nonatomic , strong) UIColor *callPutCellHeaderBackgroundColor;
/**
 *  认沽、认购列表header高度，注意高度要大于字体大小callPutCellHeaderTitleFontSize
 */
@property (nonatomic , assign) CGFloat callPutCellHeaderHeight;

/**
 *  行权价文字颜色
 */
@property (nonatomic , strong) UIColor *exPriceColor;
/**
 *  行权价文字大小
 */
@property (nonatomic , assign) CGFloat exPriceFontSize;
/**
 *  行权价背景色
 */
@property (nonatomic , strong) UIColor *exPriceBackgroundColor;
/**
 *  认沽、认购cell高度
 */
@property (nonatomic , assign) CGFloat callPutCellHeight;
/**
 *  认沽、认购cell文字大小
 */
@property (nonatomic , assign) CGFloat callPutCellFontSize;
/**
 *  认购cell背景色
 */
@property (nonatomic , strong) UIColor *callCellBackgroundColor;
/**
 *  认沽cell背景色
 */
@property (nonatomic , strong) UIColor *putCellBackgroundColor;
/**
 *  涨色
 */
@property (nonatomic , strong) UIColor *upColor;
/**
 *  跌色
 */
@property (nonatomic , strong) UIColor *downColor;
/**
 *  平盘色
 */
@property (nonatomic , strong) UIColor *aveColor;
/**
 *  空资料文字颜色
 */
@property (nonatomic , strong) UIColor *nullColor;

/**
 *  认沽、认购资料总量和金额的文字颜色
 */
@property (nonatomic , strong) UIColor *volumeAmountColor;
/**
 *  滚动的scrollView
 */
@property (nonatomic , strong, readonly) UIScrollView *scrollView;
/**
 *  代理
 */
@property (nonatomic , assign) id<MTOptionViewDelegate> delegate;
/**
 *  栏宽
 */
@property (nonatomic , assign) CGFloat columnWidth;
/**
 *  初始化后 调用此方法加载页面
 */
- (void)loadViewWithStockId:(NSString *)stockId;
/**
 *  刷新页面，加入下拉刷新时，可以绑定此方法
 */
- (void)refreshView;

/** 排列顺序 */
@property (nonatomic, assign) BOOL ascending;
/*
 *  排序栏位
 */
@property (nonatomic, assign) MSortingField field;

@end
