/////////////////////////////////////////////////////////
//                                                     //
// Copyright (c) 2016年 上证云平台. All rights reserved. //
//                                                     //
/////////////////////////////////////////////////////////


#ifndef __MAPI_OBJECT_PUBLIC_MACRO__
#define __MAPI_OBJECT_PUBLIC_MACRO__
#if __has_extension(objc_generics)
@class MTickItem, MTimeTickItem, MTimeTickDetailItem, MPriceVolumeItem, MStockItem, MOHLCItem, MAddValueItem,
MOptionItem, MSectionRankingItem, MSectionSortingItem,
MSearchResultItem, MBrokerSeatItem, MHKOddInfoItem, MStaticDataItem, MBoardInfoItem, MSubnewStockRankingItem,MSubnewBondRankingItem, MFQItem,MAHQuoteItem,MTradeItem,MTradeDateItem,MLinkItem,MDRQuoteItem,MUKItem,MBidItem,MPlateIndexItem;


#define MAPI_OBJ_TICK_TYPE                 <MTickItem *>
#define MAPI_OBJ_TIME_TICK_TYPE            <MTimeTickItem *>
#define MAPI_OBJ_TIME_TICK_DETAIL_TYPE     <MTimeTickDetailItem *>
#define MAPI_OBJ_PRICE_VOLUME_TYPE    <MPriceVolumeItem *>
#define MAPI_OBJ_STOCK_TYPE           <MStockItem *>
#define MAPI_OBJ_PLATE_INDEX_TYPE     <MPlateIndexItem *>
#define MAPI_OBJ_UK_TYPE              <MUKItem *>
#define MAPI_OBJ_OHLC_TYPE            <MOHLCItem *>
#define MAPI_OBJ_BID_TYPE            <MBidItem *>
#define MAPI_OBJ_FQ_TYPE              <MFQItem *>
#define MAPI_OBJ_AH_TYPE              <MAHQuoteItem *>
#define MAPI_OBJ_LINK_TYPE              <MLinkItem *>
#define MAPI_OBJ_CDR_GDR_TYPE         <MDRQuoteItem *>
#define MAPI_OBJ_OPTION_TYPE          <MOptionItem *>
#define MAPI_OBJ_SECTION_RANKING_TYPE <MSectionRankingItem *>
#define MAPI_OBJ_SECTION_SORTING_TYPE <MSectionSortingItem *>
#define MAPI_OBJ_SEARCH_RESULT_TYPE   <MSearchResultItem *>
#define MAPI_OBJ_BROKER_SEAT_TYPE     <MBrokerSeatItem *>
#define MAPI_OBJ_ODD_INFO_TYPE     <MHKOddInfoItem *>
#define MAPI_OBJ_STATIC_DATA_TYPE     <MStaticDataItem *>
#define MAPI_OBJ_BOARD_INFO_TYPE     <MBoardInfoItem *>
#define MAPI_OBJ_SUBNEW_STOCK_RANKING_TYPE  <MSubnewStockRankingItem *>
#define MAPI_OBJ_SUBNEW_BOND_RANKING_TYPE  <MSubnewBondRankingItem *>
#define MAPI_OBJ_TRADE_DATE_TYPE <MTradeDateItem *>
#else
#define MAPI_OBJ_TICK_TYPE
#define MAPI_OBJ_TIME_TICK_TYPE
#define MAPI_OBJ_TIME_TICK_DETAIL_TYPE
#define MAPI_OBJ_PRICE_VOLUME_TYPE
#define MAPI_OBJ_STOCK_TYPE
#define MAPI_OBJ_PLATE_INDEX_TYPE
#define MAPI_OBJ_UK_TYPE
#define MAPI_OBJ_OHLC_TYPE
#define MAPI_OBJ_BID_TYPE
#define MAPI_OBJ_FQ_TYPE
#define MAPI_OBJ_AH_TYPE
#define MAPI_OBJ_LINK_TYPE
#define MAPI_OBJ_CDR_GDR_TYPE
#define MAPI_OBJ_OPTION_TYPE
#define MAPI_OBJ_SECTION_RANKING_TYPE
#define MAPI_OBJ_SECTION_SORTING_TYPE
#define MAPI_OBJ_SEARCH_RESULT_TYPE
#define MAPI_OBJ_BROKER_SEAT_TYPE
#define MAPI_OBJ_ODD_INFO_TYPE
#define MAPI_OBJ_STATIC_DATA_TYPE
#define MAPI_OBJ_BOARD_INFO_TYPE
#define MAPI_OBJ_SUBNEW_STOCK_RANKING_TYPE
#define MAPI_OBJ_SUBNEW_BOND_RANKING_TYPE
#define MAPI_OBJ_TRADE_DATE_TYPE
#endif
#endif

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef NS_ENUM(NSInteger, MApiNetworkStatus) {
    /**
     *  网络状态
     */
    MApiNotReachable = 0,
    MApiReachableViaWiFi = 2,
    MApiReachableViaWWAN = 1
};

typedef NS_OPTIONS(NSInteger, MApiSourceLevel) {
    
    MApiSourceNone = 0,
    
    MApiSourceLevel1 = 1 << 0,    //沪深Level1
    MApiSourceLevel2 = 1 << 1,    //沪深Level2
    
    MApiSourceSHHK1 = 1 << 2,      //沪港通一档 (港)
    MApiSourceSHHK5 = 1 << 3,      //沪港通五档 (港)
    MApiSourceSZHK1 = 1 << 4,      //深港通一档 (港)
    MApiSourceSZHK5 = 1 << 5,       //深港通五档 (港)
    MApiSourceHK10  = 1 << 6,       //港股十档 (港)
    MApiSourceHKA1  = 1 << 7,       //港股实时一档 (港)
    MApiSourceHKD1  = 1 << 8,        //港股延时一档 (港)
    
    MApiSourceCFF1  = 1 << 9,       //中金所一档(中金所 默认L1)
    MApiSourceCFF2  = 1 << 10,       //中金所五档
    
    MApiSourceDCE1  = 1 << 11,       //大商所一档(大商所 默认L1)
    MApiSourceDCE2  = 1 << 12,       //大商所五档
    
    MApiSourceCZCE1  = 1 << 13,       //郑商所一档(郑商所 默认L1)
    MApiSourceCZCE2  = 1 << 14,        //郑商所五档
    
    MApiSourceSHFE1  = 1 << 15,      //上期所一档(郑商所 默认L1)
    MApiSourceSHFE2  = 1 << 16,      //上期所五档
    
    MApiSourceINE1  = 1 << 17,       //上期所原油一档(郑商所 默认L1)
    MApiSourceINE2  = 1 << 18        //上期所原油五档
    
};


typedef NS_ENUM(NSUInteger, MBSVolumeType){
    /**
     *  内外盘别
     */
    MBSVolumeTypeNone,
    MBSVolumeTypeBuy,
    MBSVolumeTypeSell
};

typedef NS_ENUM(NSUInteger, MChangeState){
    /**
     *  涨跌状态
     */
    MChangeStateFlat,
    MChangeStateRise,
    MChangeStateDrop
};

typedef NS_ENUM(NSUInteger, MChartType){
    /**
     *  走势类别
     */
    MChartTypeOneDay = 0,
    MChartTypeFiveDays = 1
};

typedef NS_ENUM(NSUInteger, MOHLCPeriod){
    /**
     *  K线周期
     */
    MOHLCPeriodDay = 0,
    MOHLCPeriodWeek = 1,
    MOHLCPeriodMonth = 2,
    MOHLCPeriodMin5 = 3,
    MOHLCPeriodMin15 = 4,
    MOHLCPeriodMin30 = 5,
    MOHLCPeriodMin60 = 6,
    MOHLCPeriodMin120 = 7,
    MOHLCPeriodMin1 = 8,
    MOHLCPeriodYear = 9
    
};

typedef NS_ENUM(NSUInteger, MRequestType){
    /** 最新的数据 */
    MRequestTypeRecent,
    /** 比xx更新的n笔数据 */
    MRequestTypeNewer,
    /** 比xx更旧的n笔数据 */
    MRequestTypeOlder,
    /** 指定区间的数据(仅沪深) */
    MRequestTypeInterval
    
};

typedef NS_ENUM(NSInteger, MResponseStatus){
    /**
     *  回传代码
     */
    MResponseStatusSuccess        = 200,
    MResponseStatusSessionExpired = 401,
    MResponseStatusNotFound       = 404,
    MResponseStatusOverLimit      = 444,
    MResponseStatusServerError    = 500,
    MResponseStatusBadGateway     = 502,

    MResponseStatusTimeout            = NSURLErrorTimedOut,
    MResponseStatusDataParseError     = -1003,
    MResponseStatusDataNil            = -1004,
    MResponseStatusParameterError     = -1005,
    MResponseStatusServerSiteNotFound = -1006,
    MResponseStatusNotReachabled      = -1009,
    MResponseStatusCertificationAuditError = -2001,
    MResponseStatusPermissionLimited = -2002
    
};

typedef NS_ENUM(NSUInteger, MOptionType){
    /**
     *  期权类别
     */
    MOptionTypeUnknown,
    MOptionTypeCall,
    MOptionTypePut
};

typedef NS_ENUM(NSInteger, MStockStatus){
    /**
     *  交易状态
     */
    MStockStatusUnknown  = 99,
    MStockStatusNormal   = 0,  // 正常交易
    MStockStatusPause    = 1,  // 停牌（通常发生在新股盘中涨跌过大时）
    MStockStatusSuspend  = 2,  // 停牌（开市前即知道此股票为全体停牌）
    MStockStatusUnmarket = 3   // 退市
};

typedef NS_ENUM(NSInteger, MStockStage) {
    /**
     *  交易阶段
     */
    MStockStageUnknown       = 99,
    MStockStageUnopen        = 0,  // 未开市
    MStockStageVirtual       = 1,  // 盘前集合竞价
    MStockStageAuction       = 2,  // 收盘集合竞价
    MStockStageOpen          = 3,  // 连续竞价
    MStockStageTempSuspensed = 4,  // 临时停市 已弃用
    MStockStageClosed        = 5,  // 已收盘
    MStockStageLunchBreak    = 6,  // 休市
    MStockStageOnTrading     = 7,   // 交易中 已弃用
    MStockStageAfterHoursTrading = 8 //盘后交易
};

typedef NS_ENUM(NSInteger, MOHLCPriceAdjustedMode) {
    MOHLCPriceAdjustedModeNone = 0,    // 不复权
    MOHLCPriceAdjustedModeForward = 1, // 前复权
    MOHLCPriceAdjustedModeBackward = 2 // 后复权
};

typedef NS_ENUM(NSInteger, MCategorySortingField) {
    MCategorySortingFieldStatus = 0,    //股票状态
    MCategorySortingFieldID = 1,        //代码
    MCategorySortingFieldName = 2,      //名称
    MCategorySortingFieldPinyin = 4,    //拼音 暂不支持
    MCategorySortingFieldLastPrice = 7, //最新价
    MCategorySortingFieldHighPrice = 8, //最高价
    MCategorySortingFieldLowPrice = 9,  //最低价
    MCategorySortingFieldOpenPrice = 10,//今开价
    MCategorySortingFieldPreClosePrice = 11,    //昨收价
    MCategorySortingFieldChangeRate = 12,       //涨跌幅
    MCategorySortingFieldVolume = 13,           //总量
    MCategorySortingFieldNowVolume = 14,        //当前成交量
    MCategorySortingFieldTurnoverRate = 15,     //换手率
    MCategorySortingFieldChange = 19,           //涨跌额
    MCategorySortingFieldAmount = 20,           //成交额
    MCategorySortingFieldVolumeRatio = 21,      //量比
    MCategorySortingFieldBuyVolume = 24,        //外盘量
    MCategorySortingFieldSellVolume = 25,       //内盘量
    MCategorySortingFieldTotalValue = 26,       //总值
    MCategorySortingFieldFlowValue = 27,        //流值
    MCategorySortingFieldNetAsset = 28,         //每股净资产
    MCategorySortingFieldPE = 29,               //动态市盈 (支持沪、深、港、新三板)
    MCategorySortingFieldROE = 30,              //净资产收益率
    MCategorySortingFieldCapitalization = 31,   //总股本
    MCategorySortingFieldCirculatingShare = 32, //流通股
    MCategorySortingFieldAmplitudeRate = 37,    //振幅
    MCategorySortingFieldReceipts = 38,         //每股收益
    MCategorySortingFieldCFFOrderRatio = 40,    //委比 (新三板)
    MCategorySortingFieldSPE = 42,              //静态市盈 (支持沪、深、港)
    MCategorySortingFieldOrderRatio = 53,       //委比 (沪深港)
    MCategorySortingFieldEntrustDiff = 54,       //委差
    MCategorySortingFieldDRCurrentShare = 57,   //当前份额 (沪伦通)
    MCategorySortingFieldDRPreviousClosingShare = 58, // 前收盘份额 (沪伦通)
    MCategorySortingFieldAfterHoursVolume = 72,       //盘后成交量
    MCategorySortingFieldAfterHoursAmount = 73,       //盘后成交额
    MCategorySortingFieldUltraLargeNetInflow = -19, //超大单净流入
    MCategorySortingFieldLargeNetInflow = -20,      //大单净流入
    MCategorySortingFieldMediumNetInflow = -21,     //中单净流入
    MCategorySortingFieldSmallNetInflow = -22,      //小单净流入
    MCategorySortingFieldBbd = -34,                 //大单净差
    MCategorySortingFieldBbd5 = -35,                //五日大单净差
    MCategorySortingFieldBbd10 = -36,               //十日大单净差
    MCategorySortingFieldDdx = -37,                 //主力动向
    MCategorySortingFieldDdx5 = -38,                //五日主力动向
    MCategorySortingFieldDdx10 = -39,               //十日主力动向
    MCategorySortingFieldDdy = -40,                 //涨跌动因
    MCategorySortingFieldDdy5 = -41,                //五日涨跌动因
    MCategorySortingFieldDdy10 = -42,               //十日涨跌动因
    MCategorySortingFieldNetCapitalInflow = -47,    //主力净流入 (主力净流入=超大单净流入+大单净流入)
    MCategorySortingFieldFiveMinRise = -48,          //5分钟涨跌幅
    MCategorySortingFieldNetInflow5  = -58,         //5日主力资金净流入
    MCategorySortingFieldNetInflow10 = -59,         //10日主力资金净流入
    MCategorySortingFieldNetInflow20 = -60,         //20日主力资金净流入
    MCategorySortingFieldNetInflowRate5 = -61,         //5日主力资金净流入占比
    MCategorySortingFieldNetInflowRate10 = -62,         //10日主力资金净流入占比
    MCategorySortingFieldNetInflowRate20 = -63,         //20日主力资金净流入占比

    
    //全球、外汇
    MCategorySortingSSEFieldLastPrice= 300,         //最新价
    MCategorySortingSSEFieldLowPrice = 301,         //最低价
    MCategorySortingSSEFieldChange = 302,           //涨跌额
    MCategorySortingSSEFieldChangeRate = 303,       //涨跌幅
    MCategorySortingSSEFieldAmount = 304,           //成交额
    MCategorySortingSSEFieldName = 305,             //名称
    MCategorySortingSSEFieldVolume = 306,           //成交量
    MCategorySortingSSEFieldPreClosePrice = 307,    //昨收价
    MCategorySortingSSEFieldHighPrice = 308         //最高价
    
};

typedef NS_ENUM(NSInteger, MSectionSortingField) {
    MSectionSortingFieldID = 0,         //代码
    MSectionSortingFieldLastPrice = 1,  //最新价
    MSectionSortingFieldOpenPrice = 2,  //开盘价
    MSectionSortingFieldHighPrice = 3,  //最高价
    MSectionSortingFieldLowPrice = 4,  //最低价
    MSectionSortingFieldPreClosePrice = 5,  //昨收价
    MSectionSortingFieldChange = 6,  //涨跌额
    MSectionSortingFieldChangeRate = 7, //涨跌幅
    MSectionSortingFieldChangeRate5 = 8,   //5日涨跌幅
    MSectionSortingFieldChangeRate10 = 9,   //10日涨跌幅
    MSectionSortingFieldAmount = 10,  //总成交额
    MSectionSortingFieldVolume = 11,  //总成交量
    MSectionSortingFieldNowVolume = 12,  //现成交量
    MSectionSortingFieldWeightedChange = 13, //权涨幅
    MSectionSortingFieldAverageChange = 14,  //均涨幅
    MSectionSortingFieldFlowValue = 15,  //流通市值
    MSectionSortingFieldTotalValue = 16,  //总市值
    MSectionSortingFieldOrderRatio = 17,  //委比
    MSectionSortingFieldEntrustDiff = 18,  //委差
    MSectionSortingFieldTurnoverRate = 19,  //换手率
    MSectionSortingFieldAmplitudeRate = 20,  //振幅
    //涨跌家数
    MSectionSortingFieldRiseRate = 21,  //涨股比
    MSectionSortingFieldAdvanceAndDeclineCount = 22, //涨跌家数
    MSectionSortingFieldLimitUpCount = 23,  //涨停家数
    MSectionSortingFieldLimitDownCount = 24,  //跌停家数
    //增值指标
    MSectionSortingFieldCapitalInflow = 25,  //主力资金流入
    MSectionSortingFieldCapitalOutflow = 26,  //主力资金流出
    MSectionSortingFieldNetCapitalInflow = 27,  //主力资金净流入
    MSectionSortingFieldNetCapitalInflow5 = 28,  //5日主力资金净流入
    MSectionSortingFieldNetCapitalInflow10 = 29,  //10日主力资金净流入
    //领涨股
    MSectionSortingFieldStockID = 30,  //领涨股
    MSectionSortingFieldStockChange = 31,  //个股涨幅
    MSectionSortingFieldStockChangeRate = 32,  //个股涨幅比
    //优品概念板块
    MSectionSortingFieldHot = 33  //优品板块的热度值
};

typedef NS_ENUM(NSInteger, MAHQuoteListField) {
    MAHQuoteListFieldLastPriceA = 2,
    MAHQuoteListFieldChangeRateA = 3,
    MAHQuoteListFieldLastPriceH = 6,
    MAHQuoteListFieldChangeRateH = 7,
    MAHQuoteListFieldPremiumRate = 9
};

