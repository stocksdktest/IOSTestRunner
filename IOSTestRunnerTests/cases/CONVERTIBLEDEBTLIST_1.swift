//
//  BlockTradeTestCase.swift
//  IOSTestRunnerTests
//
//  Created by 俞建斌 on 2019/9/25.
//  Copyright © 2019 liao xiangsen. All rights reserved.
//  可转债行情列表

import XCTest
import os.log
import SwiftyJSON

class CONVERTIBLEDEBTLIST_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.CONVERTIBLEDEBTLIST_1
    }
    func testKZZQuoteList() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MKZZQuoteListRequest()
        let paramI:NSArray = (param["PARAMS"].stringValue.split(separator: ",") as! NSArray)
        mRequest.pageIndex = Int(paramI[0] as! String)!
        mRequest.pageSize = Int(paramI[1] as! String)!
        mRequest.field = MKZZQuoteListField(rawValue: Int(paramI[2] as! String)!)!
        if paramI[3] as! String == "0"{
            mRequest.ascending = (0 as NSNumber).boolValue
        }else if paramI[3] as! String == "1"{
            mRequest.ascending = (1 as NSNumber).boolValue
        }
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let kzzQuoteListResponse = resp as! MKZZQuoteListResponse
//        XCTAssertNotNil(searchResponse.resultItems)
        if (kzzQuoteListResponse.items == nil){
            throw BaseTestError.assertFailedError(message: "kzzQuoteListResponse items is nil")
        }
        var resultJSON : JSON = [:]
        var i = 1
        for items in kzzQuoteListResponse.items {
            var itemJSON: JSON = [
                "name": items.nameKZZ,
                "code": items.codeKZZ,
                "market": items.marketKZZ,
                "subtype": items.subtypeKZZ,
                "lastPrice": items.lastPriceKZZ,
                "preClosePrice": items.preClosePriceKZZ,
                "changeRate": items.changeRateKZZ,
                "dateTime": items.datetimeKZZ
            ]
            let update1 : JSON = [
                "zgName": items.nameZG,
                "zgCode": items.codeZG,
                "zgMarket": items.marketZG,
                "zgSubtype": items.subtypeZG,
                "zgLastPrice": items.lastPriceZG,
                "zgPreClosePrice": items.preClosePriceZG,
                "zgChangeRate": items.changeRateZG,
                "zgDateTime": items.datetimeZG,
            ]
            let update2 : JSON = [
                "conversionPremiumRate": items.premiumRate,
                "conversionPrice": items.conversionPrice,
                "conversionValue": items.conversionValue,
            ]
            do {
                try itemJSON.merge(with: update1)
                try itemJSON.merge(with: update2)
            } catch {
                // ignore
            }
            for itemKey in itemJSON.dictionaryValue.keys{
                if itemJSON[itemKey] == ""{
                    itemJSON[itemKey].stringValue = "-"
                }
            }
            let itemID: String = items.codeKZZ.replacingOccurrences(of: ".", with: "_")
            
            resultJSON["\(itemID)"] = itemJSON
            i += 1
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

