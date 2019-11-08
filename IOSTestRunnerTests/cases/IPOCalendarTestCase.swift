//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//新股（债）列表
import XCTest
import os.log
import SwiftyJSON

class IPOCalendarTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.IPOCalendarTestCase
    }
    
    func testIPOCalendar() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MIPOCalendarRequest()
         mRequest.date = param["DATE"].stringValue
        
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
        }
        
        if let typeVal = MIPOType.init(rawValue:param["TYPE"].uIntValue) {
            mRequest.type = typeVal
        }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let iPOCalendarResponse = resp as! MIPOCalendarResponse
        XCTAssertNotNil(iPOCalendarResponse.info)
        
        switch mRequest.type{
            
        case .stock:
            switch mRequest.sourceType{
                
            case .GA:
                var resultJSON : JSON = [:]
                for info in iPOCalendarResponse.info{
                    let key: String = info.key as! String
                    if key == "sglist"{
                        let sglists:NSArray = info.value as! NSArray
                        var itemJSON: JSON = [
                            "title": "今日申购"
                        ]
                        var jsonarr1 : JSON = [:]
                        for sglist in sglists{
                            if let list:NSDictionary = sglist as! NSDictionary{
                                var jsonarr2: JSON = [
                                    "issuePrice": list["ISSUEPRICE"]!,
                                    "succResultNoticeDate": list["SUCCRESULTNOTICEDATE"]!,
                                    "issueShare": list["ISSUESHARE"]!,
                                    "issueShareOn": list["ISSUESHAREON"]!,
                                    "secuabbr": list["SECUABBR"]!,
                                    "tradingCode": list["TRADINGCODE"]!,
                                    "capplyShare": list["CAPPLYSHARE"]!,
                                    "capplyPrice": list["CAPPLYPRICE"]!,
                                    "applyCode": list["APPLYCODE"]!,
                                    "peaIssue": list["PEAISSUE"]!
                                    
                                ]
                                jsonarr1["\(list["APPLYCODE"]!)"] = jsonarr2
                            }
                        }
                        itemJSON["dataList"] = jsonarr1
                        resultJSON["sglist"] = itemJSON
                    }
                    if key == "wsslist"{
                        let wsslists:NSArray = info.value as! NSArray
                        var itemJSON: JSON = [
                            "title": "未上市"
                        ]
                        var jsonarr1 : JSON = [:]
                        for wsslist in wsslists{
                            if let list:NSDictionary = wsslist as! NSDictionary{
                                var jsonarr2: JSON = [
//                                    "applyCode": list["APPLYCODE"]!,
//                                    "capplyShare": list["CAPPLYSHARE"]!,
//                                    "secuabbr": list["SECUABBR"]!,
//                                    "tradingCode": list["TRADINGCODE"]!,
//                                    "peaIssue": list["PEAISSUE"]!,
//                                    "issuePrice": list["ISSUEPRICE"]!,
//                                    "allotrateon": list["ALLOTRATEON"]!,
//                                    "listingDate": list["LISTINGDATE"]!,
//                                    "issueShare": list["ISSUESHARE"]!,
//                                    "issueShareOn": list["ISSUESHAREON"]!,
//                                    "capplyPrice": list["CAPPLYPRICE"]!,
                                    
                                    "issuePrice": list["ISSUEPRICE"]!,
                                    "issueShare": list["ISSUESHARE"]!,
                                    "issueShareOn": list["ISSUESHAREON"]!,
                                    "secuabbr": list["SECUABBR"]!,
                                    "tradingCode": list["TRADINGCODE"]!,
                                    "capplyShare": list["CAPPLYSHARE"]!,
                                    "capplyPrice": list["CAPPLYPRICE"]!,
                                    "applyCode": list["APPLYCODE"]!,
                                    "allotrateon": list["ALLOTRATEON"]!,
                                    "listingDate": list["LISTINGDATE"]!
                                    
                                ]
                                jsonarr1["\(list["APPLYCODE"]!)"] = jsonarr2
                            }
                        }
                        itemJSON["dataList"] = jsonarr1
                        resultJSON["wsslist"] = itemJSON
                    }
                    if key == "zqlist"{
                        let zqlists:NSArray = info.value as! NSArray
                        var itemJSON: JSON = [
                            "title": "今日中签"
                        ]
                        var jsonarr1 : JSON = [:]
                        for zqlist in zqlists{
                            if let list:NSDictionary = zqlist as! NSDictionary{
                                var jsonarr2: JSON = [
//                                    "applyCode": list["APPLYCODE"]!,
//                                    "capplyShare": list["CAPPLYSHARE"]!,
//                                    "secuabbr": list["SECUABBR"]!,
//                                    "tradingCode": list["TRADINGCODE"]!,
//                                    "peaIssue": list["PEAISSUE"]!,
//                                    "issuePrice": list["ISSUEPRICE"]!,
//                                    "allotrateon": list["ALLOTRATEON"]!,
//                                    "issueShare": list["ISSUESHARE"]!,
//                                    "issueShareOn": list["ISSUESHAREON"]!,
//                                    "capplyPrice": list["CAPPLYPRICE"]!,
                                    
                                    "issuePrice": list["ISSUEPRICE"]!,
                                    "issueShare": list["ISSUESHARE"]!,
                                    "issueShareOn": list["ISSUESHAREON"]!,
                                    "secuabbr": list["SECUABBR"]!,
                                    "tradingCode": list["TRADINGCODE"]!,
                                    "capplyShare": list["CAPPLYSHARE"]!,
                                    "capplyPrice": list["CAPPLYPRICE"]!,
                                    "applyCode": list["APPLYCODE"]!,
                                    "allotrateon": list["ALLOTRATEON"]!,
                                    "listingDate": list["LISTINGDATE"]!,
                                    "peaIssue": list["PEAISSUE"]!
                                ]
                                jsonarr1["\(list["APPLYCODE"]!)"] = jsonarr2
                            }
                        }
                        itemJSON["dataList"] = jsonarr1
                        resultJSON["zqlist"] = itemJSON
                    }
                    if key == "sslist"{
                        let sslists:NSArray = info.value as! NSArray
                        var itemJSON: JSON = [
                            "title": "今日上市"
                        ]
                        var jsonarr1 : JSON = [:]
                        for sslist in sslists{
                            if let list:NSDictionary = sslist as! NSDictionary{
                                var jsonarr2: JSON = [
//                                    "applyCode": list["APPLYCODE"]!,
//                                    "capplyShare": list["CAPPLYSHARE"]!,
//                                    "secuabbr": list["SECUABBR"]!,
//                                    "tradingCode": list["TRADINGCODE"]!,
//                                    "peaIssue": list["PEAISSUE"]!,
//                                    "issuePrice": list["ISSUEPRICE"]!,
//                                    "allotrateon": list["ALLOTRATEON"]!,
//                                    "issueShare": list["ISSUESHARE"]!,
//                                    "issueShareOn": list["ISSUESHAREON"]!,
//                                    "capplyPrice": list["CAPPLYPRICE"]!,
                                    
                                    "issuePrice": list["ISSUEPRICE"]!,
                                    "issueShare": list["ISSUESHARE"]!,
                                    "issueShareOn": list["ISSUESHAREON"]!,
                                    "secuabbr": list["SECUABBR"]!,
                                    "tradingCode": list["TRADINGCODE"]!,
                                    "capplyShare": list["CAPPLYSHARE"]!,
                                    "capplyPrice": list["CAPPLYPRICE"]!,
                                    "applyCode": list["APPLYCODE"]!,
                                    "allotrateon": list["ALLOTRATEON"]!,
                                    "peaIssue": list["PEAISSUE"]!
                                ]
                                jsonarr1["\(list["APPLYCODE"]!)"] = jsonarr2
                            }
                        }
                        itemJSON["dataList"] = jsonarr1
                        resultJSON["sslist"] = itemJSON
                    }
                    if key == "jjfxlist"{
                        let jjfxlists:NSArray = info.value as! NSArray
                        var itemJSON: JSON = [
                            "title": "即将发行"
                        ]
                        var jsonarr1 : JSON = [:]
                        for jjfxlist in jjfxlists{
                            if let list:NSDictionary = jjfxlist as! NSDictionary{
                                var jsonarr2: JSON = [
//                                    "applyCode": list["APPLYCODE"]!,
//                                    "capplyShare": list["CAPPLYSHARE"]!,
//                                    "secuabbr": list["SECUABBR"]!,
//                                    "tradingCode": list["TRADINGCODE"]!,
//                                    "issuePrice": list["ISSUEPRICE"]!,
//                                    "issueShare": list["ISSUESHARE"]!,
//                                    "issueShareOn": list["ISSUESHAREON"]!,
//                                    "capplyPrice": list["CAPPLYPRICE"]!,
//                                    "allotrateon": list["ALLOTRATEON"]!,
//                                    "listingDate": list["LISTINGDATE"]!,
                                    
                                    "issuePrice": list["ISSUEPRICE"]!,
                                    "issueShare": list["ISSUESHARE"]!,
                                    "issueShareOn": list["ISSUESHAREON"]!,
                                    "secuabbr": list["SECUABBR"]!,
                                    "tradingCode": list["TRADINGCODE"]!,
                                    "capplyShare": list["CAPPLYSHARE"]!,
                                    "capplyPrice": list["CAPPLYPRICE"]!,
                                    "applyCode": list["APPLYCODE"]!,
                                    "peaIssue": list["PEAISSUE"]!,
                                    "bookStartDateOn": list["BOOKSTARTDATEON"]!
                                ]
                                jsonarr1["\(list["APPLYCODE"]!)"] = jsonarr2
                            }
                        }
                        itemJSON["dataList"] = jsonarr1
                        resultJSON["jjfxlist"] = itemJSON
                    }
                }
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            case .CH:
                var resultJSON : JSON = [:]
                for info in iPOCalendarResponse.info{
                    let key: String = info.key as! String
                    if key == "sglist"{
                        let sglists:NSArray = info.value as! NSArray
                        var itemJSON: JSON = [
                            "title": "今日申购"
                        ]
                        var jsonarr1 : JSON = [:]
                        for sglist in sglists{
                            if let list:NSDictionary = sglist as! NSDictionary{
                                var jsonarr2: JSON = [
                                    "issuePrice": list["ISSUEPRICE"]!,
                                    "succResultNoticeDate": list["SUCCRESULTNOTICEDATE"]!,
                                    "issueShare": list["ISSUESHARE"]!,
                                    "issueShareOn": list["ISSUESHAREON"]!,
                                    "secuabbr": list["SECUABBR"]!,
                                    "tradingCode": list["TRADINGCODE"]!
                                ]
                                let update1: JSON = [
                                    "capplyShare": list["CAPPLYSHARE"]!,
                                    "capplyPrice": list["CAPPLYPRICE"]!,
                                    "applyCode": list["APPLYCODE"]!,
                                    "peaIssue": list["PEAISSUE"]!,
                                    "cissueSharePlan": list["CISSUESHAREPLAN"]!,
                                    "issueShareOnPlan": list["ISSUESHAREONPLAN"]!,
                                    "capplyPricePlan": list["CAPPLYPRICEPLAN"]!,
                                    "capplySharePlan": list["CAPPLYSHAREPLAN"]!,
                                    "issuePricePlan": list["ISSUEPRICEPLAN"]!,
                                    "keyCode": list["KEYCODE"]!
                                ]
                                do {
                                    try jsonarr2.merge(with: update1)
                                } catch {
                                    // ignore
                                }
                                jsonarr1["\(list["APPLYCODE"]!)"] = jsonarr2
                            }
                        }
                        itemJSON["dataList"] = jsonarr1
                        resultJSON["sglist"] = itemJSON
                    }
                    if key == "wsslist"{
                        let wsslists:NSArray = info.value as! NSArray
                        var itemJSON: JSON = [
                            "title": "未上市"
                        ]
                        var jsonarr1 : JSON = [:]
                        for wsslist in wsslists{
                            if let list:NSDictionary = wsslist as! NSDictionary{
                                var jsonarr2: JSON = [
                                    "issuePrice": list["ISSUEPRICE"]!,
                                    "issueShare": list["ISSUESHARE"]!,
                                    "issueShareOn": list["ISSUESHAREON"]!,
                                    "secuabbr": list["SECUABBR"]!,
                                    "tradingCode": list["TRADINGCODE"]!,
                                    "capplyShare": list["CAPPLYSHARE"]!,
                                    "capplyPrice": list["CAPPLYPRICE"]!
                                ]
                                let update1: JSON = [
                                    "applyCode": list["APPLYCODE"]!,
                                    "allotrateon": list["ALLOTRATEON"]!,
                                    "listingDate": list["LISTINGDATE"]!,
                                    "cissueSharePlan": list["CISSUESHAREPLAN"]!,
                                    "issueShareOnPlan": list["ISSUESHAREONPLAN"]!,
                                    "capplyPricePlan": list["CAPPLYPRICEPLAN"]!,
                                    "capplySharePlan": list["CAPPLYSHAREPLAN"]!,
                                    "issuePricePlan": list["ISSUEPRICEPLAN"]!,
                                    "keyCode": list["KEYCODE"]!
                                ]
                                do {
                                    try jsonarr2.merge(with: update1)
                                } catch {
                                    // ignore
                                }
                                jsonarr1["\(list["APPLYCODE"]!)"] = jsonarr2
                            }
                        }
                        itemJSON["dataList"] = jsonarr1
                        resultJSON["wsslist"] = itemJSON
                    }
                    if key == "zqlist"{
                        let zqlists:NSArray = info.value as! NSArray
                        var itemJSON: JSON = [
                            "title": "今日中签"
                        ]
                        var jsonarr1 : JSON = [:]
                        for zqlist in zqlists{
                            if let list:NSDictionary = zqlist as! NSDictionary{
                                var jsonarr2: JSON = [
                                    "issuePrice": list["ISSUEPRICE"]!,
                                    "issueShare": list["ISSUESHARE"]!,
                                    "issueShareOn": list["ISSUESHAREON"]!,
                                    "secuabbr": list["SECUABBR"]!,
                                    "tradingCode": list["TRADINGCODE"]!,
                                    "capplyShare": list["CAPPLYSHARE"]!,
                                    "capplyPrice": list["CAPPLYPRICE"]!
                                ]
                                let update1: JSON = [
                                    "applyCode": list["APPLYCODE"]!,
                                    "allotrateon": list["ALLOTRATEON"]!,
                                    "listingDate": list["LISTINGDATE"]!,
                                    "peaIssue": list["PEAISSUE"]!,
                                    "cissueSharePlan": list["CISSUESHAREPLAN"]!,
                                    "issueShareOnPlan": list["ISSUESHAREONPLAN"]!,
                                    "capplyPricePlan": list["CAPPLYPRICEPLAN"]!,
                                    "capplySharePlan": list["CAPPLYSHAREPLAN"]!,
                                    "issuePricePlan": list["ISSUEPRICEPLAN"]!,
                                    "keyCode": list["KEYCODE"]!
                                ]
                                do {
                                    try jsonarr2.merge(with: update1)
                                } catch {
                                    // ignore
                                }
                                jsonarr1["\(list["APPLYCODE"]!)"] = jsonarr2
                            }
                        }
                        itemJSON["dataList"] = jsonarr1
                        resultJSON["zqlist"] = itemJSON
                    }
                    if key == "sslist"{
                        let sslists:NSArray = info.value as! NSArray
                        var itemJSON: JSON = [
                            "title": "今日上市"
                        ]
                        var jsonarr1 : JSON = [:]
                        for sslist in sslists{
                            if let list:NSDictionary = sslist as! NSDictionary{
                                var jsonarr2: JSON = [
                                    "issuePrice": list["ISSUEPRICE"]!,
                                    "issueShare": list["ISSUESHARE"]!,
                                    "issueShareOn": list["ISSUESHAREON"]!,
                                    "secuabbr": list["SECUABBR"]!,
                                    "tradingCode": list["TRADINGCODE"]!,
                                    "capplyShare": list["CAPPLYSHARE"]!,
                                    "capplyPrice": list["CAPPLYPRICE"]!
                                ]
                                let update1: JSON = [
                                    "applyCode": list["APPLYCODE"]!,
                                    "allotrateon": list["ALLOTRATEON"]!,
                                    "peaIssue": list["PEAISSUE"]!,
                                    "cissueSharePlan": list["CISSUESHAREPLAN"]!,
                                    "issueShareOnPlan": list["ISSUESHAREONPLAN"]!,
                                    "capplyPricePlan": list["CAPPLYPRICEPLAN"]!,
                                    "capplySharePlan": list["CAPPLYSHAREPLAN"]!,
                                    "issuePricePlan": list["ISSUEPRICEPLAN"]!,
                                    "keyCode": list["KEYCODE"]!
                                ]
                                do {
                                    try jsonarr2.merge(with: update1)
                                } catch {
                                    // ignore
                                }
                                jsonarr1["\(list["APPLYCODE"]!)"] = jsonarr2
                            }
                        }
                        itemJSON["dataList"] = jsonarr1
                        resultJSON["sslist"] = itemJSON
                    }
                    if key == "jjfxlist"{
                        let jjfxlists:NSArray = info.value as! NSArray
                        var itemJSON: JSON = [
                            "title": "即将发行"
                        ]
                        var jsonarr1 : JSON = [:]
                        for jjfxlist in jjfxlists{
                            if let list:NSDictionary = jjfxlist as! NSDictionary{
                                var jsonarr2: JSON = [
                                    "issuePrice": list["ISSUEPRICE"]!,
                                    "issueShare": list["ISSUESHARE"]!,
                                    "issueShareOn": list["ISSUESHAREON"]!,
                                    "secuabbr": list["SECUABBR"]!,
                                    "tradingCode": list["TRADINGCODE"]!,
                                    "capplyShare": list["CAPPLYSHARE"]!,
                                    "capplyPrice": list["CAPPLYPRICE"]!
                                ]
                                let update1: JSON = [
                                    "applyCode": list["APPLYCODE"]!,
                                    "peaIssue": list["PEAISSUE"]!,
                                    "bookStartDateOn": list["BOOKSTARTDATEON"]!,
                                    "cissueSharePlan": list["CISSUESHAREPLAN"]!,
                                    "issueShareOnPlan": list["ISSUESHAREONPLAN"]!,
                                    "capplyPricePlan": list["CAPPLYPRICEPLAN"]!,
                                    "capplySharePlan": list["CAPPLYSHAREPLAN"]!,
                                    "issuePricePlan": list["ISSUEPRICEPLAN"]!,
                                    "keyCode": list["KEYCODE"]!
                                ]
                                do {
                                    try jsonarr2.merge(with: update1)
                                } catch {
                                    // ignore
                                }
                                jsonarr1["\(list["APPLYCODE"]!)"] = jsonarr2
                            }
                        }
                        itemJSON["dataList"] = jsonarr1
                        resultJSON["jjfxlist"] = itemJSON
                    }
                }
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
            
        case .bond:
            var resultJSON : JSON = [:]
            for info in iPOCalendarResponse.info{
                let key: String = info.key as! String
                if key == "sglist"{
                    if let sglists:NSArray = info.value as! NSArray{
                        var itemJSON : JSON = [
                            "title":"今日申购"
                        ]
                        var jsonarr1 : JSON = [:]
                        for sglist in sglists{
                            if let list: NSDictionary = sglist as! NSDictionary{
                                var jsonarr2: JSON = [
                                    "CONVERTPRICE": list["CONVERTPRICE"]!,
                                    "STOCKTRADINGCODE": list["STOCKTRADINGCODE"]!,
                                    "TRADINGCODE": list["TRADINGCODE"]!,
                                    "SECUABBR": list["SECUABBR"]!,
                                    "STOCKSECUABBR": list["STOCKSECUABBR"]!,
                                    "PREFERREDPLACINGCODE": list["PREFERREDPLACINGCODE"]!,
                                    "APPLYCODE": list["APPLYCODE"]!
                                ]
                                jsonarr1["\(list["APPLYCODE"]!)"] = jsonarr2
                            }
                        }
                        itemJSON["dataList"] = jsonarr1
                        resultJSON["sglist"] = itemJSON
                    }
                }
                if key == "jjsglist"{
                    if let jjsglists:NSArray = info.value as! NSArray{
                        var itemJSON : JSON = [
                            "title":"即将申购"
                        ]
                        var jsonarr1 : JSON = [:]
                        for jjsglist in jjsglists{
                            if let list: NSDictionary = jjsglist as! NSDictionary{
                                var jsonarr2: JSON = [
                                    "CONVERTPRICE": list["CONVERTPRICE"]!,
                                    "STOCKTRADINGCODE": list["STOCKTRADINGCODE"]!,
                                    "TRADINGCODE": list["TRADINGCODE"]!,
                                    "SECUABBR": list["SECUABBR"]!,
                                    "STOCKSECUABBR": list["STOCKSECUABBR"]!,
                                    "PREFERREDPLACINGCODE": list["PREFERREDPLACINGCODE"]!,
                                    "APPLYCODE": list["APPLYCODE"]!
                                ]
                                jsonarr1["\(list["APPLYCODE"]!)"] = jsonarr2
                            }
                        }
                        itemJSON["dataList"] = jsonarr1
                        resultJSON["jjsglist"] = itemJSON
                    }
                }
                if key == "dsslist"{
                    if let dsslists:NSArray = info.value as! NSArray{
                        var itemJSON: JSON = [
                            "title": "当日待上市列表"
                        ]
                        var jsonarr1 : JSON = [:]
                        for dsslist in dsslists{
                            if let list: NSDictionary = dsslist as! NSDictionary{
                                var jsonarr2: JSON = [
                                    "LISTINGDATE": list["LISTINGDATE"]!,
                                    "TRADINGCODE": list["TRADINGCODE"]!,
                                    "SECUABBR": list["SECUABBR"]!,
                                    "ALLOTRATEON": list["ALLOTRATEON"]!,
                                ]
                                jsonarr1["\(list["TRADINGCODE"]!)"] = jsonarr2
                            }
                        }
                        itemJSON["dataList"] = jsonarr1
                        resultJSON["dsslist"] = itemJSON
                    }
                }
            }
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
//            if let info:NSDictionary = iPOCalendarResponse.info as! NSDictionary{
//                var resultJSON: JSON = []
//                if let sglists:NSArray = info["sglist"] as! NSArray{
//                    var jsonarr1 = [JSON]()
//                    for sglist in sglists{
//                        if let list: NSDictionary = sglist as! NSDictionary{
//                            var jsonarr2: JSON = [
//                                "APPLYCODE": list["APPLYCODE"]!,
//                                "PREFERREDPLACINGCODE": list["PREFERREDPLACINGCODE"]!,
//                                "CONVERTPRICE": list["CONVERTPRICE"]!,
//                                "STOCKTRADINGCODE": list["STOCKTRADINGCODE"]!,
//                                "STOCKSECUABBR": list["SECUABBR"]!,
//                                "TRADINGCODE": list["TRADINGCODE"]!,
//                                "SECUABBR": list["SECUABBR"]!
//                            ]
//                            jsonarr1.append(jsonarr2)
//                        }
//                    }
//                    resultJSON["sglist"].arrayObject = jsonarr1
//                }
//                if let jjsglists:NSArray = info["jjsglist"] as! NSArray{
//                    var jsonarr1 = [JSON]()
//                    for jjsglist in jjsglists{
//                        if let list: NSDictionary = jjsglist as! NSDictionary{
//                            var jsonarr2: JSON = [
//                                "APPLYCODE": list["APPLYCODE"]!,
//                                "PREFERREDPLACINGCODE": list["PREFERREDPLACINGCODE"]!,
//                                "CONVERTPRICE": list["CONVERTPRICE"]!,
//                                "STOCKTRADINGCODE": list["STOCKTRADINGCODE"]!,
//                                "STOCKSECUABBR": list["SECUABBR"]!,
//                                "TRADINGCODE": list["TRADINGCODE"]!,
//                                "SECUABBR": list["SECUABBR"]!
//                            ]
//                            jsonarr1.append(jsonarr2)
//                        }
//                    }
//                    resultJSON["jjsglist"].arrayObject = jsonarr1
//                }
//                if let dsslists:NSArray = info["dsslist"] as! NSArray{
//                    var jsonarr1 = [JSON]()
//                    for dsslist in dsslists{
//                        if let list: NSDictionary = dsslist as! NSDictionary{
//                            var jsonarr2: JSON = [
//                                "LISTINGDATE": list["LISTINGDATE"]!,
//                                "ALLOTRATEON": list["ALLOTRATEON"]!,
//                                "TRADINGCODE": list["TRADINGCODE"]!,
//                                "SECUABBR": list["SECUABBR"]!
//                            ]
//                            jsonarr1.append(jsonarr2)
//                        }
//                    }
//                    resultJSON["dsslist"].arrayObject = jsonarr1
//                }
//                print(resultJSON)
//                onTestResult(param: param, result: resultJSON)
//            }
        }
        
    }
}