typedef NS_ENUM(NSInteger, MDRQuoteListField) {
    MDRQuoteListFieldCode = 0,
    MDRQuoteListFieldName = 1,
    MDRQuoteListFieldLastPrice = 3,
    MDRQuoteListFieldPreClosePrice = 4,
    MDRQuoteListFieldChangeRate = 5,
    MDRQuoteListFieldDatetime = 6,
    MDRQuoteListFieldBaseStockCode = 7,
    MDRQuoteListFieldBaseStockName = 8,
    MDRQuoteListFieldBaseLastPrice = 10,
    MDRQuoteListFieldBasePreClosePrice = 11,
    MDRQuoteListFieldBaseChangeRate = 12,
    MDRQuoteListFieldBaseDatetime = 13,
    MDRQuoteListFieldPremiumRate = 14
};

typedef NS_ENUM(NSInteger, MSubnewStockRankingField) {
    MSubnewStockRankingFieldCode = 0,
    MSubnewStockRankingFieldName = 1,
    MSubnewStockRankingFieldIPOPrice = 2,
    MSubnewStockRankingFieldLastPrice = 3,
    MSubnewStockRankingFieldIPODate = 4,
    MSubnewStockRankingFieldContinuousLimitUpDays = 5,
    MSubnewStockRankingFieldTotalRate = 8,
};

typedef NS_ENUM(NSInteger, MSubnewBondRankingField) {
    MSubnewBondRankingFieldCode = 0,        //按股票代码排序
    MSubnewBondRankingFieldName = 1,        //按股票名称排序
    MSubnewBondRankingFieldIPOPrice = 2,    //按发行价排序
    MSubnewBondRankingFieldLastPrice = 3,   //按最新价排序
    MSubnewBondRankingFieldIPODate = 4,     //按上市日期排序
    MSubnewBondRankingFieldSubtype = 5,     //按次类别排序
    MSubnewBondRankingFieldPreClosePrice = 6,//按昨收价排序
    MSubnewBondRankingFieldTotalRate = 7,
};

typedef NS_ENUM(NSUInteger, MHKOddSide) {
    /**
     *  港股碎股订单买卖方向
     */
    MHKOddSideNone,
    MHKOddSideBid,
    MHKOddSideOffer
};

typedef NS_OPTIONS(NSUInteger, MHKInfoStatus) {
    MHKInfoStatusNone = 0,
    MHKInfoStatusODD  = 1 << 0,
    MHKInfoStatusVCM  = 1 << 1,
    MHKInfoStatusCAS  = 1 << 2,
};

typedef NS_ENUM(NSInteger, MTimeTickAMSFlag) {
    /**
     *  港股碎股订单买卖方向
     */
    MTimeTickAMSFlagUnknown = -1,
    MTimeTickAMSFlagNone = 0,                       // AMS <space>
    MTimeTickAMSFlagLateTrade = 4,                  // AMS 'P'
    MTimeTickAMSFlagNonDirectOffExchangeTrade = 22, // AMS 'M'
    MTimeTickAMSFlagAutomatchInternalized = 100,    // AMS 'Y'
    MTimeTickAMSFlagDirectOffExchangeTrade = 101,   // AMS 'X'
    MTimeTickAMSFlagOddLotTrade = 102,              // AMS 'D'
    MTimeTickAMSFlagAuctionTrade = 103              // AMS 'U'
};

typedef NS_ENUM(NSInteger, MTimeTickCFFFlag) {
    /**
     *  中金所股票买卖方向
     */
    MTimeTickCFFLongChangedHands = 1,       //多头换手
    MTimeTickCFFShortChangedHands = 2,      //空头换手
    MTimeTickCFFLongOpening = 3,            //多头开仓
    MTimeTickCFFLongClose = 4,              //多头平仓
    MTimeTickCFFShortOpening = 5,           //空头开仓
    MTimeTickCFFShortClose = 6,             //空头平仓
    MTimeTickCFFDoubleOpening = 7,          //双开仓
    MTimeTickCFFDoubleClose = 8,            //双平仓
    
};

typedef NS_ENUM(NSInteger, MTimeTickRequestType) {
    MTimeTickRequestTypeRecent = -1, // 最新N笔数据
    MTimeTickRequestTypeNewer = 0,   // 比index更新的N笔数据
    MTimeTickRequestTypeOlder = 1    // 比index更旧的N笔数据
};

typedef NS_ENUM(NSInteger, MSnapQuoteRequestType) {
    MSnapQuoteRequestType1 = 0, // 1档 (沪深)(默认)
    MSnapQuoteRequestType5,     // 5档 (沪深)
    MSnapQuoteRequestType10,    // 10档 (沪深)
};

typedef NS_OPTIONS(NSUInteger, MSearchResultItemFlag) {
    MSearchResultItemFlagNone = 0,
    MSearchResultItemFlagHH   = 1 << 0, //沪港通
    MSearchResultItemFlagHZ   = 1 << 1  //深港通
};

typedef NS_ENUM(NSInteger, MFlag) {
    MFlagNone = -1,// 资讯源未下放
    MFlagNO = 0,   // 非
    MFlagYES = 1   // 是
};

typedef NS_ENUM(NSInteger, MHKTTradeType) {
    MHKTTradeTypeNone = -1,     // 资讯源未下放
    MHKTTradeTypeForbid = 0,    // 沪深两市都不可交易
    MHKTTradeTypeSH = 1,        // 沪市可交易
    MHKTTradeTypeSZ = 2,        // 深市可交易
    MHKTTradeTypeSHSZ = 3,      // 沪深两市均可交易
};

typedef NS_ENUM(NSInteger, MInvestorRequirementsType) {
    MInvestorRequirementsTypeNone = -1,
    MInvestorRequirementsTypeAll = 0,           //表示适合所有投资者，
    MInvestorRequirementsTypePerson = 1,        //表示投资者适当性要求，
    MInvestorRequirementsTypeOrganization = 2   //表示机构投资者适当性要求
};

typedef NS_OPTIONS(NSUInteger, MTradeDateType) {
    MTradeDateTypePre6      = 1 << 0, // 近6日可交易日
    MTradeDateTypeWLS       = 1 << 1, // 交易日白名单
    MTradeDateTypeBLS       = 1 << 2, // 交易日黑名单
    MTradeDateTypeDefault   = MTradeDateTypePre6 | MTradeDateTypeWLS | MTradeDateTypeBLS
};

typedef NS_ENUM(NSUInteger, MTradeDateItemType) {
    MTradeDateItemTypeNonTrading             = 0, // 非交易日
    MTradeDateItemTypeDayTrading             = 1, // 交易日(仅日盘)
    MTradeDateItemTypeDayAndNightTrading     = 2, // 交易日(日盘＋夜盘)
    MTradeDateItemTypeMorningTrading         = 3, // 仅上午交易
    MTradeDateItemTypeAfternoonTrading       = 4  // 仅下午交易
};

typedef NS_OPTIONS(NSInteger, MChartIndexType) {
    MChartIndexTypeDDX              = 1 << 0,//大单净差
    MChartIndexTypeDDY              = 1 << 1,//主力动向
    MChartIndexTypeDDZ              = 1 << 2,//涨跌动因
    MChartIndexTypeBBD              = 1 << 3,//大单差分
    MChartIndexTypeRatioBS          = 1 << 4,//单数比
    MChartIndexTypeLargeMoneyInflow = 1 << 5,//超大单净流入
    MChartIndexTypeBigMoneyInflow   = 1 << 6,//大单净流入
    MChartIndexTypeMidMoneyInflow   = 1 << 7,//中单净流入
    MChartIndexTypeSmallMoneyInflow = 1 << 8,//小单净流入
    MChartIndexTypeLargeTradeNum    = 1 << 9,//超大单成交单数
    MChartIndexTypeBigTradeNum      = 1 << 10,//大单成交单数
    MChartIndexTypeMidTradeNum      = 1 << 11,//中单成交单数
    MChartIndexTypeSmallTradeNum    = 1 << 12,//小单成交单数
    MChartIndexTypeBigNetVolume     = 1 << 13,//大单净量
    MChartIndexTypeDefault = MChartIndexTypeDDX | MChartIndexTypeDDY | MChartIndexTypeDDZ |MChartIndexTypeBBD | MChartIndexTypeRatioBS | MChartIndexTypeLargeMoneyInflow | MChartIndexTypeBigMoneyInflow | MChartIndexTypeMidMoneyInflow |MChartIndexTypeSmallMoneyInflow | MChartIndexTypeLargeTradeNum | MChartIndexTypeBigTradeNum | MChartIndexTypeMidTradeNum | MChartIndexTypeSmallTradeNum | MChartIndexTypeBigNetVolume
};

typedef  NS_ENUM(NSInteger, MApiTcpSubscribeType) {
    MApiTcpSubscribeTypeNone    = 0,
    MApiTcpSubscribeTypeSnap    = 1 << 0,
    MApiTcpSubscribeTypeLine    = 1 << 1,
    MApiTcpSubscribeTypeLine5   = 1 << 2,
    MApiTcpSubscribeTypeDayK    = 1 << 3,
    MApiTcpSubscribeTypeWeekK   = 1 << 4,
    MApiTcpSubscribeTypeMonthK  = 1 << 5,
    MApiTcpSubscribeTypeYearK   = 1 << 6,
    MApiTcpSubscribeTypeTick    = 1 << 7,
    MApiTcpSubscribeTypeAll     = 11111111
};

@protocol MPlotDataItemSynthetic <NSObject>
@required
@property (nonatomic, copy) NSString *datetime;
@end


#pragma mark - 基底类
@interface MApiModel : NSObject <NSSecureCoding, NSCopying>

@end

#pragma mark - 请求类

/*! @brief 请求类
 */
@interface MRequest : MApiModel
@property (nonatomic, copy, readonly) NSString *APIVersion;
/** 站点信息（如果请求未发送获取时值为空），可以在请求回调中获取该请求的站点信息 */
@property (nonatomic, copy, readonly) NSString *ip;
/** 请求超时时间,默认为10秒 */
@property (nonatomic) NSTimeInterval timeoutInterval;
/** 请求次数 */
@property (nonatomic, readonly) NSUInteger sendCount;
/** 取消请求 */
- (void)cancel;
/** 设置全局请求超时时间,设置后所有的请求超时时间都将改变,默认为10秒 */
+ (void)setTimeoutInterval:(NSTimeInterval) timeoutInterval;
@end

@interface MListRequest : MRequest
/** 页次 */
@property (nonatomic, assign) NSInteger pageIndex;
@end


/*
 1、搜索
 2、自选快照
 3、联动请求
 4、分时五日
 5、历史K线
 6、分笔逐笔
 7、列表
 8、板块、个股所属板块
 9、涨跌统计
 10、期权
 11、分价
 12、港股专有行情
 13、沪港通余额
 14、假日档、次新股、次新债
 15、市场当年交易日接口
 */

#pragma mark 搜索
/*! @brief 搜寻股票请求类
 */
@interface MSearchRequest : MRequest
/** 搜寻文字 */
@property (nonatomic, copy) NSString *keyword;
/**
 搜索范围
 支持市场组合, 如: @[@"sh",@"hk"]更多市场请见文档
 支持（仅仅本地搜索时支持）分类代码组合, 如: @[@"sh_1001",@"sh_1001"], 更多分类代码请见文档,
 不支持市场、分类代码混合组合, 如: @[@"sh",@"sh_1001"]
 */
@property (nonatomic, copy) NSArray *categories;

/**
 是否为本地端搜索
 设置为yes时, 发送请求前需先调用MApi.downloadStockTableWithCompletionHandler: 方法先下载股票表
 */
@property (nonatomic, assign) BOOL searchLocal;
/** 搜寻结果数量限制 */
@property (nonatomic, assign) NSUInteger searchLimit;
/** 是否返回更名股票，默认不返回 */
@property (nonatomic, assign) BOOL returnRenamed;
/** 是否返回退市股票，默认不返回 */
@property (nonatomic, assign) BOOL returnDelisted;

/** 市场别,如sh,sz,hk */
@property (nonatomic, copy) NSString *market __attribute__((deprecated("已弃用,请改用categories属性")));
/** 子类别,如1001,1004等 */
@property (nonatomic, copy) NSString *subtype __attribute__((deprecated("已弃用,请改用categories属性")));
/** 市场别数组,如@[@"sh",@"sz",@"hk"],仅仅支持本地搜索 */
@property (nonatomic, copy) NSArray *markets __attribute__((deprecated("已弃用,请改用categories属性")));
/** 子类别数组,如@[@"1001",@"1002"],仅仅支持本地搜索 */
@property (nonatomic, copy) NSArray *subtypes __attribute__((deprecated("已弃用,请改用categories属性")));
@end

#pragma mark 自选快照

/*! @brief 股票行情请求类
 */
@interface MQuoteRequest : MRequest
/** 
    股票代码(可多笔，用逗号隔开), 单市场最大200只
    如 request.code = @"600000.sh,399001.sz,IC1709.cff"
 */
@property (nonatomic, copy) NSString *code;
/**
 * 自定义请求字段，参照MAddValueItem, MStockItem属性,!!! 如果是中金股票，参照MFuturesItem属性
 * 如：
 *    request.stockFields = @[@"openPrice", @"code"];
 *    request.addValueFields = @[@"time", @"ultraLargeBuyVolume"];
 * 默认为请求全部数据
 */
@property (nonatomic, strong) NSArray *stockFields;
/** 中金股票没有增值指标数据*/
@property (nonatomic, strong) NSArray *addValueFields;

@end

/*! @brief 股票快照行情请求类
 */
@interface MSnapQuoteRequest : MRequest
/** 股票代码(只可单笔查询), 如 600000.sh */
@property (nonatomic, copy) NSString *code;
/** 明细条数 新三板, 中金所不支持*/
@property (nonatomic, assign) NSInteger tickCount;

/**
 * 特别说明：新三板不支持自定义
 * 自定义请求字段，参照MStockItem, MAddValueItem属性, !!! 如果是期货股票，参照MFuturesItem属性
 * 如：
 *    request.stockFields = @[@"openPrice", @"code"];
 *    request.addValueFields = @[@"time", @"ultraLargeBuyVolume"];
 * 默认为请求全部数据
 */
@property (nonatomic, strong) NSArray *stockFields;
/** 中金股票没有增值指标数据*/
@property (nonatomic, strong) NSArray *addValueFields;

/**
 请求类型, 一档行情、五档行情、十档行情 （适用于沪深）
 沪港通一档，沪港通五档，深港通一档，深港通五档，港股十档，港股实时一档，港股延时一档（适用于港股）
    根据市场别 会有以下两种resp.stockItem字段差异
    1. request.code为港股时, resp.stockItem会有经济席位数据, @see MStockItem (MApiQuoteHK)
    2. request.code为沪深股时, resp.stockItem会有买卖队列数据, @see MStockItem (MApiQuoteSHSZ)
 */
@property (nonatomic, assign) MSnapQuoteRequestType type __attribute__((deprecated("已弃用, 使用MApi setUserPermissionAttributes:设置权限")));

@end

/*! @brief 交易行情行情请求类
 */
@interface MTradeQuoteRequest : MRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief UK市场行情
 */
@interface MUKQuoteRequest : MRequest
/** 股票代码(支持多只查询), 如 PRM.uk,PKG.uk */
@property (nonatomic, copy) NSString *code;

@end

/*! @brief 板块指数行情
 */
@interface MPlateIndexQuoteRequest : MRequest
/** 股票代码(支持多笔查询), 如 @"700004.bk,C41.bk" */
@property (nonatomic, copy) NSString *code;
/**
 * 自定义请求字段，参照MPlateIndexItem属性
 * 如：
 *    request.plateIndexFields = @[@"blockChg", @"code"];
 * 默认为请求全部数据
 */
@property (nonatomic, strong) NSArray *plateIndexFields;

@end


#pragma mark 港、债券、沪伦通 联动

/*! @brief AH联动 根据个股代码查对应港股行情 反之亦可
 */
@interface MAHQuoteRequest : MRequest
/** 股票代码(只可单笔查询), 如 600000.sh */
@property (nonatomic, copy) NSString *code;

@end

/*! @brief 可转债与正股联动代码查询
 */
@interface MLinkQuoteRequet : MRequest
/** 股票代码(只可单笔查询), 如 600000.sh */
@property (nonatomic, copy) NSString *code;

@end
/*! @brief 沪伦通联动 根据个股代码查对应港股行情 反之亦可
 */
@interface MDRLinkRequest : MRequest
/** 股票代码(只可单笔查询), 如 600006.sh */
@property (nonatomic, copy) NSString *code;

@end


#pragma mark 分时五日
/*! @brief 当日走势数据请求类
 */
@interface MChartRequest : MRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
/** 次类别 */
@property (nonatomic, copy) NSString *subtype;
/** 走势类别 */
@property (nonatomic, assign) MChartType chartType;
/** 是否返回盘后数据，默认不返回：NO （科创板股票当日分时才有效） */
@property (nonatomic, assign) BOOL returnAFData;
/** 叠加股票代码，可选参数 */
@property (nonatomic, copy) NSString *superpositionCode;
/** 叠加股票子类别，可选参数 */
@property (nonatomic, copy) NSString *superpositionSubtype;
@end

/*! @brief 历史分时数据
 */
@interface MHistoryChartRequest : MRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
/** 次类别 */
@property (nonatomic, copy) NSString *subtype;
/** 日期，格式：yyyyMMdd */
@property (nonatomic, copy) NSString *date;
@end

/*! @brief 集合竞价走势数据
 */
@interface MBidChartRequest : MRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
/** 次类别 */
@property (nonatomic, copy) NSString *subtype;
@end

/*! @brief 科创板盘后交易数据
 */
@interface MAfterHoursChartRequest : MRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
/** 次类别 */
@property (nonatomic, copy) NSString *subtype;
@end

/*! @brief 走势指标请求类
 *  DDX、DDY、DDZ、BBD、ratioBS
 */
@interface MChartIndexRequest : MRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
/** 子类别 */
@property (nonatomic, copy) NSString *subtype;
/** 请求指标类型，默认全部  */
@property (nonatomic, assign) MChartIndexType type;
/** 开始,默认值为0 */
@property (nonatomic, assign) NSInteger beginIndex;
/** 结束,默认值为-1表示beginIndex之后所有的 */
@property (nonatomic, assign) NSInteger endIndex;
@end


#pragma mark 历史K线行情

/*! @brief 历史行情(K线数据)请求类
 */
