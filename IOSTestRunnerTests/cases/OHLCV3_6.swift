//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//历史K线数据
import XCTest
import os.log
import SwiftyJSON

class OHLCV3_6: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.OHLCV3_6
    }
    
    func testOHLCV2() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MOHLCRequestV2()
        mRequest.code = param["CODE"].stringValue
        if param["SUBTYPE"] != ""{
            mRequest.subtype = param["SUBTYPE"].stringValue
        }
        switch param["PERIOD"] {
        case "dayk":
            mRequest.period = MOHLCPeriod(rawValue: 0)!
        case "weekk":
            mRequest.period = MOHLCPeriod(rawValue: 1)!
        case "monthk":
            mRequest.period = MOHLCPeriod(rawValue: 2)!
        case "m5":
            mRequest.period = MOHLCPeriod(rawValue: 3)!
        case "m15":
            mRequest.period = MOHLCPeriod(rawValue: 4)!
        case "m30":
            mRequest.period = MOHLCPeriod(rawValue: 5)!
        case "m60":
            mRequest.period = MOHLCPeriod(rawValue: 6)!
        case "m120":
            mRequest.period = MOHLCPeriod(rawValue: 7)!
        case "m1":
            mRequest.period = MOHLCPeriod(rawValue: 8)!
        case "yeark":
            mRequest.period = MOHLCPeriod(rawValue: 9)!
        default:
            mRequest.period = MOHLCPeriod(rawValue: 0)!
        }
        mRequest.date = param["DATE"].stringValue
        mRequest.requestType = MRequestType(rawValue: 2)!
        
        
        if param["PRICEADJUSTEDMODE"] == "0"{
            mRequest.priceAdjustedMode = MOHLCPriceAdjustedMode(rawValue: 1)!
        }else if param["PRICEADJUSTEDMODE"] == "1"{
            mRequest.priceAdjustedMode = MOHLCPriceAdjustedMode(rawValue: 2)!
        }else if param["PRICEADJUSTEDMODE"] == "2"{
            mRequest.priceAdjustedMode = MOHLCPriceAdjustedMode(rawValue: 0)!
        }
        mRequest.count = param["COUNT"].uIntValue
   
        let resp = self.makeSyncRequest(request: mRequest)
        let oHLCResponse = resp as! MOHLCResponse
        XCTAssertNotNil(oHLCResponse.ohlcItems)
//        XCTAssertNotNil(oHLCResponse.fqItems)
        print(oHLCResponse)
        var resultJSON : JSON = [:]
        for i in 0 ..< oHLCResponse.ohlcItems.count{
        let item : MOHLCItem = oHLCResponse.ohlcItems[i]
        let circulatingShareItem : MCirculatingShareItem = oHLCResponse.circulatingShareItems[i]
            var itemJSON: JSON = [
                "datetime": item.datetime,
                "openPrice": item.openPrice,
                "highPrice": item.highPrice,
                "lowPrice": item.lowPrice,
                "closePrice": item.closePrice,
                "tradeVolume": item.tradeVolume,
                "iopv": item.iopv
                
            ]
            let update1: JSON = [
                "averagePrice": item.averagePrice,
                "reference_price": item.referencePrice,
                "transaction_price": item.amount,
                "openInterest": item.openInterest,
                "fp_volume": item.afterHoursVolume,
                "fp_amount": item.afterHoursAmount,
                "date":circulatingShareItem.dateTime,
                "gb":circulatingShareItem.circulatingShare,
            ]
            do {
                try itemJSON.merge(with: update1)
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
                        resultJSON["\(item.datetime!)"] = itemJSON2
            
        }
       print(resultJSON)
       onTestResult(param: param, result: resultJSON)
    }
}

