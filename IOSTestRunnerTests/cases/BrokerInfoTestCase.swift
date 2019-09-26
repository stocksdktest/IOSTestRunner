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

class BrokerSeatTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.BrokerSeatTestCase
    }
    
    func testBrokerInfo() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MBrokerSeatRequest()
        mRequest.code = param["CODE"].stringValue

        let resp = self.makeSyncRequest(request: mRequest)
        let brokerSeatResponse = resp as! MBrokerSeatResponse
        print(brokerSeatResponse)
        XCTAssertNotNil(brokerSeatResponse.buyBrokerSeatItems)
        XCTAssertNotNil(brokerSeatResponse.sellBrokerSeatItems)
        
        for buyitem in brokerSeatResponse.buyBrokerSeatItems{
            var resultJSON: JSON = [
                "corp": buyitem.name,
                "corporation": buyitem.fullName,
                "state": "1"
            ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
        for sellitem in brokerSeatResponse.sellBrokerSeatItems{
            var resultJSON: JSON = [
                "corp": sellitem.name,
                "corporation": sellitem.fullName,
                "state": "0"
            ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
    }
}
