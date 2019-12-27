//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//财经资讯列表
import XCTest
import os.log
import SwiftyJSON

class F10_NEWSLIST_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_NEWSLIST_1
    }
    
    func testNewsList() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MNewsListRequest()
        let typeVal = param["SOURCETYPE"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        
         mRequest.newsType = param["NEWSTYPE"].stringValue
         mRequest.newsID = param["NEWSID"].stringValue
        if param["TYPE"] == "-1"{
            mRequest.type = F10NewsRequestType(rawValue: -1)!
        }else if param["TYPE"] == "5"{
            mRequest.type = F10NewsRequestType(rawValue: 1)!
        }else if param["TYPE"] == "6"{
            mRequest.type = F10NewsRequestType(rawValue: 2)!
        }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let newsListResponse = resp as! MNewsListResponse
        XCTAssertNotNil(newsListResponse.newsItems)
        var resultJSON : JSON = [:]
        for items in newsListResponse.newsItems{
          if let item: MNewsItem = items as! MNewsItem{
            var itemJSON: JSON = [
                "ID_":item.id,
                "INIPUBDATE_":item.datetime,
                "REPORTTITLE_":item.title,
                "MEDIANAME_":item.source,
                "ABSTRACTFORMAT_":item.format,
            ]
            resultJSON["\(item.datetime!)"] = itemJSON
            
            }
     }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
}
}
