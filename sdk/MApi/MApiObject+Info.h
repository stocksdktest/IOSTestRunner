/////////////////////////////////////////////////////////
//                                                     //
// Copyright (c) 2016年 上证云平台. All rights reserved. //
//                                                     //
/////////////////////////////////////////////////////////


#import "MApiObject.h"

#pragma mark - 数据结构类

#pragma mark 个股摘要

typedef NS_ENUM(NSUInteger, MNewsListSendType) {
    MNewsListSendRefresh,
    MNewsListSendGetMore
};

typedef NS_ENUM(NSInteger, F10NewsRequestType) {
    F10NewsRequestTypeRecent = -1, // 更新最新资料
    F10NewsRequestTypeNewer = 1,   // 查询比newsID更新的资料
    F10NewsRequestTypeOlder = 2    // 查询比newsID更旧的资料
};

/** f10数据来源类型 （目前基金、债券、港股用MF10DataSourceCH）*/
typedef NS_ENUM(NSUInteger, MF10DataSourceType) {
    /** 港澳数据 */
    MF10DataSourceGA = 1,
    /** 财汇数据 */
    MF10DataSourceCH = 2
};

/** IPO类型 */
typedef NS_ENUM(NSUInteger, MIPOType) {
    /** 新股 */
    MIPOTypeStock,
    /** 新债 */
    MIPOTypeBond
};

#pragma mark 个股资讯

/*! @brief 个股公告
 */
@interface MStockBulletinItem : MBaseItem
/** 日期 */
@property (nonatomic, copy) NSString *datetime;
/** 序号 */
@property (nonatomic, copy) NSString *ID;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 个股名称*/
@property (nonatomic, copy) NSString *stockName;
/** 入表日期*/
@property (nonatomic, copy) NSString *entryDate;
/** 入表时间*/
@property (nonatomic, copy) NSString *entryTime;
/** 是否是PDF文件 (YES表示详情内容pdf形式显示)  仅适用于来源为 MF10DataSourceCH*/
@property (nonatomic, assign) BOOL isPDF;
@end

/*! @brief 个股公告内文
 */
@interface MStockBulletinDetailItem : MBaseItem
/** 日期 */
@property (nonatomic, copy) NSString *datetime;
/** 序号 */
@property (nonatomic, copy) NSString *ID;
/** 内文 */
@property (nonatomic, copy) NSString *content;
/** 格式 */
@property (nonatomic, copy) NSString *format;
/** pdf_url 仅适用于来源为 MF10DataSourceCH，根据列表返回的isPDF状态判断是否有值*/
@property (nonatomic, copy) NSString *url;
@end

/*! @brief 个股新闻
 */
@interface MStockNewsItem : MBaseItem
/** 日期 */
@property (nonatomic, copy) NSString *datetime;
/** 序号 */
@property (nonatomic, copy) NSString *ID;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 报告级别，仅适用于来源为 MF10DataSourceGA */
@property (nonatomic, copy) NSString *level;
/** 来源 */
@property (nonatomic, copy) NSString *source;
/** 个股名称*/
@property (nonatomic, copy) NSString *stockName;
/** 入表日期*/
@property (nonatomic, copy) NSString *entryDate;
/** 入表时间*/
@property (nonatomic, copy) NSString *entryTime;
/** 是否是PDF文件 (YES表示详情内容pdf形式显示)  仅适用于来源为 MF10DataSourceCH*/
@property (nonatomic, assign) BOOL isPDF;
@end

/*! @brief 个股新闻内文
 */
@interface MStockNewsDetailItem : MBaseItem
/** 日期 */
@property (nonatomic, copy) NSString *datetime;
/** 序号 */
@property (nonatomic, copy) NSString *ID;
/** 内文 */
@property (nonatomic, copy) NSString *content;
/** 内容格式，仅适用于来源为 MF10DataSourceGA */
@property (nonatomic, copy) NSString *format;
/** 媒体出处(Option) */
@property (nonatomic, copy) NSString *source;
/** pdf_url 仅适用于来源为 MF10DataSourceCH，根据列表返回的isPDF状态判断是否有值*/
@property (nonatomic, copy) NSString *url;
@end

/*! @brief 个股研报
 */
