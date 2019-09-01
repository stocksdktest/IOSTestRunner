/////////////////////////////////////////////////////////
//                                                     //
// Copyright (c) 2016年 上证云平台. All rights reserved. //
//                                                     //
/////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>
#import "MApiObject.h"
#import "MApiObject+Info.h"

#define __MAPI_TCP_ENABLED 1

extern NSString * const MApiRegisterOptionGetServerPoolingTimeKey; /// 单位:秒

/// 国内外用户变化通知
extern NSString * const MApiChineUserChangedNotification;
/// 行情源切换通知
extern NSString * const MApiSourceLevelChangedNotification;
/// 行情源切换通知：市场别
extern NSString * const MApiSourceLevelChangedMarketKey;
/// 行情源切换通知：切换方向
extern NSString * const MApiSourceLevelChangedToKey;


/// 订阅股票收到TCP推送数据时会发送此通知
extern NSString * const MApiTcpDidReceivedDataNotification;
/// 推送数据类型
extern NSString * const MApiTcpDidReceivedDataTypeKey;
/// 推送股票代码
extern NSString * const MApiTcpDidReceivedDataCodeKey;
/// 推送快照数据键，值为MStockItem
extern NSString * const MApiTcpDidReceivedDataSnapKey;
/// 推送走势数据键，值为MOHLCItem数据
extern NSString * const MApiTcpDidReceivedDataLineItemsKey;
/// 推送走势交易日键，值为NSString数组
extern NSString * const MApiTcpDidReceivedDataLineTradeDatesKey;
/// 推送走势系统时间键，值为NSString
extern NSString * const MApiTcpDidReceivedDataLineTimeKey;
/// 推送分时明细数据键，值为NSArray
extern NSString * const MApiTcpDidReceivedDataTimeTickKey;


/// 上海, ref: @"sh"
extern NSString * const MApiMarketSH;
/// 深圳, ref: @"sz"
extern NSString * const MApiMarketSZ;
/// 香港, ref: @"hk"
extern NSString * const MApiMarketHK;
/// 新三板, ref: @"bj"
extern NSString * const MApiMarketBJ;
/// 中金所, ref: @"cff"
extern NSString * const MApiMarketCFF;
/// 大商所, ref: @"dce"
extern NSString * const MApiMarketDCE;
/// 郑商所, ref: @"czce"
extern NSString * const MApiMarketCZCE;
/// 上期所, ref: @"shfe"
extern NSString * const MApiMarketSHFE;
/// 上期所原油, ref: @"ine"
extern NSString * const MApiMarketINE;
/// 全球指数, ref: @"gi"
extern NSString * const MApiMarketGI;
/// 外汇, ref: @"fe"
extern NSString * const MApiMarketFE;
/// 沪伦通, ref: @"uk"
extern NSString * const MApiMarketUK;
/// 板块指数, ref: @"bk"
extern NSString * const MApiMarketBK;

typedef void (^MApiCompletionHandler)(MResponse *resp);
typedef void (^MApTimeoutHandler)(MRequest *request, BOOL *reload);

typedef BOOL (^MApiTcpUpdateBlock)(MApiModel *item);
typedef void (^MApiTcpReceiveBlock)(NSString *code, MApiTcpUpdateBlock update);

#pragma mark -

/*! @brief 上证云平台终端API
 */
@interface MApi : NSObject

/*! @brief MApi的静态函数，与服务器注册接口的使用许可。
 *
 * 需要在每次启动第三方应用程序时调用。
 * @param appkey 许可键值
 * @param handler 注册接口callback
 * @param sourcePermissions 权限设置
    默认权限为：
     @{
        MApiMarketSH: @(MApiSourceLevel1),
        MApiMarketSZ: @(MApiSourceLevel1),
        MApiMarketHK: @(MApiSourceSHHK1 | MApiSourceSZHK1),
        MApiMarketCFF:@(MApiSourceCFF1)
     } 
    即沪深为Level1权限，港股没有权限,中金所Level1权限
 */
+ (void)registerAPP:(NSString *)appkey completionHandler:(void (^)(NSError *error))handler;

+ (void)registerAPP:(NSString *)appkey sourcePermissions:(NSDictionary *)sourcePermissions completionHandler:(void (^)(NSError *error))handler;

+ (void)registerAPP:(NSString *)appkey withOptions:(NSDictionary *)options completionHandler:(void (^)(NSError *error))handler;

+ (void)registerAPP:(NSString *)appkey sourcePermissions:(NSDictionary *)sourcePermissions options:(NSDictionary *)options completionHandler:(void (^)(NSError *error))handler;

/*! @brief SDK客户权限设置
 *
 *  @param sourcePermissions 权限设置，key值参照上方MApiMarketSH等常量定义，value值参照MApiSourceLevel
 *
 *   设置【沪股Level2】权限
 *     => @{ MApiMarketSH: @(MApiSourceLevel2) }
 *
 *   设置【港股10档+沪港通5档+港股延迟1档】权限
 *     => @{ MApiMarketHK: @(MApiSourceHK10 | MApiSourceSHHK5 | MApiSourceHKD1) }
 */
