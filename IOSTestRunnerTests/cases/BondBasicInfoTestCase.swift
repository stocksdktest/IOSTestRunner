//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//债券概况
import XCTest
import os.log
import SwiftyJSON

class BondBasicInfoTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.BondBasicInfoTestCase
    }
    
    func testBondBasicInfo() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MBondBasicInfoRequest()
        mRequest.code = param["CODE"].stringValue
        
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
        mRequest.sourceType = typeVal
        }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let bondBasicInfoResponse = resp as! MBondBasicInfoResponse
        XCTAssertNotNil(bondBasicInfoResponse.record)
        if let item = bondBasicInfoResponse.record{
            var resultJSON: JSON = [
                "BONDNAME":item["BONDNAME"]!,
                "BONDSNAME":item["BONDSNAME"]!,
                "SYMBOL":item["SYMBOL"]!,
                "BONDTYPE2":item["BONDTYPE2"]!,
                "INITIALCREDITRATE":item["INITIALCREDITRATE"]!,
                "PARVALUE":item["PARVALUE"]!,
                "MATURITYYEAR":item["MATURITYYEAR"]!,
                "BASERATE":item["BASERATE"]!,
                "CALCAMODE":item["CALCAMODE"]!,
                "PAYMENTMODE":item["PAYMENTMODE"]!,
                "LISTDATE":item["LISTDATE"]!,
                "EXCHANGENAME":item["EXCHANGENAME"]!,
                "LISTSTATE":item["LISTSTATE"]!,
                "PAYMENTDATE":item["PAYMENTDATE"]!,
                "DECLAREDATE":item["DECLAREDATE"]!,
            ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
            
        }
    }
}

