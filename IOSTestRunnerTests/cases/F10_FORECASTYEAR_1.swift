//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//机构预测
import XCTest
import os.log
import SwiftyJSON

class F10_FORECASTYEAR_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_FORECASTYEAR_1
    }

    func testForecastYeare() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MForecastYearRequest()
        mRequest.code = param["CODE"].stringValue
        let typeVal = param["SRC"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let forecastYearResponse = resp as! MForecastYearResponse
//        XCTAssertNotNil(forecastYearResponse.record)
        if (forecastYearResponse.record == nil){
            throw BaseTestError.assertFailedError(message: "forecastRatingResponse record is nil")
        }
        if let record: NSDictionary = forecastYearResponse.record as NSDictionary{
            var resultJSON: JSON = [
                "NETEPS_": record["NETEPS"]!,
                "AVGCOREREVENUE_": record["AVGCOREREVENUE"]!,
                "FORECASTYEAR_": record["FORECASTYEAR"]!,
                "STATISTICDATE_": record["STATISTICDATE"]!,
                "AVGPROFIT_": record["AVGPROFIT"]!,
                "ForecastYYYY": record["FORECASTYYYY"]!,
                "FORECASTCOUNT_": record["FORECASTCOUNT"]!
            ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
    }
}

