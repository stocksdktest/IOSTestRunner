//
//  SubscribeTestCase.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 1/8/20.
//  Copyright © 2020 liao xiangsen. All rights reserved.
//

import SwiftyJSON

class SubscribeTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.SUBSCRIBE_EXAMPLE
    }
    
    internal var subscribeRecords: [JSON] = []
    internal var notificationExpectation: XCTestExpectation = XCTestExpectation.init()
    
    func testExample1() {
        let param = self.testCaseRoundConfig.getParam()
        let code = param["CODES"].stringValue
        let timeout = Int(param["SECONDS"].stringValue)!
        
        let mRequest = MSnapQuoteRequest()
        mRequest.code = code
        mRequest.stockFields = nil
        
        mRequest.tickCount = 10
        let resp = self.makeSyncRequest(request: mRequest)
        XCTAssertEqual(resp.status, MResponseStatus.success)
        let quoteResponse = resp as! MSnapQuoteResponse
        XCTAssertNotNil(quoteResponse.stockItem)
        print("订阅结果：\(quoteResponse.stockItem.description)")
        
        MApi.subscribeCode(code, type: MApiTcpSubscribeType.snap)
        
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
            MApi.unSubscribeCode(code, type: MApiTcpSubscribeType.snap)
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
//            let item = userInfo[MApiTcpDidReceivedDataLineItemsKey] as! MOHLCItem
//            let tradeDates = userInfo[MApiTcpDidReceivedDataLineTradeDatesKey] as! String
//            let time = userInfo[MApiTcpDidReceivedDataLineTimeKey] as! String
//            let itemJSON = [
//                "average_price": item.averagePrice!
//            ]
//            self.subscribeRecords.append([
//                "item": itemJSON,
//                "tradeDates": tradeDates,
//                "time": time
//            ])
//            break
//        case .snap:
//            let item = userInfo[MApiTcpDidReceivedDataSnapKey] as! MStockItem
//            let itemJSON = [
//                "average_price": item.averagePrice
//            ]
//            self.subscribeRecords.append([
//                "item": itemJSON
//            ])
//            print("订阅结果：\(item)")
//            break
//        case .tick:
//            let item = userInfo[MApiTcpDidReceivedDataTimeTickKey] as! Array<AnyObject>
//            self.subscribeRecords.append([
//                "item": item.debugDescription
//            ])
//            break
//        default:
//            break
//        }
    }
}
