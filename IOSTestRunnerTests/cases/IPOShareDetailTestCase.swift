//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//新股（债）详情
import XCTest
import os.log
import SwiftyJSON

class IPOShareDetailTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.IPOShareDetailTestCase
    }
    
    func testIPOShareDetail() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MIPOShareDetailRequest()
        mRequest.code = param["CODE"].stringValue
        
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
       mRequest.sourceType = typeVal
       }
        
        if let typeVal = MIPOType.init(rawValue:param["TYPE"].uIntValue) {
       mRequest.type = typeVal
        let resp = self.makeSyncRequest(request: mRequest)
        let iPOShareDetailResponse = resp as! MIPOShareDetailResponse
        XCTAssertNotNil(iPOShareDetailResponse.info)
            switch mRequest.type{
            case .stock:
                    if let item: NSDictionary = iPOShareDetailResponse.info as! NSDictionary{
                        var resultJSON: JSON = [
                        "applyCode":item["APPLYCODE"]!,
                        "secuabbr":item["SECUABBR"]!,
                        "tradingCode":item["TRADINGCODE"]!,
                        "peaIssue":item["PEAISSUE"]!,
                        "succResultNoticeDate":item["SUCCRESULTNOTICEDATE"]!,
                        "issuePrice":item["ISSUEPRICE"]!,
                        "capplyShare":item["CAPPLYSHARE"]!,
                        "allotrateon":item["ALLOTRATEON"]!,
                        "listingDate":item["LISTINGDATE"]!,
                        "bookStartDateOn":item["BOOKSTARTDATEON"]!,
                        "issueSharePlan":item["CISSUESHAREPLAN"]!,
                        "issueShareOnPlan":item["ISSUESHAREONPLAN"]!,
                        "issueShare":item["ISSUESHARE"]!,
                        "issueShareOn":item["ISSUESHAREON"]!,
                        "capplyPrice":item["CAPPLYPRICE"]!,
                        "boradName":item["BOARDNAME"]!,
                        "comProfile":item["COMPROFILE"]!,
                        "refundDateOn":item["REFUNDDATEON"]!,
                        "issueAllotnOn":item["ISSUEALLOTNOON"]!,
                        "businessScope":item["BUSINESSSCOPE"]!,
                        "leadUnderwriter":item["LEADUNDERWRITER"]!,
                        "issuePricePlan":item["ISSUEPRICEPLAN"]!,
                        "capplyPricePlan":item["CAPPLYPRICEPLAN"]!,
                        "cappleSharePlan":item["CAPPLYSHAREPLAN"]!,
                        "newTotRaiseAmt":item["NEWTOTRAISEAMT"]!,
                        "newNetRaiseAmt":item["NEWNETRAISEAMT"]!,
                        "keyCode":item["KEYCODE"]!
                        ]
                        print(resultJSON)
                        onTestResult(param: param, result: resultJSON)
                    }
                
            case .bond:

                    if let item: NSDictionary = iPOShareDetailResponse.info as! NSDictionary{
                        var resultJSON: JSON = [
                        "APPLYCODE":item["APPLYCODE"]!,
                        "TRADINGCODE":item["TRADINGCODE"]!,
                        "SECUABBR":item["SECUABBR"]!,
                        "STOCKTRADINGCODE":item["STOCKTRADINGCODE"]!,
                        "STOCKSECUABBR":item["STOCKSECUABBR"]!,
                        "ISSUEPRICE":item["ISSUEPRICE"]!,
                        "CONVERTPRICE":item["CONVERTPRICE"]!,
                        "PREFERREDPLACINGCODE":item["PREFERREDPLACINGCODE"]!,
                        "PREFERREDPLACINGNAME":item["PREFERREDPLACINGNAME"]!,
                        "ISSUERRATING":item["ISSUERRATING"]!,
                        "ISSUEVAL":item["ISSUEVAL"]!,
                        "INTERESTTERM":item["INTERESTTERM"]!,
                        "CAPPLYVOL":item["CAPPLYVOL"]!,
                        "BOOKSTARTDATEON":item["BOOKSTARTDATEON"]!,
                        "SUCCRESULTNOTICEDATE":item["SUCCRESULTNOTICEDATE"]!,
                        "LISTINGDATE":item["LISTINGDATE"]!,
                        "ALLOTRATEON":item["ALLOTRATEON"]!,
                        ]
                        print(resultJSON)
                        onTestResult(param: param, result: resultJSON)
                    }
                
           }
    
       }
   }
}