@interface MOHLCRequest : MRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
/** 次类别 */
@property (nonatomic, copy) NSString *subtype;
/** K线周期,不支持1分钟K */
@property (nonatomic) MOHLCPeriod period;
/** 周期单位 已废弃*/
@property (nonatomic) NSInteger unit __attribute__((deprecated));
/** 复权模式 默认不复权 (only 日K) */
@property (nonatomic, assign) MOHLCPriceAdjustedMode priceAdjustedMode;
@end

/*! @brief 历史行情(K线数据)请求类
 */
@interface MOHLCRequestV2 : MRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
/** 次类别 */
@property (nonatomic, copy) NSString *subtype;
/** K线周期 */
@property (nonatomic) MOHLCPeriod period;
/** 日期，与requestType配合使用
 *  日周月K的时间格式为 yyyyMMdd
 *  分钟K的时间格式为 yyyyMMddHHmmss
 *  特殊情况：当传入时间格式为@"yyyyMMdd,yyyyMMdd"或@"yyyyMMddHHmmss,yyyyMMddHHmmss"时获取该时间区间的数据,当传入时间格式为@"yyyyMMdd,n"或@"yyyyMMddHHmmss,n"或@"n,yyyyMMdd"或@"n,yyyyMMddHHmmss"时获取获取一个时间往前或往后的n根，其中n>0。（仅沪深，定时刷新时性能低下，不建议采用此中方式调用）
 */
@property (nonatomic, copy) NSString *date;
/**
 *  默认类型为MRequestTypeRecent,取最新的300根K线数据
 *  当类型为MRequestTypeNewer时,取date日期之后的300根K线数据
 *  当类型为MRequestTypeOlder时,取date日期之前的300根K线数据
 *  当类型为MRequestTypeInterval时,获取指定区间的K线数据，此时时间格式为@"yyyyMMdd,yyyyMMdd"
 */
@property (nonatomic, assign) MRequestType requestType;
/** 复权模式 默认不复权 (only 日K 周K 月K) */
@property (nonatomic, assign) MOHLCPriceAdjustedMode priceAdjustedMode;
@end

#pragma mark 分笔、逐笔
/*! @brief Level1分时明细请求类
 *
 *  单笔最多100条
 */
@interface MTimeTickRequest : MRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
/** 次类别 */
@property (nonatomic, copy) NSString *subtype;
/** 开始索引 */
@property (nonatomic, copy) NSString *index;
/** 笔数 默认20笔*/
@property (nonatomic, assign) NSUInteger pageSize;
/** 基于开始索引请求的类别 */
@property (nonatomic, assign) MTimeTickRequestType type;
@end
/*! @brief Level2分笔明细请求类
 *
 *  仅支持上海和深圳市场的非指数类的证券
 *  单笔限制100条
 */
@interface ML2TimeTickRequest : MTimeTickRequest

@end

/*! @brief Level2逐笔明细请求类
 *
 *  仅支持上海和深圳市场的非指数类的证券
 *  单笔限制100条
 */
@interface ML2TimeTickDetailRequest : MTimeTickRequest

@end

/*! @brief 分笔对逐笔请求类
 *
 *  单笔限制50条
 */
@interface MTimeTickDetailRequest : MTimeTickRequest
/** 页次 */
@property (nonatomic, assign) NSInteger pageIndex __attribute__((deprecated));

@end

#pragma mark 列表、AH、沪伦通
/*! @brief 分类涨跌幅排行请求类
 * 特别说明：支持两种模式, 当endIndex > 0 时执行第二种
 * 1、pageSize、pageIndex  翻页方式查询
 * 2、beginIndex、endIndex 按指定条目范围返回结果  (新三板 不支持)
 */
@interface MCategorySortingRequest : MListRequest
/** 分类代码 */
@property (nonatomic, copy) NSString *code;
/** 笔数 */
@property (nonatomic, assign) NSInteger pageSize;
/** 起始位置 */
@property (nonatomic, assign) NSInteger beginIndex;
/** 结束位置 */
@property (nonatomic, assign) NSInteger endIndex;
/** 排列顺序 */
@property (nonatomic, assign) BOOL ascending;
/** 是否包含停牌股 */
@property (nonatomic, assign) BOOL includeSuspension;
/* 排序栏位，期货排序栏位请参考CFFSortingField */
@property (nonatomic, assign) MCategorySortingField field;
/* 期货排序栏位 参照下方自定义 */
@property (nonatomic, copy) NSString *CFFSortingField;
/**
 * 特别说明：新三板不支持自定义
 * 自定义请求字段，参照MAddValueItem, MStockItem属性,!!! 如果是中金股票，参照MFuturesItem属性
 * 如：
 *    request.stockFields = @[@"openPrice", @"code"];
 *    request.addValueFields = @[@"time", @"ultraLargeBuyVolume"];
 * 默认为请求全部数据
 */
@property (nonatomic, strong) NSArray *stockFields;
/** 期货没有增值指标数据*/
@property (nonatomic, strong) NSArray *addValueFields;
@end

extern NSString * const MCategoryCFFSortingFieldID;             //代码
extern NSString * const MCategoryCFFSortingFieldname;           //名称
extern NSString * const MCategoryCFFSortingFieldPreClosePrice;  //昨收
extern NSString * const MCategoryCFFSortingFieldOpenPrice;      //开盘
extern NSString * const MCategoryCFFSortingFieldHighPrice;      //最高
extern NSString * const MCategoryCFFSortingFieldLowPrice;       //最低
extern NSString * const MCategoryCFFSortingFieldLastPrice;      //最新
extern NSString * const MCategoryCFFSortingFieldAvgPrice;       //均价
extern NSString * const MCategoryCFFSortingFieldChange;         //涨跌2
extern NSString * const MCategoryCFFSortingFieldChangeRate;     //涨跌幅
extern NSString * const MCategoryCFFSortingFieldVolume;         //成交量
extern NSString * const MCategoryCFFSortingFieldAmount;         //成交金额
extern NSString * const MCategoryCFFSortingFieldNowVolume;      //当前成交量
extern NSString * const MCategoryCFFSortingFieldSellVolume;     //内盘
extern NSString * const MCategoryCFFSortingFieldBuyVolume;      //外盘
extern NSString * const MCategoryCFFSortingFieldTradingDay;     //交易日
extern NSString * const MCategoryCFFSortingFieldSettlementGroupID;//结算组代码
extern NSString * const MCategoryCFFSortingFieldSettlementID;   //结算编号
extern NSString * const MCategoryCFFSortingFieldPreSettlement;  //昨结算
extern NSString * const MCategoryCFFSortingFieldPreOpenInterest;//昨持仓量
extern NSString * const MCategoryCFFSortingFieldOpenInterest;   //持仓量
extern NSString * const MCategoryCFFSortingFieldPositionChg;    //日增
extern NSString * const MCategoryCFFSortingFieldClose;          //今收盘价
extern NSString * const MCategoryCFFSortingFieldSettlement;     //今结算价
extern NSString * const MCategoryCFFSortingFieldLimitUp;        //涨停价
extern NSString * const MCategoryCFFSortingFieldLimitDown;      //跌停价
extern NSString * const MCategoryCFFSortingFieldPreDelta;       //昨虚实度
extern NSString * const MCategoryCFFSortingFieldCurrDelta;      //今虚实度
extern NSString * const MCategoryCFFSortingFieldUpdateMillisec; //最后修改毫秒
extern NSString * const MCategoryCFFSortingFieldBuyPrice;       //买1价
extern NSString * const MCategoryCFFSortingFieldBuyVol;         //买1量
extern NSString * const MCategoryCFFSortingFieldSellPrice;      //卖1价
extern NSString * const MCategoryCFFSortingFieldSellVol;        //卖1量

extern NSString * const MCategoryCFFSortingFieldChange1;            //涨跌1
extern NSString * const MCategoryCFFSortingFieldIntersectionNum;    //交割点数
extern NSString * const MCategoryCFFSortingFieldEntrustBuyVolume;   //委买
extern NSString * const MCategoryCFFSortingFieldEntrustSellVolume;  //委卖
extern NSString * const MCategoryCFFSortingFieldEntrustDiff;     //委差
extern NSString * const MCategoryCFFSortingFieldPosDiff;     //仓差
extern NSString * const MCategoryCFFSortingFieldOrderRatio;  //委比
extern NSString * const MCategoryCFFSortingFieldAmplitudeRate; //振幅
extern NSString * const MCategoryCFFSortingFieldExcercisePx;        //行权价
extern NSString * const MCategoryCFFSortingFieldPremiumRate;        //溢价率
extern NSString * const MCategoryCFFSortingFieldImpliedVolatility;  //隐含波动率
extern NSString * const MCategoryCFFSortingFieldRiskFreeInterestRate;    //无风险利率
extern NSString * const MCategoryCFFSortingFieldLeverageRatio;      //杠杆比率
extern NSString * const MCategoryCFFSortingFieldRemainDays;         //剩余天数


//股指期货 专有
extern NSString * const MCategoryCFFSortingFieldUnderlyingLastPx;      //标的现价
extern NSString * const MCategoryCFFSortingFieldUnderlyingPreClose;    //标的昨收
extern NSString * const MCategoryCFFSortingFieldUnderlyingChange;      //标的涨跌
extern NSString * const MCategoryCFFSortingFieldUnderlyingSymbol;      //标的名称


/*! @brief 获取AH股列表，支持排序
 * 特别说明：支持两种模式, 当endIndex > 0 时执行第二种
 * 1、pageSize、pageIndex  翻页方式查询
 * 2、beginIndex、endIndex 按指定条目范围返回结果
 */
@interface MAHQuoteListRequest : MListRequest
/** 笔数 */
@property (nonatomic, assign) NSInteger pageSize;
/** 起始位置 */
@property (nonatomic, assign) NSInteger beginIndex;
/** 结束位置 */
@property (nonatomic, assign) NSInteger endIndex;
/** 排序栏位 */
@property (nonatomic, assign) MAHQuoteListField field;
/** 排列顺序 */
@property (nonatomic, assign) BOOL ascending;
@end


/*! @brief 获取沪伦通股列表，支持排序
 */
@interface MDRQuoteListRequest : MListRequest
/** 代码 传入cdr 或者 gdr*/
@property (nonatomic, copy) NSString * code;
/** 笔数,默认20 */
@property (nonatomic, assign) NSInteger pageSize;
/** 排序栏位,默认涨幅排序：MDRQuoteListFieldChangeRate */
@property (nonatomic, assign) MDRQuoteListField field;
/** 排列顺序,默认NO */
@property (nonatomic, assign) BOOL ascending;
@end


#pragma mark 板块、个股所属板块
/*! @brief 板块排行请求类
 * 特别说明：支持两种模式, 当endIndex > 0 时执行第二种
 * 1、pageSize、pageIndex  翻页方式查询
 * 2、beginIndex、endIndex 按指定条目范围返回结果
 */
@interface MSectionSortingRequest : MListRequest
/** 板块代码 */
@property (nonatomic, copy) NSString *code;
/** 笔数 */
@property (nonatomic, assign) NSInteger pageSize;
/** 起始位置 */
@property (nonatomic, assign) NSInteger beginIndex;
/** 结束位置 */
@property (nonatomic, assign) NSInteger endIndex;
/** 排列顺序 */
@property (nonatomic, assign) BOOL ascending;
/** 排序栏位 */
@property (nonatomic, assign) MSectionSortingField field;
@property (nonatomic, copy) NSString *str_field;
@end

/*! @brief 个股所属板块行情请求类
 */
@interface MSectionQuoteRequest : MRequest
/** 股票代码*/
@property (nonatomic, copy) NSString *code;

@end



#pragma mark 涨跌统计
/*! @brief 指数成分股及沪深市场涨跌平家数请求类
 */
@interface MIndexUpdownsRequest : MRequest
/* 指数代码(只可单笔查询), 如 000001.sh
 * 沪深A股, 固定传SHSZ
 */
@property (nonatomic, copy) NSString *code;

@end

/*! @brief 沪深当日涨跌统计数据请求类
 */
@interface MMarketUpdownsRequest : MRequest

@end

#pragma mark 期权行情
/*! @brief 期权行情请求类
 *
 *  请求期权行情列表，若期权类别设置为MOptionTypeUnknown可查询认购及认沽的期权股票。
 */
@interface MOptionRequest : MListRequest
/** 标的证券代码 */
@property (nonatomic, copy) NSString *stockID;
/** 期权类别 */
@property (nonatomic) MOptionType optionType;
@end

/*! @brief 期权T型报价行情请求类
 *
 *  请求期权T型报价行情列表。
 */
@interface MOptionTRequest : MRequest
/** 标的证券代码 */
@property (nonatomic, copy) NSString *stockID;
/** 期权交割月 */
@property (nonatomic, copy) NSString *expireMonth;
@end

/*! @brief 标的证券列表请求类
 */
@interface MUnderlyingStockRequest : MRequest

@end

/*! @brief 交割月列表请求类
 */
@interface MExpireMonthRequest : MRequest
/** 标的证券代码 */
@property (nonatomic, copy) NSString *stockID;
@end

#pragma mark 分价
/*! @brief 分价量表请求类
 */
@interface MPriceVolumeRequest : MRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
/** 次类别 */
@property (nonatomic, copy) NSString *subtype;
@end

#pragma mark 港股专有行情
/*! @brief 港股其他资讯请求类
 */
@interface MHKQuoteInfoRequest : MRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
/** 次类别 */
@property (nonatomic, copy) NSString *subtype;
@end

/*! @brief 港股的价差表请求类
 */
@interface MHKPriceDiffRequest : MRequest

@end


#pragma mark 港股通余额

/*! @brief 两市港股通
 *
 *  包含每日初始额度 日中剩余额度和额度状态
 */
@interface MHKMarketInfoRequest : MRequest
@end

/*! @brief 沪股通和深股通额度接口
 */
@interface MHSAmountRequest : MRequest

@end

#pragma mark 假日档、次新股、次新债
/*! @brief 假日档请求类
 */
@interface MMarketHolidayRequest : MRequest

@end

/*! @brief 次新股请求类
 */
@interface MSubnewStockRankingRequest : MListRequest
/** 笔数 */
@property (nonatomic, assign) NSInteger pageSize;
/** 排列顺序 */
@property (nonatomic, assign) BOOL ascending;
/** 排序栏位 */
@property (nonatomic, assign) MSubnewStockRankingField field;
@property (nonatomic, copy) NSString *str_field;
@end

/*! @brief 次新债请求类
 */
@interface MSubnewBondRankingRequest : MListRequest
/** 笔数 */
@property (nonatomic, assign) NSInteger pageSize;
/** 排列顺序 */
@property (nonatomic, assign) BOOL ascending;
/** 排序栏位 */
@property (nonatomic, assign) MSubnewBondRankingField field;
@end


#pragma mark 市场当年交易日接口
/*! @brief 市场当年交易日接口
 * 
 */
@interface MTradeDateRequest : MRequest
/** 
 * 市场别：SH（沪市）,SZ（深市）,BJ（新三板）,HK（港股）,SHHK（沪港通）,SZHK（深港通）,CFF（中金所）,ZCE（郑商所）,DCE（大商所）
 * 多市场用逗号(,)隔开
 */
@property (nonatomic, copy) NSString *market;
/** 传入日期获取当前日期的日历数据，格式：yyyyMMdd，当为nil时获取该市场的当年所有的日历 */
@property (nonatomic, copy) NSString *date;
@property (nonatomic, strong) NSDictionary *param __attribute__((deprecated("已弃用，请使用market获取市场当年所有交易日数据，最近6日交易日数据请使用MAddValueItem中lastTradeDates字段")));
@end



#pragma mark - 应答类类

/*! @brief 应答类类
 *
 *  MResponse为应答类数据的基类
 */
@interface MResponse : MApiModel
/** 回传代码 */
@property (nonatomic, assign) MResponseStatus status;
/** 回传信息 */
@property (nonatomic, readonly) NSString *message;
/** 更新时间 */
@property (nonatomic, copy) NSString *datetime;
/** 总页次 */
@property (nonatomic, assign) NSUInteger numberOfPages;
/** 总条数 */
@property (nonatomic, assign) NSUInteger totalNumber;
/** 请求对象 */
@property (nonatomic, weak) MRequest *request;
/**
 *  是否为缓存数据
 *
 *  YES:缓存数据, NO:真实数据(目前只有走势及k线数据支持缓存数据的回传)
 */
@property (nonatomic, assign) BOOL isCacheResponse;
@end

@interface MAnnouncementResponse : MResponse
@property (nonatomic, readonly, copy) NSString *announcementTitle;
@property (nonatomic, readonly, copy) NSString *announcementContent;
@property (nonatomic, readonly, copy) NSString *announcementDatetime;
@end

/**
 *  取得更版信息
 */
@interface MCheckVersionResponse : MResponse
@property (nonatomic, strong) NSDictionary *versionInfo;
@property (nonatomic, readonly, copy) NSString *versionStatus;
@property (nonatomic, readonly, copy) NSString *downloadURLString;
@property (nonatomic, readonly, copy) NSString *checkVersionDescription;
@property (nonatomic, readonly, copy) NSString *version;
@end


/*! @brief 使用者行为记录应答类
 */
@interface MEventResponse : MResponse

@end


/*! @brief 取得可使用的分类类别应答类
 */
@interface MGetSourceClassResponse : MResponse
@property (nonatomic, strong) NSDictionary *sourceClassInfos;
@end

/*! @brief 取得主选单功能应答类
 */
@interface MGetMenuResponse : MResponse
@property (nonatomic, strong) NSDictionary *menuDictionary;
@end

/**
 *  各券商APP可使用的资讯源类别
 */
@interface MGetSourceResponse : MResponse
/**资讯源类别资料 */
@property (nonatomic, strong) NSDictionary *sourceInfos;
@end

/*! @brief 股票行情应答类
 *
 *  透过MQuoteRequest取得之股票行情回传数据，包含单笔或多笔股票行情
 */
@interface MQuoteResponse : MResponse
/** 股票行情列表 */
@property (nonatomic, strong) NSArray MAPI_OBJ_STOCK_TYPE *stockItems;
@end

/*! @brief 交易行情应答类
 */
@interface MTradeQuoteResponse : MResponse
/** 交易行情数据 */
@property (nonatomic, strong) MTradeItem *tradeItem;
@end

/*! @brief 港股价差表应答类
 */
