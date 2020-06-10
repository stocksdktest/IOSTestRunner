//
//  BrokerInfoTestCase.swift
//  IOSTestRunnerTests
//
//  Created by HW1-MM01 on 2019/9/17.
//  Copyright © 2019 liao xiangsen. All rights reserved.
//

import XCTest
import os.log
import SwiftyJSON

class BROKERINFO_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.BROKERINFO_1
    }
    
    func testBrokerInfo() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MBrokerSeatRequest()
        mRequest.code = param["CODE"].stringValue

        let resp = try self.makeSyncRequest(request: mRequest)
        let brokerSeatResponse = resp as! MBrokerSeatResponse
//        print(brokerSeatResponse)
//        XCTAssertNotNil(brokerSeatResponse.buyBrokerSeatItems)
//        XCTAssertNotNil(brokerSeatResponse.sellBrokerSeatItems)
        if (brokerSeatResponse.buyBrokerSeatItems == nil){
            throw BaseTestError.assertFailedError(message: "brokerSeatResponse buyBrokerSeatItems is nil")
        }
        if (brokerSeatResponse.sellBrokerSeatItems == nil){
            throw BaseTestError.assertFailedError(message: "brokerSeatResponse sellBrokerSeatItems is nil")
        }
        var resultJSON : JSON = [:]
        var i = 1
        
        for buyitem in brokerSeatResponse.buyBrokerSeatItems{
            
            let itemJSON: JSON = [
                "corp": buyitem.name,
                "corporation": buyitem.fullName,
                "state": "1"
            ]
//            print(itemJSON)
            resultJSON["\(i)"] = itemJSON
            i = i + 1
        }
        for sellitem in brokerSeatResponse.sellBrokerSeatItems{
            let itemJSON: JSON = [
                "corp": sellitem.name,
                "corporation": sellitem.fullName,
                "state": "0"
            ]
            resultJSON["\(i)"] = itemJSON
            i = i + 1
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}
