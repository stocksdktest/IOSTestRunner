//
//  File.swift
//  IOSTestRunnerTests
//
//  Created by 俞建斌 on 2019/9/5.
//  Copyright © 2019 liao xiangsen. All rights reserved.
//

import XCTest
import os.log
import SwiftyJSON

class PlateIndexQuoteTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.PlateIndexQuoteTestCase
    }
    
    func testPlateIndexQuote() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MPlateIndexQuoteRequest()
        mRequest.code = param["CODE"].stringValue
        
        if let fields = param["FIELDS"].array{
            var fieldVal = [String]()
            for field in fields{
                fieldVal.append(field.stringValue)
            }
            mRequest.plateIndexFields = fieldVal
        }

        
        let resp = self.makeSyncRequest(request: mRequest)
        let plateIndexQuoteResponse = resp as! MPlateIndexQuoteResponse
        XCTAssertNotNil(plateIndexQuoteResponse.plateIndexItems)
        var resultJSON : JSON = [:]
        for item in plateIndexQuoteResponse.plateIndexItems{
            var itemJSON:JSON = [
                "blockID" : item.blockId,
                "dateTime": item.datetime,
                "blockIndex": item.blockIndex,
                "blockChg": item.blockChg,
                "averageChg": item.averageChg,
                "turnoverRate": item.turnoverRate,
                "indexChg5": item.indexChg5,
                "indexChg10": item.indexChg10,
                "largeMoneyNetInflow": item.largeMoneyNetInflow,
                "bigMoneyNetInflow": item.bigMoneyNetInflow,
                "midMoneyNetInflow": item.midMoneyNetInflow,
                "smallMoneyNetInflow": item.smallMoneyNetInflow,
                "mainforceMoneyInflow": item.mainforceMoneyInflow,
                "mainforceMoneyOutflow": item.mainforceMoneyOutflow,
                "mainforceMoneyNetInflow5": item.mainforceMoneyNetInflow5,
                "mainforceMoneyNetInflow10": item.mainforceMoneyNetInflow10,
                "mainforceMoneyNetInflow": item.mainforceMoneyNetInflow,
                "largeVolumeB": item.largeVolumeB,
                "largeVolumeS": item.largeVolumeS,
                "largeMoneyB": item.largeMoneyB,
                "largeMoneyS": item.largeMoneyS,
                "bigVolumeB": item.bigVolumeB,
                "bigVolumeS": item.bigVolumeS,
                "bigMoneyB": item.bigMoneyB,
                "bigMoneyS": item.bigMoneyS,
                "midVolumeB": item.midVolumeB,
                "midVolumeS": item.midVolumeS,
                "midMoneyB": item.midMoneyB,
                "midMoneyS": item.midMoneyS,
                "smallVlomeB": item.smallVolumeB,
                "smallVolumeS": item.smallVolumeS,
                "smallMoneyB": item.smallMoneyB,
                "smallMoneyS": item.smallMoneyS,
                "totalTrdMoney": item.totalTrdMoney,
                "blockFAMC": item.blockFAMC,
                "totalMarketValue": item.totalMarketValue,
                "mainforceMoneyNetInflow20": item.mainforceMoneyNetInflow20,
                "ratioMainforceMoneyNetInflow5": item.ratioMainforceMoneyNetInflow5,
                "ratioMainforceMoneyNetInflow10": item.ratioMainforceMoneyNetInflow10,
                "ratioMainforceMoneyNetInflow20": item.ratioMainforceMoneyNetInflow20,
                "totalTrdVolume": item.totalTrdVolume,
                "openBlockIndex": item.openBlockIndex,
                "highBlockIndex": item.highBlockIndex,
                "lowBlockIndex": item.lowBlockIndex,
                "committee": item.committee,
                "deviation": item.deviation,
                "buyNum": item.buyNum,
                "sellNum": item.sellNum,
                "ttm": item.ttm,
                "lyr": item.lyr,
                "marketRate": item.marketRate,
                "blockName": item.blockName,
                "preCloseBlockIndex": item.preCloseBlockIndex,
                "upsDowns": item.upsDowns,
                "amplitude": item.amplitude,
                "up": item.ratioUpDown[0],
                "down": item.ratioUpDown[1],
                "same": item.ratioUpDown[2]
                
            ]
            switch item.changeState{
                
            case .flat:
                itemJSON["indexChg"].string = item.indexChg
            case .rise:
                itemJSON["indexChg"].string = "+"+(item.indexChg)
            case .drop:
                itemJSON["indexChg"].string = "-"+(item.indexChg)
            }
            resultJSON["\(item.datetime!)"] = itemJSON
            
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
}

}
