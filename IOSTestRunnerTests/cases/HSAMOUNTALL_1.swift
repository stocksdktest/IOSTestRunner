//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//沪股通和深股通额度数据接口（合并）
import XCTest
import os.log
import SwiftyJSON

class HSAMOUNTALL_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.HSAMOUNTALL_1
    }
    func testHSAmountAll() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MHSAmountAllRequest()
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let hSAmountAllResponse = resp as! MHSAmountAllResponse
        if (hSAmountAllResponse.hktQuoteItem == nil){
            throw BaseTestError.assertFailedError(message: "hSAmountAllResponse hktQuoteItem is nil")
        }
        let items : MHKTQuotaItem = hSAmountAllResponse.hktQuoteItem!
        var resultJSON: JSON = [
            "hgtInitialQuotaS":items.hgtInitialQuotaS,
            "hgtRemainingQuotaS":items.hgtRemainingQuotaS,
            "hgtQuotaStatusS":items.hgtQuotaStatusS,
            "hgtTotalBuyAmountS":items.hgtTotalBuyAmountS,
            "hgtTotalSellAmountS":items.hgtTotalSellAmountS,
            "hgtBuySellTotalAmountS":items.hgtBuySellTotalAmountS,
            "hgtInitialQuotaN":items.hgtInitialQuotaN,
            "hgtRemainingQuotaN":items.hgtRemainingQuotaN,
        ]
        let update0: JSON = [
            "hgtTotalBuyAmountN":items.hgtTotalBuyAmountN,
            "hgtTotalSellAmountN":items.hgtTotalSellAmountN,
            "hgtBuySellTotalAmountN":items.hgtBuySellTotalAmountN,
            "sgtInitialQuotaS":items.sgtInitialQuotaS,
            "sgtRemainingQuotaS":items.sgtRemainingQuotaS,
            "sgtQuotaStatusS":items.sgtQuotaStatusS,
            "sgtTotalBuyAmountS":items.sgtTotalBuyAmountS,
            "sgtTotalSellAmountS":items.sgtTotalSellAmountS,
        ]
        let update1: JSON = [
            "sgtBuySellTotalAmountS":items.sgtBuySellTotalAmountS,
            "sgtInitialQuotaN":items.sgtInitialQuotaN,
            "sgtRemainingQuotaN":items.sgtRemainingQuotaN,
            "sgtTotalBuyAmountN":items.sgtTotalBuyAmountN,
            "sgtTotalSellAmountN":items.sgtTotalSellAmountN,
            "sgtBuySellTotalAmountN":items.sgtBuySellTotalAmountN,
        ]
        do {
            try resultJSON.merge(with: update0)
            try resultJSON.merge(with: update1)
        } catch {
            // ignore
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