@interface MHKPriceDiffResponse : MResponse
/** 价差表 */
@property (nonatomic, strong) NSDictionary *HKPriceDiffs;
@end

/*! @brief 行销宣传页应答类
 */
@interface MAdvertResponse : MResponse
/** 分类列表 */
@property (nonatomic, strong) NSDictionary *advertDictionary;
@end

/*! @brief 股票快照行情应答类
 */
@interface MSnapQuoteResponse : MResponse
/** 股票快照行情 */
@property (nonatomic, strong) MStockItem *stockItem;
@property (nonatomic, strong) NSArray *orderQuantityBuyItems;
@property (nonatomic, strong) NSArray *orderQuantitySellItems;
@property (nonatomic, strong) NSArray *buyBrokerSeatItems;
@property (nonatomic, strong) NSArray *sellBrokerSeatItems;
@end

/*! @brief 板块指数行情应答类
 */
@interface MPlateIndexQuoteResponse : MResponse

@property (nonatomic, strong) NSArray MAPI_OBJ_PLATE_INDEX_TYPE *plateIndexItems;

@end

/*! @brief UK快照行情应答类
 */
@interface MUKQuoteResponse : MResponse
/** 股票行情列表 */
@property (nonatomic, strong) NSArray MAPI_OBJ_UK_TYPE *stockItems;
@end

/*! @brief AH联动应答类
 */
@interface MAHQuoteResponse : MResponse
/** 联动代码 */
@property (nonatomic, copy) NSString *linkageCode;
/** 联动代码最新价 */
@property (nonatomic, copy) NSString *lastPrice;
/** 联动代码昨收价 */
@property (nonatomic, copy) NSString *preClosePrice;
/** 联动代码涨跌幅 */
@property (nonatomic, copy) NSString *changeRate;
/** 联动代码溢价率 */
@property (nonatomic, copy) NSString *premiumRate;
@end

/*! @brief 可转债与正股联动应答类
 */
@interface MLinkQuoteResponse : MResponse
/** 可转债与正股列表 */
@property (nonatomic, strong) NSArray MAPI_OBJ_LINK_TYPE *items;
@end

/*! @brief 沪伦通联动应答类
 */
@interface MDRLinkResponse : MResponse
/** 代码 */
@property (nonatomic, copy) NSString *code;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 次类别 */
@property (nonatomic, copy) NSString *subtype;
/** 最新价 */
@property (nonatomic, copy) NSString *lastPrice;
/** 前收盘价 */
@property (nonatomic, copy) NSString *preClosePrice;
/** 涨幅 */
@property (nonatomic, copy) NSString *changeRate;
/** 涨跌 */
@property (nonatomic, copy) NSString *change;
/** 联动代码溢价率 */
@property (nonatomic, copy) NSString *premiumRate;
@end

/*! @brief AH股列表应答类
 */
@interface MAHQuoteListResponse : MResponse
/** AH列表 */
@property (nonatomic, strong) NSArray MAPI_OBJ_AH_TYPE *ahItems;
@end

/*! @brief 沪伦通股列表应答类
 */
@interface MDRQuoteListResponse : MResponse
/** 沪伦通列表 */
@property (nonatomic, strong) NSArray MAPI_OBJ_CDR_GDR_TYPE *items;
@end

/*! @brief 指数成分股及沪深市场涨跌平家数应答类
 */
@interface MIndexUpdownsResponse : MResponse
/** 上涨家数 */
@property (nonatomic, copy) NSString *advanceCount;
/** 下跌家数 */
@property (nonatomic, copy) NSString *declineCount;
/** 平盘家数 */
@property (nonatomic, copy) NSString *equalCount;
@end

/*! @brief 沪深当日涨跌统计数据应答类
 */
@interface MMarketUpdownsResponse : MResponse
/** 上涨家数 */
@property (nonatomic, copy) NSString *advanceCount;
/** 下跌家数 */
@property (nonatomic, copy) NSString *declineCount;
/** 平盘家数 */
@property (nonatomic, copy) NSString *equalCount;
/** 涨停家数 */
@property (nonatomic, copy) NSString *limitUpCount;
/** 跌停家数 */
@property (nonatomic, copy) NSString *limitDownCount;
/** 昨日统计时间 */
@property (nonatomic, copy) NSString *preDatetime;
/** 昨日上涨家数 */
@property (nonatomic, copy) NSString *preAdvanceCount;
/** 昨日下跌家数 */
@property (nonatomic, copy) NSString *preDeclineCount;
/** 昨日平盘家数 */
@property (nonatomic, copy) NSString *preEqualCount;
/** 昨日涨停家数 */
@property (nonatomic, copy) NSString *preLimitUpCount;
/** 昨日跌停家数 */
@property (nonatomic, copy) NSString *preLimitDownCount;
/** 区间涨跌家数，0到19依次表示(-∞,-9),[-9,-8),[-8,-7),[-7,-6),[-6,-5),[-5,-4),[-4,-3),[-3,-2),[-2,-1),[-1,0),[0],(0,1],(1,2],(2,3],(3,4],(4,5],(5,6],(6,7],(7,8],(8,9],(9,+∞]区间的数量 */
@property (nonatomic, strong) NSArray *list;

@end

/*! @brief 板块排行应答类
 */
@interface MSectionRankingResponse : MResponse
/** 板块排行列表 */
@property (nonatomic, strong) NSArray MAPI_OBJ_SECTION_RANKING_TYPE *sectionRankingItems;
@end

/*! @brief 板块行情应答类
 */
@interface MSectionQuoteResponse : MResponse
/** 板块行情列表 */
@property (nonatomic, strong) NSArray MAPI_OBJ_SECTION_SORTING_TYPE *sectionQuoteItems;
@end

/*! @brief 板块排行应答类
 */
@interface MSectionSortingResponse : MResponse
/** 板块排行列表 */
@property (nonatomic, strong) NSArray MAPI_OBJ_SECTION_SORTING_TYPE *sectionSortingItems;
@end

/*! @brief 分类涨幅排行应答类
 */
@interface MRiseRankingResponse : MResponse
/** 股票区块列表 */
@property (nonatomic, strong) NSArray MAPI_OBJ_STOCK_TYPE *stockItems;
@end

/*! @brief 分类跌幅排行应答类
 */
@interface MFallRankingResponse : MResponse
/** 股票区块列表 */
@property (nonatomic, strong) NSArray MAPI_OBJ_STOCK_TYPE *stockItems;
@end

/*! @brief 分类跌跌幅排行应答类
 */
@interface MCategorySortingResponse : MResponse
/** 股票区块列表 */
@property (nonatomic, strong) NSArray MAPI_OBJ_STOCK_TYPE *stockItems;
@end

/*! @brief 走势数据应答类
 */
@interface MChartResponse : MResponse
/** 走势数据数组 */
@property (nonatomic, strong) NSArray MAPI_OBJ_OHLC_TYPE *OHLCItems;
/** 盘后数据数组 */
@property (nonatomic, strong) NSArray MAPI_OBJ_OHLC_TYPE *AFItems;
/** 交易日，若五日则有五个交易日、若分时则显示当日 */
@property (nonatomic, strong) NSArray *tradeDates;
/** 指数交易时间 */
@property (nonatomic, copy) NSString *systemDatetime;
/** 叠加股票数据 */
@property (nonatomic, strong) MChartResponse *superpositionResponse;
@end

/*! @brief 历史走势数据应答类
 */
@interface MHistoryChartResponse : MResponse
/** 走势数据数组 */
@property (nonatomic, strong) NSArray MAPI_OBJ_OHLC_TYPE *OHLCItems;
@end

/*! @brief 集合竞价走势数据应答类
 */
@interface MBidChartResponse : MResponse
/** 走势数据数组 */
@property (nonatomic, strong) NSArray MAPI_OBJ_BID_TYPE *bidItems;
@end

/*! @brief 科创板盘后交易数据应答类
 */
@interface MAfterHoursChartResponse : MResponse
/** 数据数组 */
@property (nonatomic, strong) NSArray MAPI_OBJ_OHLC_TYPE *OHLCItems;
/** 指数交易时间 */
@property (nonatomic, copy) NSString *systemDatetime;
@end

/** 大商所、郑商所、国际指数及外汇走势数据 */
@interface MChartResponse (DCEZCD)
/** 交易时间段 */
@property (nonatomic, strong) NSArray *timezones;
/** 昨收价 */
@property (nonatomic, copy) NSString *preClosePrice;
/** 昨结算价（期货） */
@property (nonatomic, copy) NSString *preSettlementPrice;
/** 小数位数 */
@property (nonatomic, assign) UInt8 decimal;
/** 成交量单位 */
@property (nonatomic, assign) NSInteger volumeUnit;
@end

/*! @brief 走势指标应答类
 */
@interface MChartIndexResponse : MResponse
/** 走势指标数据数组 */
@property (nonatomic, strong) NSArray MAPI_OBJ_OHLC_TYPE *OHLCItems;
/** 开始 */
@property (nonatomic, assign) NSInteger beginIndex;
/** 结束 */
@property (nonatomic, assign) NSInteger endIndex;
@end

/*! @brief 历史行情应答类
 */
@interface MOHLCResponse : MResponse
/** K线数据数组 */
@property (nonatomic, strong) NSArray MAPI_OBJ_OHLC_TYPE *OHLCItems;
/** 复权信息（当请求前后复权时返回） */
@property (nonatomic, strong) NSArray MAPI_OBJ_FQ_TYPE *FQItems;
/** 补足当前一笔资料 */
- (NSArray *)OHLCItemsByPeriodType:(MOHLCPeriod)period andSnapshotStockItem:(MStockItem *)stockItem __attribute__((deprecated("已弃用，返回的数据已经包括当前第一笔资料")));
@end

/** 大商所、郑商所、国际指数及外汇K线数据 */
@interface MOHLCResponse (DCEZCD)
/** 小数位数 */
@property (nonatomic, assign) UInt8 decimal;
/** 成交量单位 */
@property (nonatomic, assign) NSInteger volumeUnit;
@end

/*! @brief 期权行情应答类
 */
@interface MOptionResponse : MResponse
/** 期权行情列表 */
@property (nonatomic, strong) NSArray MAPI_OBJ_OPTION_TYPE *optionItems;
@end

/*! @brief 交割月应答类
 */
@interface MExpireMonthResponse : MResponse
/** 交割月列表 */
@property (nonatomic, strong) NSArray *expireMonths;
@end

/*! @brief 标的证券应答类
 */
@interface MUnderlyingStockResponse : MResponse
/** 标的证券列表 */
@property (nonatomic, strong) NSArray MAPI_OBJ_STOCK_TYPE *stockItems;
@end


/*! @brief 板块分类即时行情应答类
 */
@interface MCategoryQuoteListResponse : MResponse
/** 分类即时列表 */
@property (nonatomic, strong) NSArray MAPI_OBJ_STOCK_TYPE *categoryQuoteItems;
@end

/*! @brief 搜索股票应答类
 */
@interface MSearchResponse : MResponse
/** 搜寻结果列表 */
@property (nonatomic, strong) NSArray MAPI_OBJ_SEARCH_RESULT_TYPE *resultItems;
@end

/*! @brief 经纪席位应答类
 */
@interface MBrokerSeatResponse : MResponse
/** 经纪席位(买) */
@property (nonatomic, strong) NSArray MAPI_OBJ_BROKER_SEAT_TYPE *buyBrokerSeatItems;
/** 经纪席位(卖) */
@property (nonatomic, strong) NSArray MAPI_OBJ_BROKER_SEAT_TYPE *sellBrokerSeatItems;
@end

/*! @brief 股票代码请求类
 */
@interface MStockTableResponse : MSearchResponse
/** 版本号 */
@property (nonatomic, copy) NSString *version;
@end

/*! @brief 股票代码单市场增量更新应答类
 */
@interface MIncrementstkStockTableResponse : MResponse
/** 当前请求的市场*/
@property (nonatomic, copy) NSString *market;
/** 结果列表 */
@property (nonatomic, strong) NSArray MAPI_OBJ_SEARCH_RESULT_TYPE *resultItems;
@end

/*! @brief 股票分类代码表应答类
 */
@interface MStockCategoryListResponse : MResponse
/** 代码表数组 */
@property (nonatomic, strong) NSArray *list;
@end

/*! @brief 分时明细应答类
 */
@interface MTimeTickResponse : MResponse
/** 明细数组 */
@property (nonatomic, strong) NSArray MAPI_OBJ_TICK_TYPE *items;
@property (nonatomic, copy) NSString *startIndex;
@property (nonatomic, copy) NSString *endIndex;
@end

/** 大商所、郑商所、国际指数及外汇K线数据 */
@interface MTimeTickResponse (DCEZCD)
/** 小数位数 */
@property (nonatomic, assign) UInt8 decimal;
/** 成交量单位 */
@property (nonatomic, assign) NSInteger volumeUnit;
@end

/*! @brief Level2分笔明细应答类
 */
@interface ML2TimeTickResponse : MResponse
@property (nonatomic, strong) NSArray MAPI_OBJ_TIME_TICK_TYPE *items;
@property (nonatomic, copy) NSString *startIndex;
@property (nonatomic, copy) NSString *endIndex;
@end

/*! @brief Level2逐笔明细应答类
 */
@interface ML2TimeTickDetailResponse : MResponse
@property (nonatomic, strong) NSArray MAPI_OBJ_TIME_TICK_DETAIL_TYPE *items;
@property (nonatomic, copy) NSString *startIndex;
@property (nonatomic, copy) NSString *endIndex;
@end

/*! @brief Level2分笔对逐笔详情应答类
 */
@interface MTimeTickDetailResponse : MResponse
@property (nonatomic, strong) NSArray MAPI_OBJ_TIME_TICK_TYPE *tickItems;
@property (nonatomic, strong) NSArray MAPI_OBJ_TIME_TICK_DETAIL_TYPE *detailTickItems;
@property (nonatomic, copy) NSString *startIndex;
@property (nonatomic, copy) NSString *endIndex;
@end

/*! @brief 分价量表应答类
 */
@interface MPriceVolumeResponse : MResponse
/** 代码表数组 */
@property (nonatomic, strong) NSArray MAPI_OBJ_PRICE_VOLUME_TYPE *items;
@end

/*! @brief 买卖队列应答类
 */
@interface MOrderQuantityResponse : MResponse
/** 买卖队列(买) */
@property (nonatomic, strong) NSArray *buyItems;
/** 买卖队列(买) */
@property (nonatomic, strong) NSArray *sellItems;
@end


/*! @brief 港股其他资讯应答类
 */
@interface MHKQuoteInfoResponse : MResponse
/** 碎股订单信息数组 */
@property (nonatomic, strong) NSArray MAPI_OBJ_ODD_INFO_TYPE *oddInfoItems;
/** 市场调节机制 时间 */
@property (nonatomic, copy) NSString *vcmDatetime;
/** 市场调节机制起始时间 143025 表示 14:30:25 */
@property (nonatomic, copy) NSString *vcmStartTime;
/** 市场调节机制结束时间 143025 表示 14:30:25 */
@property (nonatomic, copy) NSString *vcmEndTime;
/** 市场调节机制参考价 */
@property (nonatomic, copy) NSString *vcmRefPrice;
/** 市场调节下限价 */
@property (nonatomic, copy) NSString *vcmLowerPrice;
/** 市场调节上限价 */
@property (nonatomic, copy) NSString *vcmUpperPrice;
/** CAS 时间 */
@property (nonatomic, copy) NSString *casDatetime;
/** CAS 未能配对买卖盘的方向 N = 买卖盘量相等, B = 买盘比卖盘多, S = 卖盘比买盘多, <空格> = 不适用 */
@property (nonatomic, copy) NSString *casOrdImbDirection;
/** CAS 未能配对买卖盘的数量 */
@property (nonatomic, copy) NSString *casOrdImbQty;
/** CAS 的参考价格 */
@property (nonatomic, copy) NSString *casRefPrice;
/** CAS 下限价 */
@property (nonatomic, copy) NSString *casLowerPrice;
/** CAS 下限价 */
@property (nonatomic, copy) NSString *casUpperPrice;
@end


/*! @brief 假日档应答类
 */
@interface MMarketHolidayResponse : MResponse
/** 假日数组 */
@property (nonatomic, strong) NSDictionary *JSONObject;
@end

/*! @brief 个股静态数据应答类
 */
@interface MStaticDataResponse : MResponse
@property (nonatomic , strong) NSArray MAPI_OBJ_STATIC_DATA_TYPE *dataItems;
@end

/*! @brief 两市港股通
 *
 *  包含每日初始额度 日中剩余额度和额度状态
 */
@interface MHKMarketInfoResponse : MResponse
/**沪初始额度*/
@property (nonatomic , copy) NSString *SHInitialQuota;
/**沪日中剩余额度*/
@property (nonatomic , copy) NSString *SHRemainQuota;
/**沪港通额度状态:1:不可用,2:可用,0或者null:源没有*/
@property (nonatomic , assign) NSInteger SHStatus;
/**深初始额度*/
@property (nonatomic , copy) NSString *SZInitialQuota;
/**深日中剩余额度*/
@property (nonatomic , copy) NSString *SZRemainQuota;
/**深港通额度状态:1:不可用,2:可用,0或者null:源没有*/
@property (nonatomic , assign) NSInteger SZStatus;
@end

/*! @brief 次新股应答类
 */
@interface MSubnewStockRankingResponse : MResponse
@property (nonatomic, strong) NSArray MAPI_OBJ_SUBNEW_STOCK_RANKING_TYPE *items;
@end

/*! @brief 次新债应答类
 */
@interface MSubnewBondRankingResponse : MResponse
@property (nonatomic, strong) NSArray MAPI_OBJ_SUBNEW_BOND_RANKING_TYPE *items;
@end

/*! @brief 增值指标应答类
 */
@interface MAddValueResponse : MResponse
@property (nonatomic, strong) NSArray *addValueItems;
@end

/*! @brief 市场当年交易日应答类
 */
@interface MTradeDateResponse : MResponse
/** 日期数组 */
@property (nonatomic, strong) NSArray MAPI_OBJ_TRADE_DATE_TYPE *dates;
@property (nonatomic, strong) NSArray *infos __attribute__((deprecated("已弃用，请使用dates")));
@end

/*! @brief 沪股通和深股通额度应答内
 */