+ (void)setSourcePermissions:(NSDictionary *)sourcePermissions;

/*! @brief 发送请求至行情服务器
 *
 *  发起请求，请先建立请求对象，依照不同的请求目的，生成具体的请求对象后传入。当服务器应答会回调handler，将可从该回调函式返回应答对象，并从中获取数据。
 *  @param request 具体的请求对象
 *  @param handler 回调函式(返回回应内容对象)
 */
+ (void)sendRequest:(MRequest *)request completionHandler:(MApiCompletionHandler)handler;

/*! @brief 发送请求至行情服务器
 *
 *  发起请求，请先建立请求对象，依照不同的请求目的，生成具体的请求对象后传入。当服务器应答会回调handler，将可从该回调函式返回应答对象，并从中获取数据。
 *  @param request 具体的请求对象
 *  @param handler 回调函式(返回回应内容对象)
 *  @param timeoutHandler(指定是否在server timeout時重發request)
 *  @example 将reload的指针设定为YES, 即可在timeout时重新请求
 *      timeoutHandler = ^(MRequest *request, BOOL *reload) {
 *            *reload = YES;
 *      };
 */
+ (void)sendRequest:(MRequest *)request completionHandler:(MApiCompletionHandler)handler timeoutHandler:(MApTimeoutHandler)timeoutHandler;

/*! @brief 取消所有请求
 *
 *  当发起请求，请求尚未响应时，会在伫列里等待服务器应答，调用此方法将可取消所有在伫列中的请求。
 */
+ (void)cancelAllRequests;

/*! @brief 取消单一请求
 *
 *  当发起请求，请求尚未响应时，会在伫列里等待服务器应答，调用此方法将可取消某一个在伫列中的请求。
 */
+ (void)cancelRequest:(MRequest *)request;
+ (void)cancelRequest_ptr:(MRequest **)request;

/*! @brief 清除缓存
 *
 *  此库支持部分行情缓存，调用此方法可清除所有缓存数据，释放内存及硬盘空间。
 */
+ (void)clearCache;

/*! @brief 获取缓存大小
 *
 *  此库支持部分行情缓存，调用此方法可获取当前缓存使用量
 *  单位:Byte
 *  @return 返回缓存大小
 */
+ (unsigned long long)num_CacheSize;

/**
 *  获取网路状态
 *
 *  调用此方法可获取当前装置的网路状态，状态可参照@see MApiNetworkStatus
 *  @return 网路状态
 *  @see MApiNetworkStatus
 */
+ (MApiNetworkStatus)networkStatus;

/**
 *  取得市场资讯
 *
 *  若欲查询股票的市场资讯(包含小数位数、开收盘时间等信息)，可调用此方法
 *  @param market  市场别
 *  @param subtype 次类别
 *
 *  @return 市场资讯对象
 */
+ (MMarketInfo *)marketInfoWithMarket:(NSString *)market subtype:(NSString *)subtype;

/**
 *  取得各个市场最新交易日期数组
 *
 *  @return 市场交易日期数组
 */
+ (NSDictionary *)fetchMarketLastestTradeDays;

/**
 *  取得全市场股票代码表
 *
 * @param markets  市场别 sh,sz,hk,hh,hz,bj,dce,czce,shfe,ine,fe,gi,gb,cff,bk 分别是沪股，深股，港股，沪港通，深港通，新三板市场,大商所，郑商所，上期所，上期所原油，外汇，全球指数(延时),全球指数(收盘),中金所,板块市场
 * @param handler 下载完毕的回调
 */
+ (MStockTableRequest *)downloadStockTableWithMarkets:(NSArray *)markets completionHandler:(void (^)(NSError *error))handler;
+ (MStockTableRequest *)downloadStockTableWithCompletionHandler:(void (^)(NSError *error))handler;


/**
 *  设置除错模式
 */
+ (NSString *)setDebugMode:(NSDictionary *)configure;

/**
 *  当前版本信息
 */
+ (NSString *)version;
/**
 *  按具体类型订阅股票信息
 *
 *  若要使用长连接接收实时股票行情，可调用此方法
 *  通过监听MApiTcpDidReceivedDataNotification通知来获取具体推送数据
 *  @param codes  股票代码
 */
+ (void)subscribeCode:(NSString *)codes type:(MApiTcpSubscribeType)type;
/**
 *  按具体类型取消订阅信息
 *
 *  取消某一类型的订阅，取消后通知中心将不再发送此类型的通知
 *  如果要取消一只股票的所有类型的数据推送，type传入MApiTcpSubscribeTypeAll
 *  通过监听MApiTcpDidReceivedDataNotification通知来获取具体推送数据
 *  @param type  订阅类型
 */