@interface MStockReportItem : MBaseItem
/** 日期 */
@property (nonatomic, copy) NSString *datetime;
/** 序号 */
@property (nonatomic, copy) NSString *ID;
/** 内文 */
@property (nonatomic, copy) NSString *title;
/** 报告级别，仅适用于来源为 MF10DataSourceGA */
@property (nonatomic, copy) NSString *level;
/** 来源 */
@property (nonatomic, copy) NSString *source;
/** 个股名称*/
@property (nonatomic, copy) NSString *stockName;
/** 入表日期*/
@property (nonatomic, copy) NSString *entryDate;
/** 入表时间*/
@property (nonatomic, copy) NSString *entryTime;
/** 是否是PDF文件 (YES表示详情内容pdf形式显示)  仅适用于来源为 MF10DataSourceCH*/
@property (nonatomic, assign) BOOL isPDF;
@end

/*! @brief 个股研报内文
 */
@interface MStockReportDetailItem : MBaseItem
/** 日期 */
@property (nonatomic, copy) NSString *datetime;
/** 序号 */
@property (nonatomic, copy) NSString *ID;
/** 内文 */
@property (nonatomic, copy) NSString *content;
/** 内容格式，仅适用于来源为 MF10DataSourceGA */
@property (nonatomic, copy) NSString *format;
/** 媒体出处(Option) */
@property (nonatomic, copy) NSString *source;
/** pdf_url 仅适用于来源为 MF10DataSourceCH，根据列表返回的isPDF状态判断是否有值*/
@property (nonatomic, copy) NSString *url;
@end

#pragma mark 新闻资讯

/*! @brief 财经资讯
 */
@interface MNewsItem : MBaseItem
/** 识别号 */
@property (nonatomic, copy) NSString *ID;
/** 首次发布日期 */
@property (nonatomic, copy) NSString *datetime;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 媒体出处(Option) */
@property (nonatomic, copy) NSString *source;
/** 内容格式 */
@property (nonatomic, copy) NSString *format;
@end

/*! @brief 财经资讯明細
 */
@interface MNewsDetailItem : MBaseItem
/** 内容 */
@property (nonatomic, copy) NSString *content;
/** 首次发布日期 */
@property (nonatomic, copy) NSString *datetime;
/** 媒体出处(Option) */
@property (nonatomic, copy) NSString *source;
/** 内容格式 */
@property (nonatomic, copy) NSString *format;
@end

#pragma mark - 请求类

#pragma mark 个股摘要
/** f10数据请求基类 */
@interface MDataRequest : MRequest
/** 数据来源,默认为 MF10DataSourceGA */
@property (nonatomic , assign) MF10DataSourceType sourceType;
@end

/*! @brief F10接口，通用接口，以后会逐步改成所有的F10信息都调用此接口
 */
@interface MF10Request : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
/** 请求类型，具体参照下方定义 */
@property (nonatomic, strong) NSString *requestType;
/**
 1、获取某一具体指标的对比数据
 
 当前支持的财务指标：
    1，主要指标，即：MF10RequestTypeMainIndex;
    2，利润表，即：MF10RequestTypeProfitStatement;
    3，资产负债表，即：MF10RequestTypeBalanceSheet;
    4，现金流量表，即：MF10RequestTypeCashFlowStatement;
 
 参数格式：
    key: type
    value: xxxx_x：某个财务字段_0/1/2/3/4
 
 例如：获取现金流量表中每股收益的对比数据
    @{@"type":@"BIZCASHINFL_0"}：经营现金流入小计所有报告期比对数据
    @{@"type":@"BIZCASHINFL_1"}：经营现金流入小计一季度比对数据
    @{@"type":@"BIZCASHINFL_2"}：经营现金流入小计二季度比对数据
    @{@"type":@"BIZCASHINFL_3"}：经营现金流入小计三季度比对数据
    @{@"type":@"BIZCASHINFL_4"}：经营现金流入小计四季度比对数据
 完整事例：
    MF10Request *r = [[MF10Request alloc]init];
    r.code = @"600000.sh";
    r.requestType = MF10RequestTypeCashFlowStatement;
    r.sourceType = MF10DataSourceCH;
    r.param = @{@"type":@"BIZCASHINFL_1"};
    [MApi sendRequest:r completionHandler:^(MResponse *resp) {
 
    }];
 
 2、分页请求
 
 当前支持类型：
    1，大事提醒---按时间，即：MF10RequestTypeImportnoticedate
    2，大事提醒---按标题，即：MF10RequestTypeImportnoticetitle
    3，董秘问答，即：MF10RequestTypeNewsInteractive
    4, 业绩预告，即：MF10RequestTypeExptperformance
    5, 业绩公告，即：MF10RequestTypeProindicdata

 
 参数格式：
    key: param
    value: id1,id2  id1为页数默认0，id2为每页条数默认20
 
 例如：
    request.param = @{@"param":@"0,10"} 获取第0页的10条数据
 
 3、排序
 
 当前支持类型：
    1，董秘问答，即：MF10RequestTypeNewsInteractive
 参数格式：
    key: type
    value:  QUESTIONTIME_1：提问时间倒序(由近及远)
            QUESTIONTIME_0：提问时间正序
            ANSWERTIME_1：回答时间倒序(由近及远)
            ANSWERTIME_0：回答时间正序
 例如：
    request.param = @{@"type":@"QUESTIONTIME_1"} 提问时间倒序
 
 4, 接口更新
 
 当前支持类型
    1，大事提醒---按时间，即：MF10RequestTypeImportnoticedate
    2，大事提醒---按标题，即：MF10RequestTypeImportnoticetitle
 参数格式：
    key: type
    value: new
 例如：
    requset.param = @{@"type":@"new"}，当传入此参数时，数据返回发布公告
 
 
*/
@property (nonatomic, strong) NSDictionary *param;