@interface MHSAmountResponse : MResponse
/** 沪股通初始额度 */
@property (nonatomic, copy) NSString *SHInitialAmount;
/** 沪股通剩余额度 */
@property (nonatomic, copy) NSString *SHRemainingAmount;
/** 深股通初始额度 */
@property (nonatomic, copy) NSString *SZInitialAmount;
/** 深股通剩余额度 */
@property (nonatomic, copy) NSString *SZRemainingAmount;

@end
#pragma mark - 数据模型

/*! @brief 数据模型基类
 */
@interface MBaseItem : MApiModel
@end

@interface MSearchBaseItem : NSManagedObject <NSCopying, NSCoding>
@end

/*! @brief 交易时间模型类
 */
@interface MTimeZone : MBaseItem
/** 开盘时间(HHmm) */
@property (nonatomic, copy) NSString *openTime;
/** 收盘时间(HHmm) */
@property (nonatomic, copy) NSString *closeTime;
/** 开盘日期(yyyyMMdd,可能为nil) */
@property (nonatomic, copy) NSString *openDate;
/** 收盘日期(yyyyMMdd,可能为nil) */
@property (nonatomic, copy) NSString *closeDate;

@end

/*! @brief 市场资讯模型类
 */
@interface MMarketInfo : MBaseItem
/** 交易单位 */
@property (nonatomic, assign) NSInteger tradeUnit;
/** 小数位数 */
@property (nonatomic, assign) UInt8 decimal;
/** 交易时间列表 */
@property (nonatomic, strong) NSArray *timezones;
/** 盘前集合竞价时间列表 */
@property (nonatomic, strong) NSArray *preTimezones;
/** 盘后交易时间列表 */
@property (nonatomic, strong) NSArray *afterTimezones;
@end

/*! @brief 历史行情
 *
 *  包含时间、开、高、低、收、量等历史行情数据。可用来绘制走势或历史k线图。
 */
@interface MOHLCItem : MBaseItem <MPlotDataItemSynthetic>
/** 时间 */
@property (nonatomic, copy) NSString *datetime;
/** 开盘价 */
@property (nonatomic, copy) NSString *openPrice;
/** 最高价 */
@property (nonatomic, copy) NSString *highPrice;
/** 最低价 */
@property (nonatomic, copy) NSString *lowPrice;
/** 收盘价 */
@property (nonatomic, copy) NSString *closePrice;
/** 交易量 */
@property (nonatomic, copy) NSString *tradeVolume;
/** 均价 */
@property (nonatomic, copy) NSString *averagePrice;
/** 昨收价 */
@property (nonatomic, copy) NSString *preClosePrice __attribute__((deprecated("请改用referencePrice")));
/** 参考价 如果是期货，就表示昨结*/
@property (nonatomic, copy) NSString *referencePrice;
/** 成交金额 */
@property (nonatomic, copy) NSString *amount;
/** 大盘红绿柱 */
@property (nonatomic, copy) NSString *rgbar;
/** 基金净值*/
@property (nonatomic, copy) NSString *IOPV;
/** 基金净值参考价*/
@property (nonatomic, copy) NSString *referenceIOPVPrice;
/** 持仓量 */
@property (nonatomic, copy) NSString *openInterest;
/** K线复权信息，若当天（日K当天，周K当周，月K当月）有复权则此字段有值，反之没有 */
@property (nonatomic, strong) NSArray MAPI_OBJ_FQ_TYPE *FQItems;
/** 盘后成交量*/
@property (nonatomic, copy) NSString *afterHoursVolume;
/** 盘后成交额*/
@property (nonatomic, copy) NSString *afterHoursAmount;
@end

/*! @brief 走势指标
 */
@interface MOHLCItem (MApiAdditionalValue)
/** ddx */
@property (nonatomic, readonly) NSString *ddx;
/** ddy */
@property (nonatomic, readonly) NSString *ddy;
/** ddz */
@property (nonatomic, readonly) NSString *ddz;
/** bbd */
@property (nonatomic, readonly) NSString *bbd;
/** ratioBS */
@property (nonatomic, readonly) NSString *ratioBS;
/** 超大单净流入 */
@property (nonatomic, readonly) NSString *largeMoneyInflow;
/** 大单净流入 */
@property (nonatomic, readonly) NSString *bigMoneyInflow;
/** 中单净流入 */
@property (nonatomic, readonly) NSString *midMoneyInflow;
/** 小单净流入 */
@property (nonatomic, readonly) NSString *smallMoneyInflow;
/** 超大单成交单数 */
@property (nonatomic, copy) NSString *largeTradeNum;
/** 大单成交单数 */
@property (nonatomic, copy) NSString *bigTradeNum;
/** 中单成交单数 */
@property (nonatomic, copy) NSString *midTradeNum;
/** 小单成交单数 */
@property (nonatomic, copy) NSString *smallTradeNum;
/** 大单净量 */
@property (nonatomic, copy) NSString *bigNetVolume;
@end

/*! @brief 股票复权信息
 */
@interface MFQItem : MBaseItem
/** 除权息日 */
@property (nonatomic, copy) NSString *dateTime;
/** 增发价 */
@property (nonatomic, copy) NSString *increasePrice;
/** 配股价 */
@property (nonatomic, copy) NSString *allotmentPrice;
/** 每股分红（包含基金分红）*/
@property (nonatomic, copy) NSString *bonusAmount;
/** 送股比例（包含基金折算比例）*/
@property (nonatomic, copy) NSString *bonusProportion;
/** 转增比例 */
@property (nonatomic, copy) NSString *increaseProportion;
/** 增发股份 */
@property (nonatomic, copy) NSString *increaseVolume;
/** 配股比例 */
@property (nonatomic, copy) NSString *allotmentProportion;
@end

/*! @brief 股票集合竞价信息
 */
@interface MBidItem : MBaseItem
/** 最新价 */
@property (nonatomic, copy) NSString *lastPrice;
/** 参考价 */
@property (nonatomic, copy) NSString *referencePrice;
/** 时间 */
@property (nonatomic, copy) NSString *datetime;
/** 买1 */
@property (nonatomic, copy) NSString *buyVolume1;
/** 买2 */
@property (nonatomic, copy) NSString *buyVolume2;
/** 卖1 */
@property (nonatomic, copy) NSString *sellVolume1;
/** 卖2 */
@property (nonatomic, copy) NSString *sellVolume2;
@end

/*! @brief 股票行情
 *
 *  股票行情类别，包含各种行情、五档等数据
 */
@interface MStockItem : MBaseItem

/** @brief 股票状态
 *
 * 参考 MStockStatus
 */
@property (nonatomic, assign) MStockStatus status;
/** @brief 交易阶段
 *
 * 参照 MStockStage
 */
@property (nonatomic, assign) MStockStage stage;
/** @brief 股票代码
 *
 * 含市场代码的股票代码
 */
@property (nonatomic, copy) NSString *ID;
/** 股票名 */
@property (nonatomic, copy) NSString *name;
/** 交易时间 */
@property (nonatomic, copy) NSString *datetime;
/** 市场别 */
@property (nonatomic, copy) NSString *market;
/** 次类别 */
@property (nonatomic, copy) NSString *subtype;
/** 最新价 */
@property (nonatomic, copy) NSString *lastPrice;
/** 最高价 */
@property (nonatomic, copy) NSString *highPrice;
/** 最低价 */
@property (nonatomic, copy) NSString *lowPrice;
/** 今开价 */
@property (nonatomic, copy) NSString *openPrice;
/** 昨收价 */
@property (nonatomic, copy) NSString *preClosePrice;
/** 均价 */
@property (nonatomic, copy) NSString *averagePrice;
/** 涨跌比率 */
@property (nonatomic, copy) NSString *changeRate;
/** 总量 */
@property (nonatomic, copy) NSString *volume;
/** 现量 */
@property (nonatomic, copy) NSString *nowVolume;
/** 最新一根分时成交量 */
@property (nonatomic, copy) NSString *lastMinuteVolume;
/** 换手率 */
@property (nonatomic, copy) NSString *turnoverRate;
/** 涨停价 */
@property (nonatomic, copy) NSString *limitUp;
/** 跌停价 */
@property (nonatomic, copy) NSString *limitDown;
/** 涨跌 */
@property (nonatomic, copy) NSString *change;
/** 成交金额 */
@property (nonatomic, copy) NSString *amount;
/** 买一价 */
@property (nonatomic, copy) NSString *buyPrice;
/** 卖一价 */
@property (nonatomic, copy) NSString *sellPrice;
/** 外盘量 */
@property (nonatomic, copy) NSString *buyVolume;
/** 内盘量 */
@property (nonatomic, copy) NSString *sellVolume;
/** 总值 */
@property (nonatomic, copy) NSString *totalValue;
/** 流值 */
@property (nonatomic, copy) NSString *flowValue;
/** 净资产 */
@property (nonatomic, copy) NSString *netAsset;
/** PE(市盈 动) */
@property (nonatomic, copy) NSString *PE;
/** SPE(市盈 静) */
@property (nonatomic, copy) NSString *SPE;
/** ROE(市净率) */
@property (nonatomic, copy) NSString *ROE;
/** 总股本 */
@property (nonatomic, copy) NSString *capitalization;
/** 流通股 */
@property (nonatomic, copy) NSString *circulatingShare;
/** 一、五、十档委买价, 买10 -> 买1 */
@property (nonatomic, strong) NSArray *buyPrices;
/** 一、五、十档委买量, 买10 -> 买1 */
@property (nonatomic, strong) NSArray *buyVolumes;
/** 一、五、十档委买笔数, 买10 -> 买1 */
@property (nonatomic, strong) NSArray *buyCount;
/** 一、五、十档委卖价, 卖1 -> 卖10 */
@property (nonatomic, strong) NSArray *sellPrices;
/** 一、五、十档委卖量, 卖1 -> 卖10*/
@property (nonatomic, strong) NSArray *sellVolumes;
/** 一、五、十档委卖笔数, 卖1 -> 卖10*/
@property (nonatomic, strong) NSArray *sellCount;
/** 委比 */
@property (nonatomic, copy) NSString *orderRatio;
/** 委差 */
@property (nonatomic, copy) NSString *entrustDiff;
/** 量比 */
@property (nonatomic, copy) NSString *volumeRatio;
/** 振幅比率 */
@property (nonatomic, copy) NSString *amplitudeRate;
/** 每股收益(全年预估) */
@property (nonatomic, copy) NSString *receipts;
/** 每股收益*/
@property (nonatomic, copy) NSString *EPS;
/** 每股收益所属报告期*/
@property (nonatomic, copy) NSString *EPSType;
/** 最新十笔明细 不支持自定义*/
@property (nonatomic, strong) NSArray *tickItems;
/** 股票代码(不含市场) */
@property (nonatomic, copy) NSString *code;
/** 涨跌状态 */
@property (nonatomic, assign) MChangeState changeState;
/** 增值指标*/
@property (nonatomic, strong) MAddValueItem *addValueItem;
/** 风险警示标识 */
@property (nonatomic, assign) MFlag FXFlag;
/** 退市整理标识 */
@property (nonatomic, assign) MFlag TSFlag;
/** 涨跌限制标识
 涨跌幅限制类型：
 ‘N’表示交易规则（2013修订版）3.4.13规定的有涨跌幅限制类型或者权证管理办法第22条规定
 ‘R’表示交易规则（2013修订版）3.4.15和3.4.16规定的无涨跌幅限制类型
 ‘S’表示回购涨跌幅控制类型
 ‘F’表示基于参考价格的涨跌幅控制
 ‘P’表示IPO上市首日的涨跌幅控制类型
 ‘U’表示无任何价格涨跌幅控制类型
 涨幅上限价格：
 对于N类型涨跌幅限制的产品，该字段当日不会更改，基于前收盘价（已首日上市交易产品为发行价）计算。
 对于R类型无涨跌幅限制的产品，该字段取开盘时基于参考价格计算的上限价格，无实际控制意义。
 对于P类型IPO上市首日产品，取连续竞价期间基于参考价格计算最大范围的上限价格，针对科创板产品，无实际控制意义。
 跌幅下限价格：
 计算方式参考涨幅上限价格
 */
@property (nonatomic, copy)NSString *UDFlag;

/**
 *  科创板
 **/
/** 市价申报数量上限 单位股*/
@property (nonatomic, copy) NSString *subscribeLimit;
/** 市价申报数量下限 单位股*/
@property (nonatomic, copy) NSString *subscribeLowerLimit;
/** 盘后成交量*/
@property (nonatomic, copy) NSString *afterHoursVolume;
/** 盘后成交额*/
@property (nonatomic, copy) NSString *afterHoursAmount;
/** 盘后成交笔数，L2才有*/
@property (nonatomic, copy) NSString *afterHoursTransactionNumber;
/** 盘后撤单买笔数，L2才有*/
@property (nonatomic, copy) NSString *afterHoursWithdrawBuyCount;
/** 盘后撤单买数量，L2才有*/
@property (nonatomic, copy) NSString *afterHoursWithdrawBuyVolume;
/** 盘后撤单卖笔数，L2才有*/
@property (nonatomic, copy) NSString *afterHoursWithdrawSellCount;
/** 盘后撤单卖数量，L2才有*/
@property (nonatomic, copy) NSString *afterHoursWithdrawSellVolume;
/** 盘后委托买入总量，L2才有*/
@property (nonatomic, copy) NSString *afterHoursBuyVolume;
/** 盘后委托卖出总量，L2才有*/
@property (nonatomic, copy) NSString *afterHoursSellVolume;
/** 投票权差异：MFlagYES表示存在差异 */
@property (nonatomic, assign) MFlag voteFlag;
/** 盈利状态：MFlagYES表示未盈利 */
@property (nonatomic, assign) MFlag unprofitableFlag;
/** 注册资本*/
@property (nonatomic, copy) NSString *regCapital;

/**
 *  可转债
 */
@property (nonatomic, strong) NSArray *linkCode;


/**
 *  国债逆回购 专有
 */
/** 加权平均价*/
@property (nonatomic, copy) NSString *weightedAveragePrice;
/** 加权平均涨跌BP*/
@property (nonatomic, copy) NSString *BP;
/** 昨收盘加权平均价*/
@property (nonatomic, copy) NSString *weightedAveragePreClosePrice;
/** 债券合格投资者是否要求，0表示不要求，1表示要求 */
@property (nonatomic, assign) MFlag investorRequirementsFlag;
/** 债券对投资者要求级别 0表示适合所有投资者，1表示投资者适当性要求，2表示机构投资者适应性要求 */
@property (nonatomic, assign) MInvestorRequirementsType investorRequirementsType;
/** 回购期限 */
@property (nonatomic, copy) NSString *termRepo;
/** 占款天数 */
@property (nonatomic, copy) NSString *takeUpDays;
/** 资金可用日期 */
@property (nonatomic, copy) NSString *fundAvailableDate;
/** 资金可取日期 */
@property (nonatomic, copy) NSString *fundReceiptedDate;
/** 最新价涨跌BP */
@property (nonatomic, copy) NSString *changeBP;

/** 港股信息状态 */
@property (nonatomic, assign) MHKInfoStatus HKInfoStatus;
/** 沪港通标识 */
@property (nonatomic, assign) MFlag HFlag;
/** 深港通标识 */
@property (nonatomic, assign) MFlag SFlag;
/** 融资标识 */
@property (nonatomic, assign) MFlag financeFlag;
/** 融券标识 */
@property (nonatomic, assign) MFlag securityFlag;
/** 同一只股票多市场 次类别 */
@property (nonatomic, copy) NSArray *subtypes;
/** 港股最小交易单位*/
@property (nonatomic, copy) NSString *HKMinTradeUnit;
/** 法定股本*/
@property (nonatomic, copy) NSString *authorisedCapital;
/** 港股股本*/
@property (nonatomic, copy) NSString *HKCapital;
/** 港股市值*/
@property (nonatomic, copy) NSString *HKValue;
/** 是否参与CAS */
@property (nonatomic, assign) MFlag CASFlag;
/** 是否参与VCM */
@property (nonatomic, assign) MFlag VCMFlag;
/** 沪股通标识 */
@property (nonatomic, assign) MFlag HGFlag;
/** 深股通标识 */
@property (nonatomic, assign) MFlag SGFlag;
/** AH股标识 */
@property (nonatomic, assign) MFlag AHFlag;
/** 港股通是否可交易 */
@property (nonatomic, assign) MHKTTradeType tradeType;

/**
 *  股票类型
 */
/** 是否为指数股票 */
@property (nonatomic, readonly, getter=isIndex) BOOL index;
/** 是否为香港股票 */
@property (nonatomic, readonly, getter=isHongKong) BOOL hongKong;
/** 是否为债券股票 */
@property (nonatomic, readonly, getter=isBond) BOOL bond;
/** 是否为基金股票 */
@property (nonatomic, readonly, getter=isFund) BOOL fund;
/** 是否为权证股票 */
@property (nonatomic, readonly, getter=isWrnt) BOOL wrnt;
/** 是否为期权股票 */
@property (nonatomic, readonly, getter=isOption) BOOL option;
/** 是否为中金所股票*/
@property (nonatomic, readonly, getter=isCff) BOOL cff;

/** 是否盈利标识 */
@property (nonatomic, assign) MFlag profitFlag __attribute__((deprecated("已弃用，请使用unprofitableFlag字段")));
/** 是否存在投票差异标识 */
@property (nonatomic, assign) MFlag voteDiffFlag __attribute__((deprecated("已弃用，请使用voteFlag字段")));


/**
 *  指数 专有 不支持自定义
 */
/** 上涨家数(指数类专用) */
@property (nonatomic, copy) NSString *advanceCount;
/** 下跌家数(指数类专用) */
@property (nonatomic, copy) NSString *declineCount;
/** 平盘家数(指数类专用) */
@property (nonatomic, copy) NSString *equalCount;


/**
 *  沪深Level2 专有 不支持自定义
 */
/** 总买量 */
@property (nonatomic, copy) NSString *totalBuyVolume;
/** 总卖量 */
@property (nonatomic, copy) NSString *totalSellVolume;
/** 均买价 */
@property (nonatomic, copy) NSString *averageBuyPrice;
/** 均卖价 */
@property (nonatomic, copy) NSString *averageSellPrice;
/** 买入撤单笔数*/
@property (nonatomic, copy) NSString *withdrawBuyCount;
/** 买入撤单总量*/
@property (nonatomic, copy) NSString *withdrawBuyVolume;
/** 买入撤单金额*/
@property (nonatomic, copy) NSString *withdrawBuyAmount;
/** 卖出撤单笔数*/
@property (nonatomic, copy) NSString *withdrawSellCount;
/** 卖出撤单总量*/
@property (nonatomic, copy) NSString *withdrawSellVolume;
/** 卖出撤单金额*/
@property (nonatomic, copy) NSString *withdrawSellAmount;