+ (void)unSubscribeCode:(NSString *)codes type:(MApiTcpSubscribeType)type;
/**
 *  按具体类型取消订阅信息
 *
 *  取消某一类型的订阅，取消后通知中心将不再发送此类型的通知
 *  如果要取消所有股票的所有类型的数据推送，type传入MApiTcpSubscribeTypeAll
 *  通过监听MApiTcpDidReceivedDataNotification通知来获取具体推送数据
 *  @param type  订阅类型
 */
+ (void)unSubscribeAllCodeType:(MApiTcpSubscribeType)type;

/**
 *  获取某市场别行情源类别
 *
 *  若要知道某市场别当前使用的行情源，可以调用此方法
 *  @param market 市场别 [sh, sz, hk, ...]
 *
 */
+ (MApiSourceLevel)sourceLevelWithMarket:(NSString *)market;

/**
 *  更新服务器列表
 *
 *  若要更新当前服务器列表，可调用此方法
 *
 */
+ (BOOL)checkServerList;

/*! @brief 唯一识别代码
 *
 */
+ (NSString *)UUID;

/*! @brief HTTP上传数据大小
 *
 *  单位:Byte
 *  @return 返回HTTP上传数据大小
 */
+ (unsigned long long)HTTPUploadSize;

/*! @brief HTTP下载数据大小
 *
 *  单位:Byte
 *  @return 返回HTTP下载大小
 */
+ (unsigned long long)HTTPDownloadSize;

/*! @brief TCP推送数据大小
 *
 *  单位:Byte
 *  @return 返回TCP推送数据大小
 */
+ (unsigned long long)TCPUploadSize;

/*! @brief TCP下载数据大小
 *
 *  单位:Byte
 *  @return 返回TCP下载数据大小
 */
+ (unsigned long long)TCPDownloadSize;

/*! @brief 重置上传、下载数据大小（TCP、HTTP）
 *
 */
+ (void)resetUploadAndDownloadSize;

/*! @brief 设置配置信息
 *
 */
+ (void)setConfigInfo:(MConfigInfo *)config;

/*! @brief 是否是国内用户
 *  当使用者在国外或者使用国外网络时返回NO。
 */
+ (BOOL)isChinaUser;

/*! @brief 根据股票代码获取行情级别
 *  港股有多种权限设置，当获取一只股票的快照行情时，我们并不确定获取的是哪种行情，调用此方法可以获取当前股票的行情级别
 *  不适用沪深股票，因为沪深股票有L2切换L1的情况
 *  @code 股票代码
 *  @return hk10 ,hk5 ,hka1 ,hkd1 ,hk1
 */
+ (NSString *)quoteLevelFromPermissionWithCode:(NSString *)code;
@end


#pragma mark - Deprecated

@interface MApi(MApi_Deprecated)
+ (MApiSourceLevel)sourceLevel __attribute__((deprecated("已弃用")));
+ (NSString *)cacheSize __attribute__((deprecated("请先使用num_CacheSize, cacheSize后续版本返回型别将改为(unsigned long long)")));
+ (void)setUDID:(NSString *)UDID __attribute__((deprecated));
+ (void)searchingStockFromLocal __attribute__((deprecated("请使用MSearchRequest参数searchLocal")));
+ (void)registerAPP:(NSString *)appkey
        sourceLevel:(MApiSourceLevel)sourceLevel
  completionHandler:(void (^)(NSError *error))handler __attribute__((deprecated("sourceLevel已弃用, 使用setUserPermissionAttributes单独设置市场")));
+ (void)registerAPP:(NSString *)appkey
        withOptions:(NSDictionary *)options
        sourceLevel:(MApiSourceLevel)sourceLevel
  completionHandler:(void (^)(NSError *error))handler __attribute__((deprecated("sourceLevel已弃用, 使用setUserPermissionAttributes单独设置市场")));
+ (void)subscribeQuoteCode:(NSString *)codes didReceiveUpdate:(MApiTcpReceiveBlock)didReceiveUpdate  __attribute__((deprecated("已弃用, 使用unSubscribeCode:type:方法订阅MApiTcpSubscribeTypeSnap类型")));
///注意： 推送API接口升级后，以下取消订阅的API只针对取消快照推送有效，如果新订阅了分时、明细等，调用以下取消方法，只会取消订阅的快照推送，不会影响分时、明细等的推送。
/// 只会取消订阅的快照推送，不会影响分时、明细等的推送
/// 只会取消订阅的快照推送，不会影响分时、明细等的推送
/// 只会取消订阅的快照推送，不会影响分时、明细等的推送
+ (void)unsubscribeQuoteCode:(NSString *)code __attribute__((deprecated("已弃用, 使用unSubscribeCode:type:取消MApiTcpSubscribeTypeSnap类型")));
+ (void)unsubscribeAllQuoteCode __attribute__((deprecated("已弃用, 使用unSubscribeAllCodeType:取消MApiTcpSubscribeTypeALL类型")));
@end

