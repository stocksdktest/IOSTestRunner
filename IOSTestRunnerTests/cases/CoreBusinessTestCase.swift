//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//主要业务
import XCTest
import os.log
import SwiftyJSON

class CoreBusinessTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.CoreBusinessTestCase
    }
    
    func testCoreBusiness() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MCoreBusinessRequest()
        mRequest.code = param["CODE"].stringValue
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
        }
        
        
        let resp = self.makeSyncRequest(request: mRequest)
        let coreBusinessResponse = resp as! MCoreBusinessResponse
        XCTAssertNotNil(coreBusinessResponse.records)
        var resultJSON : JSON = [:]
        for records in coreBusinessResponse.records{
            if let record:NSDictionary = records as! NSDictionary{
                var itemJSON: JSON = [
                    "BUSSINESSNATURE_": record["BUSSINESSNATURE"]!,
                    "OperCost": record["OPERCOST"]!,
                    "OPERREVENUETOTOR_": record["OPERREVENUETOTOR"]!,
                    "OperProfit": record["OPERPROFIT"]!,
                    "OperRevenue": record["OPERREVENUE"]!,
                    "ENDDATE_": record["ENDDATE"]!
                ]
                resultJSON["\(record["ENDDATE"]!)"] = itemJSON
                
            }
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
    }
}