@end

/** 重要指标 */
extern NSString *const  MF10RequestTypeImportantIndex;
/** 主营构成 */
extern NSString *const  MF10RequestTypeBusinessInfo;
/** 龙虎榜－买入前5营业部 */
extern NSString *const  MF10RequestTypeCharts5Buys;
/** 龙虎榜－卖出前5营业部 */
extern NSString *const  MF10RequestTypeCharts5Sells;
/** 机构观点－机构评级 */
extern NSString *const  MF10RequestTypeExptskinvrating;
/** 机构观点－一致预测 */
extern NSString *const  MF10RequestTypeExptskstatn;
/** 公司简介 */
extern NSString *const  MF10RequestTypeCompanyInfo;
/** 分红扩股 */
extern NSString *const  MF10RequestTypeShareBonus;
/** 公司高管 */
extern NSString *const  MF10RequestTypeCompanyManager;
/** 十大流通股东 */
extern NSString *const  MF10RequestTypeTradableShareholders10;
/** 十大股东 */
extern NSString *const  MF10RequestTypeShareholder10;
/** 股本信息 */
extern NSString *const  MF10RequestTypeShareInfo;
/** 股东户数 */
extern NSString *const  MF10RequestTypeShareholderNumber;
/** 主要指标 */
extern NSString *const  MF10RequestTypeMainIndex;
/** 利润表 */
extern NSString *const  MF10RequestTypeProfitStatement;
/** 资产负债表 */
extern NSString *const  MF10RequestTypeBalanceSheet;
/** 现金流量表 */
extern NSString *const  MF10RequestTypeCashFlowStatement;
/** 大宗交易 */
extern NSString *const  MF10RequestTypeBlockTrade;
/** 融资融券 */
extern NSString *const  MF10RequestTypeTradingDetail;
/** 股东深度挖掘数据 */
extern NSString *const  MF10RequestTypeIinvholdchg;
/** 大事提醒---按时间 */
extern NSString *const  MF10RequestTypeImportnoticedate;
/** 大事提醒---按标题 */
extern NSString *const  MF10RequestTypeImportnoticetitle;
/** 大事提醒---业绩预告 */
extern NSString *const  MF10RequestTypeExptperformance;
/** 大事提醒---业绩公告 */
extern NSString *const  MF10RequestTypeProindicdata;
/** 董秘问答 */
extern NSString *const  MF10RequestTypeNewsInteractive;

/*! @brief 最新指标请求类
 */
@interface MLatestIndexRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 大事提醒请求类
 */
@interface MBigEventNotificationRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 分红配送请求类
 */
@interface MBonusFinanceRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 融资融券请求类
 */
@interface MTradeDetailInfoRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 机构预测请求类
 */
@interface MForecastYearRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 机构评等请求类
 */
@interface MForecastRatingRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 大宗交易请求类（已弃用）
 */
__attribute__((deprecated("已弃用")))
@interface MBlockTradeInfoRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

#pragma mark 个股简况

/*! @brief 基本情况请求类
 */
@interface MCompanyInfoRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 主要业务请求类
 */
@interface MCoreBusinessRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 管理层请求类
 */
@interface MLeaderPersonInfoRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 发行上市请求类（已弃用）
 */
__attribute__((deprecated("已弃用")))
@interface MIPOInfoRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

#pragma mark 个股财务

