//
//  OverLayChartTestCase.swift
//  IOSTestRunnerTests
//
//  Created by 俞建斌 on 2019/9/19.
//  Copyright © 2019 liao xiangsen. All rights reserved.
//

import XCTest
import os.log
import SwiftyJSON

class OverLayChartTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.OverLayChartTestCase
    }
    
    func testChart() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MChartRequest()
        mRequest.code = param["CODE"].stringValue
        mRequest.subtype = param["SUBTYPE"].stringValue
        if let typeVal = MChartType.init(rawValue: param["TYPE"].uIntValue) {
            mRequest.chartType = typeVal
        }
        mRequest.returnAFData = param["RETURNAFDATA"].boolValue
        if let superpositionCodeVal = param["superpositionCode"].string{
            mRequest.superpositionCode = superpositionCodeVal
        }
        if let superpositionSubtypeVal = param["superpositionSubtype"].string{
            mRequest.superpositionSubtype = superpositionSubtypeVal
        }
        let resp = self.makeSyncRequest(request: mRequest)
        let chartResponse = resp as! MChartResponse
        XCTAssertNotNil(chartResponse.ohlcItems)
        
        var jsonarr1 : JSON = [:]
        for item in chartResponse.ohlcItems{
            var jsonarr2:JSON = [
                "datetime" : item.datetime,
                "closePrice": item.closePrice,
                "tradeVolume": item.tradeVolume,
                "averagePrice": item.averagePrice,
                "md": item.rgbar,
                "openInterest": item.openInterest,
                "iopv": item.iopv,
                "iopvPre": item.referenceIOPVPrice,
//                "dayList": chartResponse.tradeDates
            ]
            jsonarr1["\(item.datetime!)"] = jsonarr2
        }
        var jsonarr3 : JSON = [:]
        if let SPitems = chartResponse.superposition.ohlcItems{
            
            for SPitem in SPitems{
                var jsonarr4: JSON = [
                    "datetime" : SPitem.datetime,
                    "closePrice": SPitem.closePrice,
                    "tradeVolume": SPitem.tradeVolume,
                    "averagePrice": SPitem.averagePrice,
                    "md": SPitem.rgbar,
                    "openInterest": SPitem.openInterest,
                    "iopv": SPitem.iopv,
                    "iopvPre": SPitem.referenceIOPVPrice
                ]
                jsonarr3["\(SPitem.datetime!)"] = jsonarr4
            }
        }
        var jsonarr5 = [String]()
        for dayLists in chartResponse.tradeDates{
            if let dayList:String = dayLists as! String{
                
                jsonarr5.append(dayList)
            }
        }
        var resultJSON: JSON = [
            "OHLCItem": jsonarr1,
            "overLayChart": jsonarr3,
            "dayList": jsonarr5
        ]
            
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        
        
    }
    
}
