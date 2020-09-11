//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//板块排行_2
import XCTest
import os.log
import SwiftyJSON

class BANKUAISORTING_2: BaseTestCase {
    var jjj = 0
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.BANKUAISORTING_2
    }
    
    func testSectionSorting() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MSectionSortingRequest()
        jjj+=1
        mRequest.code = param["SYMBOL"].stringValue
        let paramI:NSArray = (param["PARAMS"].string?.split(separator: ",") as! NSArray)
        mRequest.endIndex = Int(paramI[1] as! String)!
        mRequest.beginIndex = Int(paramI[0] as! String)!
        mRequest.ascending = (paramI[3] as! NSString).boolValue
        var sortingField = [
            "s" : 0 ,        //代码
            "zxj" : 1  ,//最新价
            "kpj" : 2 , //开盘价
            "zgj" : 3 , //最高价
            "zdj" : 4 ,//最低价
            "zsj" : 5 , //昨收价
            "zde" : 6 , //涨跌额
            
            
            
        ]
        let update1 = [
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
        do {
            try sortingField.merge(update1, uniquingKeysWith: +)
        } catch {
            // ignore
        }
        let update6 = [
            "zdf" : 7 ,//涨跌幅
            "zdf5" : 8 ,  //5日涨跌幅
            "zdf10" : 9 ,  //10日涨跌幅
            "zcje" : 10 , //总成交额
            "zcjl" : 11 , //总成交量
            "xcjl" : 12 ,//现成交量
            "qzf" :13 ,//权涨幅
        ]
        do {
            try sortingField.merge(update6, uniquingKeysWith: +)
        } catch {
            // ignore
        }
        let update7 = [
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
        ]
        do {
            try sortingField.merge(update7, uniquingKeysWith: +)
        } catch {
            // ignore
        }
        
        
        
        mRequest.field = MSectionSortingField.init(rawValue: sortingField["\(paramI[2])"]!)!
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let sectionSortingResponse = resp as! MSectionSortingResponse
//        XCTAssertNotNil(sectionSortingResponse.sectionSortingItems)
        if (sectionSortingResponse.sectionSortingItems == nil){
            throw BaseTestError.assertFailedError(message: "sectionSortingResponse sectionSortingItems is nil")
        }
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
            ]
            
            let update2: JSON = [
                "stockChangeRate": item.stockChangeRate,
                "netCapitalInflow": item.netCapitalInflow,
                "netCapitalInflow5": item.netCapitalInflow5,
            ]
            do {
                try itemJSON.merge(with: update2)
            } catch {
                // ignore
            }
            let update3: JSON = [
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
            ]
            do {
                try itemJSON.merge(with: update3)
            } catch {
                // ignore
            }
            let update4: JSON = [
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
            ]
            do {
                try itemJSON.merge(with: update4)
            } catch {
                // ignore
            }
            let update5: JSON = [
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
            do {
                try itemJSON.merge(with: update5)
            } catch {
                // ignore
            }
            var itemJSON2 : JSON = [:]
            var itemDic : Dictionary = [String:String]()
                                        for itemKey in itemJSON.dictionaryValue.keys{
                                            
                                            itemDic[itemKey] = itemJSON[itemKey].stringValue
                                            if itemDic[itemKey] != ""{
                                                itemJSON2[itemKey].stringValue = itemDic[itemKey]!
                                            }else{
                                                itemJSON2[itemKey].stringValue = "-"
                                            }
                                            
                                        }
            resultJSON["\(i)"] = itemJSON2
            i = i+1
        }
        print("执行至第\(jjj)个")
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

