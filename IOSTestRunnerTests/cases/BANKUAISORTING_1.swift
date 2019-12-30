//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//板块排行_1
import XCTest
import os.log
import SwiftyJSON

class BANKUAISORTING_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.BANKUAISORTING_1
    }
    
    func testSectionSorting() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MSectionSortingRequest()
        mRequest.code = param["SYMBOL"].stringValue
       
        let paramI:NSArray = (param["param"].string?.split(separator: ",") as! NSArray)
        mRequest.pageSize = Int(paramI[1] as! String)!
        mRequest.pageIndex = Int(paramI[0] as! String)!
        mRequest.ascending = (paramI[3] as! NSString).boolValue
        let sortingField = [
            "s" : 0 ,        //代码
            "zxj" : 1  ,//最新价
            "kpj" : 2 , //开盘价
            "zgj" : 3 , //最高价
            "zdj" : 4 ,//最低价
            "zsj" : 5 , //昨收价
            "zde" : 6 , //涨跌额
            "zdf" : 7 ,//涨跌幅
            "zdf5" : 8 ,  //5日涨跌幅
            "zdf10" : 9 ,  //10日涨跌幅
            "zcje" : 10 , //总成交额
            "zcjl" : 11 , //总成交量
            "xcjl" : 12 ,//现成交量
            "qzf" :13 ,//权涨幅
            "jzf" : 14 , //均涨幅
            "lzzh" : 15 , //流通市值
            "szzh" : 16 , //总市值
            "wb" : 17 , //委比
            "wc" : 18 , //委差
            "hsl" : 19 , //换手率
            "zf" : 20 , //振幅
            //涨跌家数
            "zgb" : 21 , //涨股比
            "zdjs" : 22 ,//涨跌家数
            "ztjs" : 23 , //涨停家数
            "dtjs" : 24 , //跌停家数
            //增值指标
            "zlzjlr" : 25 , //主力资金流入
            "zlzjlc" : 26 , //主力资金流出
            "zlzjjlr" : 27 , //主力资金净流入
            "zlzjjlr5" : 28 , //5日主力资金净流入
            "zlzjjlr10" : 29 , //10日主力资金净流入
            //领涨股
            "lzg" : 30 ,//领涨股
            "ggzf" : 31 , //个股涨幅
            "ggzfb" : 32 , //个股涨幅比
            //优品概念板块
            "hot" : 33,
        ]
        
        
        
        mRequest.field = MSectionSortingField.init(rawValue: sortingField["\(paramI[2])"]!)!
        
        let resp = self.makeSyncRequest(request: mRequest)
        let sectionSortingResponse = resp as! MSectionSortingResponse
        XCTAssertNotNil(sectionSortingResponse.sectionSortingItems)
        var resultJSON : JSON = [:]
        var i = 1
        for item in sectionSortingResponse.sectionSortingItems {
            var itemJSON: JSON = [
                "id": item.id,
                "name": item.name,
                "weightedChange": item.weightedChange,
                "averageChange": item.averageChange,
                "amount": item.amount,
                "advanceAndDeclineCount": item.advanceAndDeclineCount,
                "turnoverRate": item.turnoverRate,
                "stockID": item.stockID,
                "stockName": item.stockName,
                "stockChange": item.stockChange,
                "stockChangeRate": item.stockChangeRate,
                "netCapitalInflow": item.netCapitalInflow,
                "netCapitalInflow5": item.netCapitalInflow5,
                "netCapitalInflow10": item.netCapitalInflow10,
                "capitalInflow": item.capitalInflow,
                "capitalOutflow": item.capitalOutflow,
                "type": item.type,
                "hot": item.hot,
                "volume": item.volume,
                "nowVolume": item.nowVolume,
                "lastPrice": item.lastPrice,
                "changeRate": item.changeRate,
                "changeRate5": item.changeRate5,
                "changeRate10": item.changeRate10,
                "flowValue": item.flowValue,
                "totalValue": item.totalValue,
                "riseRate": item.riseRate,
                "openPrice": item.openPrice,
                "highPrice": item.highPrice,
                "lowPrice": item.lowPrice,
                "preClosePrice": item.preClosePrice,
                "change": item.change,
                "entrustBuyVolume": item.entrustBuyVolume,
                "entrustSellVolume": item.entrustSellVolume,
                "orderRatio": item.orderRatio,
                "entrustDiff": item.entrustDiff,
                "pe": item.pe,
                "spe": item.spe,
                "roe": item.roe,
                "amplitudeRate": item.amplitudeRate,
                
                "stockLastPrice": item.stockLastPrice,
                "limitUpCount": item.limitUpCount,
                "limitDownCount": item.limitDownCount
            ]
            resultJSON["\(i)"] = itemJSON
            i = i+1
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

