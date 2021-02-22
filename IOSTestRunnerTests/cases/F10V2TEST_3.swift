//
//  BlockTradeTestCase.swift
//  IOSTestRunnerTests
//
//  Created by 俞建斌 on 2019/9/25.
//  Copyright © 2019 liao xiangsen. All rights reserved.
//

import XCTest
import os.log
import SwiftyJSON

class F10V2TEST_3: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10V2TEST_3
    }
    func testF10V2TEST_3() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MF10Request()
        mRequest.code = param["CODE"].stringValue
        var TYPE = param["REQUESTTYPE"].stringValue.replacingOccurrences(of: "/", with: "")
        mRequest.requestType = TYPE
        let typeVal = param["SRC"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        mRequest.param  = ["type":param["quarterType"].stringValue]
        
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let f10Response = resp as! MF10Response
//        XCTAssertNotNil(f10Response.jsonObject)
        if (f10Response.jsonObject == nil){
            throw BaseTestError.assertFailedError(message: "f10Response jsonObject is nil")
        }
        var resultJSON : JSON = [:]
                if mRequest.requestType == "importantindex"{
                    if param["quarterType"] != ""{
                        let paramI:NSArray = (param["quarterType"].string?.split(separator: "_") as! NSArray)
                        if let dic1: NSDictionary = f10Response.jsonObject as! NSDictionary{
                          var resultJSON: JSON = [
                            "\(paramI[0])":dic1["\(paramI[0])"]!,
                              "MOM": dic1["MOM"]!,
                              "ENDDATE":dic1["ENDDATE"]!
                              ]
                        }
                    }else{
                    if let dic1: NSDictionary = f10Response.jsonObject as! NSDictionary{
                        var resultJSON: JSON = [
                            "REPORTTITLE":dic1["REPORTTITLE"]!,
                            "EPSBASIC":dic1["EPSBASIC"]!,
                            "NAPS":dic1["NAPS"]!,
                            "NPCUT":dic1["NPCUT"]!,
                            "TOTALSHARE":dic1["TOTALSHARE"]!,
                            "CIRCSKAMT":dic1["CIRCSKAMT"]!,
                            "BIZINCO":dic1["BIZINCO"]!,
                            
                            ]
                        let update1: JSON = [
                            "OPERINYOYB":dic1["OPERINYOYB"]!,
                            "NETPROFITYOYB":dic1["NETPROFITYOYB"]!,
                            "DISTRIBUTION":dic1["DISTRIBUTION"]!,
                            "EXRIGHT":dic1["EXRIGHT"]!,
                            "MOM": dic1["MOM"]!,
                            "ENDDATE":dic1["ENDDATE"]!
                        ]
                        do {
                            try resultJSON.merge(with: update1)
                        } catch {
                            // ignore
                        }
                        }
                      }
                   }
                if mRequest.requestType == "businessinfo"{
                    if let Lists: NSArray = f10Response.jsonObject as! NSArray{
                            if param["quarterType"] != ""{
                                let paramI:NSArray = (param["quarterType"].string?.split(separator: "_") as! NSArray)
                                for List in Lists{
                                    if let dic2 : NSDictionary = List as! NSDictionary{
                                        var jsonarr2: JSON = [
                                            "\(paramI[0])":dic2["\(paramI[0])"]!,
                                            "MOM": dic2["MOM"]!,
                                            "ENDDATE":dic2["ENDDATE"]!
                                        ]
                                        resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                    }
                                }
                            }else{
                                for List in Lists{
                                    if let dic2 : NSDictionary = List as! NSDictionary{
                                        var jsonarr2: JSON = [
                                            "CLASSNAME":dic2["CLASSNAME"]!,
                                            "TCOREBIZINCOME":dic2["TCOREBIZINCOME"]!,
                                            "TYPESTYLE":dic2["TYPESTYLE"]!,
                                            "PUBLISHDATE":dic2["PUBLISHDATE"]!,
                                            "MOM": dic2["MOM"]!,
                                            "ENDDATE":dic2["ENDDATE"]!
                                        ]
                                        resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                    }
                                }
                        }
                            
                    }
                }
                if mRequest.requestType == "charts5buys"{
                    if let Lists: NSArray = f10Response.jsonObject as! NSArray{
                        if param["quarterType"] != ""{
                            let paramI:NSArray = (param["quarterType"].string?.split(separator: "_") as! NSArray)
                            for List in Lists{
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "\(paramI[0])":dic2["\(paramI[0])"]!,
                                        "MOM": dic2["MOM"]!,
                                        "ENDDATE":dic2["ENDDATE"]!
                                    ]
                                    resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                }
                            }
                        }else{
                            for List in Lists{
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "BIZSUNITNAME":dic2["BIZSUNITNAME"]!,
                                        "BUYAMT":dic2["BUYAMT"]!,
                                        "SALEAMT":dic2["SALEAMT"]!,
                                        "TRADEDATE":dic2["TRADEDATE"]!,
                                        "CHGDESC":dic2["CHGDESC"]!,
                                        "MOM": dic2["MOM"]!,
                                        "ENDDATE":dic2["ENDDATE"]!
                                    ]
                                    resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                }
                            }
                        }
                            
                    }
                }
                if mRequest.requestType == "charts5sells"{
                    if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                        if param["quarterType"] != ""{
                            let paramI:NSArray = (param["quarterType"].string?.split(separator: "_") as! NSArray)
                            for List in Lists{
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "\(paramI[0])":dic2["\(paramI[0])"]!,
                                        "MOM": dic2["MOM"]!,
                                        "ENDDATE":dic2["ENDDATE"]!
                                    ]
                                    resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                }
                            }
                        }else{
                            for List in Lists{
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "BIZSUNITNAME":dic2["BIZSUNITNAME"]!,
                                        "BUYAMT":dic2["BUYAMT"]!,
                                        "SALEAMT":dic2["SALEAMT"]!,
                                        "TRADEDATE":dic2["TRADEDATE"]!,
                                        "CHGDESC":dic2["CHGDESC"]!,
                                        "MOM": dic2["MOM"]!,
                                        "ENDDATE":dic2["ENDDATE"]!
                                    ]
                                    resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                }
                            }
                        }
                            
                    }
                }
                if mRequest.requestType == "exptskinvrating"{
                    if let dic1: NSDictionary = f10Response.jsonObject as! NSDictionary{
                        resultJSON["STDRATING"] = dic1["STDRATING"]! as! JSON
                        var itemJSON : JSON = [:]
                        if let Lists: NSArray = dic1["list"] as!NSArray{
                            if param["quarterType"] != ""{
                                let paramI:NSArray = (param["quarterType"].string?.split(separator: "_") as! NSArray)
                                for List in Lists{
                                    if let dic2 : NSDictionary = List as! NSDictionary{
                                        var jsonarr2: JSON = [
                                            "\(paramI[0])":dic2["\(paramI[0])"]!,
                                            "MOM": dic2["MOM"]!,
                                            "ENDDATE":dic2["ENDDATE"]!
                                        ]
                                        itemJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                    }
                                }
                            }else{
                                
                                for List in Lists{
                                    if let dic2 : NSDictionary = List as! NSDictionary{
                                        var jsonarr2: JSON = [
                                            "RATING": dic2["RATING"]!,
                                            "COMPNAME":dic2["COMPNAME"]!,
                                            "RADJUSTDIR":dic2["RADJUSTDIR"]!,
                                            "DATE":dic2["DATE"]!,
                                            "PRICECAP":dic2["PRICECAP"]!,
                                            "MOM": dic2["MOM"]!,
                                            "ENDDATE":dic2["ENDDATE"]!
                                        ]
                                        itemJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                    }
                                }
                            }
                            
                            resultJSON["list"] = itemJSON
                        }
                    }
                }
                if mRequest.requestType == "exptskstatn"{
                    if let dic1: NSDictionary = f10Response.jsonObject as! NSDictionary{
                        if param["quarterType"] != ""{
                            let paramI:NSArray = (param["quarterType"].string?.split(separator: "_") as! NSArray)
                            if let dic1: NSDictionary = f10Response.jsonObject as! NSDictionary{
                              var resultJSON: JSON = [
                                "\(paramI[0])":dic1["\(paramI[0])"]!,
                                  "MOM": dic1["MOM"]!,
                                  "ENDDATE":dic1["ENDDATE"]!
                                  ]
                            }
                        }else{
                            var resultJSON: JSON = [
                                "TMBIZINCOME":dic1["TMBIZINCOME"]!,
                                "NMBIZINCOME":dic1["NMBIZINCOME"]!,
                                "YANMBIZINCOME":dic1["YANMBIZINCOME"]!,
                                "MAINBIZINCOMEYOY1":dic1["MAINBIZINCOMEYOY1"]!,
                                "MAINBIZINCOMEYOY2":dic1["MAINBIZINCOMEYOY2"]!,
                                "MAINBIZINCOMEYOY3":dic1["MAINBIZINCOMEYOY3"]!,
                                "TNETPROFIT":dic1["TNETPROFIT"]!,
                                "NNETPROFIT":dic1["NNETPROFIT"]!,
                                "MOM": dic1["MOM"]!,
                                "ENDDATE":dic1["ENDDATE"]!
                            ]
                            let update1: JSON = [
                                "YANNETPROFIT":dic1["YANNETPROFIT"]!,
                                "NETPROFITYOY1":dic1["NETPROFITYOY1"]!,
                                "NETPROFITYOY2":dic1["NETPROFITYOY2"]!,
                                "NETPROFITYOY3":dic1["NETPROFITYOY3"]!,
                                "TEPS":dic1["TEPS"]!,
                                "NEPS":dic1["NEPS"]!,
                                "YANEPS":dic1["YANEPS"]!,
                                "TENDDATE":dic1["TENDDATE"]!,
                                "NENDDATE":dic1["NENDDATE"]!,
                                "YANENDDATE":dic1["YANENDDATE"]!
                            ]
                            do {
                                try resultJSON.merge(with: update1)
                            } catch {
                                // ignore
                            }
                        }
                        
                        
                    }
                }
                if mRequest.requestType == "companyinfo"{
                    if let dic1: NSDictionary = f10Response.jsonObject as! NSDictionary{
                        if param["quarterType"] != ""{
                            let paramI:NSArray = (param["quarterType"].string?.split(separator: "_") as! NSArray)
                            if let dic1: NSDictionary = f10Response.jsonObject as! NSDictionary{
                              var resultJSON: JSON = [
                                "\(paramI[0])":dic1["\(paramI[0])"]!,
                                  "MOM": dic1["MOM"]!,
                                  "ENDDATE":dic1["ENDDATE"]!
                                  ]
                            }
                        }else{
                            var resultJSON: JSON = [
                                "LISTDATE":dic1["LISTDATE"]!,
                                "LISTOPRICE":dic1["LISTOPRICE"]!,
                                "FCLEVEL2NAME":dic1["FCLEVEL2NAME"]!,
                                "COMPNAME":dic1["COMPNAME"]!,
                                "CHAIRMAN":dic1["CHAIRMAN"]!,
                                "BSECRETARY":dic1["BSECRETARY"]!,
                                "BSECRETARYMAIL":dic1["BSECRETARYMAIL"]!,
                                "REGADDR":dic1["REGADDR"]!,
                                "ISSPRICE":dic1["ISSPRICE"]!,
                                "SWLEVEL2NAME":dic1["SWLEVEL2NAME"]!,
                                "MOM": dic1["MOM"]!,
                                "ENDDATE":dic1["ENDDATE"]!
                            ]
                        }
                        
                        
                    }
                }
                if mRequest.requestType == "sharebonus"{
                    if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                            if param["quarterType"] != ""{
                                let paramI:NSArray = (param["quarterType"].string?.split(separator: "_") as! NSArray)
                                for List in Lists{
                                    if let dic2 : NSDictionary = List as! NSDictionary{
                                        var jsonarr2: JSON = [
                                            "\(paramI[0])":dic2["\(paramI[0])"]!,
                                            "MOM": dic2["MOM"]!,
                                            "ENDDATE":dic2["ENDDATE"]!
                                        ]
                                        resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                    }
                                }
                            }else{
                                for List in Lists{
                                    if let dic2 : NSDictionary = List as! NSDictionary{
                                        var jsonarr2: JSON = [
                                            "DATETYPENAME":dic2["DATETYPENAME"]!,
                                            "PRETAXCASHMAXDVCNY":dic2["PRETAXCASHMAXDVCNY"]!,
                                            "EQURECORDDATE":dic2["EQURECORDDATE"]!,
                                            "XDRDATE":dic2["XDRDATE"]!,
                                            "MOM": dic2["MOM"]!,
                                            "ENDDATE":dic2["ENDDATE"]!,
                                            "CASHDVARRBEGDATE":dic2["CASHDVARRBEGDATE"] ?? "-",
                                            "CASHDVARRENDDATE":dic2["CASHDVARRENDDATE"] ?? "-",
                                        ]
                                        resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                    }
                                }
                        }
                            
                    }
                }
                if mRequest.requestType == "companymanager"{
                    if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                        if param["quarterType"] != ""{
                            let paramI:NSArray = (param["quarterType"].string?.split(separator: "_") as! NSArray)
                            for List in Lists{
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "\(paramI[0])":dic2["\(paramI[0])"]!,
                                        "MOM": dic2["MOM"]!,
                                        "ENDDATE":dic2["ENDDATE"]!
                                    ]
                                    resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                }
                            }
                        }else{
                            for List in Lists{
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "CNAME":dic2["CNAME"]!,
                                        "DUTY":dic2["DUTY"]!,
                                        "HOLDAFAMT":dic2["HOLDAFAMT"]!,
                                        "REMBEFTAX":dic2["REMBEFTAX"]!,
                                        "BEGINEND":dic2["BEGINEND"]!,
                                        "MEMO":dic2["MEMO"]!,
                                        "MOM": dic2["MOM"]!,
                                        "ENDDATE":dic2["ENDDATE"]!
                                    ]
                                    resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                }
                            }
                        }
                            
                    }
                }
                if mRequest.requestType == "otsholder10"{
                    if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                        if param["quarterType"] != ""{
                            let paramI:NSArray = (param["quarterType"].string?.split(separator: "_") as! NSArray)
                            for List in Lists{
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "\(paramI[0])":dic2["\(paramI[0])"]!,
                                        "MOM": dic2["MOM"]!,
                                        "ENDDATE":dic2["ENDDATE"]!
                                    ]
                                    resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                }
                            }
                        }else{
                            for List in Lists{
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "ENDDATE":dic2["ENDDATE"]!,
                                        "SHHOLDERNAME":dic2["SHHOLDERNAME"]!,
                                        "HOLDERAMT":dic2["SHHOLDERCODE"]!,
                                        "PCTOFFLOTSHARES":dic2["HOLDERAMT"]!,
                                        "HOLDERSUMCHG":dic2["PCTOFFLOTSHARES"]!,
                                        "SHHOLDERCODE":dic2["HOLDERSUMCHG"]!,
                                        "MOM": dic2["MOM"]!,
                                    ]
                                    resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                }
                            }
                        }
                            
                    }
                }
                if mRequest.requestType == "shareholder10"{
                    if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                        if param["quarterType"] != ""{
                            let paramI:NSArray = (param["quarterType"].string?.split(separator: "_") as! NSArray)
                            for List in Lists{
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "\(paramI[0])":dic2["\(paramI[0])"]!,
                                        "MOM": dic2["MOM"]!,
                                        "ENDDATE":dic2["ENDDATE"]!
                                    ]
                                    resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                }
                            }
                        }else{
                            for List in Lists{
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "ENDDATE":dic2["ENDDATE"]!,
                                        "SHHOLDERNAME":dic2["SHHOLDERNAME"]!,
                                        "HOLDERAMT":dic2["SHHOLDERCODE"]!,
                                        "PCTOFFLOTSHARES":dic2["HOLDERAMT"]!,
                                        "CURCHG":dic2["HOLDERRTO"]!,
                                        "SHHOLDERCODE":dic2["CURCHG"]!,
                                        "MOM": dic2["MOM"]!,
                                    ]
                                    resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                }
                            }
                        }
                            
                    }
                }
                if mRequest.requestType == "shareinfo"{
                    if let dic1: NSDictionary = f10Response.jsonObject as! NSDictionary{
                        if param["quarterType"] != ""{
                            let paramI:NSArray = (param["quarterType"].string?.split(separator: "_") as! NSArray)
                            
                               
                                    var resultJSON: JSON = [
                                        "\(paramI[0])":dic1["\(paramI[0])"]!,
                                        "MOM": dic1["MOM"]!,
                                        "ENDDATE":dic1["ENDDATE"]!
                                    ]
                                
                            
                        }else{
                            var resultJSON: JSON = [
                                "TOTALSHARE":dic1["TOTALSHARE"]!,
                                "CIRCSKAMT":dic1["CIRCSKAMT"]!,
                                "RELANAME":dic1["RELANAME"]!,
                                "SHHOLDERNAME":dic1["SHHOLDERNAME"]!,
                                "HOLDERRTO":dic1["HOLDERRTO"]!,
                                "TOTALSHRTO":dic1["TOTALSHRTO"]!,
                                "TOTALSHAMT":dic1["TOTALSHAMT"]!,
                                "MOM": dic1["MOM"]!,
                                "ENDDATE":dic1["ENDDATE"]!
                            ]
                        }
                        
                        
                    }
                }
                if mRequest.requestType == "shareholdernum"{
                    if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                        if param["quarterType"] != ""{
                            let paramI:NSArray = (param["quarterType"].string?.split(separator: "_") as! NSArray)
                            for List in Lists{
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "\(paramI[0])":dic2["\(paramI[0])"]!,
                                        "MOM": dic2["MOM"]!,
                                        "ENDDATE":dic2["ENDDATE"]!
                                    ]
                                    resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                }
                            }
                        }else{
                            for List in Lists{
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "ENDDATE":dic2["ENDDATE"]!,
                                        "TOTALSHAMT":dic2["TOTALSHAMT"]!,
                                        "KAVGSH":dic2["KAVGSH"]!,
                                        "MOM":dic2["MOM"]!,
                                    ]
                                    resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                }
                            }
                        }
                            
                    }
                }
                if mRequest.requestType == "profinmainindex"{
                    var i = 0
                    if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                        if param["quarterType"] != ""{
                            let paramI:NSArray = (param["quarterType"].string?.split(separator: "_") as! NSArray)
                            for List in Lists{
                                i = i+1
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "\(paramI[0])":dic2["\(paramI[0])"]!,
                                        "MOM": dic2["MOM"]!,
                                        "ENDDATE":dic2["ENDDATE"]!
                                    ]
                                    resultJSON["\(i)"] = jsonarr2
                                }
                            }
                        }else{
                            for List in Lists{
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "REPORTTITLE":dic2["REPORTTITLE"]!,
                                        "EPSBASIC":dic2["EPSBASIC"]!,
                                        "EPSDILUTED":dic2["EPSDILUTED"]!,
                                        "NAPS":dic2["NAPS"]!,
                                        "UPPS":dic2["UPPS"]!,
                                        "CRPS":dic2["CRPS"]!,
                                        "SGPMARGIN":dic2["SGPMARGIN"]!,
                                        "OPPRORT":dic2["OPPRORT"]!,
                                        
                                    ]
                                    let update2: JSON = [
                                        "SNPMARGIN":dic2["SNPMARGIN"]!,
                                        "ROEWEIGHTED":dic2["ROEWEIGHTED"]!,
                                        "ROEDILUTED":dic2["ROEDILUTED"]!,
                                        "CURRENTRT":dic2["CURRENTRT"]!,
                                        "QUICKRT":dic2["QUICKRT"]!,
                                        "OPNCFPS":dic2["OPNCFPS"]!,
                                        "MOM": dic2["MOM"]!,
                                        "ENDDATE":dic2["ENDDATE"]!
                                    ]
                                    do {
                                        try jsonarr2.merge(with: update2)
                                    } catch {
                                        // ignore
                                    }
                                    resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                }
                            }
                        }
                            
                    }
                }
                if mRequest.requestType == "proincstatementnew"{
                    var i = 0
                    if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                        if param["quarterType"] != ""{
                            let paramI:NSArray = (param["quarterType"].string?.split(separator: "_") as! NSArray)
                            for List in Lists{
                                i = i+1
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "\(paramI[0])":dic2["\(paramI[0])"]!,
                                        "MOM": dic2["MOM"]!,
                                        "ENDDATE":dic2["ENDDATE"]!
                                    ]
                                    resultJSON["\(i)"] = jsonarr2
                                }
                            }
                        }else{
                            for List in Lists{
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "REPORTTITLE":dic2["REPORTTITLE"]!,
                                        "BIZINCO":dic2["BIZINCO"]!,
                                        "BIZCOST":dic2["BIZCOST"]!,
                                        "MANAEXPE":dic2["MANAEXPE"]!,
                                        "SALESEXPE":dic2["SALESEXPE"]!,
                                        "FINEXPE":dic2["FINEXPE"]!,
                                        "PERPROFIT":dic2["PERPROFIT"]!,
                                        
                                    ]
                                    let update3: JSON = [
                                        "INVEINCO":dic2["INVEINCO"]!,
                                        "NONOPERINCOMEN":dic2["NONOPERINCOMEN"]!,
                                        "TOTPROFIT":dic2["TOTPROFIT"]!,
                                        "PARENETP":dic2["PARENETP"]!,
                                        "MOM": dic2["MOM"]!,
                                        "ENDDATE":dic2["ENDDATE"]!
                                    ]
                                    do {
                                        try jsonarr2.merge(with: update3)
                                    } catch {
                                        // ignore
                                    }
                                    resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                }
                            }
                        }
                            
                    }
                }
                if mRequest.requestType == "probalsheetnew"{
                    var i = 0
                    if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                        if param["quarterType"] != ""{
                            let paramI:NSArray = (param["quarterType"].string?.split(separator: "_") as! NSArray)
                            for List in Lists{
                                i = i+1
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "\(paramI[0])":dic2["\(paramI[0])"]!,
                                        "MOM": dic2["MOM"]!,
                                        "ENDDATE":dic2["ENDDATE"]!
                                    ]
                                    resultJSON["\(i)"] = jsonarr2
                                }
                            }
                        }else{
                            for List in Lists{
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "REPORTTITLE":dic2["REPORTTITLE"]!,
                                        "TOTLIABSHAREQUI":dic2["TOTLIABSHAREQUI"]!,
                                        "TOTCURRASSET":dic2["TOTCURRASSET"]!,
                                        "CURFDS":dic2["CURFDS"]!,
                                        "TRADFINASSET":dic2["TRADFINASSET"]!,
                                        "INVE":dic2["INVE"]!,
                                        "ACCORECE":dic2["ACCORECE"]!,
                                        "OTHERRECE":dic2["OTHERRECE"]!,
                                        "FIXEDASSENET":dic2["FIXEDASSENET"]!,
                                        "AVAISELLASSE":dic2["AVAISELLASSE"]!,
                                        "INTAASSET":dic2["INTAASSET"]!,
                                        "SHORTTERMBORR":dic2["SHORTTERMBORR"]!,
                                        
                                    ]
                                    let update4: JSON = [
                                        "ADVAPAYM":dic2["ADVAPAYM"]!,
                                        "ACCOPAYA":dic2["ACCOPAYA"]!,
                                        "TOTALCURRLIAB":dic2["TOTALCURRLIAB"]!,
                                        "SUNEVENNONCLIAB":dic2["SUNEVENNONCLIAB"]!,
                                        "TOTLIAB":dic2["TOTLIAB"]!,
                                        "PARESHARRIGH":dic2["PARESHARRIGH"]!,
                                        "CAPISURP":dic2["CAPISURP"]!,
                                        "GOODWILL":dic2["GOODWILL"]!,
                                        "MOM": dic2["MOM"]!,
                                        "ENDDATE":dic2["ENDDATE"]!
                                    ]
                                    do {
                                        try jsonarr2.merge(with: update4)
                                    } catch {
                                        // ignore
                                    }
                                    resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                }
                            }
                        }
                            
                    }
                }
                if mRequest.requestType == "procfstatementnew"{
                    var i = 0
                    if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                        if param["quarterType"] != ""{
                            let paramI:NSArray = (param["quarterType"].string?.split(separator: "_") as! NSArray)
                            for List in Lists{
                                i = i+1
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "\(paramI[0])":dic2["\(paramI[0])"]!,
                                        "MOM": dic2["MOM"]!,
                                        "ENDDATE":dic2["ENDDATE"]!
                                    ]
                                    resultJSON["\(i)"] = jsonarr2
                                }
                            }
                        }else{
                            for List in Lists{
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "REPORTTITLE":dic2["REPORTTITLE"]!,
                                        "BIZCASHINFL":dic2["BIZCASHINFL"]!,
                                        "BIZCASHOUTF":dic2["BIZCASHOUTF"]!,
                                        "MANANETR":dic2["MANANETR"]!,
                                        "INVCASHINFL":dic2["INVCASHINFL"]!,
                                        "INVCASHOUTF":dic2["INVCASHOUTF"]!,
                                        "INVNETCASHFLOW":dic2["INVNETCASHFLOW"]!,
                                        
                                    ]
                                    let update5: JSON = [
                                        "FINCASHINFL":dic2["OTHERRECE"]!,
                                        "FINCASHOUTF":dic2["FINCASHOUTF"]!,
                                        "FINNETCFLOW":dic2["FINNETCFLOW"]!,
                                        "CASHNETR":dic2["CASHNETR"]!,
                                        "MOM": dic2["MOM"]!,
                                        "ENDDATE":dic2["ENDDATE"]!
                                    ]
                                    do {
                                        try jsonarr2.merge(with: update5)
                                    } catch {
                                        // ignore
                                    }
                                    resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                }
                            }
                        }
                            
                    }
                }
                if mRequest.requestType == "blocktrade"{
                    if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                        if param["quarterType"] != ""{
                            let paramI:NSArray = (param["quarterType"].string?.split(separator: "_") as! NSArray)
                            for List in Lists{
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "\(paramI[0])":dic2["\(paramI[0])"]!,
                                        "MOM": dic2["MOM"]!,
                                        "ENDDATE":dic2["ENDDATE"]!
                                    ]
                                    resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                }
                            }
                        }else{
                            for List in Lists{
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "TRADEDATE":dic2["TRADEDATE"]!,
                                        "TRADEPRICE":dic2["TRADEPRICE"]!,
                                        "VOLUME":dic2["VOLUME"]!,
                                        "AMOUNT":dic2["AMOUNT"]!,
                                        "PRC":dic2["PRC"]!,
                                        "BUYERNAME":dic2["BUYERNAME"]!,
                                        "SELLERNAME":dic2["SELLERNAME"]!,
                                        "MOM": dic2["MOM"]!,
                                        "ENDDATE":dic2["ENDDATE"]!
                                    ]
                                    resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                }
                            }
                        }
                            
                    }
                }
                if mRequest.requestType == "iinvholdchg"{
                    if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                        if param["quarterType"] != ""{
                            let paramI:NSArray = (param["quarterType"].string?.split(separator: "_") as! NSArray)
                            for List in Lists{
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "\(paramI[0])":dic2["\(paramI[0])"]!,
                                        "MOM": dic2["MOM"]!,
                                        "ENDDATE":dic2["ENDDATE"]!
                                    ]
                                    resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                }
                            }
                        }else{
                            for List in Lists{
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "REPORTDATE":dic2["REPORTDATE"]!,
                                        "TRADING":dic2["TRADING"]!,
                                        "SESNAME":dic2["SESNAME"]!,
                                        "SETYPENAME":dic2["SETYPENAME"]!,
                                        "HOLDQTY":dic2["HOLDQTY"]!,
                                        "HOLDAMT":dic2["HOLDAMT"]!,
                                        "HOLDQTYSUMCHG":dic2["HOLDQTYSUMCHG"]!,
                                        "MOM": dic2["MOM"]!,
                                        "ENDDATE":dic2["ENDDATE"]!
                                    ]
                                    resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                }
                            }
                        }
                            
                    }
                }
                if mRequest.requestType == "importnoticedate"{
                    if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                        if param["quarterType"] != ""{
                            let paramI:NSArray = (param["quarterType"].string?.split(separator: "_") as! NSArray)
                            for List in Lists{
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "\(paramI[0])":dic2["\(paramI[0])"]!,
                                        "MOM": dic2["MOM"]!,
                                        "ENDDATE":dic2["ENDDATE"]!
                                    ]
                                    resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                }
                            }
                        }else{
                            for List in Lists{
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "REPTITLE":dic2["REPTITLE"]!,
                                        "TRADEDATE":dic2["TRADEDATE"]!,
                                        "TEXT":dic2["TEXT"]!,
                                        "MOM": dic2["MOM"]!,
                                        "ENDDATE":dic2["ENDDATE"]!
                                        
                                    ]
                                    resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                }
                            }
                        }
                            
                    }
                }
                if mRequest.requestType == "importnoticetitle"{
                    if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                        if param["quarterType"] != ""{
                            let paramI:NSArray = (param["quarterType"].string?.split(separator: "_") as! NSArray)
                            for List in Lists{
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "\(paramI[0])":dic2["\(paramI[0])"]!,
                                        "MOM": dic2["MOM"]!,
                                        "ENDDATE":dic2["ENDDATE"]!
                                    ]
                                    resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                }
                            }
                        }else{
                            for List in Lists{
                                if let dic2 : NSDictionary = List as! NSDictionary{
                                    var jsonarr2: JSON = [
                                        "REPTITLE":dic2["REPTITLE"]!,
                                        "TRADEDATE":dic2["TRADEDATE"]!,
                                        "TEXT":dic2["TEXT"]!,
                                        "MOM": dic2["MOM"]!,
                                        "ENDDATE":dic2["ENDDATE"]!
                                    ]
                                    resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                }
                            }
                        }
                            
                    }
                }
                if mRequest.requestType == "exptperformance"{
                    if let dic1: NSDictionary = f10Response.jsonObject as! NSDictionary{
                        
                        if let Lists: NSArray = dic1["List"] as!NSArray{
                            if param["quarterType"] != ""{
                                let paramI:NSArray = (param["quarterType"].string?.split(separator: "_") as! NSArray)
                                for List in Lists{
                                    if let dic2 : NSDictionary = List as! NSDictionary{
                                        var jsonarr2: JSON = [
                                            "\(paramI[0])":dic2["\(paramI[0])"]!,
                                            "MOM": dic2["MOM"]!,
                                            "ENDDATE":dic2["ENDDATE"]!
                                        ]
                                        resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                    }
                                }
                            }else{
                                for List in Lists{
                                    if let dic2 : NSDictionary = List as! NSDictionary{
                                        var jsonarr2: JSON = [
                                            "SESNAME":dic2["SESNAME"]!,
                                            "PUBLISHDATE":dic2["PUBLISHDATE"]!,
                                            "RETAMAXPROFITSMK":dic2["RETAMAXPROFITSMK"]!,
                                            "RETAMAXPROFITSINC":dic2["RETAMAXPROFITSINC"]!,
                                            "MOM": dic2["MOM"]!,
                                            "ENDDATE":dic2["ENDDATE"]!
                                        ]
                                        resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                    }
                                }
                            }
                            
                        }
                        
                    }
                }
                if mRequest.requestType == "proindicdata"{
                    if let dic1: NSDictionary = f10Response.jsonObject as! NSDictionary{
                        
                        if let Lists: NSArray = dic1["List"] as!NSArray{
                            if param["quarterType"] != ""{
                                let paramI:NSArray = (param["quarterType"].string?.split(separator: "_") as! NSArray)
                                for List in Lists{
                                    if let dic2 : NSDictionary = List as! NSDictionary{
                                        var jsonarr2: JSON = [
                                            "\(paramI[0])":dic2["\(paramI[0])"]!,
                                            "MOM": dic2["MOM"]!,
                                            "ENDDATE":dic2["ENDDATE"]!
                                        ]
                                        resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                    }
                                }
                            }else{
                                for List in Lists{
                                    if let dic2 : NSDictionary = List as! NSDictionary{
                                        var jsonarr2: JSON = [
                                            "SESNAME":dic2["SESNAME"]!,
                                            "PUBLISHDATE":dic2["PUBLISHDATE"]!,
                                            "EPSBASIC":dic2["EPSBASIC"]!,
                                            "TAGRT":dic2["TAGRT"]!,
                                            "NPGRT":dic2["NPGRT"]!,
                                            "MOM": dic2["MOM"]!,
                                            "ENDDATE":dic2["ENDDATE"]!
                                        ]
                                        resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                    }
                                }
                            }
                            
                        }
                        
                    }
                }
                if mRequest.requestType == "newsinteractive"{
                    if let dic1: NSDictionary = f10Response.jsonObject as! NSDictionary{
                        
                        if let Lists: NSArray = dic1["List"] as!NSArray{
                            if param["quarterType"] != ""{
                                let paramI:NSArray = (param["quarterType"].string?.split(separator: "_") as! NSArray)
                                for List in Lists{
                                    if let dic2 : NSDictionary = List as! NSDictionary{
                                        var jsonarr2: JSON = [
                                            "\(paramI[0])":dic2["\(paramI[0])"]!,
                                            "MOM": dic2["MOM"]!,
                                            "ENDDATE":dic2["ENDDATE"]!
                                        ]
                                        resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                    }
                                }
                            }else{
                                for List in Lists{
                                    if let dic2 : NSDictionary = List as! NSDictionary{
                                        var jsonarr2: JSON = [
                                            "TRADING":dic2["TRADING"]!,
                                            "SESNAME":dic2["SESNAME"]!,
                                            "PROBLEM":dic2["PROBLEM"]!,
                                            "QUESTIONTIME":dic2["QUESTIONTIME"]!,
                                            "REPLY":dic2["REPLY"]!,
                                            "ANSWERTIME":dic2["ANSWERTIME"]!,
                                            "NEWSSOURCE":dic2["NEWSSOURCE"]!,
                                            "INTERACTIVEID":dic2["PageNumber"]!,
                                            "MOM": dic2["MOM"]!,
                                            "ENDDATE":dic2["ENDDATE"]!
                                        ]
                                        resultJSON["\(dic2["ENDDATE"]!)"] = jsonarr2
                                    }
                                }
                            }
                            
                        }
                        
                    }
                }
                if mRequest.requestType == "fundholdings10"{
                    if let Arr: NSArray = f10Response.jsonObject as? NSArray{
                        for List in Arr{
                            if let dict : NSDictionary = List as? NSDictionary{
                                let jsonarr2: JSON = [
                                    "PUBLISHDATE":dict["PUBLISHDATE"] ?? "-",
                                    "TRADINGCODE":dict["TRADINGCODE"] ?? "-",
                                    "SKNAME":dict["SKNAME"] ?? "-",
                                    "NAVRTO":dict["NAVRTO"] ?? "-",
                                    "ACCSTKRTO":dict["ACCSTKRTO"] ?? "-",
                                    "ACCCIRCRTO":dict["ACCCIRCRTO"] ?? "-",
                                ]
                                resultJSON["\(dict["TRADINGCODE"] ?? "股票代码丢失")"] = jsonarr2
                            }
                        }
                        print(resultJSON)
                        onTestResult(param: param, result: resultJSON)
                    }
                }       
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
        }
        }
