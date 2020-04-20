//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//分价量表
import XCTest
import os.log
import SwiftyJSON

class MOREPRICE_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.MOREPRICE_1
    }
   
    func testPriceVolume() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MPriceVolumeRequest()
        mRequest.code = param["CODE"].stringValue
        mRequest.subtype = param["SUBTYPE"].stringValue
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let priceVolumeResponse = resp as! MPriceVolumeResponse
//        XCTAssertNotNil(priceVolumeResponse.items)
        if (priceVolumeResponse.items == nil){
            throw BaseTestError.assertFailedError(message: "priceVolumeResponse items is nil")
        }
        var resultJSON : JSON = [:]
        var i = 1
        for item in priceVolumeResponse.items {
            var itemJSON: JSON = [
                "price": item.price,
                "volume": item.volume,
                "buyVolume": item.buyVolume,
                "sellVolume": item.sellVolume,
                "unknownVolume": item.unknownVolume,
                "tradeCount": item.tradeCount,
                "buyCount": item.buyCount,
                "sellCount": item.sellCount,
                "unknownCount": item.unknownCount
            ]
            resultJSON["\(i)"] = itemJSON
            i = i + 1
            
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

