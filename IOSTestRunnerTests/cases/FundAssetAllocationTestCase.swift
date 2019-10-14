//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//资产配置
import XCTest
import os.log
import SwiftyJSON

class FundAssetAllocationTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.FundAssetAllocationTestCase
    }
    
    func testFundAssetAllocation() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MFundAssetAllocationRequest()
        mRequest.code = param["CODE"].stringValue
        
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
  }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let fundAssetAllocationResponse = resp as! MFundAssetAllocationResponse
        XCTAssertNotNil(fundAssetAllocationResponse.records)
        for items in fundAssetAllocationResponse.records{
            if let item: NSDictionary = items as! NSDictionary{
                var resultJSON: JSON = [
                    "ASSESECI":item["ASSESECI"]!,
                    "BDINVE":item["BDINVE"]!,
                    "FDINVE":item["FDINVE"]!,
                    "STKINVE":item["STKINVE"]!,
                    "TOTASSET":item["TOTASSET"]!,
                    "TOTASSETYOY":item["TOTASSETYOY"]!,
                ]
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
    }
}
