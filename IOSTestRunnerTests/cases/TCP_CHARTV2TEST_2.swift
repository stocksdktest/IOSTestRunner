//
//  SubscribeTestCase.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 1/8/20.
//  Copyright © 2020 liao xiangsen. All rights reserved.
//
import XCTest
import os.log
import SwiftyJSON

class TCP_CHARTV2TEST_2: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.TCP_CHARTV2TEST_2
    }
    
    internal var subscribeRecords: JSON = [:]
    internal var notificationExpectation: XCTestExpectation = XCTestExpectation.init()
    
    func testExample1() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MChartRequest()
        let code = param["CODE"].stringValue
        let timeout = Int(param["SECONDS"].stringValue)!
        if param["TYPE"] == "ChartTypeOneDay"{
            mRequest.chartType = MChartType(rawValue: 0)!
        }else if param["TYPE"] == "ChartTypeFiveDay"{
            mRequest.chartType = MChartType(rawValue: 1)!
        }
        mRequest.returnAFData = param["RETURNAFDATA"].boolValue
        if param["RETURNAFDATA"].boolValue == true{
            mRequest.subtype = "1006"
        }else{
            mRequest.subtype = param["SUBTYPE"].stringValue
        }
        mRequest.code = code
        
        let resp = self.makeSyncRequest(request: mRequest)
        XCTAssertEqual(resp.status, MResponseStatus.success)
        let chartResponse = resp as! MChartResponse
        XCTAssertNotNil(chartResponse.ohlcItems)
        print("订阅结果：\(chartResponse.ohlcItems.description)")
        
        if param["TYPE"] == "ChartTypeOneDay"{
            MApi.subscribeCode(code, type: MApiTcpSubscribeType.line)
        }else if param["TYPE"] == "ChartTypeFiveDay"{
            MApi.subscribeCode(code, type: MApiTcpSubscribeType.line5)
        }
        notificationExpectation = expectation(forNotification: NSNotification.Name.MApiTcpDidReceivedData, object: nil ) {
            [weak self] (notification) in
            guard let strongSelf = self else {
                return false
            }
            print("onReceiveNotification of '\(code)'")
            strongSelf.notificationExpectation.fulfill()
            strongSelf.onReceviveNotification(subscribeCode: code, notificaiont: notification)
            return true
        }
        notificationExpectation.expectedFulfillmentCount = Int.max
        notificationExpectation.isInverted = true
        waitForExpectations(timeout: TimeInterval(timeout)) {
            (error) in
            if param["TYPE"] == "ChartTypeOneDay"{
                MApi.unSubscribeCode(code, type: MApiTcpSubscribeType.line)
            }else if param["TYPE"] == "ChartTypeFiveDay"{
                MApi.unSubscribeCode(code, type: MApiTcpSubscribeType.line5)
            }
            print("Stop subscription: \(code), error: \(error.debugDescription)")
            let result: JSON = [
                "items": self.subscribeRecords
            ]
            self.onTestResult(param: param, result: result)
        }
    }
    
    func onReceviveNotification(subscribeCode: String ,notificaiont: Notification) {
        let userInfo = notificaiont.userInfo!
        let typeVal = userInfo[MApiTcpDidReceivedDataTypeKey] as? Int
        if (typeVal == nil) {
            print("Invalid type: \(userInfo[MApiTcpDidReceivedDataTypeKey].debugDescription)")
        }
        let type = MApiTcpSubscribeType.init(rawValue: typeVal!)
        let code = userInfo[MApiTcpDidReceivedDataCodeKey] as! String
        if (code != subscribeCode) {
            print("Subscribe code mismatch: \(subscribeCode), but got \(code).")
            return
        }
//        switch type {
//        case .line, .line5:
//            let param = self.testCaseRoundConfig.getParam()
            let chartItems = userInfo[MApiTcpDidReceivedDataLineItemsKey] as! NSArray
            let tradeDates = userInfo[MApiTcpDidReceivedDataLineTradeDatesKey] as! NSArray
            let time = userInfo[MApiTcpDidReceivedDataLineTimeKey] as! String
//            var resultJSON : JSON = [:]
            for chartItem in chartItems{
                let item: MOHLCItem = chartItem as! MOHLCItem
                     var itemJSON:JSON = [
                                   "datetime" : item.datetime,
                                   "closePrice": item.closePrice,
                                   "tradeVolume": item.tradeVolume,
                                   "averagePrice": item.averagePrice,
                                   "md": item.rgbar,
                                   "openInterest": item.openInterest,
                                   "iopv": item.iopv,
                                   "iopvPre": item.referenceIOPVPrice,
                                   
                               ]
//                               resultJSON["\(item.datetime!)"] = itemJSON
                               self.subscribeRecords["\(item.datetime!)"] = itemJSON
                           }
//                           if param["RETURNAFDATA"].boolValue == true {
//                               for item in chartResponse.afItems{
//                                   var itemJSON:JSON = [
//                                       "datetime": item.datetime,
//                                       "closePrice": item.closePrice,
//                                       "tradeVolume": item.tradeVolume,
//                                       "reference_price": item.referencePrice
//                                   ]
//                                   resultJSON["\(item.datetime!)"] = itemJSON
//                               }
                            
//                }
                
//            break
//        case .snap:
//            let item = userInfo[MApiTcpDidReceivedDataSnapKey] as! MStockItem
//            let itemJSON = [
//                "average_price": item.averagePrice
//            ]
////            self.subscribeRecords.append([
////                "item": itemJSON
////            ])
//            print("订阅结果：\(item)")
//            break
//        case .tick:
//            let item = userInfo[MApiTcpDidReceivedDataTimeTickKey] as! Array<AnyObject>
////            self.subscribeRecords.append([
////                "item": item.debugDescription
////            ])
//            break
//        default:
//            break
//        }
    }
}