/*! @brief 财务指标请求类
 */
@interface MFinancialSummaryRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
/**
 获取某一具体指标的对比数据

 参数格式：
 key: type
 value:
    1.null：返回财务报表数据（1条）
    2.N：返回财务报表数据（10条）
    3.xxxx_x：某个财务字段_0/1/2/3/4

 例如：
    1.获取1条财务报表数据
        request.param = nil;
    2.获取10条财务报表数据（港股数据财汇源支持）
        request.param = @{@"type":@"N"};
    2.获取每股收益所有报告期比对数据（财汇源支持）
        request.param = @{@"type":@"BASICEPS_0"}：每股收益所有报告期比对数据
        request.param = @{@"type":@"BASICEPS_1"}：每股收益一季度比对数据
        request.param = @{@"type":@"BASICEPS_2"}：每股收益二季度比对数据
        request.param = @{@"type":@"BASICEPS_3"}：每股收益三季度比对数据
        request.param = @{@"type":@"BASICEPS_4"}：每股收益四季度比对数据
 */
@property (nonatomic, strong) NSDictionary *param;

@end

/*! @brief 财务报表请求类
 */
@interface MFinancialInfoRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
/**
 获取某一具体指标的对比数据
 参照 MFinancialSummaryRequest 的 param 属性说明
 */
@property (nonatomic, strong) NSDictionary *param;

@end

#pragma mark 个股股东

/*! @brief 控股股东请求类（已弃用）
 */
__attribute__((deprecated("已弃用")))
@interface MControlingShareHolderRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 股本结构请求类
 */
@interface MStockShareInfoRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 股本变动请求类
 */
@interface MStockShareChangeInfoRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 股东变动请求类
 */
@interface MShareHolderHistoryInfoRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 最新自然人持股请求类
 */
@interface MTopLiquidShareHolderRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 最新机构持股请求类
 */
@interface MTopShareHolderRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 最新基金持股请求类
 */
@interface MFundShareHolderInfoRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 基金概况请求类
 */
@interface MFundBasicInfoRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 基金净值(5天)请求类
 */
@interface MFundNetValueRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 资产配置请求类
 */
@interface MFundAssetAllocationRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 行业组合请求类
 */
@interface MFundIndustryPortfolioRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 股票组合请求类
 */
@interface MFundStockPortfolioRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 份额结构请求类
 */
@interface MFundShareStructRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 基金财务请求类
 */
@interface MFundFinanceRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 基金分红请求类
 */
@interface MFundDividendRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 债券概况请求类
 */
@interface MBondBasicInfoRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 付息情况请求类
 */
@interface MBondInterestPayRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

/*! @brief 债券回购请求类
 */
@interface MBondBuyBacksRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

#pragma mark 个股资讯

/*! @brief 个股公告列表请求类
 */
@interface MStockBulletinListRequest : MListRequest

/** 数据来源 */
@property (nonatomic , assign) MF10DataSourceType sourceType;
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
/** 查询数据类别*/
@property (nonatomic, assign) F10NewsRequestType type;
/** 公告ID 第一次传nil*/
@property (nonatomic, copy) NSString * newsID;
/** 条数,默认10 */
@property (nonatomic , assign) NSInteger pageSize;

/** 页次 */
@property (nonatomic, assign) NSInteger pageIndex __attribute__((deprecated("使用newsID+type")));
/** 刷新或是取得更多 */
@property (nonatomic) MNewsListSendType newsListSendType __attribute__((deprecated));

@end

/*! @brief 个股公告明细请求类
 */
@interface MStockBulletinRequest : MDataRequest
/** 个股公告序号 */
@property (nonatomic, copy) NSString *stockBulletinID;
@end

/*! @brief 个股新闻列表请求类
 */
@interface MStockNewsListRequest : MListRequest
/** 数据来源 */
@property (nonatomic , assign) MF10DataSourceType sourceType;
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
/** 查询数据类别*/
@property (nonatomic, assign) F10NewsRequestType type;
/** 新闻ID 第一次传nil*/
@property (nonatomic, copy) NSString * newsID;
/** 条数,默认10 */
@property (nonatomic , assign) NSInteger pageSize;

/** 页次 */
@property (nonatomic, assign) NSInteger pageIndex __attribute__((deprecated));
/** 刷新或是取得更多 */
@property (nonatomic) MNewsListSendType newsListSendType __attribute__((deprecated));
@end

/*! @brief 个股新闻明细请求类
 */
