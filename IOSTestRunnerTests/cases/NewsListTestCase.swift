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

class NewsListTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.NewsListTestCase
    }
    
    func testNewsList() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MNewsListRequest()
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
            }
        
         mRequest.newsType = param["NEWSTYPE"].stringValue
         mRequest.newsID = param["NEWSID"].stringValue
        
        if let typeVal =  F10NewsRequestType.init(rawValue:param["TYPE"].intValue) {
            mRequest.type = typeVal
            }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let newsListResponse = resp as! MNewsListResponse
        XCTAssertNotNil(newsListResponse.newsItems)
        for items in newsListResponse.newsItems{
          if let item: MNewsItem = items as! MNewsItem{
            var resultJSON: JSON = [
                "ID_":item.id,
                "INIPUBDATE_":item.datetime,
                "REPORTTITLE_":item.title,
                "MEDIANAME_":item.source,
                "ABSTRACTFORMAT_":item.format,
            ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
            }
     }
}
}