/**
 *  基金 专有
 */
/** 类别2 不支持自定义*/
@property (nonatomic, copy) NSString *subtype2;
/** 基金净值 */
@property (nonatomic, copy) NSString *IOPV;
/** 基金净值参考价*/
@property (nonatomic, copy) NSString *preIOPV;

/**
 *  新三板 专有
 */
/** 转让状态 N’表示正常状态，‘Y’表示首日挂牌，‘D’ 表示新增股票挂牌转让*/
@property (nonatomic, copy) NSString *ZRZT;
/** 转让类型 ‘T’表示协议转让方式;‘M’表示做市转让 方式;‘B’表示集合竞价+连续竞价转让方式;‘C’表示集合竞价转让方式; ‘O’表示其他类型*/
@property (nonatomic, copy) NSString *ZRLX;
/** 除权除息 ‘N’表示正常状态，‘E’表示除权，‘D’ 表示除息，‘A’表示除权除息*/
@property (nonatomic, copy) NSString *CQCX;
/** 证券级别 ‘T’表示对应证券是挂牌公司股票（允许盘后支持协议转让的挂牌股票）;
            ‘B’表示对应证券是两网公司及退市公司股票;
            ‘O’表示对应证券是仅提供行权功 能的期权;
            ‘P’表示对应证券是持有人数存在 200 人限制的证券*/
@property (nonatomic, copy) NSString *ZQJB;
/** 较上一幅涨跌*/
@property (nonatomic, copy) NSString *change2;

/**
 *  沪伦通
 **/
/** CDR标识 cdr为1时表示沪伦通cdr，为2时表示cdr基础证券*/
@property (nonatomic, copy) NSString *DR;
/** CDR标识 gdr为1时表示沪伦通gdr，为2时表示gdr基础证券*/
@property (nonatomic, copy) NSString *GDR;
/** 联动代码 CDR或GDR产品时，为对应的基础证券代码,基础证券产品时，为对应的GDR或CDR产品代码*/
@property (nonatomic, copy) NSString *DRStockCode;
/** 联动名称 CDR或GDR产品时，为对应的基础证券名称,基础证券产品时，为对应的GDR或CDR产品名称*/
@property (nonatomic, copy) NSString *DRStockName;
/** 当前份额 CDR专有*/
@property (nonatomic, copy) NSString *DRCurrentShare;
/** 前收盘份额(上一交易日) CDR专有*/
@property (nonatomic, copy) NSString *DRPreviousClosingShare;
/** 转换基数(用于计算溢价)*/
@property (nonatomic, copy) NSString *DRConversionBase;
/** 基础证券转换基数(用于计算溢价)*/
@property (nonatomic, copy) NSString *DRSecuritiesConversionBase;
/** 存托机构代码 CDR专有*/
@property (nonatomic, copy) NSString *DRDepositoryInstitutionCode;
/** 存托机构名称 CDR专有*/
@property (nonatomic, copy) NSString *DRDepositoryInstitutionName;
/** 标的收盘参考价 当请求股票为GDR股票，此价格为基础证券昨收价、当请求股票为CDR基础证券，此价格为CDR昨收价*/
@property (nonatomic, copy) NSString *DRSubjectClosingReferencePrice;
/** cdr初始流动性生成起始日 CDR专有 */
@property (nonatomic, copy) NSString *DRFlowStartDate;
/** cdr初始流动性生成终止日 CDR专有*/
@property (nonatomic, copy) NSString *DRFlowEndDate;
/** 上市日期(CDR或GDR)*/
@property (nonatomic, copy) NSString *DRListingDate;

/** 行权方式 E：欧式期权，A：美式期权 */
@property (nonatomic, copy) NSString *exeType;
/**
 *  @brief 股票比较
 *
 *  @param stockItem 欲比较的股票
 *
 *  @return 比较结果
 */
- (BOOL)isEqualToStockItem:(MStockItem *)stockItem;
@end


@interface MStockItem (MApiTopBuyFixes)
/** 一、五、十档委买价, 买1 -> 买10 */
@property (nonatomic, readonly) NSArray *buyPricesReverse;
/** 一、五、十档委买量, 买1 -> 买10 */
@property (nonatomic, readonly) NSArray *buyVolumesReverse;
/** 一、五、十档委买笔数, 买1 -> 买10 */
@property (nonatomic, readonly) NSArray *buyCountReverse;
@end

@interface MStockItem (MApiQuoteSHSZ)
@property (nonatomic, readonly) NSArray *orderQuantityBuyItems;
@property (nonatomic, readonly) NSArray *orderQuantitySellItems;
@end

@interface MStockItem (MApiQuoteHK)
@property (nonatomic, readonly) NSArray *brokerSeatBuyItems;
@property (nonatomic, readonly) NSArray *brokerSeatSellItems;
@end

/*! @brief UK行情
 */
@interface MUKItem : MBaseItem
/** 股票代码*/
@property (nonatomic, copy) NSString *ID;
/** 股票名称*/
@property (nonatomic, copy) NSString *name;
/** 交易时间 */
@property (nonatomic, copy) NSString *datetime;
/** 次类别 */
@property (nonatomic, copy) NSString *subtype;
/** 开盘价*/
@property (nonatomic, copy) NSString *openPrice;
/** 收盘价 */
@property (nonatomic, copy) NSString *lastPrice;
/** 均价 */
@property (nonatomic, copy) NSString *averagePrice;
/** 总量 */
@property (nonatomic, copy) NSString *volume;
/** 成交金额 */
@property (nonatomic, copy) NSString *amount;
/** 沪伦通标识 cdr为1时表示沪伦通cdr，为2时表示cdr基础证券*/
@property (nonatomic, copy) NSString *DR;
/** 沪伦通标识 gdr为1时表示沪伦通gdr，为2时表示gdr基础证券*/
@property (nonatomic, copy) NSString *GDR;
/** GDR基础证券代码 或者 CDR代码*/
@property (nonatomic, copy) NSString *DRStockCode;
/** GDR基础证券名称 或者 CDR名称*/
@property (nonatomic, copy) NSString *DRStockName;
/** GDR基础证券次类别 或者 CDR次类别*/
@property (nonatomic, copy) NSArray *DRSubtypes;
/** 成交笔数*/
@property (nonatomic, copy) NSString *transactionNumber;
/** 收盘买一价*/
@property (nonatomic, copy) NSString *buyPrice;
/** 收盘卖一价 */
@property (nonatomic, copy) NSString *sellPrice;
/** 日内最高价(自动交易)*/
@property (nonatomic, copy) NSString *highPriceDayAuto;
/** 日内最低价(自动交易)*/
@property (nonatomic, copy) NSString *lowPriceDayAuto;
/** 日内最高价(非自动交易)*/
@property (nonatomic, copy) NSString *highPriceNonDayAuto;
/** 日内最低价(非自动交易)*/
@property (nonatomic, copy) NSString *lowPriceNonDayAuto;
/** 近一年来最高价(自动交易)*/
@property (nonatomic, copy) NSString *highPriceYearAuto;
/** 近一年来最高价出现日期(自动交易) */
@property (nonatomic, copy) NSString *highPriceTimeYearAuto;
/** 近一年来最低价(自动交易)*/
@property (nonatomic, copy) NSString *lowPriceYearAuto;
/** 近一年来最低价出现日期(自动交易) */
@property (nonatomic, copy) NSString *lowPriceTimeYearAuto;
/** 近一年来最高价(非自动交易)*/
@property (nonatomic, copy) NSString *highPriceNonYearAuto;
/** 近一年来最高价出现日期(非自动交易) */
@property (nonatomic, copy) NSString *highPriceTimeYearNonAuto;
/** 近一年来最低价(非自动交易)*/
@property (nonatomic, copy) NSString *lowPriceNonYearAuto;
/** 近一年来最低价出现日期(非自动交易) */
@property (nonatomic, copy) NSString *lowPriceTimeYearNonAuto;
/** 币种 */
@property (nonatomic, copy) NSString *currency;
/** 上市日期(CDR或GDR)*/
@property (nonatomic, copy) NSString *listingDate;
/** 转换基数(用于计算溢价)*/
@property (nonatomic, copy) NSString *conversionBase;
/** 基础证券转换基数(用于计算溢价)*/
@property (nonatomic, copy) NSString *securitiesConversionBase;
/** 标的收盘参考价*/
@property (nonatomic, copy) NSString *subjectClosingReferencePrice;
/** 溢价*/
@property (nonatomic, copy) NSString *premiumRate;
@end

@interface MFuturesItem : MStockItem
/** 市场别 */
@property (nonatomic, copy) NSString *market;
/** 类型 */
@property (nonatomic, copy) NSString *subtype;
/** 证券代码*/
@property (nonatomic, copy) NSString *ID;
/** 股票代码(不含市场) */
@property (nonatomic, copy) NSString *code;
/** 证券简称 */
@property (nonatomic, copy) NSString *name;
/** 股票状态 */
@property (nonatomic, assign) MStockStatus status;
/** 交易阶段 */
@property (nonatomic, assign) MStockStage stage;
/** 昨收价 */
@property (nonatomic, copy) NSString *preClosePrice;
/** 今开价 */
@property (nonatomic, copy) NSString *openPrice;
/** 最高价 */
@property (nonatomic, copy) NSString *highPrice;
/** 最低价 */
@property (nonatomic, copy) NSString *lowPrice;
/** 最新价 */
@property (nonatomic, copy) NSString *lastPrice;
/** 均价 */
@property (nonatomic, copy) NSString *avgPrice;
/** 涨跌2 */
@property (nonatomic, copy) NSString *change;
/** 涨跌1 */
@property (nonatomic, copy) NSString *change1;/////////
/** 涨跌比率 */
@property (nonatomic, copy) NSString *changeRate;
/** 涨跌状态 */
@property (nonatomic, assign) MChangeState changeState;
/** 成交量 */
@property (nonatomic, copy) NSString *volume;
/** 成交金额 */
@property (nonatomic, copy) NSString *amount;
/** 当前成交量 */
@property (nonatomic, copy) NSString *nowVolume;
/** 内盘量 */
@property (nonatomic, copy) NSString *sellVolume;
/** 外盘量 */
@property (nonatomic, copy) NSString *buyVolume;
/** 交易日 */
@property (nonatomic, copy) NSString *tradingDay;
/** 最后交易日*/
@property (nonatomic, copy) NSString *finalTradeDate;
/** 结算组代码 */
@property (nonatomic, copy) NSString *settlementGroupID;
/** 结算编号*/
@property (nonatomic, copy) NSString *settlementID;
/** 昨结算*/
@property (nonatomic, copy) NSString *preSettlement;
/** 昨持仓量*/
@property (nonatomic, copy) NSString *preOpenInterest;
/** 持仓量*/
@property (nonatomic, copy) NSString *openInterest;
/** 振幅比率 */
@property (nonatomic, copy) NSString *amplitudeRate;
/** 仓差 */
@property (nonatomic, copy) NSString *posDiff;
/** 日增*/
@property (nonatomic, copy) NSString *positionChg;
/** 交割点数 */
@property (nonatomic, copy) NSString *intersectionNum;///////
/** 今收盘价*/
@property (nonatomic, copy) NSString *close;
/** 今结算价*/
@property (nonatomic, copy) NSString *settlement;
/** 涨停价 */
@property (nonatomic, copy) NSString *limitUp;
/** 跌停价 */
@property (nonatomic, copy) NSString *limitDown;
/** 昨虚实度 */
@property (nonatomic, copy) NSString *preDelta;
/** 今虚实度 */
@property (nonatomic, copy) NSString *currDelta;
/** 委买 */
@property (nonatomic, copy) NSString *entrustBuyVolume;/////
/** 委卖 */
@property (nonatomic, copy) NSString *entrustSellVolume;/////
/** 委比 */
@property (nonatomic, copy) NSString *orderRatio;
/** 委差 */
@property (nonatomic, copy) NSString *entrustDiff;
/** 最后修改毫秒 */
@property (nonatomic, copy) NSString *updateMillisec;
/** 标的品种 */
@property (nonatomic, copy) NSString *underlyingType;
/** 标的名称 */
@property (nonatomic, copy) NSString *underlyingSymbol;
/** 标的昨收 */
@property (nonatomic, copy) NSString *underlyingPreClose;
/** 标的涨跌 */
@property (nonatomic, copy) NSString *underlyingChange;
/** 标的现价*/
@property (nonatomic, copy) NSString *underlyingLastPx;
/** 期现差 */
@property (nonatomic, copy) NSString *currDiff;
/** 交割日 */
@property (nonatomic, copy) NSString *deliveryDay;
/** 行权价 */
@property (nonatomic, copy) NSString *excercisePx;
/** 期权类别(Call or Put) */
@property (nonatomic, assign) MOptionType optionType;
/** 溢价率 */
@property (nonatomic, copy) NSString *premiumRate;
/** 隐含波动率 */
@property (nonatomic, copy) NSString *impliedVolatility;
/** 无风险利率 */
@property (nonatomic, copy) NSString *riskFreeInterestRate;
/** 风险指示，依次为：delta,gamma,theta,vega,rho */
@property (nonatomic, copy) NSArray *riskIndicator;
/** 杠杆比率 */
@property (nonatomic, copy) NSString *leverageRatio;
/** 剩余天数 */
@property (nonatomic, copy) NSString *remainDays;
/**
 *  行情列表  专有 MQuoteRequest、MCategorySortingRequest
 */
/** 买一价 */
@property (nonatomic, copy) NSString *buyPrice;
/** 卖一价 */
@property (nonatomic, copy) NSString *sellPrice;
/** 买一量 */
@property (nonatomic, copy) NSString *buyVol;
/** 卖一量 */
@property (nonatomic, copy) NSString *sellVol;

/**
 *  行情快照 专有 MSnapQuoteRequest
 */
/** 一、五档委买价, 买5 -> 买1 */
@property (nonatomic, strong) NSArray *buyPrices;
/** 一、五档委买量, 买5 -> 买1 */
@property (nonatomic, strong) NSArray *buyVolumes;
/** 一、五档委卖价, 卖1 -> 卖5 */
@property (nonatomic, strong) NSArray *sellPrices;
/** 一、五档委卖量, 卖1 -> 卖5*/
@property (nonatomic, strong) NSArray *sellVolumes;


@end

/*! @brief 中金所行情
 */
@interface MCFFItem : MFuturesItem

@end


@interface MPlateIndexItem : MBaseItem
/** 名称 */
@property (nonatomic, copy) NSString *blockName;
/** 代码 */
@property (nonatomic, copy) NSString *blockId;
/** 市场 */
@property (nonatomic, copy) NSString *blockMarket;
/** 交易时间 */
@property (nonatomic, copy) NSString *datetime;
/** 最新价 */
@property (nonatomic, copy) NSString *blockIndex;
/** 昨收价 */
@property (nonatomic, copy) NSString *preCloseBlockIndex;
/** 开盘价 */
@property (nonatomic, copy) NSString *openBlockIndex;
/** 最高价 */
@property (nonatomic, copy) NSString *highBlockIndex;
/** 最低价 */
@property (nonatomic, copy) NSString *lowBlockIndex;
/** 涨跌状态 */
@property (nonatomic, assign) MChangeState changeState;
/** 涨跌幅 */
@property (nonatomic, copy) NSString *indexChg;
/** 涨跌额 */
@property (nonatomic, copy) NSString *upsDowns;
/** 振幅 */
@property (nonatomic, copy) NSString *amplitude;
/** 权涨幅 */
@property (nonatomic, copy) NSString *blockChg;
/** 均涨幅 */
@property (nonatomic, copy) NSString *averageChg;
/** 换手率 */
@property (nonatomic, copy) NSString *turnoverRate;
/** 涨跌平家数 0:涨 1:跌 2:平 */
@property (nonatomic, strong) NSArray *ratioUpDown;
/** 成交额 */
@property (nonatomic, copy) NSString *totalTrdMoney;
/** 成交量 */
@property (nonatomic, copy) NSString *totalTrdVolume;
/** 流通市值 */
@property (nonatomic, copy) NSString *blockFAMC;
/** 总市值 */
@property (nonatomic, copy) NSString *totalMarketValue;
/** 委比 */
@property (nonatomic, copy) NSString *committee;
/** 委差 */
@property (nonatomic, copy) NSString *deviation;
/** 委买 */
@property (nonatomic, copy) NSString *buyNum;
/** 委卖 */
@property (nonatomic, copy) NSString *sellNum;
/** 动态市盈率 */
@property (nonatomic, copy) NSString *ttm;
/** 静态市盈率 */
@property (nonatomic, copy) NSString *lyr;
/** 市净率 */
@property (nonatomic, copy) NSString *marketRate;
/** 5日指数涨跌幅 */
@property (nonatomic, copy) NSString *indexChg5;
/** 10日指数涨跌幅 */
@property (nonatomic, copy) NSString *indexChg10;
/** 超大单净流入 */
@property (nonatomic, copy) NSString *largeMoneyNetInflow;
/** 大单净流入 */
@property (nonatomic, copy) NSString *bigMoneyNetInflow;
/** 中单净流入 */
@property (nonatomic, copy) NSString *midMoneyNetInflow;
/** 小单净流入 */
@property (nonatomic, copy) NSString *smallMoneyNetInflow;
/** 主力资金流入 */
@property (nonatomic, copy) NSString *mainforceMoneyInflow;
/** 主力资金流出 */
@property (nonatomic, copy) NSString *mainforceMoneyOutflow;
/** 主力资金净流入 */
@property (nonatomic, copy) NSString *mainforceMoneyNetInflow;
/** 5日主力资金净流入 */
@property (nonatomic, copy) NSString *mainforceMoneyNetInflow5;
/** 10日主力资金净流入 */
@property (nonatomic, copy) NSString *mainforceMoneyNetInflow10;
/** 超大单买入成交量 */
@property (nonatomic, copy) NSString *largeVolumeB;
/** 超大单卖出成交量 */
@property (nonatomic, copy) NSString *largeVolumeS;
/** 超大单买入成交额 */
@property (nonatomic, copy) NSString *largeMoneyB;
/** 超大单卖出成交额 */
@property (nonatomic, copy) NSString *largeMoneyS;
/** 大单买入成交量 */
@property (nonatomic, copy) NSString *bigVolumeB;
/** 大单卖出成交量 */
@property (nonatomic, copy) NSString *bigVolumeS;
/** 大单买入成交额 */
@property (nonatomic, copy) NSString *bigMoneyB;
/** 大单卖出成交额 */
@property (nonatomic, copy) NSString *bigMoneyS;
/** 中单买入成交量 */
@property (nonatomic, copy) NSString *midVolumeB;
/** 中单卖出成交量 */
@property (nonatomic, copy) NSString *midVolumeS;
/** 中单买入成交额 */
@property (nonatomic, copy) NSString *midMoneyB;
/** 中单卖出成交额 */
@property (nonatomic, copy) NSString *midMoneyS;
/** 小单买入成交量 */
@property (nonatomic, copy) NSString *smallVolumeB;
/** 小单卖出成交量 */
@property (nonatomic, copy) NSString *smallVolumeS;
/** 小单买入成交额 */
@property (nonatomic, copy) NSString *smallMoneyB;
/** 小单卖出成交额 */
@property (nonatomic, copy) NSString *smallMoneyS;
/** 20日主力资金净流入 */
@property (nonatomic, copy) NSString *mainforceMoneyNetInflow20;
/** 5日主力资金净流入占比 */
@property (nonatomic, copy) NSString *ratioMainforceMoneyNetInflow5;
/** 10日主力资金净流入占比 */
@property (nonatomic, copy) NSString *ratioMainforceMoneyNetInflow10;
/** 20日主力资金净流入占比 */
@property (nonatomic, copy) NSString *ratioMainforceMoneyNetInflow20;

