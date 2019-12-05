//
//  SDKSetup.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/29.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//

import Foundation

class SDKSetup {
    private static let permKeys: [String] = [
        MApiMarketSH,
        MApiMarketSZ,
        MApiMarketHK,
        MApiMarketBJ,
        MApiMarketCFF,
        MApiMarketDCE,
        MApiMarketCZCE,
        MApiMarketSHFE,
        MApiMarketINE,
        MApiMarketGI,
        MApiMarketFE,
        MApiMarketUK,
        MApiMarketBK
    ]
    private static let hkPermVals: [String: MApiSourceLevel] = [
        "hk10":  MApiSourceLevel.HK10,
        "hka1":  MApiSourceLevel.HKA1,
        "hkd1":  MApiSourceLevel.HKD1,
        "hk1":   MApiSourceLevel.SHHK1,
        "hk5":   MApiSourceLevel.SHHK5,
        "szhk1": MApiSourceLevel.SZHK1,
        "szhk5": MApiSourceLevel.SZHK5
    ]
    
    enum SDKSetupError: Error {
        case RegisterTimeout
        case RegisterError(String)
        case RunLoopUnknown(String)
    }
    
    static func setup(sdkConfig: StockTesting_SDKConfig) throws {
        MApi.setDebugMode([
            "token": "|F)w*7sYaoIdM+!#8d10LsT#0x|cA.xX/a@;a~",
            "enabled": true,
            "mode": 7
        ])
        let siteOption = buildSiteOption(sites: sdkConfig.serverSites)
        let perms = buildPerms(permCfg: sdkConfig.marketPerm)
        var registerErr: Error? = nil
        let runLoop = CFRunLoopGetCurrent()
        Utils.log(tag: "SDKSetup", str: "register start.")
        MApi.registerAPP(sdkConfig.appKeyIos, sourcePermissions: perms, options: siteOption, completionHandler: { err in
            registerErr = err
            CFRunLoopStop(runLoop)
        })

        let result = CFRunLoopRunInMode(CFRunLoopMode.defaultMode, CFTimeInterval(5.0), false)
        switch result {
        case .timedOut:
            throw SDKSetupError.RegisterTimeout
        case .stopped:
            if registerErr != nil {
                throw SDKSetupError.RegisterError(registerErr.debugDescription)
            }
            Utils.log(tag: "SDKSetup", str: "register done!")
        default:
            throw SDKSetupError.RunLoopUnknown("\(result)")
        }
    }
    
    private static func buildPerms(permCfg: StockTesting_MarketPermission) -> [String: Int] {
        var perms = [String: Int]()
        if !permCfg.level.isEmpty {
            let levelVal = permCfg.level == "1" ? MApiSourceLevel.level1 : MApiSourceLevel.level2
            perms.updateValue(levelVal.rawValue, forKey: MApiMarketSH)
            perms.updateValue(levelVal.rawValue, forKey: MApiMarketSZ)
        }
        if !permCfg.cffLevel.isEmpty {
            let levelVal = permCfg.cffLevel == "1" ? MApiSourceLevel.CFF1 : MApiSourceLevel.CFF2
            perms.updateValue(levelVal.rawValue, forKey: MApiMarketCFF)
        }
        if !permCfg.dceLevel.isEmpty {
            let levelVal = permCfg.dceLevel == "1" ? MApiSourceLevel.DCE1 : MApiSourceLevel.DCE2
            perms.updateValue(levelVal.rawValue, forKey: MApiMarketDCE)
        }
        if !permCfg.czceLevel.isEmpty {
            let levelVal = permCfg.czceLevel == "1" ? MApiSourceLevel.CZCE1 : MApiSourceLevel.CZCE2
            perms.updateValue(levelVal.rawValue, forKey: MApiMarketCZCE)
        }
        if !permCfg.feLevel.isEmpty {
            let levelVal = permCfg.feLevel == "1" ? MApiSourceLevel.level1 : MApiSourceLevel.level2
            perms.updateValue(levelVal.rawValue, forKey: MApiMarketFE)
        }
        if !permCfg.gilevel.isEmpty {
            let levelVal = permCfg.gilevel == "1" ? MApiSourceLevel.level1 : MApiSourceLevel.level2
            perms.updateValue(levelVal.rawValue, forKey: MApiMarketGI)
        }
        if !permCfg.shfeLevel.isEmpty {
            let levelVal = permCfg.shfeLevel == "1" ? MApiSourceLevel.SHFE1 : MApiSourceLevel.SHFE2
            perms.updateValue(levelVal.rawValue, forKey: MApiMarketSHFE)
        }
        if !permCfg.ineLevel.isEmpty {
            let levelVal = permCfg.ineLevel == "1" ? MApiSourceLevel.INE1 : MApiSourceLevel.INE2
            perms.updateValue(levelVal.rawValue, forKey: MApiMarketINE)
        }
        if !permCfg.hkperms.isEmpty {
            var unionLevel = MApiSourceLevel()
            for permStr in permCfg.hkperms {
                if let level = verifyHKPermValue(val: permStr) {
                    unionLevel = unionLevel.union(level)
                }
            }
            if !unionLevel.isEmpty {
                perms.updateValue(unionLevel.rawValue, forKey: MApiMarketHK)
            }
        }
        return perms
    }
    
    private static func verifyPermKey(key: String) -> Bool {
        return permKeys.contains(key)
    }
    
    private static func verifyHKPermValue(val: String) -> MApiSourceLevel? {
        return hkPermVals[val]
    }
    
    private static func buildSiteOption(sites: [String: StockTesting_Site]) -> [String: Any] {
        var option: [String: Any] = [
            MApiRegisterOptionGetServerPoolingTimeKey: 120
        ]
        if let authSite = sites["auth"] {
            option["MAPI_DEBUG_AUTH_SERVERS"] = authSite.ips
        }
        var quoteSites = [String: Any]()
        for (siteType, site) in sites {
            if (siteType == "auth") {
                continue
            }
            let ips = site.ips.map{ item in
                return ["ip": item]
            }
            quoteSites.updateValue(ips, forKey: siteType)
        }
        if !quoteSites.isEmpty {
            option["MAPI_DEBUG_QUOTE_SERVERS"] = quoteSites
        }
        return option
    }
}
