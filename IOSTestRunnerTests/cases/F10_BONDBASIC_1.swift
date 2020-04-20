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

class F10_BONDBASIC_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_BONDBASIC_1
    }
    
    func testBondBasicInfo() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MBondBasicInfoRequest()
        mRequest.code = param["CODE"].stringValue
        
        let typeVal = param["SRC"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let bondBasicInfoResponse = resp as! MBondBasicInfoResponse
//        XCTAssertNotNil(bondBasicInfoResponse.record)
        if (bondBasicInfoResponse.record == nil){
            throw BaseTestError.assertFailedError(message: "bondBasicInfoResponse record is nil")
        }
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
                
            ]
            let update1: JSON = [
                "PAYMENTMODE":item["PAYMENTMODE"]!,
                "LISTDATE":item["LISTDATE"]!,
                "EXCHANGENAME":item["EXCHANGENAME"]!,
                "LISTSTATE":item["LISTSTATE"]!,
                "PAYMENTDATE":item["PAYMENTDATE"]!,
                "DECLAREDATE":item["DECLAREDATE"]!,
            ]
            do {
                try resultJSON.merge(with: update1)
            } catch {
                // ignore
            }
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
            
        }
    }
}

