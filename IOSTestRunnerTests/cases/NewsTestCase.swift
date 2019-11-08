//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//财经资讯明细
import XCTest
import os.log
import SwiftyJSON

class NewsTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.NewsTestCase
    }
    
    func testNews() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MNewsRequest()
        mRequest.newsID = param["NEWSID"].stringValue
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
            }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let newsResponse = resp as! MNewsResponse
        XCTAssertNotNil(newsResponse.newsDetailItem)
        if let item = newsResponse.newsDetailItem{
            var resultJSON: JSON = [
                "ABSTRACT_":item.content,
                "INIPUBDATE_":item.datetime,
                "MEDIANAME_":item.source,
                "ABSTRACTFORMAT_":item.format,
                ]
           print(resultJSON)
           onTestResult(param: param, result: resultJSON)
            }
        }
    }

        