@end


@interface MTradeItem : MBaseItem
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
/** 股票名称 */
@property (nonatomic, copy) NSString *name;
/** 子类型 */
@property (nonatomic, copy) NSString *subtype;
/** 一、五、十档委买价, 买10 -> 买1 */
@property (nonatomic, strong) NSArray *buyPrices;
/** 一、五、十档委买量, 买10 -> 买1 */
@property (nonatomic, strong) NSArray *buyVolumes;
/** 一、五、十档委卖价, 卖1 -> 卖10 */
@property (nonatomic, strong) NSArray *sellPrices;
/** 一、五、十档委卖量, 卖1 -> 卖10*/
@property (nonatomic, strong) NSArray *sellVolumes;
/** 最新价 */
@property (nonatomic, copy) NSString *lastPrice;
/** 昨收价 */
@property (nonatomic, copy) NSString *preClosePrice;
/** 涨停价 */
@property (nonatomic, copy) NSString *limitUp;
/** 跌停价 */
@property (nonatomic, copy) NSString *limitDown;
/** 涨跌 */
@property (nonatomic, copy) NSString *change;
/** 涨跌比率 */
@property (nonatomic, copy) NSString *changeRate;
/** 涨跌状态 */
@property (nonatomic, assign) MChangeState changeState;
/** 数量单位（手转股单位） */
@property (nonatomic, copy) NSString *buyVolumeUnit;
/** 数量单位（手转股单位） */
@property (nonatomic, copy) NSString *sellVolumeUnit;
/** 价格档位（港股请使用MHKPriceDiffRequest接口获取对照表，配合priceDiffType查询，） */
@property (nonatomic, copy) NSString *priceUnit;
/** 港股价差类别 */
@property (nonatomic, copy) NSString *priceDiffType;
@end

/*! @brief 期权行情
 */
@interface MOptionItem : MStockItem
/** 合约代码 */
@property (nonatomic, copy) NSString *contractID;
/** 标的证券代码 */
@property (nonatomic, copy) NSString *stockID;
/** 标的证券简称 */
@property (nonatomic, copy) NSString *stockSymble;
/** 标的证券类型 */
@property (nonatomic, copy) NSString *stockType;
/** 合约单位 */
@property (nonatomic, copy) NSString *unit;
/** 执行价格 */
@property (nonatomic, copy) NSString *exePrice;
/** 首交易日 */
@property (nonatomic, copy) NSString *startDate;
/** 最后交易日 */
@property (nonatomic, copy) NSString *endDate;
/** 行权日 */
@property (nonatomic, copy) NSString *exeDate;
/** 交割日 */
@property (nonatomic, copy) NSString *deliDate;
/** 到期日 */
@property (nonatomic, copy) NSString *expDate;
/** 合约版号 */
@property (nonatomic, copy) NSString *version;
/** 前结算价 */
@property (nonatomic, copy) NSString *presetPrice;
/** 标的证券昨收 */
@property (nonatomic, copy) NSString *stockClose;
/** 标的证券价格 */
@property (nonatomic, copy) NSString *stockLast;
/** 有无涨跌限制 */
@property (nonatomic, assign) BOOL isLimit;
/** 剩余天数 */
@property (nonatomic, copy) NSString *remainDate;
/** 持仓量 */
@property (nonatomic, copy) NSString *openInterest;
/** 期权类别(Call or Put) */
@property (nonatomic, readonly) MOptionType optionType;

/** 隐含波动率 */
@property (nonatomic, copy) NSString *impliedVolatility;
/** Delta */
@property (nonatomic, copy) NSString *delta;
/** Rho */
@property (nonatomic, copy) NSString *rho;
/** Theta */
@property (nonatomic, copy) NSString *theta;
/** Gamma */
@property (nonatomic, copy) NSString *gamma;
/** Vega */
@property (nonatomic, copy) NSString *vega;
/** 内在价值 */
@property (nonatomic, copy) NSString *inValue;
/** 时间价值 */
@property (nonatomic, copy) NSString *timeValue;
/** 杠杆率 */
@property (nonatomic, copy) NSString *leverageRatio;
/** 溢价率 */
@property (nonatomic, copy) NSString *premiumRate;
/** 虚实度 */
@property (nonatomic, copy) NSString *virtualReality;
/** 真实杠杆 */
@property (nonatomic, copy) NSString *leverage;
/** 理论价 */
@property (nonatomic, copy) NSString *theoreticalPrice;
@end


/*! @brief 全球指数、外汇
 */
@interface MSSEItem : MStockItem
/** 合约代码 含市场*/
@property (nonatomic, copy) NSString *ID;
/** 合约名称 */
@property (nonatomic, copy) NSString *name;
/** 交易时间 */
@property (nonatomic, copy) NSString *datetime;
/** 市场别 */
@property (nonatomic, copy) NSString *market;
/** 最新价 */
@property (nonatomic, copy) NSString *lastPrice;
/** 今开价 */
@property (nonatomic, copy) NSString *openPrice;
/** 最高价 */
@property (nonatomic, copy) NSString *highPrice;
/** 最低价 */
@property (nonatomic, copy) NSString *lowPrice;
/** 昨收价 */
@property (nonatomic, copy) NSString *preClosePrice;
/** 均价 */
@property (nonatomic, copy) NSString *averagePrice;
/** 涨停价 */
@property (nonatomic, copy) NSString *limitUp;
/** 跌停价 */
@property (nonatomic, copy) NSString *limitDown;
/** 涨跌幅 */
@property (nonatomic, copy) NSString *changeRate;
/** 涨跌 */
@property (nonatomic, copy) NSString *change;
/** 涨跌状态 */
@property (nonatomic, assign) MChangeState changeState;
/** 今日结算价*/
@property (nonatomic, copy) NSString *settlement;
/** 昨日结算价*/
@property (nonatomic, copy) NSString *preSettlement;
/** 外盘量 */
@property (nonatomic, copy) NSString *buyVolume;
/** 内盘量 */
@property (nonatomic, copy) NSString *sellVolume;
/** 总量 */
@property (nonatomic, copy) NSString *volume;
/** 成交金额 */
@property (nonatomic, copy) NSString *amount;
/** 现量 */
@property (nonatomic, copy) NSString *nowVolume;
/** 振幅比率 */
@property (nonatomic, copy) NSString *amplitudeRate;
/** 委比 */
@property (nonatomic, copy) NSString *orderRatio;
/** 委差 */
@property (nonatomic, copy) NSString *entrustDiff;
/** 持仓量*/
@property (nonatomic, copy) NSString *openInterest;
/** 日增*/
@property (nonatomic, copy) NSString *positionChg;
/** 增仓*/
@property (nonatomic, copy) NSString *masukura;
/** 买入价 */
@property (nonatomic, copy) NSString *buyPrice;
/** 卖出价 */
@property (nonatomic, copy) NSString *sellPrice;
/** 股票代码(不含市场) */
@property (nonatomic, copy) NSString *code;
/** 一、五档委买价, 买5 -> 买1 */
@property (nonatomic, strong) NSArray *buyPrices;
/** 一、五档委买量, 买5 -> 买1 */
@property (nonatomic, strong) NSArray *buyVolumes;
/** 一、五档委卖价, 卖1 -> 卖5 */
@property (nonatomic, strong) NSArray *sellPrices;
/** 一、五档委卖量, 卖1 -> 卖5*/
@property (nonatomic, strong) NSArray *sellVolumes;
/** 小数位数 */
@property (nonatomic, assign) UInt8 decimal;
/** 成交量单位 */
@property (nonatomic, assign) NSInteger volumeUnit;
@end



/*! @brief AH联动
 */
@interface MAHQuoteItem : MBaseItem
/** 联动名称 */
@property (nonatomic, copy) NSString *name;
/** A股代码 */
@property (nonatomic, copy) NSString *codeA;
/** A股最新价 */
@property (nonatomic, copy) NSString *lastPriceA;
/** A股昨收 */
@property (nonatomic, copy) NSString *preClosePriceA;
/** A股涨跌比率 */
@property (nonatomic, copy) NSString *changeRateA;
/** A股交易时间 */
@property (nonatomic, copy) NSString *datetimeA;
/** H股代码 */
@property (nonatomic, copy) NSString *codeH;
/** H股最新价 */
@property (nonatomic, copy) NSString *lastPriceH;
/** H股昨收 */
@property (nonatomic, copy) NSString *preClosePriceH;
/** H股涨跌比率 */
@property (nonatomic, copy) NSString *changeRateH;
/** H股交易时间 */
@property (nonatomic, copy) NSString *datetimeH;
/** 联动代码溢价率 */
@property (nonatomic, copy) NSString *premiumRate;
@end


/*! @brief 沪伦通排行
 */
@interface MDRQuoteItem : MBaseItem
/** 代码 */
@property (nonatomic, copy) NSString *code;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 次类别 */
@property (nonatomic, copy) NSString *subtype;
/** 最新价 */
@property (nonatomic, copy) NSString *lastPrice;
/** 前收盘价 */
@property (nonatomic, copy) NSString *preClosePrice;
/** 涨幅 */
@property (nonatomic, copy) NSString *changeRate;
/** 涨跌 */
@property (nonatomic, copy) NSString *change;
/** 行情时间 */
@property (nonatomic, copy) NSString *datetime;
/** 基础证券代码*/
@property (nonatomic, copy) NSString *baseStockCode;
/** 基础证券名称*/
@property (nonatomic, copy) NSString *baseStockName;
/** 基础证券最新价*/
@property (nonatomic, copy) NSString *baseLastPrice;
/** 基础证券前收盘价*/
@property (nonatomic, copy) NSString *basePreClosePrice;
/** 基础证券涨幅 */
@property (nonatomic, copy) NSString *baseChangeRate;
/** 基础证券涨跌 */
@property (nonatomic, copy) NSString *baseChange;
/** 基础证券次类别 */
@property (nonatomic, copy) NSString *baseSubtype;
/** 基础证券行情时间 */
@property (nonatomic, copy) NSString *baseDatetime;
/** 溢价 */
@property (nonatomic, copy) NSString *premiumRate;

@end

/*! @brief 板块排行
 */
@interface MSectionRankingItem : MBaseItem
/** 板块名称 */
@property (nonatomic, copy) NSString *name;
/** 板块代号 */
@property (nonatomic, copy) NSString *ID;
/** 板块涨幅比 */
@property (nonatomic, copy) NSString *changeRate;
/** 板块涨幅 */
@property (nonatomic, copy) NSString *change;
/** 领涨名称 */
@property (nonatomic, copy) NSString *stockName;
/** 领涨代号 */
@property (nonatomic, copy) NSString *stockID;
/** 领涨个股涨幅比 */
@property (nonatomic, copy) NSString *stockChangeRate;
/** 领涨个股涨幅 */
@property (nonatomic, copy) NSString *stockChange;
@end

@interface MSectionRankingItem (MStockItem)
+ (MStockItem *)stockItemBySectionRankingItem:(MSectionRankingItem *)sectionRankingItem;
+ (NSArray *)stockItemsBySectionRankingItems:(NSArray *)sectionRankingItems;
@end

/*! @brief 板块排行
 */
@interface MSectionSortingItem : MBaseItem
/** 板块代号 */
@property (nonatomic, copy) NSString *ID;
/** 板块名称 */
@property (nonatomic, copy) NSString *name;
/** 板块类型： Notion 概念板块， Area 地区板块， Trade 行业板块 ，HKTrade 港股行业板块*/
@property (nonatomic, copy) NSString *type;
/** 最新价 */
@property (nonatomic, copy) NSString *lastPrice;
/** 开盘价 */
@property (nonatomic, copy) NSString *openPrice;
/** 最高价 */
@property (nonatomic, copy) NSString *highPrice;
/** 最低价 */
@property (nonatomic, copy) NSString *lowPrice;
/** 昨收价 */
@property (nonatomic, copy) NSString *preClosePrice;
/** 涨跌额 */
@property (nonatomic, copy) NSString *change;
/** 涨跌幅 */
@property (nonatomic, copy) NSString *changeRate;
/** 5日涨跌幅 */
@property (nonatomic, copy) NSString *changeRate5;
/** 10日涨跌幅 */
@property (nonatomic, copy) NSString *changeRate10;
/** 总成交量 */
@property (nonatomic, copy) NSString *volume;
/** 总成交额 */
@property (nonatomic, copy) NSString *amount;
/** 现成交量 */
@property (nonatomic, copy) NSString *nowVolume;
/** 权涨幅 */
@property (nonatomic, copy) NSString *weightedChange;
/** 均涨幅 */
@property (nonatomic, copy) NSString *averageChange;
/** 流值总和 */
@property (nonatomic, copy) NSString *flowValue;
/** 市值总和 */
@property (nonatomic, copy) NSString *totalValue;
/** 委买 */
@property (nonatomic, copy) NSString *entrustBuyVolume;
/** 委卖 */
@property (nonatomic, copy) NSString *entrustSellVolume;
/** 委比 */
@property (nonatomic, copy) NSString *orderRatio;
/** 委差 */
@property (nonatomic, copy) NSString *entrustDiff;
/** 换手率 */
@property (nonatomic, copy) NSString *turnoverRate;
/** PE(市盈 动) */
@property (nonatomic, copy) NSString *PE;
/** SPE(市盈 静) */
@property (nonatomic, copy) NSString *SPE;
/** ROE(市净率) */
@property (nonatomic, copy) NSString *ROE;
/** 振幅比率 */
@property (nonatomic, copy) NSString *amplitudeRate;

/** 涨股比 */
@property (nonatomic, copy) NSString *riseRate;
/** 涨跌家数 */
@property (nonatomic, copy) NSString *advanceAndDeclineCount;
/** 涨停家数 */
@property (nonatomic, copy) NSString *limitUpCount;
/** 跌停家数 */
@property (nonatomic, copy) NSString *limitDownCount;

/** 主力资金流入 */
@property (nonatomic, copy) NSString *capitalInflow;
/** 主力资金流出 */
@property (nonatomic, copy) NSString *capitalOutflow;
/** 主力资金净流入 */
@property (nonatomic, copy) NSString *netCapitalInflow;
/** 5日主力资金净流入 */
@property (nonatomic, copy) NSString *netCapitalInflow5;
/** 10日主力资金净流入 */
@property (nonatomic, copy) NSString *netCapitalInflow10;
/**
 *  领涨股
 **/
/** 领涨个股代码 */
@property (nonatomic, copy) NSString *stockID;
/** 领涨个股名 */
@property (nonatomic, copy) NSString *stockName;
/** 领涨个股涨幅 */
@property (nonatomic, copy) NSString *stockChange;
/** 领涨个股涨幅比 */
@property (nonatomic, copy) NSString *stockChangeRate;
/** 领涨个股最新价 */
@property (nonatomic, copy) NSString *stockLastPrice;

/**
 *  优品概念板块
 **/
/** 热度值，只有优品概念板块才有值 */
@property (nonatomic, copy) NSString *hot;
@end


/*! @brief 搜寻商品结果类
 */
@interface MSearchResultItem : MSearchBaseItem
/** 股票代码 */
@property (nonatomic, copy) NSString *stockID;
/** 股票名称 */
@property (nonatomic, copy) NSString *name;
/** 市场别 sh,sz,hk,hh,hz,bj分别是沪股，深股，港股，沪港通，深港通，新三板市场 */
@property (nonatomic, copy) NSString *market;
/** 拼音 */
@property (nonatomic, copy) NSString *pinyin;
/** 次类别 */
@property (nonatomic, copy) NSString *subtype;
/** 股票代码(不含市场别) */
@property (nonatomic, copy) NSString *code;
/** 标签  是否是沪港通、深港通、沪深港通*/
@property (nonatomic, assign) MSearchResultItemFlag flag;
/** 所属子类别 */
@property (nonatomic, strong) NSArray *subtypes;

@end

/*! @brief 分时成交
 *
 *  包含时、价、量、内外盘等分时数据，可用于显示分时明细画面。
 */
@interface MTickItem : MBaseItem
/*
 *  中金所分时成交 只包括 time、tradePrice、tradeVolume、CFFFlag
 *  大商所、郑商所 只包括 time、tradePrice、tradeVolume、type
 */
/** 时间 HHmmssff */
@property (nonatomic, readonly) NSString *time;
/** 时间 */
@property (nonatomic, copy) NSString *datetime __attribute__((deprecated("使用time4")));
/** 买进价 */
@property (nonatomic, copy) NSString *buyPrice;
/** 卖出价 */
@property (nonatomic, copy) NSString *sellPrice;
/** 最新价 */
@property (nonatomic, copy) NSString *tradePrice;
/** 量 */
@property (nonatomic, copy) NSString *tradeVolume;
/** 内外盘 */
@property (nonatomic, assign) MBSVolumeType type;
/** 港股AMS */
@property (nonatomic, assign) MTimeTickAMSFlag AMSFlag;
/** 中金所股票成交状态 */
@property (nonatomic, assign) MTimeTickCFFFlag CFFFlag;