@interface MStockNewsRequest : MDataRequest
/** 个股新闻序号 */
@property (nonatomic, copy) NSString *stockNewsID;
@end

/*! @brief 个股研报列表请求类
 */
@interface MStockReportListRequest : MListRequest
/** 数据来源 */
@property (nonatomic , assign) MF10DataSourceType sourceType;
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
/** 查询数据类别*/
@property (nonatomic, assign) F10NewsRequestType type;
/** 研报ID 第一次传nil*/
@property (nonatomic, copy) NSString * newsID;
/** 条数,默认10 */
@property (nonatomic , assign) NSInteger pageSize;

/** 页次 */
@property (nonatomic, assign) NSInteger pageIndex __attribute__((deprecated));
/** 刷新或是取得更多 */
@property (nonatomic) MNewsListSendType newsListSendType __attribute__((deprecated));
@end

/*! @brief 个股研报明细请求类
 */
@interface MStockReportRequest : MDataRequest
/** 个股研报序号 */
@property (nonatomic, copy) NSString *stockReportID;
@end


#pragma mark 新股(或新债)资讯

/*! @brief 新股(债)上市日期信息请求类
 */
@interface MIPODateRequest : MDataRequest
/** IPO类型，默认为新股：MIPOTypeStock */
@property (nonatomic, assign)MIPOType type;
@end

/*! @brief 某日的所有新股(债)信息请求类
 */
@interface MIPOCalendarRequest : MDataRequest
/** 查询日期 YYYY-MM-DD */
@property (nonatomic, copy) NSString *date;
/** IPO类型，默认为新股：MIPOTypeStock */
@property (nonatomic, assign)MIPOType type;
@end

/*! @brief 新股(债)信息请求类
 */
@interface MIPOShareDetailRequest : MDataRequest
/** 股号 */
@property (nonatomic, copy) NSString *code;
/** IPO类型，默认为新股：MIPOTypeStock */
@property (nonatomic, assign)MIPOType type;
@end


#pragma mark 分级基金

/*! @brief 分级基金信息请求类
 */
@interface MGradeFundRequest : MDataRequest
/** 分级基金信息类别，参照下方定义 */
@property (nonatomic, copy) NSString *gradeFundType;
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
@end

extern NSString *const MGradeFundTypeInfo;       // 概括、基本信息
extern NSString *const MGradeFundTypePosition;   // 持仓
extern NSString *const MGradeFundTypeDiagnose;   // 诊断
extern NSString *const MGradeFundTypeSubscribe;  // 申购
extern NSString *const MGradeFundTypeSplit;      // 合并、拆分
extern NSString *const MGradeFundTypeConvert;    // 折算说明
extern NSString *const MGradeFundTypeParentFund; // 母基金费用说明

#pragma mark 新闻资讯

/*! @brief 财经资讯列表请求类
 */
@interface MNewsListRequest : MListRequest
/** 数据来源 */
@property (nonatomic , assign) MF10DataSourceType sourceType;
/** 新闻类别, 参照下方定义 */
@property (nonatomic, copy) NSString *newsType;
/** 查询数据类别*/
@property (nonatomic, assign) F10NewsRequestType type;
/** 公告ID 第一次传nil*/
@property (nonatomic, copy) NSString * newsID;

/** 页次 */
@property (nonatomic, assign) NSInteger pageIndex __attribute__((deprecated("使用newsID+type")));
/** 刷新或是取得更多 */
@property (nonatomic) MNewsListSendType newsListSendType __attribute__((deprecated));

@end

extern NSString *const MNewsTypeImportant;       // 要闻
extern NSString *const MNewsTypeRoll;            // 滚动
extern NSString *const MNewsTypeFinance;         // 财经
extern NSString *const MNewsTypeIndustry;        // 行业
extern NSString *const MNewsTypeStock;           // 股票
extern NSString *const MNewsTypeFuture;          // 期货
extern NSString *const MNewsTypeForeignExchange; // 外汇
extern NSString *const MNewsTypeFund;            // 基金
extern NSString *const MNewsTypeBond;            // 债券
extern NSString *const MNewsTypeGold;            // 黄金
extern NSString *const MNewsTypeOthers;          // 其他


/*! @brief 财经资讯明细请求类
 */
@interface MNewsRequest : MDataRequest
/** 财经资讯序号 */
@property (nonatomic, copy) NSString *newsID;
@end

/*! @brief 财经资讯图片请求类
 */
