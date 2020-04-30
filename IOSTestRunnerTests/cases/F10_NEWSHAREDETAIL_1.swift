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

class F10_NEWSHAREDETAIL_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_NEWSHAREDETAIL_1
    }
    
    func testIPOShareDetail() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MIPOShareDetailRequest()
        mRequest.code = param["CODE"].stringValue
        
        let typeVal = param["SRC"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
//        mRequest.type = MIPOType(rawValue: 0)!
        let resp = try self.makeSyncRequest(request: mRequest)
        let iPOShareDetailResponse = resp as! MIPOShareDetailResponse
//        XCTAssertNotNil(iPOShareDetailResponse.info)
        if (iPOShareDetailResponse.info == nil){
            throw BaseTestError.assertFailedError(message: "iPOShareDetailResponse info is nil")
        }
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
                            "bookStartDateOn":item["BOOKSTARTDATEON"]!
                        ]
                        let update1: JSON = [
                            "issueSharePlan":item["CISSUESHAREPLAN"]!,
                            "issueShareOnPlan":item["ISSUESHAREONPLAN"]!,
                            "issueShare":item["ISSUESHARE"]!,
                            "issueShareOn":item["ISSUESHAREON"]!,
                            "capplyPrice":item["CAPPLYPRICE"]!,
                            "boradName":item["BOARDNAME"]!,
                            "comProfile":item["COMPROFILE"]!,
                            "refundDateOn":item["REFUNDDATEON"]!
                        ]
                        let update2: JSON = [
                            "refundDateOn":item["REFUNDDATEON"]!,
                            "issueAllotnOn":item["ISSUEALLOTNOON"]!,
                            "businessScope":item["BUSINESSSCOPE"]!,
                            "leadUnderwriter":item["LEADUNDERWRITER"]!,
                            "issuePricePlan":item["ISSUEPRICEPLAN"]!,
                            "capplyPricePlan":item["CAPPLYPRICEPLAN"]!,
                            "capplySharePlan":item["CAPPLYSHAREPLAN"]!,
                            "newTotRaiseAmt":item["NEWTOTRAISEAMT"]!,
                            "newNetRaiseAmt":item["NEWNETRAISEAMT"]!,
                            "keyCode":item["KEYCODE"]!
                        ]
                        do {
                            try resultJSON.merge(with: update1)
                            try resultJSON.merge(with: update2)
                        } catch {
                            // ignore
                        }
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
                            "CONVERTPRICE":item["CONVERTPRICE"]!
                        ]
                        let update1: JSON = [
                            "PREFERREDPLACINGCODE":item["PREFERREDPLACINGCODE"]!,
                            "PREFERREDPLACINGNAME":item["PREFERREDPLACINGNAME"]!,
                            "ISSUERRATING":item["ISSUERRATING"]!,
                            "ISSUEVAL":item["ISSUEVAL"]!,
                            "INTERESTTERM":item["INTERESTTERM"]!,
                            "CAPPLYVOL":item["CAPPLYVOL"]!,
                            "BOOKSTARTDATEON":item["BOOKSTARTDATEON"]!,
                            "SUCCRESULTNOTICEDATE":item["SUCCRESULTNOTICEDATE"]!,
                            "LISTINGDATE":item["LISTINGDATE"]!,
                            "ALLOTRATEON":item["ALLOTRATEON"]!
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
   
}