/** 期货专有*/

/** 仓差 */
@property (nonatomic, copy) NSString *openInterestDiff;
/** 开仓量 */
@property (nonatomic, copy) NSString *openInterest;
/** 平仓量 */
@property (nonatomic, copy) NSString *closeInterest;

@end


@interface MTimeTickItem : MTickItem
/** 范围 */
@property (nonatomic, copy) NSString *sectionRange;
@end

@interface MTimeTickDetailItem : MTickItem
/** 索引 */
@property (nonatomic, copy) NSString *index;
@end

@interface MTickItem (Convenience)
/** 时间 HH:mm */
@property (nonatomic, readonly) NSString *time4;
/** 时间 HH:mm:ss */
@property (nonatomic, readonly) NSString *time6;
/** 时间 HH:mm:ss:ff */
@property (nonatomic, readonly) NSString *time8;
@end

/*! @brief 板块分类
 */
@interface MCategoryItem : MBaseItem
/** 分类代码 */
@property (nonatomic, copy) NSString *code;
/** 分类名 */
@property (nonatomic, copy) NSString *name;
@end

/*! @brief 经纪席位
 */
@interface MBrokerSeatItem : MBaseItem
/** 量 */
@property (nonatomic, copy) NSString *value;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 完整名称 */
@property (nonatomic, copy) NSString *fullName;
@end


/*! @brief 分时成交
 *
 *  包含价、量数据，可用于显示分价量表画面。
 */
@interface MPriceVolumeItem : MBaseItem
/*  
 *  中金所股票 只有价 和 买卖总量
 */
/** 价 */
@property (nonatomic, copy) NSString *price;
/** 买卖总量 */
@property (nonatomic, copy) NSString *volume;
/** 买量 */
@property (nonatomic, copy) NSString *buyVolume;
/** 卖量 */
@property (nonatomic, copy) NSString *sellVolume;
/** 未知买卖方向量 */
@property (nonatomic, copy) NSString *unknownVolume;
/** 买卖笔数 */
@property (nonatomic, copy) NSString *tradeCount;
/** 买笔数 */
@property (nonatomic, copy) NSString *buyCount;
/** 卖笔数 */
@property (nonatomic, copy) NSString *sellCount;
/** 未知买卖方向笔数 */
@property (nonatomic, copy) NSString *unknownCount;
@end


/*! @brief 交易单明细
 *
 *  包含量数据，可用于显示买卖队列
 */
@interface MOrderQuantityItem : MBaseItem
/** 量 */
@property (nonatomic, copy) NSString *volume;
@end


/*! @brief 港股碎股资讯
 *
 *  包含订单编号、经纪人编号等信息
 */
@interface MHKOddInfoItem : MBaseItem
/** 订单编号 */
@property (nonatomic, copy) NSString *orderId;
/** 订单数量 */
@property (nonatomic, copy) NSString *orderQty;
/** 价格 */
@property (nonatomic, copy) NSString *price;
/** 经纪人编号 */
@property (nonatomic, copy) NSString *brokerId;
/** 买卖方向 */
@property (nonatomic, assign) MHKOddSide side;
/** 时间 */
@property (nonatomic, copy) NSString *datetime;
@end

/*! @brief 个股静态数据
 *
 *  包含个股所属板块信息、两市港股通标识、融资标识、融券标识
 */
@interface MStaticDataItem : MBaseItem
/** 所属板块信息 */
@property (nonatomic, strong) NSArray MAPI_OBJ_BOARD_INFO_TYPE *boardInfoItems;
/** 1为沪港通标识 默认为0*/
@property (nonatomic, assign) BOOL HFlag;
/** 1为深港通标识 默认为0*/
@property (nonatomic, assign) BOOL SFlag;
/** 1为融资标识 0源未下 ,默认为0*/
@property (nonatomic, assign) BOOL financeFlag;
/** 1为融券标识 0源未下 ,默认为0*/
@property (nonatomic, assign) BOOL securityFlag;
/** 法定股本 */
@property (nonatomic, strong) NSString *aCapitalStock;
/** 港股股本 */
@property (nonatomic, strong) NSString *hCapitalStock;

@end

/*! @brief 版块信息
 */
@interface MBoardInfoItem : MBaseItem
/** 版块名称 */
@property (nonatomic, copy) NSString *name;
/** 版块ID */
@property (nonatomic, copy) NSString *ID;
@end

/*! @brief 次新股
 */
@interface MSubnewStockRankingItem : MBaseItem
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
/** 股票名称 */
@property (nonatomic, copy) NSString *name;
/** 发行价 */
@property (nonatomic, copy) NSString *IPOPrice;
/** 最新价 */
@property (nonatomic, copy) NSString *lastPrice;
/** 发行日期 */
@property (nonatomic, copy) NSString *IPODate;
/** 连续涨停天数 */
@property (nonatomic, assign) NSInteger continuousLimitUpDays;
/** 昨收价 */
@property (nonatomic, copy) NSString *preClosePrice;
/** 涨跌幅 */
@property (nonatomic, copy) NSString *rate;
/** 累计涨跌幅 */
@property (nonatomic, copy) NSString *totalRate;
@end

/*! @brief 次新债
 */
@interface MSubnewBondRankingItem : MBaseItem
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
/** 股票名称 */
@property (nonatomic, copy) NSString *name;
/** 发行价 */
@property (nonatomic, copy) NSString *IPOPrice;
/** 最新价 */
@property (nonatomic, copy) NSString *lastPrice;
/** 上市日期 */
@property (nonatomic, copy) NSString *IPODate;
/** 次类别 */
@property (nonatomic, copy) NSString *subtype;
/** 昨收价 */
@property (nonatomic, copy) NSString *preClosePrice;
/** 涨跌幅 */
@property (nonatomic, copy) NSString *rate;
/** 累计涨跌幅 */
@property (nonatomic, copy) NSString *totalRate;

@end

@interface MAddValueItem : MBaseItem
/** 证券代码 */
@property (nonatomic, copy) NSString *code;
/** 当前快照日期 */
@property (nonatomic, copy) NSString *date;
/** 当前快照时间 */
@property (nonatomic, copy) NSString *time;
/** 超大单主动买入成交量 */
@property (nonatomic, copy) NSString *ultraLargeBuyVolume;
/** 超大单主动卖出成交量 */
@property (nonatomic, copy) NSString *ultraLargeSellVolume;
/** 超大单主动买入成交额 */
@property (nonatomic, copy) NSString *ultraLargeBuyAmount;
/** 超大单主动卖出成交额 */
@property (nonatomic, copy) NSString *ultraLargeSellAmount;
/** 大单主动买入成交量 */
@property (nonatomic, copy) NSString *largeBuyVolume;
/** 大单主动卖出成交量 */
@property (nonatomic, copy) NSString *largeSellVolume;
/** 大单主动买入成交额 */
@property (nonatomic, copy) NSString *largeBuyAmount;
/** 大单主动卖出成交额 */
@property (nonatomic, copy) NSString *largeSellAmount;
/** 中单主动买入成交量 */
@property (nonatomic, copy) NSString *mediumBuyVolume;
/** 中单主动卖出成交量 */
@property (nonatomic, copy) NSString *mediumSellVolume;
/** 中单主动买入成交额 */
@property (nonatomic, copy) NSString *mediumBuyAmount;
/** 中单主动卖出成交额 */
@property (nonatomic, copy) NSString *mediumSellAmount;
/** 小单主动买入成交量 */
@property (nonatomic, copy) NSString *smallBuyVolume;
/** 小单主动卖出成交量 */
@property (nonatomic, copy) NSString *smallSellVolume;
/** 小单主动买入成交额 */
@property (nonatomic, copy) NSString *smallBuyAmount;
/** 小单主动卖出成交额 */
@property (nonatomic, copy) NSString *smallSellAmount;
/** 超大单净流入 */
@property (nonatomic, copy) NSString *ultraLargeNetInflow;
/** 大单净流入 */
@property (nonatomic, copy) NSString *largeNetInflow;
/** 中单净流入 */
@property (nonatomic, copy) NSString *mediumNetInflow;
/** 小单净流入 */
@property (nonatomic, copy) NSString *smallNetInflow;
/** 主力净流入(超大单+大单) */
@property (nonatomic, copy) NSString *netCapitalInflow;
/** 主力资金流入(6天) */
@property (nonatomic, copy) NSArray *fundsInflows;
/** 主力资金流出(6天)*/
@property (nonatomic, copy) NSArray *fundsOutflows;
/** 散户资金流入(6天) */
@property (nonatomic, copy) NSArray *othersFundsInflows;
/** 散户资金流出(6天)*/
@property (nonatomic, copy) NSArray *othersFundsOutflows;
/** 近6天交易日日期 */
@property (nonatomic, copy) NSArray *lastTradeDates;
/** 超大单差 */
@property (nonatomic, copy) NSString *ultraLargeDiffer;
/** 大单差 */
@property (nonatomic, copy) NSString *largeDiffer;
/** 中单差 */
@property (nonatomic, copy) NSString *mediumDiffer;
/** 小单差 */
@property (nonatomic, copy) NSString *smallDiffer;
/** 每单大买单成交手数（超大单+大单） */
@property (nonatomic, copy) NSString *largeBuyDealCount;
/** 每单大卖单成交手数（超大单+大单） */
@property (nonatomic, copy) NSString *largeSellDealCount;
/** 每单成交手数移动平均值 */
@property (nonatomic, copy) NSString *dealCountMovingAverage;
/** 买入单数 */
@property (nonatomic, copy) NSString *buyCount;
/** 卖出单数 */
@property (nonatomic, copy) NSString *sellCount;
/** 大单净差 */
@property (nonatomic, copy) NSString *bbd;
/** 五日大单净差 */
@property (nonatomic, copy) NSString *bbd5;
/** 十日大单净差 */
@property (nonatomic, copy) NSString *bbd10;
/** 主力动向 */
@property (nonatomic, copy) NSString *ddx;
/** 五日主力动向 */
@property (nonatomic, copy) NSString *ddx5;
/** 十日主力动向 */
@property (nonatomic, copy) NSString *ddx10;
/** 涨跌动因 */
@property (nonatomic, copy) NSString *ddy;
/** 五日涨跌动因 */
@property (nonatomic, copy) NSString *ddy5;
/** 十日涨跌动因 */
@property (nonatomic, copy) NSString *ddy10;
/** 大单差分 */
@property (nonatomic, copy) NSString *ddz;
/** 单数比 */
@property (nonatomic, copy) NSString *ratioBS;
/** 5分钟涨跌幅 */
@property (nonatomic, copy) NSString *fiveMinRise;
/** 超大单买入单数 */
@property (nonatomic, copy) NSString *ultraLargeBuyCount;
/** 超大单卖出单数 */
@property (nonatomic, copy) NSString *ultraLargeSellCount;
/** 大单买入单数 */
@property (nonatomic, copy) NSString *largeBuyCount;
/** 大单卖出单数 */
@property (nonatomic, copy) NSString *largeSellCount;
/** 中单买入单数 */
@property (nonatomic, copy) NSString *mediumBuyCount;
/** 中单卖出单数 */
@property (nonatomic, copy) NSString *mediumSellCount;
/** 小单买入单数 */
@property (nonatomic, copy) NSString *smallBuyCount;
/** 小单卖出单数 */
@property (nonatomic, copy) NSString *smallSellCount;
/** 5日净流入 */
@property (nonatomic, copy) NSString *netInflow5;
/** 10日净流入 */
@property (nonatomic, copy) NSString *netInflow10;
/** 20日净流入 */
@property (nonatomic, copy) NSString *netInflow20;
/** 5日净流入占比 */
@property (nonatomic, copy) NSString *netInflowRate5;
/** 10日净流入占比 */
@property (nonatomic, copy) NSString *netInflowRate10;
/** 20日净流入占比 */
@property (nonatomic, copy) NSString *netInflowRate20;
@end

/*! @brief 交易日期
 */
@interface MTradeDateItem : MBaseItem
/** 日期 */
@property (nonatomic, copy) NSString *date;
/** 交易类型 */
@property (nonatomic, assign) MTradeDateItemType type;
/** 非交易日说明 */
@property (nonatomic, copy) NSString *desc;
@end

/*! @brief 配置信息，主要用于统计
 */
@interface MConfigInfo : MBaseItem
/** 用户ID，唯一标识别 */
@property (nonatomic, copy) NSString *userID;
/** ip */
@property (nonatomic, copy) NSString *ip;
/** 地域 */
@property (nonatomic, copy) NSString *area;
/** 运营商 */
@property (nonatomic, copy) NSString *carrier;
/** 经纬度，逗号隔开 */
@property (nonatomic, copy) NSString *latitudeAndLongitude;
@end

/*! 可转债与正股联动行情
 */
@interface MLinkItem : MBaseItem
/** 证券代码 */
@property (nonatomic, copy) NSString *code;
/** 证券名称 */
@property (nonatomic, copy) NSString *name;
/** 最新价 */
@property (nonatomic, copy) NSString *lastPrice;
/** 涨跌 */
@property (nonatomic, copy) NSString *change;
/** 涨跌幅 */
@property (nonatomic, copy) NSString *changeRate;
/** 溢价率 */
@property (nonatomic, copy) NSString *premiumRate;

@end


#pragma mark 不建议使用

#pragma mark 券商更版公告宣传
/*! @brief 取得券商公告
 */
@interface MAnnouncementRequest : MRequest
@end

/*! @brief 行销宣传页请求类
 */
@interface MAdvertRequest : MRequest
/** 广告key(可为空，取回所有广告) */
@property (nonatomic, copy) NSString *advertKey;
@end
/*! @brief 取得主选单功能请求类
 */
@interface MGetMenuRequest : MRequest
@end

/**
 *  取得更版信息
 */
@interface MCheckVersionRequest : MRequest
@end

/*! @brief 使用者行为记录请求类
 */
@interface MEventRequest : MRequest
/** 功能代码 */
@property (nonatomic, copy) NSString *fid;
@end

/**
 *  取得各券商APP可使用的资讯源
 */
@interface MGetSourceRequest : MRequest
@end

/*! @brief 取得可使用的分类类别请求
 */
@interface MGetSourceClassRequest : MRequest
@end

/*! @brief 板块分类即时行情列表请求类
 */
@interface MCategoryQuoteListRequest : MListRequest
/** 板块ID */
@property (nonatomic, copy) NSString *categoryID;
@end

/*! @brief 经纪席位请求类(港股专用)
 *  建议从快照获取
 */
@interface MBrokerSeatRequest : MRequest
/** 港股股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 买卖队列请求类
 *  建议从快照获取
 */
@interface MOrderQuantityRequest : MRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
/** 次类别 */
@property (nonatomic, copy) NSString *subtype;
@end

/*! @brief 个股静态数据，不支持新三板股票
 *  建议从快照获取
 *  包含个股静态数据、个股所属板块信息、两市港股通标识、融资标识、融券标识、法定股本、港股股本
 */
@interface MStaticDataRequest : MRequest
/** 股票代码，多个股票用逗号隔开，如“600000.sh,000001.sz” */
@property (nonatomic, copy) NSString *code;
/**
 *  默认为 “bk,hki,su,bu,ac,hs”
 *  bk:个股所属板块信息
 *  hki:两市港股通标识
 *  su:融资标识
 *  bu:融券标识
 *  ac:法定股本
 *  hs:港股股本
 */
@property (nonatomic, copy) NSString *param;

@end

/*! @brief 增值指标接口
 *  建议使用快照接口获取，支持自定义
 */
@interface MAddValueRequest : MRequest
/**
 * 股票代码(可多笔，用逗号隔开), 如果不同市场别则要分开发送请求
 * 如 request.code = @"600000.sh,600001.sh"
 * request.code = @"399001.sz,300398.sz"
 */
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *subtype;
/**
 * 自定义请求字段，参照MAddValueItem属性
 * 如：request.fields = @[@"code",@"time",@"ultraLargeBuyVolume"];
 * 默认为请求全部增值指标
 */
@property (nonatomic, strong) NSArray *fields;
@end


/*
 *  下载代码表建议使用  downloadStockTableWithMarkets  支持多市场，增量更新
 */
/*! @brief 股票代码请求类
 */
@interface MStockTableRequest : MRequest
/**
 * 市场别: sh,sz,hk,hh,hz,bj 分别是沪股，深股，港股，沪港通，深港通，新三板市场
 * 如：request.market = @[@"sh",@"sz",@"hk"];
 * 也可以传入带版号的市场别，版号见MStockTableResponse的version属性值
 * 如：request.market = @[@"sh_201704061200",@"sz",@"hk"];
 */
@property (nonatomic, copy) NSArray *markets;
@end

/*! @brief 股票代码单市场增量更新请求类
 */
@interface MIncrementstkStockTableRequest : MRequest
/**
 * 传入需要的市场别
 */
@property (nonatomic, copy) NSString *market;
@end



#pragma mark Deprecated

__attribute__((deprecated("请使用MQuoteRequest")))
@interface MQuoteSeriesRequest : MQuoteRequest

@end

/*! @brief 板块排行请求类
 */
__attribute__((deprecated("已弃用, 使用MSectionSortingRequest")))
@interface MSectionRankingRequest : MListRequest
/** 板块代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 分类涨幅排行请求类（已弃用）
 */
__attribute__((deprecated("已弃用, 使用MCategorySortingRequest")))
@interface MRiseRankingRequest : MListRequest
/** 分类代码 */
@property (nonatomic, copy) NSString *code;
/** 笔数 */
@property (nonatomic, assign) NSInteger pageSize;
@end

/*! @brief 分类跌幅排行请求类（已弃用）
 */
__attribute__((deprecated("已弃用, 使用MCategorySortingRequest")))
@interface MFallRankingRequest : MListRequest
/** 分类代码 */
@property (nonatomic, copy) NSString *code;
/** 笔数 */
@property (nonatomic, assign) NSInteger pageSize;
@end

/*! @brief 股票分类代码表请求类（已弃用，改用MGetSourceClassRequest）
 */
__attribute__((deprecated("已弃用，请改用MGetSourceClassRequest")))
@interface MStockCategoryListRequest : MRequest

@end