@interface MNewsImgRequest : MDataRequest
/** 财经资讯序号 */
@property (nonatomic, copy) NSString *newsID;
@end

/*! @brief 基金净值(12个月)请求类
 */
@interface MFundValueRequest : MDataRequest
/** 基金代码 */
@property (nonatomic, copy) NSString *code;
/** 基金净值周期（已废弃） */
@property (nonatomic, copy) NSString *type __attribute__((deprecated));
@end

/*! @brief 融资融券--分市场提供最近交易日融资融券数据
 */
@interface MMarginInfoRequest : MDataRequest
/** 市场代码：@"sh"、@"sz"、@"sh_sz" */
@property (nonatomic, copy) NSString *market;
/** 页数 */
@property (nonatomic, assign) NSInteger pageIndex;
/** 笔数 */
@property (nonatomic, assign) NSInteger pageSize;
/** 排列顺序 */
@property (nonatomic, assign) BOOL ascending;
/** 排序栏位，字段见文档说明 */
@property (nonatomic, copy) NSString *field;
/**
 * 可选字段, 可以指定只显示部份字段, 用逗号分隔, 此参数不传则显示预设的栏位
 * 例如：@“TRADEDATE,FINBALANCE”，其它字段见文档说明
 */
@property (nonatomic, copy) NSString *options;
@end

/*! @brief 融资融券--融资融券差额接口(最近90天)
 */
@interface MMarginInfoDiffRequest : MDataRequest
/** 市场代码：@"sh"、@"sz"、@"sh_sz" */
@property (nonatomic, copy) NSString *market;
/** 页数 */
@property (nonatomic, assign) NSInteger pageIndex;
/** 笔数 */
@property (nonatomic, assign) NSInteger pageSize;
/**
 * 可选字段, 可以指定只显示部份字段, 用逗号分隔, 此参数不传则显示预设的栏位
 * 例如：@“TRADEDATE,FINBALANCESUM”，其它字段见文档说明
 */
@property (nonatomic, copy) NSString *options;
@end

/*! @brief 融资融券--个股融资融券接口（最近90天）
 */
@interface MMarginInfoShareRequest : MDataRequest
/** 股票代码 */
@property (nonatomic, copy) NSString *code;
/** 页数 */
@property (nonatomic, assign) NSInteger pageIndex;
/** 笔数 */
@property (nonatomic, assign) NSInteger pageSize;
/**
 * 可选字段, 可以指定只显示部份字段, 用逗号分隔, 此参数不传则显示预设的栏位
 * 例如：@“TRADEDATE,FINBALANCE”，其它字段见文档说明
 */
@property (nonatomic, copy) NSString *options;
@end

#pragma mark - 应答类

#pragma mark 个股简要

/*! @brief 最新指标应答类
 */
@interface MLatestIndexResponse : MResponse
/** 最新指标对象 */
@property (nonatomic, strong) NSDictionary *record;
@end

/*! @brief 大事提醒应答类
 */
@interface MBigEventNotificationResponse : MResponse
/** 大事提醒列表 */
@property (nonatomic, strong) NSArray *records;
@end

/*! @brief 分红配送应答类
 */
@interface MBonusFinanceResponse : MResponse
/** 分红配送列表 */
@property (nonatomic, strong) NSArray *records;
@end

/*! @brief 融资融券应答类
 */
@interface MTradeDetailInfoResponse : MResponse
/** 融资融券对象 */
@property (nonatomic, strong) NSDictionary *record;
@end

/*! @brief 机构预测应答类
 */
@interface MForecastYearResponse : MResponse
/** 机构预测对象 */
@property (nonatomic, strong) NSDictionary *record;
@end

/*! @brief 机构评等应答类
 */
@interface MForecastRatingResponse : MResponse
/** 评级 */
@property (nonatomic, copy) NSString *ratingFlag;
/** 评级敘述 */
@property (nonatomic, copy) NSString *ratingDescription;
/** 更新日期 */
@property (nonatomic, copy) NSString *dateTitle;
/** 机构评等列表 */
@property (nonatomic, strong) NSArray *records;
@end

/*! @brief 发行上市应答类
 */
@interface MIPOInfoResponse : MResponse
/** 发行上市对象 */
@property (nonatomic, strong) NSDictionary *record;
@end

#pragma mark 个股概况

/*! @brief 基本情况应答类
 */
@interface MCompanyInfoResponse : MResponse
/** 基本情况对象 */
@property (nonatomic, strong) NSDictionary *record;
@end

