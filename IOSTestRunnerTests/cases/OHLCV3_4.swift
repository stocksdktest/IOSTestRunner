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

class OHLCV3_4: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.OHLCV3_4
    }
    
    func testOHLCV2() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MOHLCRequestV2()
        mRequest.code = param["CODE"].stringValue
        if param["SUBTYPE"] != ""{
            mRequest.subtype = param["SUBTYPE"].stringValue
        }
        if param["PERIOD"] == "3"{
            mRequest.period = MOHLCPeriod(rawValue: 9)!
        }else if param["PERIOD"] == "4"{
            mRequest.period = MOHLCPeriod(rawValue: 8)!
        }else if param["PERIOD"] == "5"{
            mRequest.period = MOHLCPeriod(rawValue: 3)!
        }else if param["PERIOD"] == "6"{
            mRequest.period = MOHLCPeriod(rawValue: 4)!
        }else if param["PERIOD"] == "7"{
            mRequest.period = MOHLCPeriod(rawValue: 5)!
        }else if param["PERIOD"] == "8"{
            mRequest.period = MOHLCPeriod(rawValue: 6)!
        }else if param["PERIOD"] == "9"{
            mRequest.period = MOHLCPeriod(rawValue: 7)!
        }else{
            mRequest.period = MOHLCPeriod.init(rawValue:param["PERIOD"].uIntValue)!
        }
        if param["BeginDate"] != "" && param["EndDate"] == ""{
            mRequest.date = param["BeginDate"].stringValue
            mRequest.requestType = MRequestType(rawValue: 1)!
        }else if param["EndDate"] != "" && param["BeginDate"] == ""{
            mRequest.date = param["EndDate"].stringValue
            mRequest.requestType = MRequestType(rawValue: 2)!
        }else if param["EndDate"] != "" && param["BeginDate"] != ""{
            mRequest.date = "\(param["BeginDate"]),\(param["EndDate"])"
            mRequest.requestType = MRequestType(rawValue: 3)!
        }
        
        
        if param["PRICEADJUSTEDMODE"] == "0"{
            mRequest.priceAdjustedMode = MOHLCPriceAdjustedMode(rawValue: 1)!
        }else if param["PRICEADJUSTEDMODE"] == "1"{
            mRequest.priceAdjustedMode = MOHLCPriceAdjustedMode(rawValue: 2)!
        }else if param["PRICEADJUSTEDMODE"] == "2"{
            mRequest.priceAdjustedMode = MOHLCPriceAdjustedMode(rawValue: 0)!
        }
        mRequest.count = 300
   
        let resp = self.makeSyncRequest(request: mRequest)
        let oHLCResponse = resp as! MOHLCResponse
        XCTAssertNotNil(oHLCResponse.ohlcItems)
//        XCTAssertNotNil(oHLCResponse.fqItems)
        print(oHLCResponse)
        var resultJSON : JSON = [:]
        for item in oHLCResponse.ohlcItems {
            var itemJSON: JSON = [
                "datetime": item.datetime,
                "openPrice": item.openPrice,
                "highPrice": item.highPrice,
                "lowPrice": item.lowPrice,
                "closePrice": item.closePrice,
                "tradeVolume": item.tradeVolume,
                
            ]
            let update1: JSON = [
                "averagePrice": item.averagePrice,
                "reference_price": item.referencePrice,
                "transaction_price": item.amount,
                "openInterest": item.openInterest,
                "fp_volume": item.afterHoursVolume,
                "fp_amount": item.afterHoursAmount
            ]
            do {
                try itemJSON.merge(with: update1)
            } catch {
                // ignore
            }
            resultJSON["\(item.datetime!)"] = itemJSON
            
        }
       print(resultJSON)
       onTestResult(param: param, result: resultJSON)
    }
}

