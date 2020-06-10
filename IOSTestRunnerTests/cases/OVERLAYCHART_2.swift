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

class OVERLAYCHART_2: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.OVERLAYCHART_2
    }
    
    func testChart() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MChartRequest()
        mRequest.code = param["CODE"].stringValue
        mRequest.subtype = param["SUBTYPE"].stringValue
        if param["TYPE"].stringValue == "ChartTypeOneDay"{
            mRequest.chartType = MChartType(rawValue: 0)!
        }else if param["TYPE"].stringValue == "ChartTypeFiveDay"{
            mRequest.chartType = MChartType(rawValue: 1)!
        }
        mRequest.returnAFData = ("0" as NSString).boolValue
        if let superpositionCodeVal = param["superpositionCode"].string{
            mRequest.superpositionCode = superpositionCodeVal
        }
        if let superpositionSubtypeVal = param["superpositionSubtype"].string{
            mRequest.superpositionSubtype = superpositionSubtypeVal
        }
        let resp = try self.makeSyncRequest(request: mRequest)
        let chartResponse = resp as! MChartResponse
//        XCTAssertNotNil(chartResponse.ohlcItems)
        if (chartResponse.ohlcItems == nil){
            throw BaseTestError.assertFailedError(message: "chartResponse ohlcItems is nil")
        }
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
//                "volRatio": item.volumeRatio,
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
//                    "volRatio": SPitem.volumeRatio,
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