/*! @brief 主要业务应答类
 */
@interface MCoreBusinessResponse : MResponse
/** 主要业务列表 */
@property (nonatomic, strong) NSArray *records;
@end

/*! @brief 管理层应答类
 */
@interface MLeaderPersonInfoResponse : MResponse
/** 管理层列表 */
@property (nonatomic, strong) NSArray *records;
@end

/*! @brief 大宗交易应答类
 */
@interface MBlockTradeInfoResponse : MResponse
/** 大宗交易列表 */
@property (nonatomic, strong) NSArray *records;
@end

#pragma mark 个股股东

/*! @brief 控股股东应答类
 */
@interface MControlingShareHolderResponse : MResponse
/** 控股股东对象 */
@property (nonatomic, strong) NSArray *records;
@end

/*! @brief 股本结构应答类
 */
@interface MStockShareInfoResponse : MResponse
/** 股本结构对象 */
@property (nonatomic, strong) NSDictionary *record;
@end

/*! @brief 股本变动应答类
 */
@interface MStockShareChangeInfoResponse : MResponse
/** 股本变动对象 */
@property (nonatomic, strong) NSArray *records;
@end

/*! @brief 股东变动应答类
 */
@interface MShareHolderHistoryInfoResponse : MResponse
/** 股东变动列表 */
@property (nonatomic, strong) NSArray *records;
@end

/*! @brief 最新自然人持股应答类
 */
@interface MTopLiquidShareHolderResponse : MResponse
/** 股东列表 */
@property (nonatomic, strong) NSArray *records;
@end

/*! @brief 最新机构持股应答类
 */
@interface MTopShareHolderResponse : MResponse
/** 股东列表 */
@property (nonatomic, strong) NSArray *records;
@end

/*! @brief 最新基金持股应答类
 */
@interface MFundShareHolderInfoResponse : MResponse
@property (nonatomic, readonly) NSInteger count;
@property (nonatomic, readonly) NSString *endDate;
/** 基金持股列表 */
@property (nonatomic, strong) NSArray *records;
@end

#pragma mark 个股财务

/*! @brief 财务报表应答类
 */
@interface MFinancialInfoResponse : MResponse
/** 财务报表 */
@property (nonatomic, strong) NSDictionary *record __attribute__((deprecated("使用JSONObject")));
/** 财务报表 */
@property (nonatomic, strong) NSObject *JSONObject;
@end

/*! @brief 财务指标应答类
 */
@interface MFinancialSummaryResponse : MResponse
/** 财务指标 */
@property (nonatomic, strong) NSDictionary *record __attribute__((deprecated("使用JSONObject")));
/** 财务指标 */
@property (nonatomic, strong) NSObject *JSONObject;
@end

/*! @brief 基金概况应答类
 */
@interface MFundBasicInfoResponse : MResponse
/** 基金概况 */
@property (nonatomic, strong) NSDictionary *record;
@end

/*! @brief 基金净值应答类
 */
@interface MFundNetValueResponse : MResponse
/** 基金净值列表 */
@property (nonatomic, strong) NSArray *records;
@end

/*! @brief 资产配置应答类
 */
@interface MFundAssetAllocationResponse : MResponse
/** 资产配置列表 */
@property (nonatomic, strong) NSArray *records;
@end

/*! @brief 行业组合应答类
 */
@interface MFundIndustryPortfolioResponse : MResponse
/** 行业组合列表 */
@property (nonatomic, strong) NSArray *records;
@end

/*! @brief 股票组合应答类
 */
@interface MFundStockPortfolioResponse : MResponse
/** 股票组合列表 */
@property (nonatomic, strong) NSArray *records;
@end

/*! @brief 份额结构应答类
 */
@interface MFundShareStructResponse : MResponse
/** 份额结构列表 */
@property (nonatomic, strong) NSArray *records;
@end

/*! @brief 基金财务应答类
 */
@interface MFundFinanceResponse : MResponse
/** 基金财务 */
@property (nonatomic, strong) NSDictionary *record;
@end

/*! @brief 基金分红应答类
 */
@interface MFundDividendResponse : MResponse
/** 基金分红 */
@property (nonatomic, strong) NSDictionary *record;
@end

/*! @brief 债券概况应答类
 */
@interface MBondBasicInfoResponse : MResponse
/** 债券概况列表 */
@property (nonatomic, strong) NSDictionary *record;
@end

/*! @brief 付息情况应答类
 */
