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

class F10_BNDNEWSHARESCAL_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_BNDNEWSHARESCAL_1
    }
    
    func testIPOCalendar() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MIPOCalendarRequest()
         mRequest.date = param["DATE"].stringValue
        
        let typeVal = param["SOURCETYPE"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        mRequest.type = MIPOType(rawValue: 1)!
        
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
                                var itemID: String = (list["APPLYCODE"]as! String).replacingOccurrences(of: ".", with: "_")
                                
                                jsonarr1["\(itemID)"] = jsonarr2
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
                                    "capplyPrice": list["CAPPLYPRICE"]!,
                                    "applyCode": list["APPLYCODE"]!,
                                    "allotrateon": list["ALLOTRATEON"]!,
                                    "listingDate": list["LISTINGDATE"]!
                                    
                                ]
                                var itemID: String = (list["APPLYCODE"]as! String).replacingOccurrences(of: ".", with: "_")
                                
                                jsonarr1["\(itemID)"] = jsonarr2
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
                                    "capplyPrice": list["CAPPLYPRICE"]!,
                                    "applyCode": list["APPLYCODE"]!,
                                    "allotrateon": list["ALLOTRATEON"]!,
                                    "listingDate": list["LISTINGDATE"]!,
                                    "peaIssue": list["PEAISSUE"]!
                                ]
                                var itemID: String = (list["APPLYCODE"]as! String).replacingOccurrences(of: ".", with: "_")
                                
                                jsonarr1["\(itemID)"] = jsonarr2
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
                                    "capplyPrice": list["CAPPLYPRICE"]!,
                                    "applyCode": list["APPLYCODE"]!,
                                    "allotrateon": list["ALLOTRATEON"]!,
                                    "peaIssue": list["PEAISSUE"]!
                                ]
                                var itemID: String = (list["APPLYCODE"]as! String).replacingOccurrences(of: ".", with: "_")
                                
                                jsonarr1["\(itemID)"] = jsonarr2
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
                                    "capplyPrice": list["CAPPLYPRICE"]!,
                                    "applyCode": list["APPLYCODE"]!,
                                    "peaIssue": list["PEAISSUE"]!,
                                    "bookStartDateOn": list["BOOKSTARTDATEON"]!
                                ]
                                var itemID: String = (list["APPLYCODE"]as! String).replacingOccurrences(of: ".", with: "_")
                                
                                jsonarr1["\(itemID)"] = jsonarr2
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
                                var itemID: String = (list["APPLYCODE"]as! String).replacingOccurrences(of: ".", with: "_")
                                
                                jsonarr1["\(itemID)"] = jsonarr2
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
                                var itemID: String = (list["APPLYCODE"]as! String).replacingOccurrences(of: ".", with: "_")
                                
                                jsonarr1["\(itemID)"] = jsonarr2
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
                                var itemID: String = (list["APPLYCODE"]as! String).replacingOccurrences(of: ".", with: "_")
                                
                                jsonarr1["\(itemID)"] = jsonarr2
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
                                var itemID: String = (list["APPLYCODE"]as! String).replacingOccurrences(of: ".", with: "_")
                                
                                jsonarr1["\(itemID)"] = jsonarr2
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
                                var itemID: String = (list["APPLYCODE"]as! String).replacingOccurrences(of: ".", with: "_")
                                
                                jsonarr1["\(itemID)"] = jsonarr2
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
                                var itemID: String = (list["APPLYCODE"]as! String).replacingOccurrences(of: ".", with: "_")
                                
                                jsonarr1["\(itemID)"] = jsonarr2
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
                                var itemID: String = (list["APPLYCODE"]as! String).replacingOccurrences(of: ".", with: "_")
                                
                                jsonarr1["\(itemID)"] = jsonarr2
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
                                var itemID: String = (list["TRADINGCODE"]as! String).replacingOccurrences(of: ".", with: "_")
                                
                                jsonarr1["\(itemID)"] = jsonarr2
                            }
                        }
                        itemJSON["dataList"] = jsonarr1
                        resultJSON["dsslist"] = itemJSON
                    }
                }
            }
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
        
    }
}

