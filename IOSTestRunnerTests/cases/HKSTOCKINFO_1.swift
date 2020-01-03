//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//港股其他信息
import XCTest
import os.log
import SwiftyJSON

class HKSTOCKINFO_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.HKSTOCKINFO_1
    }
    
    func testHKQuoteInfo() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MHKQuoteInfoRequest()
        mRequest.code = param["CODE"].stringValue
        mRequest.subtype = param["SUBTYPE"].stringValue
        
        let resp = self.makeSyncRequest(request: mRequest)
        let hKQuoteInfoResponse = resp as! MHKQuoteInfoResponse
        XCTAssertNotNil(hKQuoteInfoResponse.oddInfoItems)
        var resultJSON: JSON = [
            "vcmDataTimestamp": hKQuoteInfoResponse.vcmDatetime,
            "vcmStartTime": hKQuoteInfoResponse.vcmStartTime,
            "vcmEndTime": hKQuoteInfoResponse.vcmEndTime,
            "vcmReffPrice": hKQuoteInfoResponse.vcmRefPrice,
            "vcmLowerPrice": hKQuoteInfoResponse.vcmLowerPrice,
            "vcmUpperPrice": hKQuoteInfoResponse.vcmUpperPrice,
            
        ]
        let update1: JSON = [
            "casDataTimestamp": hKQuoteInfoResponse.casDatetime,
            "casOrdImbDirection": hKQuoteInfoResponse.casOrdImbDirection,
            "casOrdImbQty": hKQuoteInfoResponse.casOrdImbQty,
            "casReffPrice": hKQuoteInfoResponse.casRefPrice,
            "casLowerPrice": hKQuoteInfoResponse.casLowerPrice,
            "casUpperPrice": hKQuoteInfoResponse.casUpperPrice
        ]
        do {
            try resultJSON.merge(with: update1)
        } catch {
            // ignore
        }
        var jsonarr1 : JSON = [:]
        for item in hKQuoteInfoResponse.oddInfoItems {
            var jsonarr2: JSON = [
                "OrderId": item.orderId,
                "OrderQty": item.orderQty,
                "Price": item.price,
                "BrokerID": item.brokerId,
                "Side": item.side.rawValue,
                "DataTimestamp": item.datetime
            ]
            jsonarr1["\(item.orderId!)"] = jsonarr2
        }
        resultJSON["HKOtherItem"] = jsonarr1
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