@interface MBondInterestPayResponse : MResponse
/** 付息情况列表 */
@property (nonatomic, strong) NSDictionary *record;
@end

/*! @brief 债券回购应答类
 */
@interface MBondBuyBacksResponse : MResponse
/** 债券回购列表 */
@property (nonatomic, strong) NSDictionary *record;
@end

#pragma mark 个股资讯

/*! @brief 个股公告列表应答类
 */
@interface MStockBulletinListResponse : MResponse
/** 个股公告列表 */
@property (nonatomic, strong) NSArray *stockBulletinItems;
/** 是否超过10笔资料更新 */
@property (nonatomic) BOOL overpage;
@end

/*! @brief 个股公告明细应答类
 */
@interface MStockBulletinResponse : MResponse
/** 个股公告明细对象 */
@property (nonatomic, strong) MStockBulletinDetailItem *stockBulletinDetailItem;
@end

/*! @brief 个股新闻列表应答类
 */
@interface MStockNewsListResponse : MResponse
/** 个股新闻列表 */
@property (nonatomic, strong) NSArray *stockNewsItems;
/** 是否超过10笔资料更新 */
@property (nonatomic) BOOL overpage;
@end

/*! @brief 个股新闻明细应答类
 */
@interface MStockNewsResponse : MResponse
/** 个股新闻明细对象 */
@property (nonatomic, strong) MStockNewsDetailItem *stockNewsDetailItem;
@end

/*! @brief 个股研报列表应答类
 */
@interface MStockReportListResponse : MResponse
/** 个股研报列表 */
@property (nonatomic, strong) NSArray *stockReportItems;
/** 是否超过10笔资料更新 */
@property (nonatomic) BOOL overpage;
@end

/*! @brief 个股研报明细应答类
 */
@interface MStockReportResponse : MResponse
/** 个股研报明细对象 */
@property (nonatomic, strong) MStockReportDetailItem *stockReportDetailItem;
@end

#pragma mark 新闻资讯

/*! @brief 财经资讯列表应答类
 */
@interface MNewsListResponse : MResponse
/** 财经资讯列表 */
@property (nonatomic, strong) NSArray *newsItems;
/** 是否超过10笔资料更新 */
@property (nonatomic) BOOL overpage;
@end

/*! @brief 财经资讯明细应答类
 */
@interface MNewsResponse : MResponse
/** 财经资讯明细对象 */
@property (nonatomic, strong) MNewsDetailItem *newsDetailItem;
@end

@interface MNewsImgResponse : MResponse
/** 财经资讯图片NSdata */
@property (nonatomic, strong) NSData *imageData;
@end

#pragma mark 新股(债)资讯

/*! @brief 新股(债)上市日期信息应答类
 */
@interface MIPODateResponse : MResponse
/** 新股(债)日期及上市个数数组 */
@property (nonatomic, strong) NSArray *infos;
@end

/*! @brief 某日的所有新股(债)信息应答类
 */
@interface MIPOCalendarResponse : MResponse
/** 新股(债)列表信息 */
@property (nonatomic, strong) NSDictionary *info;
@end

/*! @brief 新股(债)信息应答类
 */
@interface MIPOShareDetailResponse : MResponse
/** 新股(债)详细信息 */
@property (nonatomic, strong) NSDictionary *info;
@end

/*! @brief 基金净值应答类
 */
@interface MFundValueResponse : MResponse
/** 基金净值信息 */
@property (nonatomic, strong) NSArray *items;
@end

/*! @brief 分级基金信息应答类
 */
@interface MGradeFundResponse : MResponse
/** 分级基金信息 */
@property (nonatomic, strong) NSObject *JSONObject;
@end

/*! @brief F10信息应答类
 */
@interface MF10Response : MResponse
/** F10 JSON信息 */
@property (nonatomic, strong) NSObject *JSONObject;
@end

/*! @brief 融资融券--分市场提供最近交易日融资融券数据
 */
@interface MMarginInfoResponse : MResponse
/** 融资融券信息 */
@property (nonatomic, strong) NSObject *JSONObject;
@end

/*! @brief 融资融券--融资融券差额接口(最近90天)
 */
@interface MMarginInfoDiffResponse : MResponse
/** 融资融券信息 */
@property (nonatomic, strong) NSObject *JSONObject;
@end

/*! @brief 融资融券--个股融资融券接口（最近90天）
 */
@interface MMarginInfoShareResponse : MResponse
/** 融资融券信息 */
@property (nonatomic, strong) NSObject *JSONObject;
@end

