//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//机构评等
import XCTest
import os.log
import SwiftyJSON

class F10_FORECASTRATING_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_FORECASTRATING_1
    }
    
    func testForecastRating() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MForecastRatingRequest()
        mRequest.code = param["CODE"].stringValue
        let typeVal = param["SOURCETYPE"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        
        
        let resp = self.makeSyncRequest(request: mRequest)
        let forecastRatingResponse = resp as! MForecastRatingResponse
        XCTAssertNotNil(forecastRatingResponse.records)
        var resultJSON: JSON = [
            "RatingFlag": forecastRatingResponse.ratingFlag,
            "RatingDec": forecastRatingResponse.ratingDescription,
            "DATETITLE_": forecastRatingResponse.dateTitle
        ]
        var jsonarr1 : JSON = [:]
        for list in forecastRatingResponse.records{
                        if let dic1:NSDictionary = list as! NSDictionary{
                            var jsonarr2: JSON = [
                                "WRITINGDATE_": dic1["WRITINGDATE"]!,
                                "CHINAMEABBR_": dic1["CHINAMEABBR"]!,
                                "INVRATINGDESC_": dic1["INVRATINGDESC"]!,
                                "LAST_INVRATINGDESC_": dic1["LAST_INVRATINGDESC"]!
                            ]
                            jsonarr1["\(dic1["WRITINGDATE"]!)"] = jsonarr2
                        }
                    }
                    resultJSON["list"] = jsonarr1
        
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }


}

